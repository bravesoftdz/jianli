unit NovaHComboBox;
{------------------------------------
  功能说明：用于下拉的帮助下拉选择框，可查询任意表
  创建日期：2011/01/30
  作者：lanck
  版权：nova
  修改日志  日期            修改人       修改内容
            2011/03/02      ice          1、删除默认的 id code value ，
                                            改为按字段名称取值HelpFieldValue['fieldname']，
                                            显示字段为displayFieldname
                                         2、添加Params给开发人员自定义要传入的参数
                                         3、isdebug改名为AutoSelectFirst
                                         4、添加方法SetItemIndexByField(fieldname:String;value:variant)，
                                            用于修改时根据字段名及字段值设置当前选中的行


-------------------------------------}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Forms, jsonConnection, jsonClientDataSet,db,Dialogs,Generics.Collections,Variants;

type
  THelpOptions = class(TPersistent)
  private
    FDataSourceName: String;
    FQueryAddress: String;
    FJSONConnection: TJSONConnection;
    FDisAll: boolean;
    FAutoSelectFirst: boolean;
    FdisplayFieldname:string;
    procedure SetDataSourceName(const Value: String);
    procedure SetJSONConnection(const Value: TJSONConnection);
    procedure SetQueryAddress(const Value: String);
    procedure SetDisAll(const Value: boolean);
    procedure SetIsDebug(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); overload; // virtual;
    destructor Destroy; override;
  published
    Property HJSONConnection: TJSONConnection read FJSONConnection write
      SetJSONConnection;
    Property HDataSourceName
      : String read FDataSourceName write SetDataSourceName;
    Property HQueryAddress: String read FQueryAddress write SetQueryAddress;
    Property DisAll: boolean read FDisAll write SetDisAll default False;
    Property AutoSelectFirst: boolean read FAutoSelectFirst write SetIsDebug default False;
    property displayFieldname:string read FdisplayFieldname write FdisplayFieldname;
  end;

  TNovaHComboBox = class(TComboBox)
  private
    FDisEnableType: boolean;
    FAutoTab: boolean;
    FDisEnableColor: TColor;
    FOnEnterColor: TColor;
    FExitcolor: TColor;
    FDisEnabledFont: TFont;
    FNextTabComponent: TWinControl;
    FPerTabComponent: TWinControl;
    FFStopErrorKey: boolean;
    FOldValue: string;
    FOnChangeColor: TColor;
    FChangeColorSet: boolean;
    FBindLabel: TLabel;
    FActive: boolean;
    JsonClientDataSet1: TJsonClientDataSet;
    FHelpOptions: THelpOptions;
    //FOnChange: TNotifyEvent;
    resultListMap:TList<TDictionary<String,Variant>>;
    function GetPerent(Sender: TWinControl): TWinControl;
    procedure SetNextTabComponent(const Value: TWinControl);
    procedure SetPerTabComponent(const Value: TWinControl);
    procedure FindParControl;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure SetAutoTab(const Value: boolean);
    procedure SetDisEnableColor(const Value: TColor);
    procedure SetDisEnabledFont(const Value: TFont);
    procedure SetDisEnableType(const Value: boolean);
    procedure SetFStopErrorKey(const Value: boolean);
    procedure SetOldValue(const Value: string);
    procedure SetOnChangeColor(const Value: TColor);
    procedure SetChangeColorSet(const Value: boolean);
    procedure SetBindLabel(const Value: TLabel);
    procedure SetActive(const Value: boolean);
    procedure SetHelpOptions(const Value: THelpOptions);
    procedure initParamter;
    function GetHelpFieldValue(const ParamName: WideString): Variant;
    procedure SetParams(const Value: TParams);
    function GetParams: TParams;
  protected
    property Caption;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Function GetPerentForm: TCustomForm;
    function HaveChange: boolean;
    function GetChangeText: string;
    function SetItemIndexByField(fieldname:String;value:variant):Integer;
    property HelpFieldValue[const ParamName: WideString]
      : Variant read GetHelpFieldValue;
  published
    property Active: boolean read FActive write SetActive default False;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure Change;override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    property OnEnterColor: TColor read FOnEnterColor write FOnEnterColor;
    property OnExitColot: TColor read FExitcolor write FExitcolor;
    Property AutoTab: boolean read FAutoTab write SetAutoTab default False;
    Property PerTabComponent: TWinControl read FPerTabComponent write
      SetPerTabComponent;
    Property NextTabComponent: TWinControl read FNextTabComponent write
      SetNextTabComponent;
    Property DisEnableFont: TFont read FDisEnabledFont write SetDisEnabledFont;
    Property DisEnableType
      : boolean read FDisEnableType write SetDisEnableType
      default true;
    Property DisEnableColor
      : TColor read FDisEnableColor write SetDisEnableColor;
    Property OnChangeColor: TColor read FOnChangeColor write SetOnChangeColor;
    property OldValue: string read FOldValue write SetOldValue;
    property ChangeColorSet
      : boolean read FChangeColorSet write SetChangeColorSet default False;
    property BindLabel: TLabel read FBindLabel write SetBindLabel;
    Property HelpOptions: THelpOptions read FHelpOptions write SetHelpOptions;
    property Params: TParams read GetParams write SetParams;
   // property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNovaHComboBox]);
