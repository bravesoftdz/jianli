unit UFrmVehicleReportStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox;

type
  TFrmVehicleReportStatus = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    cbbvehiclereport: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleReportStatus: TFrmVehicleReportStatus;

implementation
uses SystemInstance, SysInfoIntf, PubFn, Services;
{$R *.dfm}

procedure TFrmVehicleReportStatus.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmVehicleReportStatus.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['reportway'] := cbbvehiclereport.ItemIndex;
    Active := True;

   log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
   if Trim(nvckbOrgid.GetSelectID) <>'' then
    log := log +',[��������]��'+nvckbOrgid.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->�����������һ����','��ѯ',log);
  end;
end;

end.
