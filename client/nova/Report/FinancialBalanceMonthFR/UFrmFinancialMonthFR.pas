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
    SysDialogs.ShowMessage('��ѡ�������');
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
    log := '��ѯ�����У�[��Ʊ�·�]'+ formatdatetime('yyyy-MM',dtpstartdate.Date);
    if Trim(nvHcbbOrg.Text) <>'' then
      log := log +',[����]��'+nvHcbbOrg.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->�����¶���֧ƽ���','��ѯ',log);

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
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
   frxrprt1.FileName:='�����¶���֧ƽ���.xls';
   frxrprt1.PrepareReport(true);
   frxrprt1.Export(frxlsxprt1);
    tbtnFilterClick(Sender);
end;

end.
