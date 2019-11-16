unit UFrmFinancialMonthFR;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox, frxClass, frxDBSet, frxPreview, frxExportXLS;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TfrmFinancialMonthFR = class(TSimpleCRUDForm)
    lbl1: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    frxdbdtst1: TfrxDBDataset;
    frxrprt1: TfrxReport;
    frxprvw1: TfrxPreview;
    frxlsxprt1: TfrxXLSExport;
    nvHcbbOrg: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
  WPath : string;
    { Public declarations }
  end;

var
  frmFinancialMonthFR: TfrmFinancialMonthFR;

implementation

uses SystemInstance, SysInfoIntf,PubFn,DateUtils;
{$R *.dfm}

procedure TfrmFinancialMonthFR.FormShow(Sender: TObject);
begin
  inherited;
  nvHcbbOrg.Active := False;
  nvHcbbOrg.Active := True;
  dtpstartdate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  WPath := ExtractFilePath(Application.ExeName);
end;

procedure TfrmFinancialMonthFR.tbtnFilterClick(Sender: TObject);
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
    if nvHcbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['orgids'] := nvHcbbOrg.HelpFieldValue['id'];
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Active := True;
    log := '查询条件有：[售票月份]'+ formatdatetime('yyyy-MM',dtpstartdate.Date);
    if Trim(nvHcbbOrg.Text) <>'' then
      log := log +',[机构]：'+nvHcbbOrg.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->财务月度收支平衡表','查询',log);

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
  end;
  frxrprt1.Preview := frxprvw1;
  if frxrprt1.PrepareReport then
  frxrprt1.ShowPreparedReport;
end;

procedure TfrmFinancialMonthFR.tbtnDeleteClick(Sender: TObject);
begin
  frxrprt1.Print;
   tbtnFilterClick(Sender);
end;

procedure TfrmFinancialMonthFR.tbtnEditClick(Sender: TObject);
begin
   frxrprt1.FileName:='财务月度收支平衡表.xls';
   frxrprt1.PrepareReport(true);
   frxrprt1.Export(frxlsxprt1);
    tbtnFilterClick(Sender);
end;

end.
