unit UFrmQueryBilldetailReport;

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
  TfrmQueryBilldetailReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    novahcbbtype: TNovaHComboBox;
    nvhlprecipients: TNovaHelp;
    lbl5: TLabel;
    Label2: TLabel;
    novahcbbstorage: TNovaHComboBox;
    jcdsResultorgname: TWideStringField;
    jcdsResulttotal: TFloatField;
    jcdsResultleftnum: TFloatField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultsellbyname: TWideStringField;
    jcdsResultbtname: TWideStringField;
    jcdsResultbillno: TWideStringField;
    jcdsResultcaoffnum: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryBilldetailReport: TfrmQueryBilldetailReport;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryBilldetailReport.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  novahcbbtype.Active := False;
  novahcbbtype.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryBilldetailReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBilldetailReport.tbtnFilterClick(Sender: TObject);
var
  log:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//����ѡ��ʱ��bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date+1);
    if novahcbbstorage.ItemIndex>=0 then
      Params.ParamByName('storageid').Value :=novahcbbstorage.HelpFieldValue['id']
    else
      Params.ParamByName('storageid').Value :='';

    if novahcbbtype.ItemIndex>=0 then
      Params.ParamByName('billtypeid').Value :=novahcbbtype.HelpFieldValue['id']
    else
      Params.ParamByName('billtypeid').Value :='';

    if nvhlprecipients.id<=0 then
      Params.ParamByName('recipients').Value := ''
    else
      Params.ParamByName('recipients').Value := nvhlprecipients.Id;

    Active := True;


    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '��ѯ�����У�[��Ʊ����]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;

    log := log + ' ��[��ѯ���]:���� ' + inttostr(recordcount) + ' ����¼��';
    SysLog.WriteLog('����ͳ��->վ��ֹ�˾ʹ��Ʊ֤��ϸ��', '��ѯ', log);
  end;

end;

end.
