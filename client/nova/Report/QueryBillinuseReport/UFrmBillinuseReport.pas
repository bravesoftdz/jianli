unit UFrmBillinuseReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmBillinuseReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlprecipients: TNovaHelp;
    chkcount: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillinuseReport: TFrmBillinuseReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmBillinuseReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
end;

procedure TFrmBillinuseReport.tbtnFilterClick(Sender: TObject);
var log : string;
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
  with jcdsResult do
  begin
    Active := False;
      Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamByName('enddate').Value := formatdatetime('yyyy-mm-dd', dtpenddate.DateTime);
      if Trim(nvhlprecipients.Text) = '' then
        Params.ParamByName('recipients').Value := ''
      else
        Params.ParamByName('recipients').Value := nvhlprecipients.Id;
      if chkcount.Checked then
        Params.ParamByName('status').Value := '2'
      else
        Params.ParamByName('status').Value := '';
      dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：' + SysInfo.LoginUserInfo.OrgName;
      dbgrdhResult.PrintInfo.PageTopRight:='使用票证日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '[使用票证日期]：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if nvhlprecipients.Id <> 0 then
      log := log +',[售票员]：'+nvhlprecipients.Text;
    if chkcount.Checked then
      log := log +',[未用完]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->售票员票证使用情况','查询',log);

  end;
end;

end.
