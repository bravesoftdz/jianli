unit UFrmVehicleStowageReport;

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
  TfrmVehicleStowageReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    lbl2: TLabel;
    chkIsnotovertime: TCheckBox;
    chkIsovertime: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmvehicleStowageReport: TfrmVehicleStowageReport;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmVehicleStowageReport.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  //nvckbOrgid.Params.ParamValues['orgid']:=SysInfo.LoginUserInfo.OrgID;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmVehicleStowageReport.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  truetake: double;
  aa,log:string;
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
   if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
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
    Params.ParamValues['orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
   if not (nvhlpRoute.Id = 0 ) then
    begin
      Params.ParamValues['routeid']:= nvhlpRoute.HelpFieldValue['id'];
      //log := log+'��·:'+nvhlpRoute.Text+', ';
    end
    else
    begin
       Params.ParamValues['routeid']:= '';
    end;

     if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //�Ƿ�Ӱ���
      begin
         Params.ParamValues['isovertime']:='1';
        // log := log+'�Ӱ�,';
      end
      else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
      begin
         Params.ParamValues['isovertime']:='0';
         //log := log+'����,';
      end
      else
      begin
         Params.ParamValues['isovertime']:='';
      end;

    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[�򵥻���]��'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log +',[��·]:'+ nvhlpRoute.Text;
    if chkIsnotovertime.Checked then
      log := log+',[����]';
    if chkIsovertime.Checked then
      log := log +',[�Ӱ�]';

    log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->����Ӫ������ͳ�Ʊ�','��ѯ',log);

  end;

end;

end.
