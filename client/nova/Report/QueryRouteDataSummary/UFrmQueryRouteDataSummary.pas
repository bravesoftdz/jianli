unit UFrmQueryRouteDataSummary;

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
  TfrmQueryRouteDataSummary = class(TSimpleCRUDForm)
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
    lbl5: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    chkBynormal: TCheckBox;
    chkBylatter: TCheckBox;
    Label2: TLabel;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryRouteDataSummary: TfrmQueryRouteDataSummary;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryRouteDataSummary.dtpComEndChange(Sender: TObject);
begin
   if not(dtpComEnd.Date=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date)
   then
   begin
      dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
   end;
end;

procedure TfrmQueryRouteDataSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
   dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
end;

procedure TfrmQueryRouteDataSummary.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  chkBylatter.Checked := True;
  chkBynormal.Checked := True;
end;

procedure TfrmQueryRouteDataSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := True;
  NovaChkPrintOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryRouteDataSummary.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
      if trim(NovaChkPrintOrg.Text)='' then
      begin
        dbgrdhResult.Columns[1].Visible :=false;
      end
      else
      begin
        dbgrdhResult.Columns[1].Visible :=true;
      end;
  end;
end;

procedure TfrmQueryRouteDataSummary.tbtnFilterClick(Sender: TObject);
var
  log:string;

  pstr:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//消除选择时间bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('请选择班次机构！');
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
    if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    begin
    Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= '';
    end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);
      Params.ParamValues['filter_INS_vr!reportorgid'] := NovaChkPrintOrg.GetSelectID;

    //是否按晚班排序
    if chkBylatter.Checked then
    begin
      Params.ParamValues['isbylatter']:= 'true';
      pstr :='正班';
    end
    else
      Params.ParamValues['isbylatter']:= 'false';

      //是否按正班
    if chkBynormal.Checked then
    begin
      Params.ParamValues['isbynormal']:= 'true';
      pstr :='加班';
    end
    else
      Params.ParamValues['isbynormal']:= 'false';

    Active := True;

    if chkBynormal.Checked and chkBylatter.Checked then
    begin
      pstr :='';
    end;

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' 同比日期：'+ formatdatetime('yyyy-mm-dd',dtpComStar.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpComEnd.Date)+'  '+pstr;

   log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)
      +'[同比日期] 从 '+FormatDateTime('yyyy-mm-dd',dtpComStar.Date)
      +' 至 '+FormatDateTime('yyyy-mm-dd',dtpComEnd.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log +',[线路]:'+ nvhlpRoute.Text;
    if chkBylatter.Checked then
      log := log +',[按加班车统计]' ;
    if chkBynormal.Checked then
      log := log +',[按正班车统计]';

    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->站务分公司班线数据情况汇总表','查询',log);
  end;

end;

end.