end;
{ TNovaHComboBox }

procedure TNovaHComboBox.Change;
begin
 // if Assigned(FOnChange) then
 { if FHelpOptions.FDisAll then
   text:='全部'
  else if trim(self.Text)='' then
       self.Text:='请选择...';    }
  inherited;
end;

constructor TNovaHComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHelpOptions := THelpOptions.Create(Self);
  JsonClientDataSet1 := TJsonClientDataSet.Create(Self);
  imeMode := imClose;
 { if FHelpOptions.FDisAll then
   text:='全部'
  else if trim(self.Text)='' then
       self.Text:='请选择...';  }
  FOnEnterColor := clGradientActiveCaption;
  FExitcolor := clWindow;
  FOnChangeColor := $004ACBD9;
  FAutoTab := False;
  FDisEnableColor := clred;
  FDisEnableType := true;
  FDisEnabledFont := Tfont.Create;
{  FGridHeadFont := Tfont.Create;
  FGridHeadFont.Name := '宋体'; // Screen.Forms[0].Font.name;
  FGridHeadFont.Size := 16;
  FTitleFont.PixelsPerInch := Screen.forms[0].Font.PixelsPerInch;
  FTitleFont.Charset := Screen.forms[0].Font.Charset;
  FTitleFont.Color := Screen.forms[0].Font.Color;
  FTitleFont.Height := -19;
  FTitleFont.Pitch := Screen.forms[0].Font.Pitch;
  FTitleFont.Style := Screen.forms[0].Font.Style;}
  resultListMap:=TList<TDictionary<String,Variant>>.Create;
end;

destructor TNovaHComboBox.Destroy;
begin
  FHelpOptions.Free;
  JsonClientDataSet1.Free;
  inherited Destroy;
end;

procedure TNovaHComboBox.DoEnter;
begin
  inherited;
  Color := FOnEnterColor;
end;

procedure TNovaHComboBox.DoExit;
begin
  if HaveChange then
  begin
    Color := FOnChangeColor;
  end
  else
  begin
    Color := FExitcolor;
  end;
  inherited;
end;

procedure TNovaHComboBox.FindParControl;
var
  I: Integer; // StartIndex
  ParForm: TWinControl;
begin
  try
    ParForm := Parent;
    for I := 0 to ParForm.ControlCount - 1 do
    begin
      if ParForm.Controls[I].Name = Self.Name then
      begin
        if I = 0 then
        begin
          if (ParForm.Controls[ParForm.ControlCount - 1] as TWinControl)
            .CanFocus then
          begin (ParForm.Controls[ParForm.ControlCount - 1] as TWinControl)
            .SetFocus;
            break;
          end;
        end
        else
        begin
          if (ParForm.Controls[I - 1] as TWinControl).CanFocus then
          begin (ParForm.Controls[I - 1] as TWinControl)
            .SetFocus;
            break;
          end;
        end;
      end;
    end;
  finally

  end;
end;

function TNovaHComboBox.GetChangeText: string;
begin
  result := '';
  if not HaveChange then
    exit;
  if Assigned(FBindLabel) then
  begin
    result := FBindLabel.Caption;
  end;
  result := '原:' + Self.OldValue + ';新' + Text;
end;

