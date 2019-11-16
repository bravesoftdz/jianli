unit UFrmVehicleStationDepartinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmVehicleStationDepartinvoice = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    lblendstationname: TLabel;
    lblroute: TLabel;
    nvhlpendstation: TNovaHelp;
    nvhlpRoute: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleStationDepartinvoice: TFrmVehicleStationDepartinvoice;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmVehicleStationDepartinvoice.FormCreate(Sender: TObject);
begin
  inherited;
    dtpstartdate.DateTime := Now();
    dtpenddate.DateTime := Now();
    cbborg.Active := False;
    cbborg.Active := True;
    cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmVehicleStationDepartinvoice.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
   if (cbborg.GetCount = 0) or (cbborg.Text = '')then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    exit;
  end;
  if nvhelpvehicleno.Id = 0 then
  begin
    SysDialogs.ShowMessage('请先填写车辆信息！');
    Exit;
  end  ;
  if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['orgid'] := cbborg.GetSelectID;
    Params.ParamValues['vehicleid'] := nvhelpvehicleno.Id;

    if nvhlproute.Id > 0 then
      params.ParamValues['routeid'] := nvhlproute.HelpFieldValue['id']
    else
      params.ParamValues['routeid'] := '';

    if (Trim(nvhlpendstation.Text)<>'') then
    begin
      Params.ParamValues['stationid']:= nvhlpendstation.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['stationid']:= '';
    end;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd', (dtpstartdate.Date));
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd', (dtpenddate.Date));
    Active:= true;
    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbborg.Text) <>'' then
      log := log +',[所属机构]：'+cbborg.Text;
    if nvhlpRoute.Id <> 0 then
      log  := log +',[线路]:'+nvhlpRoute.Text;
    if nvhelpvehicleno.Id <> 0 then
      log := log +'[车牌]：'+nvhelpvehicleno.Text;
    if nvhlpendstation.Id <> 0 then
      log := log +',[到达站]:'+ nvhlpendstation.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->车辆停靠站点运量情况汇总表','查询',log);
  end;
end;

end.
