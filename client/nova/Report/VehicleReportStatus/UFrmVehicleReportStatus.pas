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
    SysDialogs.ShowMessage('请选择机构！');
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

   log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
   if Trim(nvckbOrgid.GetSelectID) <>'' then
    log := log +',[报到机构]：'+nvckbOrgid.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->车辆报班情况一览表','查询',log);
  end;
end;

end.
