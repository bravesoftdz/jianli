unit UFrmVehicleDepartinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic;

type
  TFrmVehicleDepartinvoices = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    lbl2: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    Label4: TLabel;
    nvhelpunitname: TNovaHelp;
    nvhelpvehicleno: TNovaHelp;
    chkovertime: TCheckBox;
    chknotovertime: TCheckBox;
    lblvehicletypeid: TLabel;
    NovaHVehicleTypes: TNovaHelp;
    Label12: TLabel;
    cbbbalancetype: TComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleDepartinvoices: TFrmVehicleDepartinvoices;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVehicleDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  cbbbalancetype.ItemIndex:=0;

end;

procedure TFrmVehicleDepartinvoices.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmVehicleDepartinvoices.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if trim(cbbOrgid.GetSelectID) = '' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := cbbOrgid.GetSelectID;
    params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvhelpunitname.Text) = '' then
      Params.ParamValues['filter_EQL_u1!id'] := null
    else
      Params.ParamValues['filter_EQL_u1!id'] := nvhelpunitname.Id;
    if Trim(nvhelpvehicleno.Text) = '' then
      Params.ParamValues['filter_EQL_v!id'] := null
    else
      Params.ParamValues['filter_EQL_v!id'] := nvhelpvehicleno.Id;
    if Trim(NovaHVehicleTypes.Text) = '' then
      Params.ParamValues['filter_EQL_v!vehicletypeid'] := null
    else
      params.ParamValues['filter_EQL_v!vehicletypeid'] := NovaHVehicleTypes.Id;
    if ((chkovertime.Checked) and (chknotovertime.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'true';
    end else if ((chkovertime.Checked = false) and (chknotovertime.Checked)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'false';
    end else if ((chkovertime.Checked) and (chknotovertime.Checked)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:=null;
    end else if ((chkovertime.Checked = false) and (chknotovertime.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:=null;
    end;
    Params.ParamValues['balancetypeflag']:=cbbbalancetype.ItemIndex;
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbbOrgid.GetSelectID) <>'' then
      log := log +',[机构]：'+cbbOrgid.Text;
    if nvhelpunitname.Id <> 0 then
      log := log +',[车属单位]:'+ nvhelpunitname.Text;
    if nvhelpvehicleno.Id <> 0 then
      log := log+',[车牌号]:'+nvhelpvehicleno.Text;
    if Trim(NovaHVehicleTypes.Text)<>'' then
      log := log +',[车型]：'+NovaHVehicleTypes.Text;
    if chkovertime.Checked then
      log := log +',[加班]';
    if chknotovertime.Checked then
      log := log +',[正班]' ;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->车辆结算汇总查询','查询',log);

  end;
  dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);


end;

end.
