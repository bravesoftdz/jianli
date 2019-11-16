unit UFrmQueryVehicleLicense;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,UDMPublic;

type
  TFrmQueryVehicleLicense = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label8: TLabel;
    cbbOvertime: TComboBox;
    NovaChkReportOrg: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryVehicleLicense: TFrmQueryVehicleLicense;

implementation
 uses PubFn, Services;
{$R *.dfm}

procedure TFrmQueryVehicleLicense.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date:=now;
  dtpenddate.Date:=now;
  NovaChkReportOrg.Active := False;
  NovaChkReportOrg.Active := True;
  NovaChkReportOrg.CheckById(True, sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQueryVehicleLicense.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if NovaChkReportOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ�񱨵�������');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpenddate.Date - dtpstartdate.Date) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['rp.orgids'] := NovaChkReportOrg.GetSelectID;
    Params.ParamValues['rp.schtype'] := cbbOvertime.ItemIndex;
    Params.ParamValues['rp.unitid'] := NovaHelpUnit.Id;
    Params.ParamValues['rp.routeid'] := NHelpRoute.Id;
    Params.ParamValues['rp.vehicleid'] := NovaHelpVehiclenoHelp.Id;
    Params.ParamValues['rp.startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['rp.enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    dbgrdhResult.PrintInfo.Title:=sysinfo.LoginUserInfo.OrgName+self.Caption;
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '�������ڣ�' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' ��' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(NovaChkReportOrg.GetSelectID) <>'' then
      log := log +',[��������]��'+NovaChkReportOrg.Text;
    if NovaHelpUnit.Id <>0 then
      log  := log +',[������λ]:'+NovaHelpUnit.Text;
    if NHelpRoute.Id <> 0 then
      log := log +'[��·]��'+NHelpRoute.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log:= log+',[����]:'+NovaHelpVehiclenoHelp.Text;
    if cbbOvertime.Text <>'' then
      log := log +',[�������]'+cbbOvertime.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->����Ӧ��ǼǱ�','��ѯ',log);
  end;

end;

end.
