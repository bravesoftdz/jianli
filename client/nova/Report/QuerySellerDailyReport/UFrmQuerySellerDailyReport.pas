unit UFrmQuerySellerDailyReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQuerySellerDailyReport  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl6: TLabel;
    nvhelpUserid: TNovaHelp;
    lbl2: TLabel;
    dtpSellEnddate: TDateTimePicker;
    dtpSellStartdate: TDateTimePicker;
    lbl3: TLabel;
    chkGroupby: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuerySellerDailyReport: TfrmQuerySellerDailyReport;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQuerySellerDailyReport.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := Sysinfo.LoginUserInfo.UserID;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpSellStartdate.Date := Now;
  dtpSellEnddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQuerySellerDailyReport.jcdsResultAfterOpen(DataSet: TDataSet);
var  footers :TColumnFooterEh;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    if chkGroupby.Checked then
    begin
       dbgrdhResult.Columns[2].Visible := True;
       dbgrdhResult.SumList.Active :=false ;
       footers := dbgrdhResult.Columns[1].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[3].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[4].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[5].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[6].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[7].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[8].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[9].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[10].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[11].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[12].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[13].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[14].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[15].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[16].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[17].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[18].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[19].Footer;
       footers.ValueType := fvtNon;
       footers := dbgrdhResult.Columns[20].Footer;
       footers.ValueType := fvtNon;
    end
    else
    begin
       dbgrdhResult.Columns[2].Visible := False;
       dbgrdhResult.SumList.Active :=true;
       footers := dbgrdhResult.Columns[1].Footer;
       footers.ValueType := fvtCount;
       footers := dbgrdhResult.Columns[3].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[4].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[5].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[6].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[7].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[8].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[9].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[10].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[11].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[12].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[13].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[14].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[15].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[16].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[17].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[18].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[19].Footer;
       footers.ValueType := fvtSum;
       footers := dbgrdhResult.Columns[20].Footer;
       footers.ValueType := fvtSum;
    end;
  end;
end;

procedure TfrmQuerySellerDailyReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpSellStartdate.Date) > FormatDateTime('yyyymmdd',
    dtpSellEnddate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpSellEnddate.Date-dtpSellStartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_ttd!moneydate'] :=  formatdatetime('yyyy-mm-dd',dtpSellStartdate.Date);
    Params.ParamValues['filter_LED_ttd!moneydate'] :=  formatdatetime('yyyy-mm-dd',dtpSellEnddate.Date);

    if (not (Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id>0) then
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhelpUserid.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

    //�Ƿ���������
    if chkGroupby.Checked then
      Params.ParamValues['groupbydate']:= 'true'
    else
      Params.ParamValues['groupbydate']:= 'false';
    Active:=true;

    log := '��ѯ�����У�[��Ʊ����]�� '+ formatdatetime('yyyy-mm-dd',dtpSellStartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpSellEnddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    if Trim(nvhelpUserid.Text) <>'' then
      log  := log +',[��ƱԱ]��'+nvhelpUserid.Text;
    if chkGroupby.Checked then
      log := log +',[��ѡ�� ����Ʊ����ͳ��]';
    if not (chkGroupby.Checked) then
    log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';

    SysLog.WriteLog('����ͳ��->��ƱԱ���˷��ձ���','��ѯ',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpSellStartdate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpSellEnddate.Date);

    end
end;

end.
