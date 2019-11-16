unit UFrmScheduleOperationReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmScheduleOperationReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    lbl2: TLabel;
    nvhlpRoute: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleOperationReport: TFrmScheduleOperationReport;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmScheduleOperationReport.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;

   dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmScheduleOperationReport.tbtnFilterClick(Sender: TObject);
var log:string;
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
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
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
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
      Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if not (nvhlpRoute.Id = 0 ) then
    begin
      Params.ParamValues['routeid']:= nvhlpRoute.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['routeid']:= '';
    end;
    Active := True;

     log := '查询条件有：[日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[报班机构]：'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log+',[线路]：'+nvhlpRoute.Text;
    log := log+'。查询结果:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->班线运营情况汇总表','查询',log);

  end;
end;

end.
