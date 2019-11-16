unit UFrmOrgInvoinceDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, ComCtrls, StdCtrls,
  NovaCheckedComboBox, NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList,
  GridsEh, DBGridEh, NvDbgridEh, ToolWin, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox;

type
  TFrmOrgInvoinceDetail = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label7: TLabel;
    NovaHelpBalanceUnit: TNovaHelp;
    Label2: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label3: TLabel;
    NovaHelpSchedule: TNovaHelp;
    lbltype: TLabel;
    nvcbbChecktype: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOrgInvoinceDetail: TFrmOrgInvoinceDetail;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure TFrmOrgInvoinceDetail.FormCreate(Sender: TObject);
begin
  inherited;
  //dbgrdhResult.OddRowColor:=clSkyBlue; //奇数行颜色
end;

procedure TFrmOrgInvoinceDetail.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  nvcbbChecktype.Active := False;
  nvcbbChecktype.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmOrgInvoinceDetail.tbtnFilterClick(Sender: TObject);
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
   if Trim(nvcbbChecktype.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择营运类型！');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_GED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_dv!departdate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);

    if (Trim(NHelpRoute.Text)<>'') and  (NHelpRoute.Id>0) then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;

    if (Trim(NovaHelpBalanceUnit.Text)<>'') and  (NovaHelpBalanceUnit.Id>0) then
      Params.ParamValues['filter_EQL_u2!id'] := NovaHelpBalanceUnit.Id
    else
      Params.ParamValues['filter_EQL_u2!id'] := null;

    if (Trim(NovaHelpVehiclenoHelp.Text)<>'') and  (NovaHelpVehiclenoHelp.Id>0) then
      Params.ParamValues['filter_EQL_v!id'] := NovaHelpVehiclenoHelp.Id
    else
      Params.ParamValues['filter_EQL_v!id'] := null;

    if (Trim(NovaHelpUnit.Text)<>'') and  (NovaHelpUnit.Id>0) then
      Params.ParamValues['filter_EQL_u1!id'] := NovaHelpUnit.Id
    else
      Params.ParamValues['filter_EQL_u1!id'] := null;

    if (Trim(NovaHelpSchedule.Text)<>'') and  (NovaHelpSchedule.Id>0) then
      Params.ParamValues['filter_EQL_s!id'] := NovaHelpSchedule.Id
    else
      Params.ParamValues['filter_EQL_s!id'] := null;

      Params.ParamValues['filter_INS_v!type'] := nvcbbChecktype.GetSelectID;



     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


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
    if nvcbbChecktype.GetSelectID <> '' then
      log  := log +'[班次类型]:'+nvcbbChecktype.Text;
    if NovaHelpSchedule.Id <>0 then
      log  := log +',[班次号]:'+NovaHelpSchedule.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->客运站划拨明细表','查询',log);

  end
end;

end.
