unit AC_DataListEx;

interface

uses
  SysUtils,
  Classes,
  Menus,
  DBTables,
  DB,
  Dialogs,
  Variants,
  ADODB,
  CustAdoInt;

type
  TFilterInfo = record
     Bookmark : Pointer;
     ExprValue :variant;
  end;

  TLastFilters = record
     Expr :string;
     Count :integer;
     Infos :array of TFilterInfo;
  end;

  TAcDataItemEx = class(TCollectionItem)
  private
    { Private declarations }
    FDataSet :TDataSet;
    FACDataRef : TAcDataItemEx;
    FDispName :string;
    FilterList :TList;
    FRecPos :integer;
    FCacheFilter : TLastFilters;
    FUseADOInterface: boolean;
    function ACDataItemRef:TAcDataItemEx;
    procedure SetUseADOInterface(const Value: boolean);
  protected
    { Protected declarations }
    IsInnerDataset: boolean;
    IsCustDataset: boolean;
    function GetDisplayName: string; override;
    procedure SetDataSet(ADataSet: TDataSet);
    procedure SetDispName(AName: string);
  public
    { Public declarations }
    FAggrBeginPos :TBookMark;   //在解析合计函数时标识本次合计运算的开始位置。
    FAggrToCurrentPos :boolean; //在解析合计函数时标识是否只合计到当前位置
    FProxDataset: TAcProxDataset;

    constructor Create(Owner :TCollection);override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;


    procedure SaveAggrPos;
    procedure ReleaseAggrPos;

  published
    { Published declarations }
    property DataSet :TDataSet read FDataSet write SetDataSet;
    property DispName :string read FDispName write SetDispName;
    property UseADOInterface: boolean read FUseADOInterface write SetUseADOInterface;
  end;

  TAcDataListEx = class(TCollection)
  private
    { Private declarations }
    FOwner: TPersistent;

    function GetItem(Index: Integer): TAcDataItemEx;
    procedure SetItem(Index: Integer; Value: TAcDataItemEx);
  protected
    { Protected declarations }

    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    { Public declarations }
    constructor Create(Owner: TPersistent); overload;
    constructor Create; overload;
    procedure Assign(Source: TPersistent); override;
    procedure SetDataset(ADispName :string; ADataSet :TDataSet);
    procedure SetInnerDataset(ADispName :string; ADataSet :TDataSet);
    procedure SetCustDataset(ADispName :string; ADataSet :TDataSet);
    procedure ClearInnerDatasets;
    procedure ClearCustDatasets;

    procedure AddItem(Value: TAcDataItemEx);
    procedure RemoveItem(Value: TAcDataItemEx);

    function FindFieldByName(const aName: string): TField;
    function FindItem(const Value: string): TAcDataItemEx;
    function ItemByName(const Value: string): TAcDataItemEx;
    procedure GetDatasetList(AList: TStrings);
    procedure GetFieldsList(ADataset:string; AList: TStrings);

    property Items[Index: Integer]: TAcDataItemEx read GetItem write SetItem; default;
    property Owner :TPersistent read FOwner;
  published
    { Published declarations }
  end;

implementation

function TAcDataItemEx.ACDataItemRef: TAcDataItemEx;
begin
  FACDataRef := Self;
  if not Assigned(FACDataRef) then
    if Assigned(Collection) and (DispName <> '') then
      FACDataRef := TAcDataListEx(Collection).ItemByName(DispName)
    else
      FACDataRef := Self;

  Result := FACDataRef;
end;

constructor TAcDataItemEx.Create(Owner :TCollection);
begin
   inherited;
   FDataSet := nil;
   FProxDataset := nil;
   FDispName := '';                           
   FAggrBeginPos := nil;
   FAggrToCurrentPos := false;
   FilterList := TList.Create;
   FCacheFilter.Count := 0;
   IsInnerDataset := false;
   IsCustDataset := false;
   FRecPos := 0;
end;

destructor TAcDataItemEx.Destroy;
begin
  FilterList.Free;
  if FProxDataset <> nil then
    FProxDataset.Free;
  inherited;
end;

procedure TAcDataItemEx.Assign(Source: TPersistent);
begin
  with TAcDataItemEx(Source) do
  begin
    self.FDataSet := DataSet;
    self.FDispName := DispName;
  end;   
end;

procedure TAcDataItemEx.SaveAggrPos;
begin
  if FDataSet <> nil then
  begin
    if FAggrBeginPos <> nil then
     ReleaseAggrPos;
    FAggrBeginPos := FDataSet.GetBookmark;
  end;
end;

procedure TAcDataItemEx.ReleaseAggrPos;
begin
   if (FDataSet <> nil) and Assigned(FAggrBeginPos) then
   begin
       FDataSet.FreeBookmark(FAggrBeginPos);
       FAggrBeginPos := nil;
   end;
end;


function TAcDataItemEx.GetDisplayName: string;
begin
  if FDispName = '' then
    Result := inherited GetDisplayName
  else
    Result := FDispName;
end;

procedure TAcDataItemEx.SetDataSet(ADataSet: TDataSet);
begin
  if (FDispName = '') or
     ( (FDataSet <> nil) and (AnsiCompareText(FDataSet.Name, FDispName)=0)
      ) then
  if ADataSet <> nil then    
    FDispName := ADataSet.Name;
  FDataSet := ADataSet;
  if FDataset <> nil then
  if (FDataset is TADODataset) or (FDataset is TADOTable) or (FDataset is TADOQuery) then
    FUseADOInterface := true;
end;

