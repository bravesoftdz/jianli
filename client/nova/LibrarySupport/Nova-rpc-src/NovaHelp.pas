unit NovaHelp;
{------------------------------------
  功能说明：用于实现可下拉的帮助输入框
  创建日期：2011/01/30
  作者：lanck
  版权：nova
-------------------------------------}
interface

uses
  Windows, Variants, Messages, SysUtils, Classes, Graphics, Controls,
  jsonConnection, StdCtrls, ExtCtrls, Forms, jsonClientDataSet,
  DBGrids, db, Dialogs, NovaEdit,WinSkinData,Math;
type
  THelpOptions = class(TPersistent)
  private
    FControl: TControl;
    FOnChange: TNotifyEvent;
    FJSONConnection: TjsonConnection;
    FEdtField:String;//填入edit中的字段
    FHelpWidth: TConstraintSize;
    FHelpHeight: TConstraintSize;
    FDataSourceName:String;
    FQueryAddress:String;
    FHelpType:String;
    FSkinData:TSkinData;
    FDBGColumns: TDBGridColumns;
    FHelpLeft: TConstraintSize;
    FHelpTop: TConstraintSize;
    procedure SetConstraints(Index: Integer; Value: TConstraintSize);
    procedure SetDBGColumns(const Value: TDBGridColumns);
    function CreateColumns: TDBGridColumns; dynamic;
    procedure SetJSONConnection(const Value: TJSONConnection);
    procedure SetDataSourceName(const Value: String);
    procedure SetHelpType(const Value: String);
    procedure SetQueryAddress(const Value: String);
    procedure SetEdtField(const Value: String);
    procedure SetSkinData(const Value: TSkinData);

  protected
    procedure Change; virtual;
    procedure AssignTo(Dest: TPersistent); override;
    property Control: TControl read FControl;

  public
    constructor Create(AOwner: TComponent); overload; // virtual;
    destructor Destroy; override;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    Property HelpHeight: TConstraintSize index 0 read FHelpHeight write
      SetConstraints default 120;
    Property HelpWidth: TConstraintSize index 1 read FHelpWidth write
      SetConstraints default 120;
    Property HelpTop
      : TConstraintSize index 2 read FHelpTop write
      SetConstraints default 0;
    Property HelpLeft: TConstraintSize index 3 read FHelpLeft write
      SetConstraints default 0;

    Property EdtField: String read FEdtField write SetEdtField;
    Property HSkinData: TSkinData read FSkinData write SetSkinData;
    Property HJSONConnection: TJSONConnection read FJSONConnection write SetJSONConnection;
    Property HDataSourceName: String read FDataSourceName write SetDataSourceName;
    Property HelpType: String read FHelpType write SetHelpType;
    Property HQueryAddress: String read FQueryAddress write SetQueryAddress;
  end;

type
  TNovaHelp = class(TNovaEdit)
  private
    SkyPan: TPanel;
    JsonClientDataSet1: TJsonClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    FDBGColumns: TDBGridColumns;
    CompInit: boolean;
    IsChange: boolean;
    FHelpOptions: THelpOptions;
    FHelpFieldValue: array [0 .. 1] of array of Variant;
    dontFindData: boolean; // 当回车或双击赋值后，不要在change事件中再查询一次数据库
    FnotFocusedShowHelp:boolean;
    FignoreSearchFlag:String; //忽略查询标志
    procedure DoEnter; overload; override;
    procedure DoExit; overload; override;
    procedure Change; overload; OverRide;
    procedure KeyDown(var Key: Word; Shift: TShiftState); overload; override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); overload; override;
    procedure DBGridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    Procedure DBGridDblClick(Sender: TObject); overload;
    Procedure DBExit(Sender: TObject);
    Procedure ShowHelp;
    Procedure DropForm;
    procedure SetDBGColumns(const Value: TDBGridColumns);
    procedure SetHelpOptions(const Value: THelpOptions);
    Procedure GetFindValue;
    function GetHelpFieldValue(const ParamName: WideString): Variant;
    procedure SetHelpFieldValue(const ParamName: WideString;
      const Value: Variant);
    function GetParams: TParams;
    procedure SetParams(const Value: TParams);
    function getisactive:boolean;
  protected
    Procedure AlterSizeBig;

    Procedure DoFindData(Value: string);
    Function CheckCanFind: boolean;
    function CreateColumns: TDBGridColumns; dynamic;
    procedure QueryChanged(Sender: TObject);
    procedure HelpChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Procedure Init;
    property HelpFieldValue[const ParamName: WideString]
      : Variant read GetHelpFieldValue write SetHelpFieldValue;
  published
    Property HDBGColumns: TDBGridColumns read FDBGColumns write SetDBGColumns;
    Property HelpOptions: THelpOptions read FHelpOptions write SetHelpOptions;
    property Params: TParams read GetParams write SetParams;
    property isactive:boolean read getisactive;
    property notFocusedShowHelp:boolean read FnotFocusedShowHelp write FnotFocusedShowHelp;
    property ignoreSearchFlag:String read FignoreSearchFlag write FignoreSearchFlag;
  end;

  NoFieldFindException = class(Exception);

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNovaHelp]);
end;

