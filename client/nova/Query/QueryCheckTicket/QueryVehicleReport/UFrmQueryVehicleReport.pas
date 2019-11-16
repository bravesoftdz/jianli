unit UFrmQueryVehicleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryVehicleReport = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    nvhelpUnit: TNovaHelp;
    jcdsStatusname: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    nvhelpVehicle: TNovaHelp;
    chkIsLine: TCheckBox;
    chkIsnotLine: TCheckBox;
    lbl2: TLabel;
    blnfldResultisreported: TBooleanField;
    wdstrngfldResultstatus: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    dtfldResultdepartdate: TDateField;
    dtmfldResultreporttime: TDateTimeField;
    wdstrngfldResultvehicleno: TWideStringField;
    lrgntfldResultseatnum: TLargeintField;
    blnfldResultislinework: TBooleanField;
    blnfldResultisovertime: TBooleanField;
    wdstrngfldResultplanunitname: TWideStringField;
    wdstrngfldResultplanvehicleno: TWideStringField;
    wdstrngfldResultdrivername1: TWideStringField;
    wdstrngfldResultdrivername2: TWideStringField;
    wdstrngfldResultdrivername3: TWideStringField;
    wdstrngfldResultdrivername4: TWideStringField;
    wdstrngfldResultstewardname1: TWideStringField;
    wdstrngfldResultstewardname2: TWideStringField;
    wdstrngfldResultplandriver1: TWideStringField;
    wdstrngfldResultplandriver2: TWideStringField;
    wdstrngfldResultplandriver3: TWideStringField;
    wdstrngfldResultplandriver4: TWideStringField;
    wdstrngfldResultplansteward1: TWideStringField;
    wdstrngfldResultplansteward2: TWideStringField;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    chkIsReport: TCheckBox;
    chkIsNotReport: TCheckBox;
    wdstrngfldResultunitname: TWideStringField;
    wdstrngfldResultstatusname: TWideStringField;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    lbl1: TLabel;
    nvHcbbOrg: TNovaHComboBox;
    wdstrngfldResultdeparttime: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryVehicleReport: TfrmQueryVehicleReport;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryVehicleReport.FormCreate(Sender: TObject);
begin
  inherited;
  with nvHcbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    nvHcbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
  dtpBdepartdate.Date:=Now;
//  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date:=Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
//  dtpEdepartdate.Checked := False;
end;

procedure TfrmQueryVehicleReport.tbtnFilterClick(Sender: TObject);
var log:string;
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
    Params.ParamValues['filter_GED_sp!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_sp!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    if  (not (Trim(nvhelpUnit.Text) = '')) and  (nvhelpUnit.Id>0) then         //��λ
      begin
        Params.ParamValues['filter_EQL_ut!id']:= nvhelpUnit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_ut!id']:= '';
      end;

      if  (not (Trim(nvhlpSchedule.Text) = '')) and  (nvhlpSchedule.Id>0) then      //���
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpSchedule.HelpFieldValue['id'];
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

   if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then
    begin
      Params.ParamValues['filter_EQL_vh!id']:= nvhelpVehicle.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_vh!id']:= '';
    end;


      if chkIsnotLine.Checked then                //�Ƿ���ˮ��
        begin
          if not( chkIsLine.Checked ) then
          begin
            Params.ParamValues['filter_EQB_sp!islinework']:='false';
          end
          else
          begin
          Params.ParamValues['filter_EQB_sp!islinework']:='';
          end;
        end
        else
        begin
          if chkIsLine.Checked  then
          begin
            Params.ParamValues['filter_EQB_sp!islinework']:='true';
          end;
        end;

          if chkIsNotOver.Checked then                //�Ƿ�Ӱ�
        begin
          if not( chkIsOver.Checked ) then
          begin
            Params.ParamValues['filter_EQB_sp!isovertime']:='false';
          end
          else
          begin
          Params.ParamValues['filter_EQB_sp!isovertime']:='';
          end;
        end
        else
        begin
          if chkIsOver.Checked  then
          begin
            Params.ParamValues['filter_EQB_sp!isovertime']:='true';
          end;
        end;

          if chkIsNotReport.Checked then                //�Ƿ��ѱ���
        begin
          if not( chkIsReport.Checked ) then
          begin
            Params.ParamValues['filter_EQB_ss!isreported']:='0';
          end
          else
          begin
          Params.ParamValues['filter_EQB_ss!isreported']:='';
          end;
        end
        else
        begin
          if chkIsReport.Checked  then
          begin
            Params.ParamValues['filter_EQB_ss!isreported']:='true';
          end;
        end;
    Active:=true;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[��������]��'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     if Trim(nvHcbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[��ǰ����վ]��'+nvHcbbOrg.Text;
    if nvhelpUnit.Id <> 0 then
      log  := log +',[Ӫ�˵�λ]:'+nvhelpUnit.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[Ӫ����·]:'+nvhlproute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[��κ�]��'+nvhlpschedule.Text;
    if nvhelpVehicle.Id <> 0 then
      log  := log +',[����]:'+nvhelpVehicle.Text;
    if chkIsLine.Checked then
      log := log +',[��ˮ��]:';
    if chkIsnotLine.Checked then
      log := log +',[����ˮ���]:';
    if chkIsOver.Checked then
      log := log +',[�Ӱ�]';
    if chkIsNotOver.Checked then
      log := log +',[����]';
    if chkIsReport.Checked then
      log := log +'[�ѱ���]';
    if chkIsNotOver.Checked then
      log := log +',[δ����]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->��α��������ѯ','��ѯ',log);
  end
end;

end.

