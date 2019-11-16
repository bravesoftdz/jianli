unit AC_VarEx;

interface

uses
  SysUtils, Classes,  Menus, DBTables, DB,
  Dialogs, Variants;
  
const
    page_no = '页码#';
    total_pages = '总页数#';

type
  TAcVarItemEx = class(TCollectionItem)
  private
    { Private declarations }
    FACVarRef : TAcVarItemEx;
    FValue :Variant;
    FName :string;
    function ACVarItemRef:TAcVarItemEx;
  protected
    { Protected declarations }
    function GetDisplayName: string; override;
  public
    { Public declarations }
    constructor Create(Owner :TCollection);override;
    procedure Assign(Source: TPersistent); override;
  published
    { Published declarations }
    property Value :Variant read FValue write FValue;
    property Name :string read FName write FName;
  end;

  TAcVariantsEx = class(TCollection)
  private
    { Private declarations }
    FOwner: TPersistent;

    function GetItem(Index: Integer): TAcVarItemEx;
    procedure SetItem(Index: Integer; Value: TAcVarItemEx);
  protected
    { Protected declarations }

    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    { Public declarations }
    constructor Create(Owner: TPersistent); overload;
    constructor Create; overload;
    procedure Assign(Source: TPersistent); override;
    
    procedure AddItem(Value: TAcVarItemEx);
    procedure RemoveItem(Value: TAcVarItemEx);

    procedure SetVariant(Name :string; Value :variant);
    function GetVarValue(Name :string) :variant;
    function GetVarValueEx(const Name :string; var Value :variant) :boolean;

    function FindItem(const Value: string): TAcVarItemEx;
    function ItemByName(const Value: string): TAcVarItemEx;
    procedure GetVariantsList(AList: TStrings);

    property Items[Index: Integer]: TAcVarItemEx read GetItem write SetItem; default;
    property Owner :TPersistent read FOwner;
  published
    { Published declarations }
  end;

function ACSysVariants :TAcVariantsEx;

implementation

var FSysVariants :TAcVariantsEx = nil;

function ACSysVariants :TAcVariantsEx;
begin
   if not Assigned(FSysVariants) then
      FSysVariants := TAcVariantsEx.Create;
   result := FSysVariants;   
end;

constructor TAcVarItemEx.Create(Owner :TCollection);
begin  
   inherited;
   //
end;

procedure TAcVarItemEx.Assign(Source: TPersistent);
begin
  with TAcVarItemEx(Source) do
  begin
    Self.FName := Name;
    Self.FValue := Value;
  end;
end;

function TAcVarItemEx.ACVarItemRef: TAcVarItemEx;
begin
  if not Assigned(FACVarRef) then
    if Assigned(Collection) and (Name <> '') then
      FACVarRef := TAcVariantsEx(Collection).ItemByName(Name) else
      FACVarRef := Self;
  Result := FACVarRef;
end;

function TAcVarItemEx.GetDisplayName: string;
begin
  if FName = '' then
    Result := inherited GetDisplayName else
    Result := FName;
end;
{TAcVariantsEx}

constructor TAcVariantsEx.Create(Owner: TPersistent);
begin
      FOwner := Owner;
      inherited Create(TAcVarItemEx);
end;

constructor TAcVariantsEx.Create;
begin               
      FOwner := nil;
      inherited Create(TAcVarItemEx);
end;

procedure TAcVariantsEx.Assign(Source: TPersistent);
var
  i: integer;
begin
  for i := 0 to TAcVariantsEx(Source).Count -1 do
    with TAcVariantsEx(Source).Items[i] do
      SetVariant(Name, Value);
end;

function TAcVariantsEx.GetItem(Index: Integer): TAcVarItemEx;
begin
  Result := TAcVarItemEx(inherited Items[Index]);
  Result := Result.ACVarItemRef;
end;

procedure TAcVariantsEx.SetItem(Index: Integer; Value: TAcVarItemEx);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

procedure TAcVariantsEx.AddItem(Value: TAcVarItemEx);
begin
  Value.Collection := Self;
end;

procedure TAcVariantsEx.RemoveItem(Value: TAcVarItemEx);
begin
  Value.Collection := nil;
end;

function TAcVariantsEx.FindItem(const Value: string): TAcVarItemEx;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TAcVarItemEx(inherited Items[I]);
    if AnsiCompareText(Result.Name, Value) = 0 then Exit;
  end;
  Result := nil;
end;

function TAcVariantsEx.ItemByName(const Value: string): TAcVarItemEx;
begin
  Result := FindItem(Value);
  if Result = nil then
   raise Exception.Create('数据列表参数错误！');
end;

procedure TAcVariantsEx.GetVariantsList(AList: TStrings);
var
  i: integer;
begin
  AList.Clear;
  for i := 0 to Count - 1 do
    AList.Add(Items[i].Name);
end;

function TAcVariantsEx.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TAcVariantsEx.Update(Item: TCollectionItem);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].FACVarRef := nil;
  inherited Update(Item);
end;

procedure TAcVariantsEx.SetVariant(Name :string; Value :variant);
var AVarItem :TAcVarItemEx;
begin                  
    AVarItem := FindItem(Name);
    if AVarItem = nil then
    begin
      AVarItem := TAcVarItemEx.Create(Self);
      AVarItem.Name := Name;
    end;
    AVarItem.Value := Value;
end;

function TAcVariantsEx.GetVarValue(Name :string) :variant;
var AVarItem :TAcVarItemEx;
begin
    result := Null;
    AVarItem := ItemByName(Name);
    if AVarItem <> nil then
      result := AVarItem.Value;
end;

function TAcVariantsEx.GetVarValueEx(const Name :string; var Value :variant) :boolean;
var AVarItem :TAcVarItemEx;
  i: integer;
begin
    result := false;
    if AnsiCompareText(Name, '日期') =0 then
    begin
      Value := Date();
      result := true;
      Exit;
    end else
    if AnsiCompareText(Name, '时间') =0 then
    begin
      Value := Time();
      result := true;
      Exit;
    end else
    if AnsiCompareText(Name, '日期时间') =0 then
    begin
      Value := Date();
      result := true;
      Exit;
    end else
    if AnsiCompareText(Name, '版权信息') =0 then
    begin
      Value := 'shao 2011.9';
      result := true;
      Exit;
    end;

    AVarItem := FindItem(Name);
    if AVarItem <> nil then
    begin
       Value := AVarItem.Value;
       result := true;
    end;
end;

initialization

  with ACSysVariants do
  begin
     SetVariant('日期', NULL);
     SetVariant('时间', NULL);
     SetVariant('日期时间', NULL);
     SetVariant('日期时间', NULL);
     
     SetVariant(page_no, Null);
     SetVariant(total_pages, Null);
     
     SetVariant('工作路径', ExtractFilePath(ParamStr(0)));
     SetVariant('AppPath', ExtractFilePath(ParamStr(0)));
     SetVariant('版权信息', '');
     SetVariant('AppConnString', '');
  end;
end.
