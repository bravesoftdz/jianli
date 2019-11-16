unit UFrmFullSeatSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmFullSeatSchedule  = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    lblroute: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    pnl2: TPanel;
    grp2: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    spl1: TSplitter;
    dsSold: TDataSource;
    jcdsSoldResult: TjsonClientDataSet;
    lbl3: TLabel;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    nvcbbOrgid: TNovaCheckedComboBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFullSeatSchedule: TfrmFullSeatSchedule;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmFullSeatSchedule.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmFullSeatSchedule.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvcbbOrgid.GetSelectID='' then
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
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;

with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['filter_GED_ss!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['filter_LED_ss!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);

    Params.ParamValues['filter_INS_s!orgid'] := nvcbbOrgid.GetSelectID;

    if trim(nvhlproute.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;



    if Trim(nvhlpSchedule.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpSchedule.Id;
    end;

      if not chkIsOver.Checked  and chkIsNotOver.Checked  then    //�Ƿ�Ӱ�
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='false';
      end
      else if not chkIsNotOver.Checked  and chkIsOver.Checked then
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='true';
      end
      else
      begin
         Params.ParamValues['filter_EQB_t!isovertime']:='';
      end;
    Active:= true;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvcbbOrgid.Text;
    if nvhlpRoute.Id <>0 then
      log  := log +',[��·]:'+nvhlpRoute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +'[��κ�]��'+nvhlpschedule.Text;
    if chkIsOver.Checked then
      log:= log+',[�Ӱ�]';
    if chkIsNotOver.Checked then
      log := log +',[����]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->������������ѯ','��ѯ',log);
  end;
end ;
end.
