unit UFrmQueryBusinessDataSummary;

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
    TfrmQueryBusinessDataSummary = class(TSimpleCRUDForm)lbl1: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    chkBylatter: TCheckBox;
    chkBynormal: TCheckBox;
    nvckbOrgid: TNovaCheckedComboBox;
    jcdsResultorgname: TWideStringField;
    jcdsResultschnum1: TFloatField;
    jcdsResultschnumComp: TFloatField;
    jcdsResultschnumPercent: TWideStringField;
    jcdsResultticketnum: TFloatField;
    jcdsResultticketnum1: TFloatField;
    jcdsResultticketnumComp: TFloatField;
    jcdsResultticketnumPercent: TWideStringField;
    jcdsResulttotalamount: TFloatField;
    jcdsResulttotalamount1: TFloatField;
    jcdsResulttotalamountComp: TFloatField;
    jcdsResulttotalamountPercent: TWideStringField;
    jcdsResultpeopledistance: TFloatField;
    jcdsResultpeopledistance1: TFloatField;
    jcdsResultpeopledistanceComp: TFloatField;
    jcdsResultpeopledistancePercent: TWideStringField;
    jcdsResultrate: TWideStringField;
    jcdsResultrate1: TWideStringField;
    jcdsResultrateComp: TWideStringField;
    jcdsResultratePercent: TWideStringField;
    jcdsResultsellincome: TFloatField;
    jcdsResultsellincome1: TFloatField;
    jcdsResultsellincomeComp: TFloatField;
    jcdsResultsellincomePercent: TWideStringField;
    jcdsResultschnum: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
    // procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid: String;
    { Public declarations }
  end;

var
  frmQueryBusinessDataSummary: TfrmQueryBusinessDataSummary;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryBusinessDataSummary.dtpComEndChange(Sender: TObject);
begin
  if not(dtpComEnd.Date = dtpComStar.Date + dtpenddate.Date -
      dtpstartdate.Date) then
  begin
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
  end;
end;

procedure TfrmQueryBusinessDataSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
end;

procedure TfrmQueryBusinessDataSummary.dtpenddateChange(Sender: TObject);
begin
  // if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  // begin
  // dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
  // end;

end;

// procedure TfrmQueryBusinessDataSummary.dtpstartdateChange(Sender: TObject);
// begin
// inherited;
// if dtpstartdate.Checked then
// dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
// end;

procedure TfrmQueryBusinessDataSummary.FormCreate(Sender: TObject);
var
  columntitle: TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  chkBylatter.Checked := True;
  chkBynormal.Checked := True;
end;

procedure TfrmQueryBusinessDataSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBusinessDataSummary.tbtnFilterClick(Sender: TObject);
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
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
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
  if StrToInt(getParametervalue('0007', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpenddate.Date - dtpstartdate.Date) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
    begin
    SysDialogs.Warning('同比日期天数差必须等于发车日期天数差!');
    Exit;
    end; }
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    // if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    // end
    // else
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= '';
    // end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpComEnd.Date);



    Active := True;
   
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' 同比日期：'+ formatdatetime('yyyy-mm-dd',dtpComStar.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpComEnd.Date);

     log := '查询条件有：[发车日期]从 ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date)
      + '[同比日期] 从 ' + FormatDateTime('yyyy-mm-dd', dtpComStar.Date)
      + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpComEnd.Date);
    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[机构]：' + nvckbOrgid.Text;


    log := log + ' 。[查询结果]:返回 ' + inttostr(recordcount) + ' 条记录！';
    SysLog.WriteLog('报表统计->站务分公司站场业务数据情况汇总表', '查询', log);
  end;

end;

end.
