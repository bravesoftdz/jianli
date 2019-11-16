unit UFrmVehicleDepartinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic;

type
  TFrmVehicleDepartinvoices = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    lbl2: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    Label4: TLabel;
    nvhelpunitname: TNovaHelp;
    nvhelpvehicleno: TNovaHelp;
    chkovertime: TCheckBox;
    chknotovertime: TCheckBox;
    lblvehicletypeid: TLabel;
    NovaHVehicleTypes: TNovaHelp;
    Label12: TLabel;
    cbbbalancetype: TComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleDepartinvoices: TFrmVehicleDepartinvoices;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVehicleDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  cbbbalancetype.ItemIndex:=0;

end;

procedure TFrmVehicleDepartinvoices.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmVehicleDepartinvoices.tbtnFilterClick(Sender: TObject);
var log : string;
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
  if trim(cbbOrgid.GetSelectID) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := cbbOrgid.GetSelectID;
    params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvhelpunitname.Text) = '' then
      Params.ParamValues['filter_EQL_u1!id'] := null
    else
      Params.ParamValues['filter_EQL_u1!id'] := nvhelpunitname.Id;
    if Trim(nvhelpvehicleno.Text) = '' then
      Params.ParamValues['filter_EQL_v!id'] := null
    else
      Params.ParamValues['filter_EQL_v!id'] := nvhelpvehicleno.Id;
    if Trim(NovaHVehicleTypes.Text) = '' then
      Params.ParamValues['filter_EQL_v!vehicletypeid'] := null
    else
      params.ParamValues['filter_EQL_v!vehicletypeid'] := NovaHVehicleTypes.Id;
    if ((chkovertime.Checked) and (chknotovertime.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'true';
    end else if ((chkovertime.Checked = false) and (chknotovertime.Checked)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := 'false';
    end else if ((chkovertime.Checked) and (chknotovertime.Checked)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:=null;
    end else if ((chkovertime.Checked = false) and (chknotovertime.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime']:=null;
    end;
    Params.ParamValues['balancetypeflag']:=cbbbalancetype.ItemIndex;
    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+cbbOrgid.Text;
    if nvhelpunitname.Id <> 0 then
      log := log +',[������λ]:'+ nvhelpunitname.Text;
    if nvhelpvehicleno.Id <> 0 then
      log := log+',[���ƺ�]:'+nvhelpvehicleno.Text;
    if Trim(NovaHVehicleTypes.Text)<>'' then
      log := log +',[����]��'+NovaHVehicleTypes.Text;
    if chkovertime.Checked then
      log := log +',[�Ӱ�]';
    if chknotovertime.Checked then
      log := log +',[����]' ;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->����������ܲ�ѯ','��ѯ',log);

  end;
  dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);


end;

end.