procedure TAcDataItemEx.SetDispName(AName: string);
begin
  if AName <> '' then
    FDispName := AName
  else
  begin
    if FDataSet <> nil then
      FDispName := FDataSet.Name;
  end
end;
{TAcDataListEx}

constructor TAcDataListEx.Create(Owner: TPersistent);
begin
  FOwner := Owner;
  inherited Create(TAcDataItemEx);
end;

constructor TAcDataListEx.Create;
begin
  FOwner := nil;
  inherited Create(TAcDataItemEx);
end;

procedure TAcDataListEx.Assign(Source: TPersistent);
var
  i: integer;
begin
  for i := 0 to TAcDataListEx(Source).Count -1 do
    with TAcDataListEx(Source)[i] do
     Self.SetDataSet(DispName, DataSet);
end;

procedure TAcDataListEx.SetDataSet(ADispName :string; ADataset :TDataSet);
var AItem :TAcDataItemEx;
begin
  AItem := FindItem(ADispName);
  if AItem = nil then
    AItem := TAcDataItemEx.Create(Self);

  AItem.DispName := ADispName;
  AItem.DataSet := ADataSet;
end;

procedure TAcDataListEx.SetInnerDataset(ADispName :string; ADataset :TDataSet);
var AItem :TAcDataItemEx;
begin
  AItem := FindItem(ADispName);
  if AItem = nil then
    AItem := TAcDataItemEx.Create(Self);

  AItem.DispName := ADispName;
  AItem.DataSet := ADataSet;
  AItem.IsInnerDataset := true;
end;

procedure TAcDataListEx.SetCustDataset(ADispName :string; ADataset :TDataSet);
var AItem :TAcDataItemEx;
begin
  AItem := FindItem(ADispName);
  if AItem = nil then
    AItem := TAcDataItemEx.Create(Self);

  AItem.DispName := ADispName;
  AItem.DataSet := ADataSet;
  AItem.IsCustDataset := true;
end;

procedure TAcDataListEx.ClearInnerDatasets;
var
  i: integer;
  AItem: TAcDataItemEx;
begin
  for i := Count - 1 downto 0 do
    if Items[i].IsInnerDataset then
    begin
     // AItem := Items[i];
     // AItem.Collection := nil;
     // AItem.Free;
      Delete(i);
    end;
end;

procedure TAcDataListEx.ClearCustDatasets;
var
  i: integer;
  AItem: TAcDataItemEx;
begin
   for i := Count - 1 downto 0 do
   if Items[i].IsCustDataset then
    begin
    //  AItem := Items[i];
    //  AItem.Collection := nil;
    //  AItem.Free;
      Delete(i);
    end;

end;

function TAcDataListEx.GetItem(Index: Integer): TAcDataItemEx;
begin
  Result := TAcDataItemEx(inherited Items[Index]);
  Result := Result.ACDataItemRef;
end;

procedure TAcDataListEx.SetItem(Index: Integer; Value: TAcDataItemEx);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

procedure TAcDataListEx.AddItem(Value: TAcDataItemEx);
begin
  Value.Collection := Self;
end;

procedure TAcDataListEx.RemoveItem(Value: TAcDataItemEx);
begin
  Value.Collection := nil;
end;

function TAcDataListEx.FindItem(const Value: string): TAcDataItemEx;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TAcDataItemEx(inherited Items[I]);
    if (AnsiCompareText(Result.DispName, Value) = 0) or
     (Result.Dataset<>nil) and (AnsiCompareText(Result.Dataset.Name, Value) = 0)
    then Exit;
  end;
  Result := nil;
end;

function TAcDataListEx.ItemByName(const Value: string): TAcDataItemEx;
begin
  Result := FindItem(Value);
  if Result = nil then
   raise Exception.Create('数据列表参数错误！');
end;

procedure TAcDataListEx.GetDatasetList(AList: TStrings);
var
  i: integer;
begin
  AList.Clear;
  for i := 0 to Count - 1 do
    AList.Add(Items[i].DispName);
end;

procedure TAcDataListEx.GetFieldsList(ADataset:string; AList: TStrings);
var
  aItem: TAcDataItemEx;
  i: integer;
begin
  aItem := FindItem(ADataset);
  if aItem = nil then Exit;
  AList.Clear;
  for i := 0 to aItem.DataSet.FieldCount - 1 do
    AList.Add(aItem.DataSet.Fields[i].DisplayName);
end;

function TAcDataListEx.FindFieldByName(const aName: string): TField;
var
   st, sf: string;
   i: integer;
   aItem: TAcDataItemEx;
begin
   result := nil;
   i := pos('.', aName);
   if i <= 0 then
     Exit;
   st := copy(aName, 1, i-1);
   sf := trim(copy(aName, i+1, 255));
   aItem := FindItem(st);
   if aItem = nil then
     Exit;
   for i := 0 to aItem.Dataset.FieldCount -1 do
     if (AnsiCompareText(sf, aItem.Dataset.Fields[i].DisplayName)= 0) or
       (AnsiCompareText(sf, aItem.Dataset.Fields[i].FieldName)= 0) then
     begin
       Result := aItem.Dataset.Fields[i];
       Exit;
     end;
end;

function TAcDataListEx.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TAcDataListEx.Update(Item: TCollectionItem);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Items[i].FACDataRef := nil;
  inherited Update(Item);
end;


procedure TAcDataItemEx.SetUseADOInterface(const Value: boolean);
begin
  if Value then
  if (FDataset <> nil) then
  if not ((FDataset is TADODataset) or (FDataset is TADOTable) or (FDataset is TADOQuery)) then
    Exit;
  FUseADOInterface := Value;
end;

end.