constructor TNovaHelp.Create(AOwner: TComponent);
begin
  FnotFocusedShowHelp:=false;
  FignoreSearchFlag:='';
  inherited Create(AOwner);
  CompInit := false;
  FDBGColumns := CreateColumns;

  SkyPan := TPanel.Create(self);
  DBGrid1 := TDBGrid.Create(SkyPan);
  FHelpOptions := THelpOptions.Create(Self);
  FHelpOptions.HelpWidth := width + 5;
  FHelpOptions.OnChange := HelpChanged;

  SkyPan.Visible := false;
  SkyPan.Align := alCustom;
  DBGrid1.Parent := SkyPan;
  DBGrid1.Align := alClient;
  DBGrid1.TabStop := false;
  JsonClientDataSet1 := TJsonClientDataSet.Create(Self);

  DataSource1 := TDataSource.Create(Self);
  DataSource1.DataSet := JsonClientDataSet1;
  DBGrid1.DataSource := DataSource1;
  DBGrid1.OnExit := DBExit;
  DBGrid1.OnKeyDown := DBGridKeyDown;
  DBGrid1.OnDblClick := DBGridDblClick;
  dontFindData := false;

  SkyPan.width := FHelpOptions.HelpWidth;
  SkyPan.Height := FHelpOptions.HelpHeight;
  DBGrid1.Options := [dgTitles, dgIndicator, dgColumnResize, dgColLines,
    dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit,
    DGALWAYSSHOWSELECTION];
end;

procedure TNovaHelp.QueryChanged(Sender: TObject);
begin
  if (JsonClientDataSet1.Active) then
    JsonClientDataSet1.Close;
end;

destructor TNovaHelp.Destroy;
begin
  inherited Destroy;
end;

Procedure TNovaHelp.AlterSizeBig;
var
  i: Integer;
  findW: Integer;
  lefttop:TPoint;
begin
  if FHelpOptions.HelpWidth = 126 then
  begin
    findW := 0;
    for i := 0 to Self.DBGrid1.Columns.Count - 1 do
    begin
      Inc(findW, DBGrid1.Columns.Items[i].width + 10);
    end;
    SkyPan.width := findW + 20
  end
  else
  begin
    SkyPan.width := FHelpOptions.HelpWidth;
  end;
  SkyPan.Height:=FHelpOptions.HelpHeight;
  lefttop:=ClientToParent(Point(0,Height),GetParentForm(Self,false));
  SkyPan.Left:=max(0,Min(lefttop.X,GetParentForm(Self,false).width-skypan.Width));
  if (lefttop.Y+skypan.Height>GetParentForm(Self,false).height)
    and (lefttop.Y-Height-skypan.Height>=0) then
    SkyPan.Top:=lefttop.Y-Height-skypan.Height
  else
    SkyPan.Top:=lefttop.Y;
end;

