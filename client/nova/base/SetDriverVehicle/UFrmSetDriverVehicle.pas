unit UFrmSetDriverVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaHComboBox;

type
  TfrmSetDriverVehicle = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    NovaHelpDriver: TNovaHelp;
    nvhlpVehicleno: TNovaHelp;
    jcdsDel: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetDriverVehicle: TfrmSetDriverVehicle;

implementation

uses Services, UFrmSetDriverVehicleAdd, UFrmSetDriverVehicleModify;
{$R *.dfm}

procedure TfrmSetDriverVehicle.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active := False;
  NovaHCbbOrg.Active := True;
end;

procedure TfrmSetDriverVehicle.FormShow(Sender: TObject);
begin
  inherited;
  with NovaHCbbOrg do
  begin
    Active := False;
    Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
    Active := True;
    NovaHCbbOrg.SetItemIndexByField('id', Sysinfo.LoginUserInfo.OrgID);
  end;
end;

procedure TfrmSetDriverVehicle.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult: integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if SysDialogs.Confirm('删除操作', '确认要删除所选吗？') then
    with jcdsDel do
    begin
      Active := false;
      Params.ParamValues['setDriverVehicleid'] := jcdsResult.FieldByName('id').AsString;

      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);
      Active := True;
    end;
  end;
end;

procedure TfrmSetDriverVehicle.tbtnEditClick(Sender: TObject);
begin
  inherited;
  frmSetDriverVehicleModify := TfrmSetDriverVehicleModify.Create(self);
  try
    with frmSetDriverVehicleModify do
    begin
       if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
       begin
       frmSetDriverVehicleModify.Caption := '修改驾驶员驾驶车辆';
       ID := jcdsResult.FieldByName('id').AsString; // 用来存放ID
       orgid := jcdsResult.FieldByName('orgid').AsString;
       driverid := jcdsResult.FieldByName('driverid').AsString;
       vehicleid := jcdsResult.FieldByName('vehicleid').AsString;

       NovaHCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
       NovaHCbbOrg.Enabled := False;
       NovaHelpDriver.Id := jcdsResult.FieldByName('driverid').AsInteger;
       NovaHelpDriver.Text := jcdsResult.FieldByName('drivername').AsString;
       NovaHelpDriver.Enabled := False;
       nvhlpVehicleno.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
       nvhlpVehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;

       if SysMainForm.showFormModal(frmSetDriverVehicleModify, False)= mrok then
       begin
         tbtnFilterClick(Sender);
       end;
       end;
    end;
  finally
    FreeAndNil(frmSetDriverVehicleModify);
  end;
end;

procedure TfrmSetDriverVehicle.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_s!orgid'] := NovaHCbbOrg.HelpFieldValue
      ['id'];
    if (not(Trim(NovaHelpDriver.Text) = '')) and (NovaHelpDriver.ID > 0) then
    begin
      Params.ParamValues['filter_EQL_s!driverid'] :=
        NovaHelpDriver.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!driverid'] := '';
    end;
    if (not(Trim(nvhlpVehicleno.Text) = '')) and (nvhlpVehicleno.ID > 0) then
    begin
      Params.ParamValues['filter_EQL_s!vehicleid'] :=
        nvhlpVehicleno.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!vehicleid'] := '';
    end;
    Active := True;
  end;
end;

procedure TfrmSetDriverVehicle.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  frmSetDriverVehicleAdd := TfrmSetDriverVehicleAdd.Create(self);
  try
    with frmSetDriverVehicleAdd do
    begin
      frmSetDriverVehicleAdd.Caption := '添加驾驶员驾驶车辆';
      with NovaHCbbOrg do
      begin
        Active := False;
        Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
        Active := True;
        NovaHCbbOrg.SetItemIndexByField('id', Sysinfo.LoginUserInfo.OrgID);
      end;
      if SysMainForm.showFormModal(frmSetDriverVehicleAdd, False) = mrok then
      begin
        tbtnFilterClick(Sender);
      end;
    end;
  finally
    FreeAndNil(frmSetDriverVehicleAdd);
  end;
end;

end.
