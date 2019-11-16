unit UFrmQryDepartSchedules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, NovaHComboBox,UDMPublic;

type
  TFrmQryDepartSchedules = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl11: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    Label9: TLabel;
    lbl7: TLabel;
    dtpBdepartdate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    nvhelpUnit: TNovaHelp;
    nvhelpVehicle: TNovaHelp;
    nvhelpUserid: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    chkIsovertime: TCheckBox;
    chkIsnotovertime: TCheckBox;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    Label2: TLabel;
    cbbdepart: TNovaCheckedComboBox;
    nvckbOrgid: TNovaCheckedComboBox;
    lblRun: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryDepartSchedules: TFrmQryDepartSchedules;

implementation
   uses Services,PubFn;
{$R *.dfm}

procedure TFrmQryDepartSchedules.FormCreate(Sender: TObject);
begin
  inherited;

   nvckbOrgid.Active:=false;
   nvckbOrgid.Active:=true;
   nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
   cbbdepart.Active := False;
   cbbdepart.Active := True;
   cbbdepart.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQryDepartSchedules.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbType.Active:=false;
  nvcbbType.Active:=true;
  self.dtpBdepartdate.Date:=now;
  self.dtpEdepartdate.Date:=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmQryDepartSchedules.tbtnFilterClick(Sender: TObject);
var stationservicefee, computefee,coolairfee,additionfee,waterfee,
				insurefee,otherfee,fueladditionfee,agentfee,allfee : Int64;
    log:string;
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
  if Trim(cbbdepart.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��������λ��');
    Exit;
  end;
    if Trim(nvcbbType.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����������');
    nvcbbType.SetFocus;
    Exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ds!departinvoicesno'] := nvedtTicketno.Text;
    // ��������
    Params.ParamValues['startdate'] := formatdatetime
      ('yyyy-mm-dd', dtpBdepartdate.Date);

    Params.ParamValues['enddate'] := formatdatetime
      ('yyyy-mm-dd', dtpEdepartdate.Date);

    if (not(Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id > 0) then // ��λ
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := nvhelpUnit.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := '';
    end;

    if (not(Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id > 0) then
    // ��κ�     //���
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhlproute.Text) = '')) and (nvhlproute.Id > 0) then // ��·
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if (not(Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id > 0) then
    // ����
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhelpVehicle.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end;

    if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //�Ƿ�Ӱ���
    begin
     Params.ParamValues['filter_EQB_s!isovertime']:='true';
     //log := log+'�Ӱ�,';
    end
    else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:='false';
      //log := log+'����,';
    end;

    if nvcbbType.GetSelectID='' then
        Params.ParamValues['filter_INS_ddc!orderno']:=null
    else
        Params.ParamValues['filter_INS_ddc!orderno'] := nvcbbType.GetSelectID;


    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then // ��Ա
    begin
      Params.ParamValues['filter_EQL_ds!printby'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_ds!printby'] := null;
    end;
    if Trim(cbbdepart.Text) <> '' then                              //��������λ
      Params.ParamValues['filter_INS_ds!printorgid'] := cbbdepart.GetSelectID
    else
      Params.ParamValues['filter_INS_ds!printorgid'] := null;



    Active := true;
    log := '��ѯ�����У�[��������]��'+formatdatetime('yyyy-mm-dd', dtpBdepartdate.Date)
          +'��'+formatdatetime('yyyy-mm-dd', dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID)<>'' then
      log := log+',[��λ���]��'+nvckbOrgid.Text;
    if Trim(cbbdepart.GetSelectID) <> '' then
      log := log +',[��������λ]��'+cbbdepart.Text ;
    if  nvhlproute.Id <> 0 then
      log := log +',[��·]��'+nvhlproute.Text ;
    if nvhlpschedule.Id <> 0 then
      log := log +',]��κ�]��'+nvhlpschedule.Text ;
    if nvhelpUnit.Id <> 0 then
      log := log +',[Ӫ�˵�λ]:'+nvhelpUnit.Text ;
    if nvhelpVehicle.Id <> 0 then
      log := log +',[Ӫ�˳���]:'+ nvhelpVehicle.Text;
    if nvhelpUserid.Id <> 0 then
      log := log +',[��Ա]:'+ nvhelpUserid.Text;
    if Trim(nvedtTicketno.Text) <> '' then
      log := log +',[���㵥��]:'+ nvedtTicketno.Text;
    if chkIsnotovertime.Checked then
      log := log +',[����]';
    if chkIsovertime.Checked then
      log :=log+',[�Ӱ�]';

     log := log+',[��������]��'+nvcbbType.Text
     +' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->����������̨��','��ѯ',log);

  end;
end;
end.
