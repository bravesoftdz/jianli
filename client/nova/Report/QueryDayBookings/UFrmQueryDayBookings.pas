unit UFrmQueryDayBookings;

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
    TfrmQueryDayBookings = class(TSimpleCRUDForm)lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl3: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    lbl16: TLabel;
    jcdsResultorgname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultticketoutletsname: TWideStringField;
    jcdsResultticketoutletstype: TWideStringField;
    jcdsResultnumPercent: TWideStringField;
    jcdsResultbacktenprice: TFloatField;
    jcdsResultpricePercent: TWideStringField;
    jcdsResultsamedaynum4: TFloatField;
    jcdsResultsamedaynum1: TFloatField;
    jcdsResultsamedaynum2: TFloatField;
    jcdsResultsamedaynum3: TFloatField;
    jcdsResultsamedaynum5: TFloatField;
    jcdsResultsamedaynum6: TFloatField;
    jcdsResultsamedaynum7: TFloatField;
    jcdsResultsamedaynum8: TFloatField;
    jcdsResultsamedaynum9: TFloatField;
    jcdsResultsamedaynum10: TFloatField;
    jcdsticketoutletsvalue: TjsonClientDataSet;
    jcdsResultticketoutletstypevalue: TWideStringField;
    nvhcbbTickettype: TNovaComboBox;
    jcdsResultsamedaynum: TFloatField;
    jcdsResultbacktennum: TFloatField;
    jcdsResultsamedayprice: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid: String;
    { Public declarations }
  end;

var
  frmQueryDayBookings: TfrmQueryDayBookings;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryDayBookings.FormCreate(Sender: TObject);
var
  columntitle: TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  jcdsticketoutletsvalue.Active := False;
  jcdsticketoutletsvalue.Active := True;
end;

procedure TfrmQueryDayBookings.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryDayBookings.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  nvckbOrgid.SetFocus; // ����ѡ��ʱ��bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  { if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
    begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
    end;
    if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
    begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
    end;
    if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
    <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
    begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
    end;
    }
  { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
    begin
    SysDialogs.Warning('ͬ�����������������ڷ�������������!');
    Exit;
    end; }
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date + 1);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date + 1);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date + 11);

    if nvhelpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!routeid'] := nvhelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!routeid'] := '';

    if nvhelpTicketoutlets.Id <= 0 then
      Params.ParamValues['filter_EQL_t!ticketoutletsid'] := ''
    else
      Params.ParamValues['filter_EQL_t!ticketoutletsid'] :=
        nvhelpTicketoutlets.Id;

    if nvhcbbTickettype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_t!ticketoutletstype'] :=
        ''
    else
      Params.ParamValues['filter_EQS_t!ticketoutletstype'] := nvhcbbTickettype.GetSelectCode;
    {
      Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
      Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
      Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);
      }
    Active := True;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '���ڣ�' + FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);

    log := '��ѯ�����У�[����]' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date);
    // +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)

    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[����]��' + nvckbOrgid.Text;

    log := log + ' ��[��ѯ���]:���� ' + inttostr(RecordCount) + ' ����¼��';
    SysLog.WriteLog('����ͳ��->Ԥ��Ʊ�ձ���', '��ѯ', log);
  end;

end;

end.
