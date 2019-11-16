unit UFrmQueryTicketSummary;

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
  TfrmQueryTicketSummary = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
//    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryTicketSummary: TfrmQueryTicketSummary;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryTicketSummary.dtpComEndChange(Sender: TObject);
begin
   if not(dtpComEnd.Date=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date)
   then
   begin
      dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
   end;
end;

procedure TfrmQueryTicketSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
   dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
end;

procedure TfrmQueryTicketSummary.dtpenddateChange(Sender: TObject);
begin
//  if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
//  begin
//    dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
//  end;

end;

//procedure TfrmQueryTicketSummary.dtpstartdateChange(Sender: TObject);
//begin
//  inherited;
//  if dtpstartdate.Checked then
//  dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
//end;

procedure TfrmQueryTicketSummary.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryTicketSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryTicketSummary.tbtnFilterClick(Sender: TObject);
var
  log:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//消除选择时间bug
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
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
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

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date+1);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date+1);

    Active := True;

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' 同比日期：'+ formatdatetime('yyyy-mm-dd',dtpComStar.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpComEnd.Date);

   log := '查询条件有：[售票日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)
      +'[同比日期] 从 '+FormatDateTime('yyyy-mm-dd',dtpComStar.Date)
      +' 至 '+FormatDateTime('yyyy-mm-dd',dtpComEnd.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;

    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->站务分公司网点售票情况汇总表','查询',log);
  end;

end;

end.
