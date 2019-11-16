unit UFrmQueryVehicleStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryVehicleStop  = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl2: TLabel;
    nvhlpVehicle: TNovaHelp;
    lbl7: TLabel;
    nvhlpCreateby: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    lbl6: TLabel;
    nvHcbbOrg: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryVehicleStop: TfrmQueryVehicleStop;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryVehicleStop.FormCreate(Sender: TObject);
begin
  inherited;
//  nvckbOrgid.Active := False;
//  nvckbOrgid.Active := True;
//  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
   with nvHcbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    nvHcbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
end;

procedure TfrmQueryVehicleStop.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_st!id']:= nvHcbbOrg.HelpFieldValue['id'];
                                                                    //发车日期
    Params.ParamValues['filter_GED_ss!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ss!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    if  (not (Trim(nvhlpCreateby.Text) = '')) and  (nvhlpCreateby.Id>=0) then
      begin
        Params.ParamValues['filter_EQL_upb!id']:= nvhlpCreateby.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_upb!id']:= '';
      end;

    if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then      //班次
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhlproute.Text) = '')) and (nvhlproute.Id>0) then
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlproute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

      //计划车辆
    if (not (Trim(nvhlpVehicle.Text) = '')) and (nvhlpVehicle.Id>0) then
      begin
        Params.ParamValues['vehicleno']:= nvhlpVehicle.Text;
      end
    else
      begin
        Params.ParamValues['vehicleno']:= '';
      end;
      Active:=true;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvHcbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[当前调度站]：'+nvHcbbOrg.Text;
    if nvhlpVehicle.Id <> 0 then
      log  := log +',[车辆]:'+nvhlpVehicle.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[营运线路]:'+nvhlproute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[班次号]：'+nvhlpschedule.Text;
    if nvhlpCreateby.Id <> 0 then
      log  := log +',[操作人]:'+nvhlpCreateby.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->停班班次情况查询','查询',log);
   end
end;

end.