procedure TNovaHelp.Init;
begin
  if not CompInit then
  begin
    DBGrid1.Columns.Assign(HDBGColumns);
    SkyPan.Parent:=GetParentForm(self,false);
    JsonClientDataSet1.RemoteServer := HelpOptions.FJsonConnection;
    JsonClientDataSet1.Params.CreateParam(ftString,'helpType',ptInput);
    JsonClientDataSet1.Params.CreateParam(ftString,'param',ptInput);
    if HelpOptions.FQueryAddress='' then
       JsonClientDataSet1.QueryAddress:='system/help'
    else
       JsonClientDataSet1.QueryAddress:=HelpOptions.FQueryAddress;
    if HelpOptions.FDataSourceName='' then
       JsonClientDataSet1.DataSourceName:='helpmap'
    else
       JsonClientDataSet1.DataSourceName:=HelpOptions.FDataSourceName;
    AlterSizeBig;
    CompInit := true;
  end;
end;

procedure TNovaHelp.DoEnter;
begin
  inherited;
  Init;
end;

Procedure TNovaHelp.ShowHelp;
begin
  if CheckCanFind then
  begin
    // 这里添加自动调整大小的控制
    AlterSizeBig;
    SkyPan.Visible := true;
    if not Assigned(HelpOptions.FSkinData) then
//       HelpOptions.FSkinData.AddNestForm(GetParentForm(SkyPan),GetParentForm(SkyPan,false));
       HelpOptions.FSkinData.UpdateSkinControl(TForm(GetParentForm(SkyPan))); //,false
  end;
end;

procedure TNovaHelp.DropForm;
begin
  SkyPan.Visible := false;
  if JsonClientDataSet1.Active then
    JsonClientDataSet1.Close;
end;

procedure TNovaHelp.DBExit(Sender: TObject);
begin
//  DropForm;
end;

procedure TNovaHelp.DoExit;
begin
  inherited;
  if (not self.Focused) and (not DBGrid1.Focused) then
  begin
    DropForm;
    if IsChange then
    begin
      code := '';
      Value := '';
      id := 0;
      //SetLength(FHelpFieldValue[0],0);
    end;
  end;
end;

procedure TNovaHelp.Change;
begin
  inherited;
  //为空时不查询
  if (Trim(Text)='')
  or ((FignoreSearchFlag<>'')  // (length(Text)>=length(FignoreSearchFlag))    and (copy(Text,1,length(FignoreSearchFlag))=FignoreSearchFlag)
      and (pos(FignoreSearchFlag,Text)=1)) then
  begin
    DropForm;
    id:=0;
    exit;
  end;
  if CompInit and (FnotFocusedShowHelp or Focused or DBGrid1.Focused) then
  begin
    ShowHelp;
  end;
  if CheckCanFind then
  begin
    if SkyPan.Visible then
    begin
      IsChange := true;
      if not dontFindData then
        DoFindData(ValueTrim);
      dontFindData := false;
    end;
  end;
end;

procedure TNovaHelp.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if JsonClientDataSet1.Active then
  begin
    if Key = 40 then // 向下
    begin
      Key := 0;
      if JsonClientDataSet1.RecNo < JsonClientDataSet1.RecordCount then
      begin
        JsonClientDataSet1.RecNo := JsonClientDataSet1.RecNo + 1;
       // GetFindValue; // 取得值
      end;
      //GetFindValue;
    end;
    if Key = 38 then // 向上
    begin
      Key := 0;
      if JsonClientDataSet1.RecNo > 1 then
      begin
        JsonClientDataSet1.RecNo := JsonClientDataSet1.RecNo - 1;
      end;
     // GetFindValue; // 取得值
    end;
    if Key = 13 then
    begin
      GetFindValue; // 取得值
      SkyPan.Visible := false;
    end;
    if Key = 27 then // esc
    begin
      if IsChange then
      begin
        code := '';
        Value := '';
        id := 0;
       // SetLength(FHelpFieldValue[0],0);
      end;
      DoExit;
      SkyPan.Visible := false;
    end;
  end;

  inherited;
end;

Procedure TNovaHelp.GetFindValue;
var
  i: Integer;