function TNovaHComboBox.GetHelpFieldValue(const ParamName: WideString): Variant;
var
  i: Integer;
  notfindField: boolean;
  row:TDictionary<String,Variant>;
begin
  result := '';
  if self.ItemIndex<0 then
     exit;
  notfindField := true;
  row:=resultListMap.Items[Self.ItemIndex];
  if row.ContainsKey(ParamName) then
  begin
    result:=row.Items[ParamName];
    notfindField := false;
  end;
  if notfindField then
    raise Exception.Create('TNovaHComboBox:没有"' + ParamName + '"这个字段');
end;

function TNovaHComboBox.GetParams: TParams;
begin
  Result:=JsonClientDataSet1.Params;
end;

function TNovaHComboBox.GetPerent(Sender: TWinControl): TWinControl;
begin
  if Sender = nil then
  begin
    Sender := Self;
  end;

  if Sender.Parent = nil then
  begin
    result := Sender;
  end
  else
  begin
    result := GetPerent(Sender.Parent);
  end;
end;

function TNovaHComboBox.GetPerentForm: TCustomForm;
begin
  result := GetParentForm(Self);
end;

function TNovaHComboBox.HaveChange: boolean;
begin
  result := False;
  if FChangeColorSet then
  begin
    if ((Text = '') and (OldValue = '')) then
    begin
      result := False;
    end
    else
    begin
      result := not(Trim(Text) = Trim(FOldValue));
    end;
  end;
end;

procedure TNovaHComboBox.initParamter;
begin
  if (JsonClientDataSet1.RemoteServer = nil) then
  begin
    JsonClientDataSet1.RemoteServer := HelpOptions.FJSONConnection;
    if HelpOptions.FQueryAddress = '' then
      JsonClientDataSet1.QueryAddress := 'system/help'
    else
      JsonClientDataSet1.QueryAddress := HelpOptions.FQueryAddress;
    if HelpOptions.FDataSourceName = '' then
      JsonClientDataSet1.DataSourceName := 'helpmap'
    else
      JsonClientDataSet1.DataSourceName := HelpOptions.FDataSourceName;
  end;
end;

procedure TNovaHComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TNovaHComboBox.KeyPress(var Key: Char);
begin
  if FAutoTab then
  begin
    if Key = #27 then
    begin
      if FPerTabComponent <> nil then
      begin
        if FPerTabComponent.CanFocus then
        begin
          FPerTabComponent.SetFocus;
        end;
      end
      else
      begin
        selectNext((GetPerent(nil) as Tform).activeControl, False, False);
      end;
    end;
    if Key = #13 then
    begin
      if FNextTabComponent <> nil then
      begin
        if FNextTabComponent.CanFocus then
        begin
          FNextTabComponent.SetFocus;
        end;
      end
      else
      begin
        keybd_event(9, 0, 0, 0);
        keybd_event(9, 0, 2, 0);
      end;
    end;
  end;
  inherited;

end;

procedure TNovaHComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TNovaHComboBox.SetActive(const Value: boolean);
var
   i:integer;
   row:TDictionary<String,Variant>;
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
    begin
      initParamter;

      if ((self.FHelpOptions.FJSONConnection.Connected) and
       (JsonClientDataSet1.RemoteServer <> nil)) then
      begin
        with JsonClientDataSet1 do
        begin
          Active := False;
