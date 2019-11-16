unit UFrmQueryScheduleCheckSum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,UDMPublic,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,Services;

type
  TFrmQueryScheduleCheckSum = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl11: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label9: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBdepartdate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    nvhelpSchedule: TNovaHelp;
    nvhelpRoute: TNovaHelp;
    nvhelpUserid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryScheduleCheckSum: TFrmQueryScheduleCheckSum;

implementation
   uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TFrmQueryScheduleCheckSum.FormCreate(Sender: TObject);
begin
  inherited;
   nvckbOrgid.Active:=false;
   nvckbOrgid.Active:=true;
   nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQueryScheduleCheckSum.FormShow(Sender: TObject);
begin
  inherited;
  self.dtpBdepartdate.Date:=now;
  self.dtpEdepartdate.Date:=now;
end;

procedure TFrmQueryScheduleCheckSum.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
   if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    // ��������
    Params.ParamValues['filter_GED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpEdepartdate.Date);


    if (not(Trim(nvhelpSchedule.Text) = '')) and (nvhelpSchedule.Id > 0) then
    // ��κ�     //���
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhelpSchedule.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhelpRoute.Text) = '')) and (nvhelpRoute.Id > 0) then // ��·
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhelpRoute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then // ��Ա
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    Active := true;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[��������]��'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvckbOrgid.Text;
    if nvhelpRoute.Id <> 0 then
      log := log +',[Ӫ����·]:'+nvhelpRoute.Text;
    if nvhelpSchedule.Id <> 0 then
      log := log +',[��κ�]��'+nvhelpSchedule.Text;
    if nvhelpUserid.Id <> 0 then
      log  := log +',[��ƱԱ]:'+nvhelpUserid.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->��μ�Ʊ���ܱ�','��ѯ',log);
  end;
end;
end.
