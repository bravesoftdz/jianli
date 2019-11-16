unit UFrmScheduleStationDepart;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmScheduleStationDepart = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbborg: TNovaCheckedComboBox;
    lblroute: TLabel;
    nvhlpRoute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    lblschedule: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleStationDepart: TFrmScheduleStationDepart;

implementation

uses Services,PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleStationDepart.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  cbborg.Active := false;
  cbborg.Active := True;
  cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmScheduleStationDepart.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
  if (cbborg.GetCount = 0) or (cbborg.Text = '')then
  begin
    SysDialogs.ShowMessage('请选择所属机构！');
    exit;
  end;
  if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择!');
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
      Params.ParamValues['orgid'] := cbborg.GetSelectID;
    if nvhlpRoute.Id = 0 then
    begin
      Params.ParamValues['routeid'] := '';
    end else
    begin
      Params.ParamValues['routeid'] := nvhlpRoute.HelpFieldValue['id']
    end;

     if nvhlpschedule.Id = 0 then
    begin
      Params.ParamValues['scheduleid'] := '';
    end else
    begin
      Params.ParamValues['scheduleid'] := nvhlpschedule.HelpFieldValue['id']
    end;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbborg.Text) <>'' then
      log := log +',[所属机构]：'+cbborg.Text;
    if Trim(nvhlpRoute.Text) <>'' then
      log := log +',[线路]:'+ nvhlpRoute.Text;
    if Trim(nvhlpschedule.Text) <>'' then
      log := log+',[班次:]'+nvhlpschedule.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->班线停靠站点运量情况汇总表','查询',log);
  end;
end;

end.
