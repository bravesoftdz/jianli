unit UFrmFullSeatSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmFullSeatSchedule  = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    lblroute: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    pnl2: TPanel;
    grp2: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    spl1: TSplitter;
    dsSold: TDataSource;
    jcdsSoldResult: TjsonClientDataSet;
    lbl3: TLabel;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    nvcbbOrgid: TNovaCheckedComboBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFullSeatSchedule: TfrmFullSeatSchedule;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmFullSeatSchedule.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmFullSeatSchedule.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvcbbOrgid.GetSelectID='' then
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
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;

with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['filter_GED_ss!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['filter_LED_ss!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);

    Params.ParamValues['filter_INS_s!orgid'] := nvcbbOrgid.GetSelectID;

    if trim(nvhlproute.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;



    if Trim(nvhlpSchedule.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpSchedule.Id;
    end;

      if not chkIsOver.Checked  and chkIsNotOver.Checked  then    //是否加班
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='false';
      end
      else if not chkIsNotOver.Checked  and chkIsOver.Checked then
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='true';
      end
      else
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='';
      end;
    Active:= true;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvcbbOrgid.Text;
    if nvhlpRoute.Id <>0 then
      log  := log +',[线路]:'+nvhlpRoute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +'[班次号]：'+nvhlpschedule.Text;
    if chkIsOver.Checked then
      log:= log+',[加班]';
    if chkIsNotOver.Checked then
      log := log +',[正班]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->满座班次情况查询','查询',log);
  end;
end ;
end.
