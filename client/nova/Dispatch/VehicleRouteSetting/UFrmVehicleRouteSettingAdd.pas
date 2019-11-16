unit UFrmVehicleRouteSettingAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, NovaHelp,
  NovaCheckedComboBox, DB, DBClient, jsonClientDataSet,Services, NovaHComboBox,
  Menus;

type
  TFrmVehicleRouteSettingAdd = class(TSimpleEditForm)
    Bevel2: TBevel;
    lbl3: TLabel;
    Label4: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    Nvehicleno: TNovaHelp;
    jcdssave: TjsonClientDataSet;
    DataSource1: TDataSource;
    jcdsSaveCtrl: TjsonClientDataSet;
    cbborg: TNovaHComboBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure NvehiclenoIdChange(Sender: TObject);
     procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
   ids : string;
    { Private declarations }
  public
   id : integer;
    { Public declarations }
  end;

var
  FrmVehicleRouteSettingAdd: TFrmVehicleRouteSettingAdd;

implementation

{$R *.dfm}

procedure TFrmVehicleRouteSettingAdd.bbtnSaveClick(Sender: TObject);
var
  nResult : Integer;
  sResult : string;
begin
  inherited;

 if (Trim(cbborg.Text)='') or (cbborg.HelpFieldValue['id'] =null) then
  begin
    SysDialogs.Warning('机构不能为空!');
    Exit;
  end;
  if (Trim(Nvehicleno.Text)='') or (Nvehicleno.Id=0) then
  begin
    SysDialogs.Warning('车辆不能为空!');
    Exit;
  end;
   ids := '';
     with jcdsSaveCtrl do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('isselect').AsBoolean then
      ids := ids + fieldbyname('id').AsString + ',';
      Next;
    end;
  end;
  if ids = '' then
  begin
    SysDialogs.Warning('未选择线路!');
    exit;
  end;
  with jcdssave do
  begin
    Active:=False;
    Params.ParamValues['id'] :=id;
    Params.ParamValues['orgid'] := cbborg.HelpFieldValue['id'];
    Params.ParamValues['vehicleid'] := Nvehicleno.Id;
    Params.ParamValues['routeids'] := Trim(ids);
    try
      Execute;
     nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保存失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicleRouteSettingAdd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 ModalResult := mrok;
end;

procedure TFrmVehicleRouteSettingAdd.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active :=  false;
  cbborg.SetItemIndexByField('id',sysinfo.LoginUserInfo.OrgID);
  cbborg.Active :=  true;
end;

procedure TFrmVehicleRouteSettingAdd.FormShow(Sender: TObject);
begin
  inherited;
Nvehicleno.SetFocus;
end;

procedure TFrmVehicleRouteSettingAdd.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsSaveCtrl do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := true;
        next;
      end;
    end;
  end;
end;

procedure TFrmVehicleRouteSettingAdd.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsSaveCtrl do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := false;
        next;
      end;
    end;
  end;
end;

procedure TFrmVehicleRouteSettingAdd.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsSaveCtrl do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := not fieldbyname('isselect').AsBoolean;
        next;
      end;
    end;
  end;
end;

procedure TFrmVehicleRouteSettingAdd.NvehiclenoIdChange(Sender: TObject);
begin
  inherited;
 with jcdsSaveCtrl do
    begin
      Active:=False;
      Params.ParamValues['vehicleid'] := Nvehicleno.Id;
      Active:=True;
    end;
end;

end.
