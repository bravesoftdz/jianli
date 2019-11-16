unit UFrmQueryDayBookings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
    TfrmQueryDayBookings = class(TSimpleCRUDForm)lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl3: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    lbl16: TLabel;
    jcdsResultorgname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultticketoutletsname: TWideStringField;
    jcdsResultticketoutletstype: TWideStringField;
    jcdsResultnumPercent: TWideStringField;
    jcdsResultbacktenprice: TFloatField;
    jcdsResultpricePercent: TWideStringField;
    jcdsResultsamedaynum4: TFloatField;
    jcdsResultsamedaynum1: TFloatField;
    jcdsResultsamedaynum2: TFloatField;
    jcdsResultsamedaynum3: TFloatField;
    jcdsResultsamedaynum5: TFloatField;
    jcdsResultsamedaynum6: TFloatField;
    jcdsResultsamedaynum7: TFloatField;
    jcdsResultsamedaynum8: TFloatField;
    jcdsResultsamedaynum9: TFloatField;
    jcdsResultsamedaynum10: TFloatField;
    jcdsticketoutletsvalue: TjsonClientDataSet;
    jcdsResultticketoutletstypevalue: TWideStringField;
    nvhcbbTickettype: TNovaComboBox;
    jcdsResultsamedaynum: TFloatField;
    jcdsResultbacktennum: TFloatField;
    jcdsResultsamedayprice: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid: String;
    { Public declarations }
  end;

var
  frmQueryDayBookings: TfrmQueryDayBookings;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryDayBookings.FormCreate(Sender: TObject);
var
  columntitle: TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  jcdsticketoutletsvalue.Active := False;
  jcdsticketoutletsvalue.Active := True;
end;

procedure TfrmQueryDayBookings.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryDayBookings.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  nvckbOrgid.SetFocus; // 消除选择时间bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  { if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
    begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
    end;
    if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
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
    }
  { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
    begin
    SysDialogs.Warning('同比日期天数差必须等于发车日期天数差!');
    Exit;
    end; }
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date + 1);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date + 1);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date + 11);

    if nvhelpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!routeid'] := nvhelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!routeid'] := '';

    if nvhelpTicketoutlets.Id <= 0 then
      Params.ParamValues['filter_EQL_t!ticketoutletsid'] := ''
    else
      Params.ParamValues['filter_EQL_t!ticketoutletsid'] :=
        nvhelpTicketoutlets.Id;

    if nvhcbbTickettype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_t!ticketoutletstype'] :=
        ''
    else
      Params.ParamValues['filter_EQS_t!ticketoutletstype'] := nvhcbbTickettype.GetSelectCode;
    {
      Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
      Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
      Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);
      }
    Active := True;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '日期：' + FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);

    log := '查询条件有：[日期]' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date);
    // +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)

    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[机构]：' + nvckbOrgid.Text;

    log := log + ' 。[查询结果]:返回 ' + inttostr(RecordCount) + ' 条记录！';
    SysLog.WriteLog('报表统计->预售票日报表', '查询', log);
  end;

end;

end.
