unit UFrmBalanceUnitInvoinces;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaComboBox, NovaEdit, NovaHelp, NovaCheckedComboBox,
  NovaHComboBox,UDMPublic;

type
  TFrmBalanceUnitInvoinces = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbbBalanceObject: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    NHelpRoute: TNovaHelp;
    NovaHelpBalanceUnit: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label8: TLabel;
    cbbOvertime: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBalanceUnitInvoinces: TFrmBalanceUnitInvoinces;

implementation

uses PubFn, Services;
{$R *.dfm}

procedure TFrmBalanceUnitInvoinces.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := true;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  cbbBalanceObject.ItemIndex:=0;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmBalanceUnitInvoinces.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if cbbBalanceObject.ItemIndex=3 then
  begin
     dbgrdhResult.Columns[1].Visible:=true;
     dbgrdhResult.Columns[2].Visible:=true;
  end
  else
  begin
     dbgrdhResult.Columns[1].Visible:=false;
     dbgrdhResult.Columns[2].Visible:=false;
  end;
  if nvckbOrgid.GetSelectID = '' then
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
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['type'] := cbbBalanceObject.ItemIndex;
    if (NovaHelpUnit.Text <> '') and (NovaHelpUnit.Id > 0) then
        Params.ParamValues['filter_EQL_u1!id'] := NovaHelpUnit.Id
    else
        Params.ParamValues['filter_EQL_u1!id'] := null;
    if (NovaHelpBalanceUnit.Text <> '') and (NovaHelpBalanceUnit.Id > 0) then
        Params.ParamValues['filter_EQL_u2!id'] := NovaHelpBalanceUnit.Id
    else
        Params.ParamValues['filter_EQL_u2!id'] := null;

    if (NHelpRoute.Text <> '') and (NHelpRoute.Id > 0) then
        Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
        Params.ParamValues['filter_EQL_r!id'] := null;

    if (NovaHelpVehiclenoHelp.Text <> '') and (NovaHelpVehiclenoHelp.Id > 0) then
        Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehiclenoHelp.Id
    else
        Params.ParamValues['filter_EQL_v!id'] := null;

    if (NovaHelpSchedule.Text <> '') and (NovaHelpSchedule.Id > 0) then
        Params.ParamValues['filter_EQL_s!id'] := NovaHelpSchedule.Id
    else
        Params.ParamValues['filter_EQL_s!id'] := null;


    if cbbOvertime.ItemIndex>0 then
        if  cbbOvertime.ItemIndex=1 then
         Params.ParamValues['filter_EQB_s!isovertime'] := false
        else
         Params.ParamValues['filter_EQB_s!isovertime'] := true
    else
        Params.ParamValues['filter_EQB_s!isovertime'] := null;

    Params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := true;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    if NHelpRoute.Id <>0 then
      log  := log +',[��·]��'+NHelpRoute.Text;
    if Trim(cbbBalanceObject.Text) <>'' then
      log  := log +'[�������]:'+cbbBalanceObject.Text;
    if NovaHelpUnit.Id <> 0 then
      log := log +',[������λ]:'+NovaHelpUnit.Text;
    if NovaHelpBalanceUnit.Id <> 0 then
      log := log +',[���㵥λ]:'+NovaHelpBalanceUnit.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log :=log +',[Ӫ�˳���]:'+NovaHelpVehiclenoHelp.Text;
    if NovaHelpSchedule.Id <>0 then
      log  := log +',[��κ�]:'+NovaHelpSchedule.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->���ֹ�˾�������ܱ�','��ѯ',log);

  end
end;

end.
