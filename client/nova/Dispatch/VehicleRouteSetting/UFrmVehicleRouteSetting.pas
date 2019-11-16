unit UFrmVehicleRouteSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmVehicleRouteSetting = class(TSimpleCRUDForm)
    NvDbgridEh1: TNvDbgridEh;
    jcdsdelctrl: TjsonClientDataSet;
    cbborg: TNovaCheckedComboBox;
    Nvehicleno: TNovaHelp;
    NRoute: TNovaHelp;
    Label4: TLabel;
    lbl3: TLabel;
    Label2: TLabel;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NvehiclenoIdChange(Sender: TObject);
    procedure NRouteIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleRouteSetting: TFrmVehicleRouteSetting;

implementation
  uses UFrmVehicleRouteSettingAdd,Services,UFrmVehicleRouteSettingEdit;
{$R *.dfm}

procedure TFrmVehicleRouteSetting.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := false;
  cbborg.Active := true;
end;

procedure TFrmVehicleRouteSetting.NRouteIdChange(Sender: TObject);
begin
  inherited;
 tbtnFilterClick(sender);
end;

procedure TFrmVehicleRouteSetting.NvehiclenoIdChange(Sender: TObject);
begin
  inherited;
    tbtnFilterClick(sender);
end;

procedure TFrmVehicleRouteSetting.tbtnDeleteClick(Sender: TObject);

  var
  nResult : Integer;
  sResult : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jcdsdelctrl do
  try
    close;
    Params.ParamByName('id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    tbtnFilterClick(sender);
  except
    on E: Exception do
    begin
      SysLog.WriteErr('删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmVehicleRouteSetting.tbtnEditClick(Sender: TObject);
begin
  inherited;
 if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmVehicleRouteSettingEdit := TFrmVehicleRouteSettingEdit.Create(self);
  with FrmVehicleRouteSettingEdit do
  begin
    id :=  jcdsResult.FieldByName('id').AsLargeInt;
    Nvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    Nvehicleno.Id :=   jcdsResult.FieldByName('vehicleid').AsLargeInt ;
    cbborg.Text:= jcdsResult.FieldByName('orgname').AsString;
    NRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NRoute.Text:=  jcdsResult.FieldByName('routename').AsString;
    Caption := '编辑设置';
    if SysMainForm.showFormModal(FrmVehicleRouteSettingEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmVehicleRouteSetting.tbtnFilterClick(Sender: TObject);
begin
  inherited;
 with jcdsResult do
  begin
     Active := False;
     if Trim(cbborg.Text)='' then
      Params.ParamByName('filter_INS_vr!orgid').Value := null
     else
      Params.ParamByName('filter_INS_vr!orgid').Value := cbborg.GetSelectID;

     if Trim(Nvehicleno.Text)='' then
      Params.ParamByName('filter_EQS_vr!vehicleid').Value := null
     else
      Params.ParamByName('filter_EQS_vr!vehicleid').Value := Nvehicleno.Id;

     if Trim(NRoute.Text)='' then
      Params.ParamByName('filter_EQS_vr!routeid').Value := null
     else
      Params.ParamByName('filter_EQS_vr!routeid').Value := NRoute.Id;

     Active := True;
  end;
end;

procedure TFrmVehicleRouteSetting.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmVehicleRouteSettingAdd := TFrmVehicleRouteSettingAdd.Create(self);
  with FrmVehicleRouteSettingAdd do
  begin
    id :=0;
    Caption := '添加设置';
    if SysMainForm.showFormModal(FrmVehicleRouteSettingAdd) = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