begin
  with JsonClientDataSet1 do
  begin
    if Active then
    begin
      if RecordCount > 0 then
      begin
        // 20080425 ice add
        SetLength(FHelpFieldValue[0], Fields.Count);
        SetLength(FHelpFieldValue[1], Fields.Count);
        for i := 0 to Fields.Count - 1 do
        begin
          FHelpFieldValue[0][i] := Fields.Fields[i].FieldName;
          FHelpFieldValue[1][i] := Fields.Fields[i].Value;
        end;
        try
          dontFindData := true;
         // if fieldcount > HelpOptions.Code_index then
        //     code := Fields.Fields[HelpOptions.Code_index].AsString;
          if (HelpOptions.EdtField<>'') then
             ValueTrim := trim(Fields.FieldByName(HelpOptions.EdtField).AsString)
          else
             ValueTrim := trim(Fields.FieldByName('name').AsString)
          {else if fieldcount > HelpOptions.Value_index then
          begin
            ValueTrim := trim(Fields.Fields[HelpOptions.Value_index].AsString);
          end;   }
        except
          on E: Exception do
          begin
            ShowMessage('控件信息错误' + E.message);
            ValueTrim := '';
            code := '';
          end;
        end;
        IsChange := false;
        try
         { if fieldcount > HelpOptions.Id_index then
          begin
            // 20080915 ice 要想在IDchange时取到变化后的TEXT CODE VALUE等值，就要
            // 最后对ID赋值，但对VALUETRIM赋值后数据集将被关闭，所以从数组取值
            // Id := Fields.Fields[HelpOptions.FId_index].AsInteger;
            id := FHelpFieldValue[1][HelpOptions.Fid_index];
          end; }
          id := self.GetHelpFieldValue('id');
         // SkyPan.Visible := false;
        Except
          on E: NoFieldFindException do
          begin
            id := 0;
           // SkyPan.Visible := false;
          end;
        end;
        // Application.ProcessMessages;
      end; // end if   RecordCount
    end; // end if
    Close;
   // SkyPan.Visible := false;
    SelectAll;
    if DBGrid1.Focused then
    begin
      SetFocus;
    end;
  end; // end with
end;

procedure TNovaHelp.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_Shift then
    ShowHelp;
  if (Key = 32) and (SkyPan.Visible) then
  begin
    if (Text = '') then
    begin
      DoFindData('');
    end;
  end;
end;

function TNovaHelp.GetParams: TParams;
begin
  Result:=JsonClientDataSet1.Params;
end;

procedure TNovaHelp.DoFindData(Value: string);
var
  i:integer;
begin
  if CheckCanFind then
  begin
   with JsonClientDataSet1 do
    begin
      Close;
      try
        Params.ParamByName('helpType').Value :=FHelpOptions.FHelpType;
        Params.ParamByName('param').Value :=value;
        active:=true;
        i:=recordcount;
        i:=i+1;
        // if recordcount=1 then  //20090311 ice 找到唯一记录时自动选择
        // begin
        // GetFindValue;
        // end;
      except
        on E: Exception do
        begin
          ShowMessage(E.Message);
        end;
      end;
    end;
  end;
end;

function TNovaHelp.CheckCanFind: boolean;
begin
  result := false;
  begin
    if JsonClientDataSet1 <> nil then
      if JsonClientDataSet1.RemoteServer <> nil then
        if ((trim(JsonClientDataSet1.DataSourceName) <> '') and
            (trim(JsonClientDataSet1.QueryAddress) <> '')) then
        begin
          result := true;
        end;
  end;
end;

procedure TNovaHelp.SetDBGColumns(const Value: TDBGridColumns);
begin
  FDBGColumns.Assign(Value);
end;

function TNovaHelp.CreateColumns: TDBGridColumns;
begin
  result := TDBGridColumns.Create(nil, TColumn);
end;

procedure TNovaHelp.DBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    KeyDown(Key, Shift);
    SetFocus;
  end;
end;

{ THelpOptions }

procedure THelpOptions.AssignTo(Dest: TPersistent);
begin
  // inherited;
  if Dest is THelpOptions then
    with THelpOptions(Dest) do
    begin
      Change;
    end
    else
      inherited AssignTo(Dest);
