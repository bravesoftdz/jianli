unit UFrmQuerySellBalanceSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TfrmQuerySellbalanceSummary = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    cbbPrintOrgid: TNovaCheckedComboBox;
    cbbSellOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    nvhlpSchedule: TNovaHelp;
    nvhlpVehicle: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    { protected declarations }
  public
    { Public declarations }
  published
    { published declarations }
  automated
    { automated declarations }
  end;

var
  frmQuerySellbalanceSummary: TfrmQuerySellbalanceSummary;

implementation
uses Services,PubFn;
{$R *.dfm}
procedure TfrmQuerySellbalanceSummary.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  cbbPrintOrgid.Active := False;
  cbbPrintOrgid.Active := True;
  cbbSellOrgid.Active := False;
  cbbSellOrgid.Active := True;
end;
procedure TfrmQuerySellbalanceSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  cbbPrintOrgid.Active := False;
  cbbPrintOrgid.Active := True;
  cbbSellOrgid.Active := False;
  cbbSellOrgid.Active := True;
end;

procedure TfrmQuerySellbalanceSummary.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数['+
    getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID)+'天],请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['printorgids'] := cbbPrintOrgid.GetSelectID;
      Params.ParamValues['sellorgids'] := cbbSellOrgid.GetSelectID;
      Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
      Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
      Params.ParamValues['routeid'] :=  nvhlpRoute.Id;
      Params.ParamValues['scheduleid'] :=  nvhlpSchedule.Id;
      Params.ParamValues['vehicleid'] := nvhlpVehicle.Id;
    Active := True;
  end;
end;

end.
