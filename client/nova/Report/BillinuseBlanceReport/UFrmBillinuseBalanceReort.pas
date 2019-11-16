unit UFrmBillinuseBalanceReort;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmBillinuseBalanceReort = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlpsaler: TNovaHelp;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillinuseBalanceReort: TFrmBillinuseBalanceReort;

implementation
uses Services,PubFn;

{$R *.dfm}

procedure TFrmBillinuseBalanceReort.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Trunc(Now);
  dtpenddate.Date := Trunc(Now);
end;

procedure TFrmBillinuseBalanceReort.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvckbOrgid.SetFocus;
    exit;
  end;
  if Trunc(dtpstartdate.Date) >Trunc(dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpstartdate.SetFocus;
    exit;
  end;
   if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := DateToStr(dtpstartdate.Date);
    Params.ParamValues['enddate'] := DateToStr(dtpenddate.Date);
    Params.ParamValues['salerid'] := nvhlpsaler.Id;
    Params.ParamValues['check'] := CheckBox1.Checked;
    Active := True;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='ͳ����Ʊ���ڣ�'+ DateToStr(dtpstartdate.Date)+' �� '+DateToStr(dtpenddate.Date);
    dbgrdhResult.PrintInfo.PrintName:=SysInfo.LoginUserInfo.UserName;

     log := '[��Ʊ����]��'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvckbOrgid.Text;
    if nvhlpsaler.Id <> 0 then
      log := log +',[��ƱԱ]��'+nvhlpsaler.Text;
    if CheckBox1.Checked then
      log := log +',[����Ʊ֤]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->��ƱԱƱ������ͳ�Ʊ�','��ѯ',log);

  end
end;

end.
