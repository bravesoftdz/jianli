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
  //dbgrdhResult.OddRowColor:=clSkyBlue; //奇数行颜色
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
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
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
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;

    if NovaChkPrintOrg.GetSelectID = '' then
    begin
      SysDialogs.ShowMessage('请选择打单机构！');
      exit;
    end;
                         //开运量单位
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

    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    if NHelpRoute.Id <>0 then
      log  := log +',[线路]：'+NHelpRoute.Text;
    if NovaHelpUnit.Id <> 0 then
      log := log +',[车属单位]:'+NovaHelpUnit.Text;
    if NovaHelpBalanceUnit.Id <> 0 then
      log := log +',[结算单位]:'+NovaHelpBalanceUnit.Text;
    if NovaHelpVehiclenoHelp.Id <> 0 then
      log :=log +',[营运车辆]:'+NovaHelpVehiclenoHelp.Text;
    if cbbType.GetSelectID <> 0 then
      log := log +',[营运类型]:'+cbbType.Text;
    if NovaChkPrintOrg.GetSelectID <>'' then
      log := log +',[开运量单位]:'+NovaChkPrintOrg.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->车辆划拨汇总表','查询',log);
  end
end;

end.
