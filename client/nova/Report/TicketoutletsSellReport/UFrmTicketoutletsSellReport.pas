unit UFrmTicketoutletsSellReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  CheckLst, NovaHComboBox;

type
  TFrmTicketoutletsSellReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label6: TLabel;
    NovaHelpBalanceUnit: TNovaHelp;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    lbl3: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dtpBselldateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketoutletsSellReport: TFrmTicketoutletsSellReport;

implementation

uses PubFn, Services;
{$R *.dfm}

procedure TFrmTicketoutletsSellReport.dtpBselldateClick(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked then
  begin
    dtpEselldate.Checked:=true;
  end
  else
  begin
    dtpEselldate.Checked:=false;
  end;
end;

procedure TFrmTicketoutletsSellReport.FormCreate(Sender: TObject);
begin
  inherited;
  // dbgrdhResult.OddRowColor:=clSkyBlue; //奇数行颜色
end;

procedure TFrmTicketoutletsSellReport.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpBselldate.Date := Now;
  dtpEselldate.Date := Now;
  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := True;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TFrmTicketoutletsSellReport.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if nvckbOrgid.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
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
  if NovaChkPrintOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择打单机构！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_printorg!id'] :=
      NovaChkPrintOrg.GetSelectID; // 开运量单位
    Params.ParamValues['filter_GED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;
    log := '[发车日期]' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + '[至]' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date);
    if (NHelpRoute.Text <> '') and (NHelpRoute.Id > 0) then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;

    if (NovaHelpBalanceUnit.Text <> '') and (NovaHelpBalanceUnit.Id > 0) then
      Params.ParamValues['filter_EQL_u!id'] := NovaHelpBalanceUnit.Id
    else
      Params.ParamValues['filter_EQL_u!id'] := null;

    if (NovaHelpVehiclenoHelp.Text <> '') and (NovaHelpVehiclenoHelp.Id > 0)
      then
      Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehiclenoHelp.Id
    else
      Params.ParamValues['filter_EQL_v!id'] := null;
    // 售票点
    if nvhelpTicketoutlets.Text <> '' then
    begin
      Params.ParamValues['filter_EQS_ts!ticketoutletsname'] :=
        nvhelpTicketoutlets.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ts!ticketoutletsname'] := null;
    end;
    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime']:=FormatDateTime('yyyy-mm-dd', dtpBselldate.Date)+' 00:00:00';
      Params.ParamValues['filter_LED_ts!selltime']:=FormatDateTime('yyyy-mm-dd', dtpEselldate.Date)+' 23:59:59';
    end
    else
    begin
      Params.ParamValues['filter_GED_ts!selltime']:=null;
      Params.ParamValues['filter_LED_ts!selltime']:=null;
    end;
    dbgrdhResult.PrintInfo.PageTopRight := '发车日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' 至' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    if NHelpRoute.Id <> 0 then
      log := log + ',[线路]：' + NHelpRoute.Text;
    if NovaHelpBalanceUnit.Id <> 0 then
      log := log + ',[结算单位]:' + NovaHelpBalanceUnit.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log := log + ',[营运车辆]:' + NovaHelpVehiclenoHelp.Text;
    if NovaChkPrintOrg.GetSelectID <> '' then
      log := log + ',[开运量单位]:' + NovaChkPrintOrg.Text;
    if nvhelpTicketoutlets.Id > 0 then
    begin
      log := log + ',[售票点]:' + nvhelpTicketoutlets.Text;
    end;
    SysLog.WriteLog('报表统计->售票点班线售票情况表', '查询', log);
    Active := True;
  end
end;

end.
