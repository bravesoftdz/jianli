unit UFrmRouteBalanceRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmRouteBalanceRpt = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label2: TLabel;
    label20: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlroute: TNovaHelp;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRouteBalanceRpt: TFrmRouteBalanceRpt;

implementation

uses UDMPublic, Services, PubFn;
{$R *.dfm}

procedure TFrmRouteBalanceRpt.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;

end;

procedure TFrmRouteBalanceRpt.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)) <= Trunc
      (dtpenddate.Date - dtpstartdate.Date)) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
    log := '��ѯ�����У�[��������]�� ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' �� ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[����]��' + nvckbOrgid.Text;
    if Trim(nvhlroute.Text) <> '' then
      log := log + ',[��·]��' + nvhlroute.Text;
    if chkIsOver.Checked then
      log := log + '������ͣ�[�Ӱ�]';
    if chkIsNotOver.Checked then
      log := log + '������ͣ�[����]';
    SysLog.WriteLog('����ͳ��->��·������ܱ�', '��ѯ', log);
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_r!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    if (not(Trim(nvhlroute.Text) = '')) and (nvhlroute.Id > 0) then // Ӫ����·
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlroute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if not chkIsNotOver.Checked and chkIsOver.Checked then // �Ƿ�Ӱ���
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'true';
      // log := log+'�Ӱ�,';
    end
    else if not chkIsOver.Checked and chkIsNotOver.Checked then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'false';
      // log := log+'����,';
    end;



    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + Sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '�������ڣ�' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' ��' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);

    Active := True;
  end;

end;

end.