//          with JsonClientDataSet1 do
//          begin
//            Params.Clear;
//            Params.Assign(self.FHelpOptions.Params);
//          end;
          resultListMap.Clear;
          try
            Active := true;
            Self.Items.Clear;
            if recordcount > 0 then
            begin
              if FHelpOptions.FDisAll then
              begin
                row:=TDictionary<String,Variant>.Create;
                for i := 0 to Fields.Count - 1 do
                begin
                  if HelpOptions.displayFieldname=Fields.Fields[i].FieldName then
                  begin
                    row.Add(Fields.Fields[i].FieldName,'全部');
                  end
                  else
                    row.Add(Fields.Fields[i].FieldName,null);
                end;
                resultListMap.Add(row);
                Items.Add('全部');
              end;

              while not eof do
              begin
                row:=TDictionary<String,Variant>.Create;
                for i := 0 to Fields.Count - 1 do
                begin
                  row.Add(Fields.Fields[i].FieldName,Fields.Fields[i].Value);
                end;
                resultListMap.Add(row);
                Self.Items.Add(FieldByName(HelpOptions.displayFieldname).AsString);
                Next;
              end;
              if ((FHelpOptions.FAutoSelectFirst) and (self.ItemCount>0)) then
                   self.ItemIndex:=0;

            end;
          except
            on E: Exception do
            begin
              FActive := false;
              ShowMessage('控件错误' + E.message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TNovaHComboBox.SetAutoTab(const Value: boolean);
begin
  FAutoTab := Value;
end;

procedure TNovaHComboBox.SetBindLabel(const Value: TLabel);
begin
  FBindLabel := Value;
end;

procedure TNovaHComboBox.SetChangeColorSet(const Value: boolean);
begin
  FChangeColorSet := Value;
end;

procedure TNovaHComboBox.SetDisEnableColor(const Value: TColor);
begin
  FDisEnableColor := Value;
end;

procedure TNovaHComboBox.SetDisEnabledFont(const Value: TFont);
begin
  if Assigned(Value) then
     FDisEnabledFont := Value;
end;

procedure TNovaHComboBox.SetDisEnableType(const Value: boolean);
begin
  FDisEnableType := Value;
end;

procedure TNovaHComboBox.SetFStopErrorKey(const Value: boolean);
begin
  FFStopErrorKey := Value;
end;

procedure TNovaHComboBox.SetHelpOptions(const Value: THelpOptions);
begin
  FHelpOptions := Value;
end;

function TNovaHComboBox.SetItemIndexByField(fieldname: String;
  value: variant): Integer;
var I: Integer;
    find:boolean;
    row:TDictionary<String,variant>;
begin
  find:=False;
  if resultListMap<>nil then
  begin
    for i:=0 to resultListMap.Count-1 do
    begin
      row:=resultListMap.Items[i];
      if (row.ContainsKey(fieldname)) and (row.Items[fieldname]=value) then
      begin
        self.ItemIndex:=i;
        Result:=i;
        find:=true;
        Break;
      end;
    end;
  end;
  if not find then
  begin
    self.ItemIndex:=-1;
    Result:=-1;
  end;
end;

procedure TNovaHComboBox.SetNextTabComponent(const Value: TWinControl);
begin
  FNextTabComponent := Value;
end;

procedure TNovaHComboBox.SetOldValue(const Value: string);
begin
  FOldValue := Value;
  FChangeColorSet := Value <> '';
end;

procedure TNovaHComboBox.SetOnChangeColor(const Value: TColor);
begin
  FOnChangeColor := Value;
end;

procedure TNovaHComboBox.SetParams(const Value: TParams);
begin
  JsonClientDataSet1.Params.Assign(Value);
end;

procedure TNovaHComboBox.SetPerTabComponent(const Value: TWinControl);
begin
  FPerTabComponent := Value;
end;

procedure TNovaHComboBox.WMPaint(var Message: TWMPaint);
var
  C: TControlCanvas;
  R: TRect;
begin
  inherited;
  if FDisEnableType then
  begin
    if not Enabled then
    begin
      C := TControlCanvas.Create;
      try
        C.Control := Self;
        with C do
        begin
          R := ClientRect;
          C.Font := Self.Font;
          C.Font.Color := FDisEnableColor;
          TextOut(R.Left+3, R.Top+4, Text + ' ');
        end;
      finally
        C.Free;
      end;
    end;
  end;

end;

{ THelpOptions }

constructor THelpOptions.Create(AOwner: TComponent);
begin
  FQueryAddress := 'system/help';
  FDataSourceName := 'helpmap';
  displayFieldname:='name';
  inherited Create;
end;

destructor THelpOptions.Destroy;
begin
  inherited;
end;

procedure THelpOptions.SetDataSourceName(const Value: String);
begin
  FDataSourceName := Value;
end;

procedure THelpOptions.SetDisAll(const Value: boolean);
begin
  FDisAll := Value;
end;

procedure THelpOptions.SetIsDebug(const Value: boolean);
begin
  FAutoSelectFirst := Value;
end;

procedure THelpOptions.SetJSONConnection(const Value: TJSONConnection);
begin
  FJSONConnection := Value;
end;

procedure THelpOptions.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

end.
