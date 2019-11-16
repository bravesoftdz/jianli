unit UFrmVehicleIncome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  CheckLst, NovaHComboBox;

type
  TFrmVehicleIncome = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label6: TLabel;
    NovaHelpBalanceUnit: TNovaHelp;
    lbltype: TLabel;
    cbbType: TNovaComboBox;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label2: TLabel;
    cbbOvertime: TComboBox;
    Label3: TLabel;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    lblRun: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleIncome: TFrmVehicleIncome;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure TFrmVehicleIncome.FormCreate(Sender: TObject);
begin
  inherited;
  //dbgrdhResult.OddRowColor:=clSkyBlue; //��������ɫ
end;

procedure TFrmVehicleIncome.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvcbbType.Active := False;
  nvcbbType.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  cbbType.Active := False;
  cbbType.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := true;
  dbgrdhResult.GridUser := sysInfo.LoginUserInfo.UserID;
end;

procedure TFrmVehicleIncome.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
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
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;

    if NovaChkPrintOrg.GetSelectID = '' then
    begin
      SysDialogs.ShowMessage('��ѡ��򵥻�����');
      exit;
    end;
                         //��������λ
    Params.ParamValues['printorgids'] :=NovaChkPrintOrg.GetSelectID;

    if (NHelpRoute.Text <> '') and (NHelpRoute.Id > 0) then
        Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
        Params.ParamValues['filter_EQL_r!id'] := null;


    if (NovaHelpBalanceUnit.Text <> '') and (NovaHelpBalanceUnit.Id > 0) then
        Params.ParamValues['filter_EQL_u1!id'] := NovaHelpBalanceUnit.Id
    else
        Params.ParamValues['filter_EQL_u1!id'] := null;


    if (NovaHelpUnit.Text <> '') and (NovaHelpUnit.Id > 0) then
        Params.ParamValues['filter_EQL_u2!id'] := NovaHelpUnit.Id
    else
        Params.ParamValues['filter_EQL_u2!id'] := null;

    if (NovaHelpVehiclenoHelp.Text <> '') and (NovaHelpVehiclenoHelp.Id > 0) then
        Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehiclenoHelp.Id
    else
        Params.ParamValues['filter_EQL_v!id'] := null;

    if cbbType.ItemIndex>=0 then
        Params.ParamValues['filter_EQS_v!type'] := cbbType.GetSelectCode
    else
        Params.ParamValues['filter_EQS_v!type'] := null;

    if cbbOvertime.ItemIndex>0 then
        if  cbbOvertime.ItemIndex=1 then
         Params.ParamValues['filter_EQB_s!isovertime'] := false
        else
         Params.ParamValues['filter_EQB_s!isovertime'] := true
    else
        Params.ParamValues['filter_EQB_s!isovertime'] := null;
    if nvcbbType.GetSelectID='' then
        Params.ParamValues['filter_INS_s!districttype'] := null
    else
        Params.ParamValues['filter_INS_s!districttype'] := nvcbbType.GetSelectID;

    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    if NHelpRoute.Id <>0 then
      log  := log +',[��·]��'+NHelpRoute.Text;
    if NovaHelpUnit.Id <> 0 then
      log := log +',[������λ]:'+NovaHelpUnit.Text;
    if NovaHelpBalanceUnit.Id <> 0 then
      log := log +',[���㵥λ]:'+NovaHelpBalanceUnit.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log :=log +',[Ӫ�˳���]:'+NovaHelpVehiclenoHelp.Text;
    if cbbType.GetSelectID <> 0 then
      log := log +',[Ӫ������]:'+cbbType.Text;
    if NovaChkPrintOrg.GetSelectID <>'' then
      log := log +',[��������λ]:'+NovaChkPrintOrg.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->�����������ܱ�','��ѯ',log);
  end
end;

end.
