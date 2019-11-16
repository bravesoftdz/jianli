unit UFrmFinancialMonthRpt;

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
  TfrmFinancialMonthRpt = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFinancialMonthRpt: TfrmFinancialMonthRpt;

implementation

uses SystemInstance, SysInfoIntf,PubFn,DateUtils;
{$R *.dfm}

procedure TfrmFinancialMonthRpt.FormShow(Sender: TObject);
begin
  inherited;
   nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmFinancialMonthRpt.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  peplodistance1: double;
  alldistance1: Int64;
  allseatnum1: Int64;
  checkticketnum1: Int64;
  truetake: double;
  _truetake: double;
  aa,log:string;
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '') then
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

    Active := True;

     log := '查询条件有：[售票月份]'+ formatdatetime('yyyy-MM',dtpstartdate.Date)
          +' 至 '+formatdatetime('yyyy-MM',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->财务收支月平衡表','查询',log);

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
  end;

end;


end.
