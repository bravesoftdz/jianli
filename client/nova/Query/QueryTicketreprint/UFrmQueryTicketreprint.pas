unit UFrmQueryTicketreprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaComboBox, NovaCheckedComboBox;

type
  TFrmQueryTicketreprint = class(TSimpleCRUDForm)
    lbl5: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    nvedtnewticketno: TNovaEdit;
    nvedtoldticketno: TNovaEdit;
    nvhelpUserid: TNovaHelp;
    Label1: TLabel;
    dtpBchangedate: TDateTimePicker;
    Label2: TLabel;
    dtpEchangedate: TDateTimePicker;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    Label3: TLabel;
    dtpEdepartdate: TDateTimePicker;
    Label4: TLabel;
    nvhelpendstation: TNovaHelp;
    Label5: TLabel;
    nvhelpChangeUser: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBchangedateChange(Sender: TObject);
    procedure dtpEchangedateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryTicketreprint: TFrmQueryTicketreprint;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmQueryTicketreprint.dtpBchangedateChange(Sender: TObject);
begin
  inherited;
  { if dtpBchangedate.Checked = True then
    begin
    dtpEchangedate.Checked := True;
    end;
    if dtpBchangedate.Checked = False then
    begin
    dtpEchangedate.Checked := False;
    end; }
  dtpEchangedate.Checked := dtpBchangedate.Checked;
end;

procedure TFrmQueryTicketreprint.dtpEchangedateChange(Sender: TObject);
begin
  inherited;
  { if dtpEchangedate.Checked = True then
    begin
    dtpBchangedate.Checked := True;
    end;
    if dtpEchangedate.Checked = False then
    begin
    dtpBchangedate.Checked := False;
    end; }
  dtpBchangedate.Checked := dtpEchangedate.Checked;
end;

procedure TFrmQueryTicketreprint.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);

  dtpBdepartdate.Date := Now;
  dtpEdepartdate.Date := Now;
  dtpBchangedate.Date := Now;
  dtpEchangedate.Date := Now;
end;

procedure TFrmQueryTicketreprint.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;

  if (nvckbOrgid.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvckbOrgid.SetFocus;
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime
    ('yyyymmdd', dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpBdepartdate.SetFocus;
    exit;
  end;

  if (dtpBchangedate.Checked) and (FormatDateTime('yyyymmdd',
      dtpBchangedate.Date) > FormatDateTime('yyyymmdd', dtpEchangedate.Date))
    then
  begin
    SysDialogs.ShowMessage('��Ʊ��ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpBchangedate.SetFocus;
    exit;
  end;

  { if (trim(nvedtnewticketno.Text) <> '') and
    (length(trim(nvedtnewticketno.Text)) <> sysinfo.curBillLength.Items
    ['Ticket']) then
    begin
    SysDialogs.Warning('���������Ʊ�ų��Ȳ��ԣ�');
    nvedtnewticketno.SetFocus;
    exit;
    end;

    if (trim(nvedtoldticketno.Text) <> '') and
    (length(trim(nvedtoldticketno.Text)) <> sysinfo.curBillLength.Items
    ['Ticket']) then
    begin
    SysDialogs.Warning('������ľ�Ʊ�ų��Ȳ��ԣ�');
    nvedtoldticketno.SetFocus;
    exit;
    end; }

  with jcdsResult do
  begin
    Active := False;

    Params.ParamValues['filter_INS_trp!sellorgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_trp!newticketno'] := trim
      (nvedtnewticketno.Text);
    Params.ParamValues['filter_EQS_trp!oldticketno'] := trim
      (nvedtoldticketno.Text);

    Params.ParamByName('filter_GED_trp!departdate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.DateTime);
    Params.ParamByName('filter_LED_trp!departdate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.DateTime);

    if (nvhelpendstation.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_trp!reachstationid'] :=
        nvhelpendstation.Id;
      // log := log + ',[����վ]:' + nvhelpendstation.Text;
    end
    else
      Params.ParamValues['filter_EQL_trp!reachstationid'] := null;

    if (nvhelpUserid.Id > 0) or
      ((nvhelpUserid.Id = 0) and (trim(nvhelpUserid.Text) = '��վ�û�')) then
    begin
      Params.ParamValues['filter_EQL_trp!sellby'] := nvhelpUserid.Id;
      // log := log + ',[��ƱԱ]:' + nvhelpUserid.Text;
    end
    else
      Params.ParamValues['filter_EQL_trp!sellby'] := null;

    if (nvhelpChangeUser.Id > 0) or ((nvhelpChangeUser.Id = 0) and
        (trim(nvhelpChangeUser.Text) = '��վ�û�')) then
    begin
      Params.ParamValues['filter_EQL_trp!changeby'] := nvhelpChangeUser.Id;
      // log := log + ',[��ƱԱ]:' + nvhelpChangeUser.Text;
    end
    else
      Params.ParamValues['filter_EQL_trp!changeby'] := null;

    if dtpBchangedate.Checked then // ��Ʊ����
    begin

      Params.ParamValues['filter_GED_trp!changetime'] := FormatDateTime
        ('yyyy-mm-dd', dtpBchangedate.DateTime);
      Params.ParamValues['filter_LED_trp!changetime'] := FormatDateTime
        ('yyyy-mm-dd', dtpEchangedate.DateTime + 1);
      // log :=' [��Ʊ����]��'+DateToStr(dtpBchangedate.DateTime)+'��'+DateToStr(dtpEchangedate.DateTime)+', ';
    end
    else
    begin
      Params.ParamValues['filter_GED_trp!changetime'] := null;
      Params.ParamValues['filter_LED_trp!changetime'] := null;
    end;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '���ڣ�' + FormatDateTime('yyyy-mm-dd',
      dtpBdepartdate.DateTime) + ' ��' + FormatDateTime('yyyy-mm-dd',
      dtpEdepartdate.DateTime);

    Active := True; // cn.nova.bus.report.action.QueryBillinuseAction

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
