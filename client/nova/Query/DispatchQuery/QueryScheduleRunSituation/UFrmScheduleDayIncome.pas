unit UFrmScheduleDayIncome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, ComCtrls, StdCtrls, NovaHComboBox,
  NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh,Services,
  NvDbgridEh, ToolWin, ExtCtrls,PubFn, NovaCheckedComboBox;

type
  TFrmScheduleDayIncome = class(TSimpleCRUDForm)
    lbl6: TLabel;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    Label1: TLabel;
    dtpEndDate: TDateTimePicker;
    nvckbOrgid: TNovaCheckedComboBox;
    yes: TCheckBox;
    no: TCheckBox;
    lblsc: TLabel;
    nvcbbSchedulestatus: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleDayIncome: TFrmScheduleDayIncome;

implementation

{$R *.dfm}

procedure TFrmScheduleDayIncome.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbSchedulestatus.Active := False;
  nvcbbSchedulestatus.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;

end;

procedure TFrmScheduleDayIncome.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
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
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
   if Trim(nvcbbSchedulestatus.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����״̬��');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if ((yes.Checked) and (no.Checked = false)) then
    begin
      Params.ParamValues['isovertime'] := 'true';
    end else if ((yes.Checked = false) and (no.Checked)) then
    begin
      Params.ParamValues['isovertime'] := 'false';
    end else if ((yes.Checked) and (no.Checked)) then
    begin
      Params.ParamValues['isovertime']:=null;
    end else if ((yes.Checked = false) and (no.Checked = false)) then
    begin
      Params.ParamValues['isovertime']:=null;
    end;
    Params.ParamByName('schedulestatus').Value := nvcbbSchedulestatus.GetSelectID;

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '[��������]��'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpEndDate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvckbOrgid.Text;
    if nvcbbSchedulestatus.GetSelectID <> '' then
      log := log +',[���״̬]:'+nvcbbSchedulestatus.Text;
    if yes.Checked then
      log := log +',[�Ӱ�]';
    if no.Checked then
      log  := log +',[����]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->����ÿ�հ��Ӫ��ͳ�Ʊ�','��ѯ',log);

  end
end;

end.
