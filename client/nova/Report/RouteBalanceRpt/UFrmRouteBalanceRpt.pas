unit UFrmRouteBalanceRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmRouteBalanceRpt = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label2: TLabel;
    label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlroute: TNovaHelp;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRouteBalanceRpt: TFrmRouteBalanceRpt;

implementation

uses UDMPublic, Services, PubFn;
{$R *.dfm}

procedure TFrmRouteBalanceRpt.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;

end;

procedure TFrmRouteBalanceRpt.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)) <= Trunc
      (dtpenddate.Date - dtpstartdate.Date)) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
    log := '查询条件有：[发车日期]从 ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[机构]：' + nvckbOrgid.Text;
    if Trim(nvhlroute.Text) <> '' then
      log := log + ',[线路]：' + nvhlroute.Text;
    if chkIsOver.Checked then
      log := log + '班次类型：[加班]';
    if chkIsNotOver.Checked then
      log := log + '班次类型：[正班]';
    SysLog.WriteLog('报表统计->线路结算汇总表', '查询', log);
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_r!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    if (not(Trim(nvhlroute.Text) = '')) and (nvhlroute.Id > 0) then // 营运线路
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlroute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if not chkIsNotOver.Checked and chkIsOver.Checked then // 是否加班班次
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'true';
      // log := log+'加班,';
    end
    else if not chkIsOver.Checked and chkIsNotOver.Checked then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'false';
      // log := log+'正班,';
    end;



    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + Sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '发车日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' 至' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);

    Active := True;
  end;

end;

end.
