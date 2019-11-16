unit UFrmTicketReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaComboBox, NovaCheckedComboBox;

type
  TFrmTicketReport = class(TSimpleCRUDForm)
    lbl5: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    lbl13: TLabel;
    nvcbbticketstatus: TNovaComboBox;
    lbl8: TLabel;
    lbl9: TLabel;
    nvedtstartTicketno: TNovaEdit;
    nvedtendTicketno: TNovaEdit;
    jcdsResultstartticketno: TWideStringField;
    jcdsResultendticketno: TWideStringField;
    jcdsResulttotalamount: TFloatField;
    jcdsResultstartselltime: TWideStringField;
    jcdsResultendselltime: TWideStringField;
    jcdsResultsellnum: TLargeintField;
    nvhelpUserid: TNovaHelp;
    jcdsResultz_sellnum: TLargeintField;
    jcdsResultz_totalamount: TFloatField;
    jcdsResultr_sellnum: TLargeintField;
    jcdsResultr_totalamount: TFloatField;
    jcdsResultc_sellnum: TLargeintField;
    jcdsResultc_totalamount: TFloatField;
    jcdsResultb_sellnum: TLargeintField;
    Label1: TLabel;
    dtpBselldate: TDateTimePicker;
    Label2: TLabel;
    dtpEselldate: TDateTimePicker;
    jcdsResultreturnvouchernum: TLargeintField;
    jcdsResulttotalnum: TLargeintField;
    jcdsResultorgname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketReport: TFrmTicketReport;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmTicketReport.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True then
  begin
    dtpEselldate.Checked := True;
  end;
  if dtpBselldate.Checked = False then
  begin
    dtpEselldate.Checked := False;
  end;
end;

procedure TFrmTicketReport.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True then
  begin
    dtpBselldate.Checked := True;
  end;
  if dtpEselldate.Checked = False then
  begin
    dtpBselldate.Checked := False;
  end;
end;

procedure TFrmTicketReport.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);

  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active := True;

  dtpBselldate.DateTime := Now();
  dtpEselldate.DateTime := Now();
end;

procedure TFrmTicketReport.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  // if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
  // dtpenddate.Date)then
  // begin
  // SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
  // exit;
  // end;
  if (nvckbOrgid.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvckbOrgid.SetFocus;
    exit;
  end;

  if (dtpBselldate.Checked = False) and (trim(nvedtstartTicketno.Text) = '') and
    (trim(nvedtendTicketno.Text) = '') then
  begin
    SysDialogs.ShowMessage('������ʱ��λ�Ʊ�Σ�');
    nvedtstartTicketno.SetFocus;
    exit;
  end;

  if (trim(nvedtstartTicketno.Text) <> '') or
    (trim(nvedtendTicketno.Text) <> '') then
  begin
    if trim(nvedtstartTicketno.Text) = '' then
    begin
      SysDialogs.ShowMessage('�����뿪ʼƱ�ţ�');
      nvedtstartTicketno.SetFocus;
      exit;
    end;

    if trim(nvedtendTicketno.Text) = '' then
    begin
      SysDialogs.ShowMessage('���������Ʊ�ţ�');
      nvedtendTicketno.SetFocus;
      exit;
    end;

  end;

  if (trim(nvedtstartTicketno.Text) <> '') and
    (length(trim(nvedtstartTicketno.Text)) <> sysinfo.curBillLength.Items
      ['Ticket']) then
  begin
    SysDialogs.Warning('������Ŀ�ʼƱ�ų��Ȳ��ԣ�');
    nvedtstartTicketno.SetFocus;
    exit;
  end;

  if (trim(nvedtendTicketno.Text) <> '') and
    (length(trim(nvedtendTicketno.Text)) <> sysinfo.curBillLength.Items
      ['Ticket']) then
  begin
    SysDialogs.Warning('������Ľ���Ʊ�ų��Ȳ��ԣ�');
    nvedtendTicketno.SetFocus;
    exit;
  end;

  if (trim(nvedtstartTicketno.Text) <> '') and
    (trim(nvedtendTicketno.Text) <> '') and
    (strtoint(trim(nvedtstartTicketno.Text)) > strtoint
      (trim(nvedtendTicketno.Text))) then
  begin
    SysDialogs.ShowMessage('��ʼƱ�Ų��ܴ��ڽ���Ʊ�ţ�');
    nvedtendTicketno.SetFocus;
    exit;
  end;

  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd',
      dtpBselldate.Date) > FormatDateTime('yyyymmdd', dtpEselldate.Date)) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    // Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd',
    // dtpstartdate.DateTime);
    // Params.ParamByName('enddate').Value := formatdatetime('yyyy-mm-dd',
    // dtpenddate.DateTime);
    Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startticketno'] := trim(nvedtstartTicketno.Text);
    Params.ParamValues['endticketno'] := trim(nvedtendTicketno.Text);

    if (nvhelpUserid.Id > 0) or
      ((nvhelpUserid.Id = 0) and (trim(nvhelpUserid.Text) = '��վ�û�')) then
    begin
      Params.ParamValues['filter_EQL_t!sellby'] := nvhelpUserid.Id;
      // log := log + ',[��ƱԱ]:' + nvhlprecipients.Text;
    end
    else
      Params.ParamValues['filter_EQL_t!sellby'] := null;

    if nvcbbticketstatus.ItemIndex >= 0 then
    begin
      Params.ParamValues['filter_EQS_t!ticketstatus'] :=
        nvcbbticketstatus.GetSelectCode;
      // log := log + ',[��Ʊ״̬]:' + nvcbbticketstatus.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!ticketstatus'] := null;
    end;

    if dtpBselldate.Checked then // ��Ʊ����
    begin

      Params.ParamValues['filter_GED_t!startselltime'] := FormatDateTime
        ('yyyy-mm-dd', dtpBselldate.DateTime);
      Params.ParamValues['filter_LED_t!endselltime'] := FormatDateTime
        ('yyyy-mm-dd', dtpEselldate.DateTime + 1);
      // log :=' [����]��'+DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime)+', ';
    end
    else
    begin
      Params.ParamValues['filter_GED_t!startselltime'] := null;
      Params.ParamValues['filter_LED_t!endselltime'] := null;
    end;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := 'Ʊ�Σ�' + nvedtstartTicketno.Text +
      ' ��' + nvedtendTicketno.Text;
    Active := True;

    // log := '[ʹ��Ʊ֤����]��' + formatdatetime('yyyy-mm-dd', dtpstartdate.Date)
    // + ' ��' + formatdatetime('yyyy-mm-dd', dtpenddate.Date);
    // if nvhlprecipients.Id <> 0 then
    // log := log + ',[��ƱԱ]��' + nvhlprecipients.Text;
    // if chkcount.Checked then
    // log := log + ',[δ����]';
    // log := log + '��[��ѯ���]:���� ' + inttostr(RecordCount) + ' ����¼��';
    // SysLog.WriteLog('�ۺϲ�ѯ->��ƱԱƱ֤ʹ�����', '��ѯ', log);

  end;
end;

end.
