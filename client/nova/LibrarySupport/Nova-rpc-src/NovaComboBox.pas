unit NovaComboBox;
{------------------------------------
  功能说明：用于下拉的帮助下拉选择框,只查询数据字典表
  创建日期：2011/01/30
  作者：lanck
  版权：nova
-------------------------------------}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Forms, jsonConnection, jsonClientDataSet,db,Dialogs;

type
  TCommInfo = Class(Tobject) // 一个通用的类用于保存一下几个信息，比如机构,有TCombobox的用途都可调用
    ID: Integer;
    Value: String;
    Name: String;
    IsSelected: boolean;
  end;

  THelpOptions = class(TPersistent)
  private
    FDataSourceName: String;
    FQueryAddress: String;
    FJSONConnection: TJSONConnection;
    FTableName: String;
    FColumnname: String;
    FCode: String;
    FDisAll: boolean;
    FIsDebug: boolean;
    procedure SetDataSourceName(const Value: String);
    procedure SetJSONConnection(const Value: TJSONConnection);
    procedure SetQueryAddress(const Value: String);
    procedure SetColumnname(const Value: String);
    procedure SetTableName(const Value: String);
    procedure SetCode(const Value: String);
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
    Property TableName: String read FTableName write SetTableName;
    Property Columnname: String read FColumnname write SetColumnname;
    Property Code: String read FCode write SetCode;
    Property DisAll: boolean read FDisAll write SetDisAll default False;
    Property IsDebug: boolean read FIsDebug write SetIsDebug default False;
  end;

  TNovaComboBox = class(TComboBox)
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
  protected
    property Caption;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    Function GetPerentForm: TCustomForm;
    function HaveChange: boolean;
    function GetChangeText: string;
    function GetSelectID:integer;
    function GetSelectCode:String;
    function GetSelectValue:String;
    function SetItemIndexByID(id:Integer):Integer;
    function SetItemIndexByCode(code:string):Integer;
    function SetItemIndexByValue(value:String):Integer;
  published
    property Active: boolean read FActive write SetActive default False;
    procedure DoEnter; override;
    procedure DoExit; override;
//    procedure Change;override;
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
   // property OnChange: TNotifyEvent read FOnChange write FOnChange;


  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNovaComboBox]);
end;
{ TNovaComboBox }


constructor TNovaComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  self.Text:='请选择...';
  FHelpOptions := THelpOptions.Create(Self);
  JsonClientDataSet1 := TJsonClientDataSet.Create(Self);
  JsonClientDataSet1.Params.CreateParam(ftString, 'tablename', ptInput);
  JsonClientDataSet1.Params.CreateParam(ftString, 'columnname', ptInput);
  JsonClientDataSet1.Params.CreateParam(ftString, 'code', ptInput);
  imeMode := imClose;
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
end;

destructor TNovaComboBox.Destroy;
begin
  FHelpOptions.Free;
  JsonClientDataSet1.Free;
  inherited Destroy;
end;

procedure TNovaComboBox.DoEnter;
begin
  inherited;
  Color := FOnEnterColor;
end;

procedure TNovaComboBox.DoExit;
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

procedure TNovaComboBox.FindParControl;
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

function TNovaComboBox.GetChangeText: string;
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

function TNovaComboBox.GetPerent(Sender: TWinControl): TWinControl;
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

function TNovaComboBox.GetPerentForm: TCustomForm;
begin
  result := GetParentForm(Self);
end;

function TNovaComboBox.GetSelectCode: String;
begin
  if (self.ItemIndex>=0) then
    result:=TCommInfo(Items.Objects[ItemIndex]).Value
  else
   result:='';
end;

function TNovaComboBox.GetSelectID: integer;
begin
  if (self.ItemIndex>=0) then
    result:=TCommInfo(Items.Objects[ItemIndex]).ID
  else
   result:=-1;
end;

function TNovaComboBox.GetSelectValue: String;
begin
  if (self.ItemIndex>=0) then
    result:=TCommInfo(Items.Objects[ItemIndex]).name
  else
   result:='';
end;

function TNovaComboBox.HaveChange: boolean;
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

procedure TNovaComboBox.initParamter;
begin
  if (JsonClientDataSet1.RemoteServer = nil) then
  begin
    JsonClientDataSet1.RemoteServer := HelpOptions.FJSONConnection;
    if HelpOptions.FQueryAddress = '' then
      JsonClientDataSet1.QueryAddress := 'system/querydictionary'
    else
      JsonClientDataSet1.QueryAddress := HelpOptions.FQueryAddress;
    if HelpOptions.FDataSourceName = '' then
      JsonClientDataSet1.DataSourceName := 'diclist'
    else
      JsonClientDataSet1.DataSourceName := HelpOptions.FDataSourceName;
    if ((FHelpOptions.Columnname <> '') and (FHelpOptions.TableName<>'')) then
    begin
      JsonClientDataSet1.Params.ParamByName('Columnname').Value :=
       FHelpOptions.Columnname;
      JsonClientDataSet1.Params.ParamByName('TableName').Value :=
       FHelpOptions.TableName;
    end;
    if (FHelpOptions.FCode <> '') then
    begin
      JsonClientDataSet1.Params.ParamByName('Code').Value :=
       FHelpOptions.Code;
    end;
  end;
end;

