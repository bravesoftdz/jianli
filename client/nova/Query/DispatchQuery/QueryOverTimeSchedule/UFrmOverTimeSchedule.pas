unit UFrmOverTimeSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmOverTimeSchedule  = class(TSimpleCRUDForm)
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
    lbl3: TLabel;
    nvhlpBalanceUnit: TNovaHelp;
    nvhlpUnit: TNovaHelp;
    nvhlpBUnit: TNovaHelp;
    nvhlproute: TNovaHelp;
    lbl6: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lblsc: TLabel;
    nvcbbSchedulestatus: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOverTimeSchedule: TfrmOverTimeSchedule;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmOverTimeSchedule.FormCreate(Sender: TObject);
begin
  inherited;
 with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    //nvHcbbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
    NovaHCbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
end;

procedure TfrmOverTimeSchedule.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  nvcbbSchedulestatus.Active := False;
  nvcbbSchedulestatus.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmOverTimeSchedule.tbtnFilterClick(Sender: TObject);
var selectids,st,results,log :string;temp:Integer ;
begin
  inherited;
   if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['curstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_GED_sp!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['filter_LED_sp!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
  if trim(nvhlproute.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;

   if Trim(nvhlpunit.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_vrr!reportunit'] := null;
    end else
    begin
      Params.ParamValues['filter_EQS_vrr!reportunit'] := nvhlpunit.Text;
    end;

    if Trim(nvhlpBUnit.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_vrr!balanceid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_vrr!balanceid'] := nvhlpBUnit.Id;
    end;
    selectids :=   nvcbbSchedulestatus.GetSelectID;
    selectids:=Copy(selectids,2,Length(selectids)-2);
    for st in selectids do
    begin
      if Pos(',',st)>0 then
        results:=results+st
      else
        results:=results+'''' +st+'''';
    end;
    results :='('+results+')';
    Params.ParamByName('filter_INS_ss!status').Value := results;
    Active:= true;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[�������ڴ�] '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(NovaHCbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[��ǰ����վ]��'+NovaHCbbOrg.Text;
    if nvhlpRoute.Id <> 0 then
      log  := log +',[��·]:'+nvhlpRoute.Text;
    if  nvhlpUnit.Id <> 0 then
      log := log +',[��Ӫ��λ]��'+nvhlpUnit.Text;
    if nvhlpBUnit.Id <> 0 then
      log := log +',[���㵥λ]��'+nvhlpBUnit.Text;
    if Trim(nvcbbSchedulestatus.GetSelectID) <>'' then
      log := log+',[���״̬]��'+nvcbbSchedulestatus.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('���Ȳ�ѯ->����վ�Ӱ�������ѯ','��ѯ',log);
  end;
end ;
end.

