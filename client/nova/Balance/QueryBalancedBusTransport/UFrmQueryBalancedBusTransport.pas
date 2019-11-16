unit UFrmQueryBalancedBusTransport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services, NovaPrint,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic, Generics.Collections,
  NovaHComboBox;

type
  TfrmQueryBalancedBusTransport = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    dtpBalancedBusTransportStart: TDateTimePicker;
    dtpBalancedBusTransportEnd: TDateTimePicker;
    NovaHelpUnit: TNovaHelp;
    Splitter1: TSplitter;
    Label1: TLabel;
    nvhlpRoute: TNovaHelp;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    jcdsResultorgname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultdeductmoney: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    parameter: String;
  public
    { Public declarations }
  end;

var
  frmQueryBalancedBusTransport: TfrmQueryBalancedBusTransport;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryBalancedBusTransport.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := False;
  nvcbborg.Active := True;
  nvcbborg.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  dtpBalancedBusTransportStart.Date := Now;
  dtpBalancedBusTransportEnd.Date := Now;
end;

procedure TfrmQueryBalancedBusTransport.tbtnFilterClick(Sender: TObject);
var
  log: string;
  printstr: string;
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbborg.SetFocus;
    exit;
  end;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_org!id'] := nvcbborg.GetSelectID;

    Params.ParamValues['filter_GED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportStart.DateTime);
    Params.ParamValues['filter_LED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportEnd.DateTime + 1);

    if (not(Trim(NovaHelpUnit.Text) = '')) and (NovaHelpUnit.Id > 0) then
    // 车属单位
    begin
      Params.ParamValues['filter_EQL_u!id'] := NovaHelpUnit.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;

    // 线路
    if nvhlpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!id'] := nvhlpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := '';

    // 车牌
    if nvhelpvehicleno.Id > 0 then
      Params.ParamValues['filter_EQL_v!id'] := nvhelpvehicleno.Id
    else
      Params.ParamValues['filter_EQL_v!id'] := '';

    Active := True;
    log := '查询条件有：[结账日期]从 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedBusTransportStart.Date) + ' 至 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedBusTransportEnd.Date);
    if Trim(nvcbborg.Text) <> '' then
      log := log + ',[所属机构]：' + nvcbborg.Text;
    if Trim(nvhlpRoute.Text) <> '' then
      log := log + ',[线路]：' + nvhlpRoute.Text;
    if Trim(NovaHelpUnit.Text) <> '' then
    begin
      log := log + ',[车属单位]：' + NovaHelpUnit.Text;
      printstr := ',车属单位:' + NovaHelpUnit.Text;
    end;
    if Trim(nvhelpvehicleno.Text) <> '' then
      log := log + ',[车牌]：' + nvhelpvehicleno.Text;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '结账日期：' + formatdatetime
      ('yyyy-mm-dd', dtpBalancedBusTransportStart.Date)
      + ' 至 ' + formatdatetime('yyyy-mm-dd', dtpBalancedBusTransportEnd.Date)
      + printstr;

    log := log + '。[查询结果]:返回 ' + inttostr(recordcount) + ' 条记录！';
    SysLog.WriteLog('结算管理->已结算查询', '查询', log);
  end;
end;

end.
