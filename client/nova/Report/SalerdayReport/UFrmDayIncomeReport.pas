unit UFrmDayIncomeReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, NovaHelp,Services, NovaCheckedComboBox, DBGridEhGrouping;

type
  TFrmDayIncomeReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    NvHelpUser: TNovaHelp;
    Label2: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDayIncomeReport: TFrmDayIncomeReport;

implementation
uses   PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmDayIncomeReport.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;

end;

procedure TFrmDayIncomeReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
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
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if (NvHelpUser.Text<>'') and (NvHelpUser.HelpFieldValue['id']>0) then
      Params.ParamValues['seller'] :=NvHelpUser.HelpFieldValue['id']
    else
      Params.ParamValues['seller'] :=null;

    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '查询条件有：[售票日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    if NvHelpUser.Id <>0 then
      log  := log +',[售票员]：'+NvHelpUser.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->售票每日营收统计表','查询',log);
  end

end;

end.
