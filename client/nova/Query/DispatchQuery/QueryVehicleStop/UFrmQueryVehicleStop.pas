unit UFrmQueryVehicleStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryVehicleStop  = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl2: TLabel;
    nvhlpVehicle: TNovaHelp;
    lbl7: TLabel;
    nvhlpCreateby: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    lbl6: TLabel;
    nvHcbbOrg: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryVehicleStop: TfrmQueryVehicleStop;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryVehicleStop.FormCreate(Sender: TObject);
begin
  inherited;
//  nvckbOrgid.Active := False;
//  nvckbOrgid.Active := True;
//  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
   with nvHcbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    nvHcbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
end;

procedure TfrmQueryVehicleStop.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
   if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_st!id']:= nvHcbbOrg.HelpFieldValue['id'];
                                                                    //��������
    Params.ParamValues['filter_GED_ss!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ss!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    if  (not (Trim(nvhlpCreateby.Text) = '')) and  (nvhlpCreateby.Id>=0) then
      begin
        Params.ParamValues['filter_EQL_upb!id']:= nvhlpCreateby.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_upb!id']:= '';
      end;

    if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then      //���
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhlproute.Text) = '')) and (nvhlproute.Id>0) then
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlproute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

      //�ƻ�����
    if (not (Trim(nvhlpVehicle.Text) = '')) and (nvhlpVehicle.Id>0) then
      begin
        Params.ParamValues['vehicleno']:= nvhlpVehicle.Text;
      end
    else
      begin
        Params.ParamValues['vehicleno']:= '';
      end;
      Active:=true;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[��������]��'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvHcbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[��ǰ����վ]��'+nvHcbbOrg.Text;
    if nvhlpVehicle.Id <> 0 then
      log  := log +',[����]:'+nvhlpVehicle.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[Ӫ����·]:'+nvhlproute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[��κ�]��'+nvhlpschedule.Text;
    if nvhlpCreateby.Id <> 0 then
      log  := log +',[������]:'+nvhlpCreateby.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->ͣ���������ѯ','��ѯ',log);
   end
end;

end.
