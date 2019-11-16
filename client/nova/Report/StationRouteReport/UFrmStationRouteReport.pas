unit UFrmStationRouteReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmStationRouteReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStationRouteReport: TFrmStationRouteReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmStationRouteReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmStationRouteReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if (cbborg.GetCount = 0) or (cbborg.Text = '')then
  begin
    SysDialogs.ShowMessage('请选所属机构！');
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
    Active:= false;
    Params.ParamValues['orgids'] :=  cbborg.GetSelectID;
    Params.ParamValues['startdate']
            :=formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate']
            := formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active:= true;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbborg.Text) <>'' then
      log := log +',[所属机构]：'+cbborg.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->客运班线调查统计表','查询',log);

  end;
end;

end.
