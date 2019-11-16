unit UFrmQueryVehicleLate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryVehicleLate  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    nvhelpVehicle: TNovaHelp;
    lbl13: TLabel;
    nvcbbStatus: TNovaComboBox;
    chkIsbalance: TCheckBox;
    chkIsnotbalance: TCheckBox;
    lbl2: TLabel;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    nvhlpUnit: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryVehicleLate: TfrmQueryVehicleLate;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryVehicleLate.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbStatus.Active := False;
  nvcbbStatus.Active := True;
  dtpBdepartdate.Date:=Now;
//  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date:=Now;
//  dtpEdepartdate.Checked := False;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryVehicleLate.tbtnFilterClick(Sender: TObject);
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
    Params.ParamValues['filter_INS_vr!orgid']:= nvckbOrgid.GetSelectID;

                                                              //��������
    Params.ParamValues['filter_GED_vl!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_vl!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);


    if  (not (Trim(nvhlpUnit.Text) = '')) and  (nvhlpUnit.Id>0) then         //��λ
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhlpUnit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

      if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then      //���
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhlpRoute.Text) = '')) and (nvhlpRoute.Id>0) then
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

   if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then
    begin
      Params.ParamValues['filter_EQL_v!id']:= nvhelpVehicle.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_v!id']:= '';
    end;

//    if nvcbbStatus.ItemIndex >= 0 then
//    begin
//      Params.ParamValues['filter_EQS_ss!status']:= nvcbbStatus.GetSelectCode;
//    end
//     else
//    begin
//      Params.ParamValues['filter_EQS_ss!status']:='';
//    end;

      if chkIsnotbalance.Checked then                //�Ƿ��ѽ���
        begin
          if not( chkIsbalance.Checked ) then
          begin
            Params.ParamValues['notbalance']:='is null';
            Params.ParamValues['filter_GTL_vl!balanceid']:='';
          end
          else
          begin
            Params.ParamValues['filter_GTL_vl!balanceid']:='';
            Params.ParamValues['notbalance']:='';
          end;
        end
        else
        begin
          if chkIsbalance.Checked  then
          begin
            Params.ParamValues['filter_GTL_vl!balanceid']:=0;
            Params.ParamValues['notbalance']:='';
          end;
        end;
    Active:=true;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[��������]��'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvckbOrgid.Text;
    if nvhlpUnit.Id <> 0 then
      log  := log +',[Ӫ�˵�λ]:'+nvhlpUnit.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[Ӫ����·]:'+nvhlproute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[��κ�]��'+nvhlpschedule.Text;
    if nvhelpVehicle.id <> 0 then
      log  := log +',[����]:'+nvhelpVehicle.Text;
//    if Trim(nvcbbStatus.ItemIndex) <> '' then
//      log  := log +',[���״̬]��'+nvcbbStatus.Text;
    if chkIsbalance.Checked then
      log := log +'[�ѽ���]';
    if chkIsnotbalance.Checked then
      log := log +',[δ����]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->����������ѯ','��ѯ',log);
   end
end;

end.
