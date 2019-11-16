unit UFrmQueryBalancedBusTransport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services, NovaPrint,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic, Generics.Collections,
  NovaHComboBox;

type
  TfrmQueryBalancedBusTransport = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    dtpBalancedBusTransportStart: TDateTimePicker;
    dtpBalancedBusTransportEnd: TDateTimePicker;
    NovaHelpUnit: TNovaHelp;
    Splitter1: TSplitter;
    Label1: TLabel;
    nvhlpRoute: TNovaHelp;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    jcdsResultorgname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultdeductmoney: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    parameter: String;
  public
    { Public declarations }
  end;

var
  frmQueryBalancedBusTransport: TfrmQueryBalancedBusTransport;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryBalancedBusTransport.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := False;
  nvcbborg.Active := True;
  nvcbborg.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  dtpBalancedBusTransportStart.Date := Now;
  dtpBalancedBusTransportEnd.Date := Now;
end;

procedure TfrmQueryBalancedBusTransport.tbtnFilterClick(Sender: TObject);
var
  log: string;
  printstr: string;
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvcbborg.SetFocus;
    exit;
  end;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_org!id'] := nvcbborg.GetSelectID;

    Params.ParamValues['filter_GED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportStart.DateTime);
    Params.ParamValues['filter_LED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportEnd.DateTime + 1);

    if (not(Trim(NovaHelpUnit.Text) = '')) and (NovaHelpUnit.Id > 0) then
    // ������λ
    begin
      Params.ParamValues['filter_EQL_u!id'] := NovaHelpUnit.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;

    // ��·
    if nvhlpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!id'] := nvhlpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := '';

    // ����
    if nvhelpvehicleno.Id > 0 then
      Params.ParamValues['filter_EQL_v!id'] := nvhelpvehicleno.Id
    else
      Params.ParamValues['filter_EQL_v!id'] := '';

    Active := True;
    log := '��ѯ�����У�[��������]�� ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedBusTransportStart.Date) + ' �� ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedBusTransportEnd.Date);
    if Trim(nvcbborg.Text) <> '' then
      log := log + ',[��������]��' + nvcbborg.Text;
    if Trim(nvhlpRoute.Text) <> '' then
      log := log + ',[��·]��' + nvhlpRoute.Text;
    if Trim(NovaHelpUnit.Text) <> '' then
    begin
      log := log + ',[������λ]��' + NovaHelpUnit.Text;
      printstr := ',������λ:' + NovaHelpUnit.Text;
    end;
    if Trim(nvhelpvehicleno.Text) <> '' then
      log := log + ',[����]��' + nvhelpvehicleno.Text;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '�������ڣ�' + formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportStart.Date)
      + ' �� ' + formatdatetime('yyyy-mm-dd', dtpBalancedBusTransportEnd.Date)
      + printstr;

    log := log + '��[��ѯ���]:���� ' + inttostr(recordcount) + ' ����¼��';
    SysLog.WriteLog('�������->�ѽ����ѯ', '��ѯ', log);
  end;
end;

end.