procedure TNovaComboBox.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TNovaComboBox.KeyPress(var Key: Char);
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

procedure TNovaComboBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

procedure TNovaComboBox.SetActive(const Value: boolean);
var
   CommInfo:TCommInfo;
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
          try
            Active := true;
            if recordcount > 0 then
            begin
             // Self.Text:='';
              Self.Items.Clear;
              if FHelpOptions.FDisAll then
              begin
                CommInfo := TCommInfo.Create;
                CommInfo.ID := 0;
                CommInfo.Name := '全部';
                CommInfo.Value := '';
                Self.Items.AddObject(CommInfo.Name, CommInfo);
              end;
             { else
              begin
                CommInfo := TCommInfo.Create;
                CommInfo.ID := 0;
                CommInfo.Name := '请选择...';
                CommInfo.Value := '';
                Self.Items.AddObject(CommInfo.Name, CommInfo);
              end; }

              while not eof do
              begin
                CommInfo := TCommInfo.Create;
                CommInfo.ID := Fieldbyname('ID').AsInteger;
                CommInfo.Name := Fieldbyname('value').AsString;
                CommInfo.Value := Fieldbyname('CODE').AsString;
                Self.Items.AddObject(CommInfo.Name, CommInfo);
                Next;
              end;
              if ((FHelpOptions.FIsDebug) and (self.ItemCount>0)) then
                   self.ItemIndex:=0;

            end;
          except
            on E: Exception do
            begin
              FActive := false;
              ShowMessage('控件信息错误' + E.message);
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TNovaComboBox.SetAutoTab(const Value: boolean);
begin
  FAutoTab := Value;
end;

procedure TNovaComboBox.SetBindLabel(const Value: TLabel);
begin
  FBindLabel := Value;
end;

procedure TNovaComboBox.SetChangeColorSet(const Value: boolean);
begin
  FChangeColorSet := Value;
end;

procedure TNovaComboBox.SetDisEnableColor(const Value: TColor);
begin
  FDisEnableColor := Value;
end;

procedure TNovaComboBox.SetDisEnabledFont(const Value: TFont);
begin
  if Assigned(Value) then
     FDisEnabledFont := Value;
end;

procedure TNovaComboBox.SetDisEnableType(const Value: boolean);
begin
  FDisEnableType := Value;
end;

procedure TNovaComboBox.SetFStopErrorKey(const Value: boolean);
begin
  FFStopErrorKey := Value;
end;

procedure TNovaComboBox.SetHelpOptions(const Value: THelpOptions);
begin
  FHelpOptions := Value;
end;

function TNovaComboBox.SetItemIndexByCode(code: string): Integer;
var I: Integer;
    find:boolean;
begin
  find:=False;
  for I := 0 to Items.Count - 1 do
  begin
    if TCommInfo(Items.Objects[i]).Value=code then
    begin
      self.ItemIndex:=i;
      Result:=i;
      find:=true;
      Break;
    end;
  end;
  if not find then
  begin
    self.ItemIndex:=-1;
    Result:=-1;
  end;
end;

function TNovaComboBox.SetItemIndexByID(id: Integer): Integer;
var I: Integer;
    find:boolean;
begin
  find:=False;
  for I := 0 to Items.Count - 1 do
  begin
    if TCommInfo(Items.Objects[i]).ID=id then
    begin
      self.ItemIndex:=i;
      Result:=i;
      find:=true;
      Break;
    end;
  end;
  if not find then
  begin
    self.ItemIndex:=-1;
    Result:=-1;
  end;
end;

function TNovaComboBox.SetItemIndexByValue(value: String): Integer;
var I: Integer;
    find:boolean;
begin
  find:=False;
  for I := 0 to Items.Count - 1 do
  begin
    if TCommInfo(Items.Objects[i]).name=value then
    begin
      self.ItemIndex:=i;
      Result:=i;
      find:=true;
      Break;
    end;
  end;
  if not find then
  begin
    self.ItemIndex:=-1;
    Result:=-1;
  end;
end;

procedure TNovaComboBox.SetNextTabComponent(const Value: TWinControl);
begin
  FNextTabComponent := Value;
end;

procedure TNovaComboBox.SetOldValue(const Value: string);
begin
  FOldValue := Value;
  FChangeColorSet := Value <> '';
end;

procedure TNovaComboBox.SetOnChangeColor(const Value: TColor);
begin
  FOnChangeColor := Value;
end;

procedure TNovaComboBox.SetPerTabComponent(const Value: TWinControl);
begin
  FPerTabComponent := Value;
end;

procedure TNovaComboBox.WMPaint(var Message: TWMPaint);
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
  FQueryAddress := 'system/querydictionary';
  FDataSourceName := 'diclist';
  inherited Create; ;

end;

destructor THelpOptions.Destroy;
begin

  inherited;
end;

procedure THelpOptions.SetCode(const Value: String);
begin
  FCode := Value;
end;

procedure THelpOptions.SetColumnname(const Value: String);
begin
  FColumnname := Value;
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
  FIsDebug := Value;
end;

procedure THelpOptions.SetJSONConnection(const Value: TJSONConnection);
begin
  FJSONConnection := Value;
end;

procedure THelpOptions.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

procedure THelpOptions.SetTableName(const Value: String);
begin
  FTableName := Value;
end;

end.
