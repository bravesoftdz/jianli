unit UFrmDepartinvoicededuct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaCheckedComboBox;

type
  TFrmDepartinvoicededuct = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbbdepart: TNovaHComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicededuct: TFrmDepartinvoicededuct;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmDepartinvoicededuct.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
  cbbdepart.Active := False;
  cbbdepart.Active := True;
end;

procedure TFrmDepartinvoicededuct.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

procedure TFrmDepartinvoicededuct.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
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
  if trim(cbbOrgid.GetSelectID) = '' then
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
    Params.ParamValues['orgid'] := cbbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if Trim(cbbdepart.Text) <> '' then
      Params.ParamValues['printorgid'] := cbbdepart.HelpFieldValue['id']
    else
      Params.ParamValues['printorgid'] := '';
    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+cbbOrgid.Text;
    if Trim(cbbdepart.Text) <> '' then
      log := log +',[��������λ]:'+ cbbdepart.Text;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->�̶��۷���Ŀ��ѯ','��ѯ',log);

  end;

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

end;

end.
