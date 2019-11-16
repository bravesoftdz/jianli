unit UFrmQueryVehicleLicense;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,UDMPublic;

type
  TFrmQueryVehicleLicense = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label8: TLabel;
    cbbOvertime: TComboBox;
    NovaChkReportOrg: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryVehicleLicense: TFrmQueryVehicleLicense;

implementation
 uses PubFn, Services;
{$R *.dfm}

procedure TFrmQueryVehicleLicense.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date:=now;
  dtpenddate.Date:=now;
  NovaChkReportOrg.Active := False;
  NovaChkReportOrg.Active := True;
  NovaChkReportOrg.CheckById(True, sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQueryVehicleLicense.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if NovaChkReportOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择报到机构！');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpenddate.Date - dtpstartdate.Date) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['rp.orgids'] := NovaChkReportOrg.GetSelectID;
    Params.ParamValues['rp.schtype'] := cbbOvertime.ItemIndex;
    Params.ParamValues['rp.unitid'] := NovaHelpUnit.Id;
    Params.ParamValues['rp.routeid'] := NHelpRoute.Id;
    Params.ParamValues['rp.vehicleid'] := NovaHelpVehiclenoHelp.Id;
    Params.ParamValues['rp.startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['rp.enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    dbgrdhResult.PrintInfo.Title:=sysinfo.LoginUserInfo.OrgName+self.Caption;
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '发车日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' 至' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(NovaChkReportOrg.GetSelectID) <>'' then
      log := log +',[报到机构]：'+NovaChkReportOrg.Text;
    if NovaHelpUnit.Id <>0 then
      log  := log +',[车属单位]:'+NovaHelpUnit.Text;
    if NHelpRoute.Id <> 0 then
      log := log +'[线路]：'+NHelpRoute.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log:= log+',[车辆]:'+NovaHelpVehiclenoHelp.Text;
    if cbbOvertime.Text <>'' then
      log := log +',[班次类型]'+cbbOvertime.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->车辆应班登记表','查询',log);
  end;

end;

end.