end;

procedure THelpOptions.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor THelpOptions.Create(AOwner: TComponent);
begin
  FDBGColumns := CreateColumns;
  FQueryAddress:='system/help';
  FDataSourceName:='helpmap';
  FControl := Control;
  FEdtField:='name';
  inherited Create; ;
end;


procedure THelpOptions.SetConstraints(Index: Integer; Value: TConstraintSize);
begin
  case Index of
    0:
      if Value <> FHelpHeight then
      begin
        FHelpHeight := Value;
        Change;
      end;
    1:
      if Value <> FHelpWidth then
      begin
        FHelpWidth := Value;
        Change;
      end;
    2:
      if Value <> FHelpTop then
      begin
        FHelpTop := Value;
        Change;
      end;
    3:
      if Value <> HelpLeft then
      begin
        HelpLeft := Value;
        Change;
      end;
  end;
end;

procedure TNovaHelp.SetHelpOptions(const Value: THelpOptions);
begin
  FHelpOptions.AssignTo(Value);
end;

procedure TNovaHelp.SetParams(const Value: TParams);
begin
  JsonClientDataSet1.Params.Assign(Value);
end;

procedure THelpOptions.SetDataSourceName(const Value: String);
begin
  FDataSourceName := Value;
end;

procedure THelpOptions.SetDBGColumns(const Value: TDBGridColumns);
begin
  FDBGColumns.Assign(Value);
end;

procedure THelpOptions.SetEdtField(const Value: String);
begin
  FEdtField := Value;
end;

procedure THelpOptions.SetHelpType(const Value: String);
begin
  FHelpType := Value;
end;

function THelpOptions.CreateColumns: TDBGridColumns;
begin
  result := TDBGridColumns.Create(nil, TColumn);
end;

destructor THelpOptions.Destroy;
begin
  inherited;
end;

procedure THelpOptions.SetJSONConnection(const Value: TJSONConnection);
begin
  FJSONConnection := Value;
end;


procedure THelpOptions.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

procedure THelpOptions.SetSkinData(const Value: TSkinData);
begin
  FSkinData := Value;
end;

procedure TNovaHelp.HelpChanged(Sender: TObject);
begin
  //
end;

procedure TNovaHelp.DBGridDblClick(Sender: TObject);
begin
  GetFindValue;
  DropForm;
end;

function TNovaHelp.GetHelpFieldValue(const ParamName: WideString): Variant;
var
  i: Integer;
  notfindField: boolean;
begin
  result := '';
  if IsChange then
     exit;

  notfindField := true;
  for i := 0 to High(FHelpFieldValue[0]) do
  begin
    if UpperCase(FHelpFieldValue[0][i]) = UpperCase(ParamName) then
    begin
      result := FHelpFieldValue[1][i];
      notfindField := false;
      exit;
    end;
  end;
  if notfindField then
    raise NoFieldFindException.Create('TNovaHelp:没有"' + ParamName + '"这个字段');
end;

function TNovaHelp.getisactive: boolean;
begin
  result:=Assigned(JsonClientDataSet1) and JsonClientDataSet1.Active;
end;

procedure TNovaHelp.SetHelpFieldValue(const ParamName: WideString;
  const Value: Variant);
var
  i: Integer;
  findByParamName: boolean;
begin
  findByParamName := false;
  for i := 0 to High(FHelpFieldValue[0]) do
  begin
    if UpperCase(FHelpFieldValue[0][i]) = UpperCase(ParamName) then
    begin
      FHelpFieldValue[1][i] := Value;
      findByParamName := true;
    end;
  end;
  if not findByParamName then
  begin
    SetLength(FHelpFieldValue[0], Length(FHelpFieldValue[0]) + 1);
    SetLength(FHelpFieldValue[1], Length(FHelpFieldValue[0]) + 1);
    FHelpFieldValue[0][ High(FHelpFieldValue[0])] := ParamName;
    FHelpFieldValue[1][ High(FHelpFieldValue[0])] := Value;
  end;
end;




end.
