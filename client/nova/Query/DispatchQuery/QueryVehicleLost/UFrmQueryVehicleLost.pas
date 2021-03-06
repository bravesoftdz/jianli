unit UFrmQueryVehicleLost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryVehicleLost  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    chkIsbalance: TCheckBox;
    chkIsnotbalance: TCheckBox;
    lbl2: TLabel;
    nvhelpVehicle: TNovaHelp;
    lbl7: TLabel;
    nvhlpCreateby: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlproute: TNovaHelp;
    nvhlpUnit: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryVehicleLost: TfrmQueryVehicleLost;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryVehicleLost.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date:=Now;
//  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date:=Now;
//  dtpEdepartdate.Checked := False;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryVehicleLost.tbtnFilterClick(Sender: TObject);
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
    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;

//    if dtpBdepartdate.Checked then
//    begin                                                                     //发车日期
    Params.ParamValues['filter_GED_vl!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
//    end
//    else
//    begin
//       Params.ParamValues['filter_GED_vl!departdate'] :='';
//    end;
//    if dtpEdepartdate.Checked then
//    begin
        Params.ParamValues['filter_LED_vl!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
//    end
//    else
//    begin
//      Params.ParamValues['filter_LED_vl!departdate'] :='';
//    end;

    if  (not (Trim(nvhlpUnit.Text) = '')) and  (nvhlpUnit.Id>0) then         //单位
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhlpUnit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

    if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then      //班次
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then
      begin
        Params.ParamValues['filter_EQL_pv!id']:= nvhelpVehicle.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_pv!id']:= '';
      end;

    if (not (Trim(nvhlproute.Text) = '')) and (nvhlproute.Id>0) then
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlproute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

      if  (not (Trim(nvhlpCreateby.Text) = '')) and  (nvhlpCreateby.Id>=0) then
      begin
        Params.ParamValues['filter_EQL_c!id']:= nvhlpCreateby.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_c!id']:= '';
      end;

     if chkIsnotbalance.Checked then                //是否已结算
      begin
        if not( chkIsbalance.Checked ) then
        begin
          Params.ParamValues['filter_EQL_vl!balanceid']:='0';
          Params.ParamValues['filter_GTL_vl!balanceid']:='';
        end
        else
        begin
          Params.ParamValues['filter_GTL_vl!balanceid']:='';
          Params.ParamValues['filter_EQL_vl!balanceid']:='';
        end;
      end
      else
      begin
        if chkIsbalance.Checked  then
        begin
          Params.ParamValues['filter_GTL_vl!balanceid']:='0';
          Params.ParamValues['filter_EQL_vl!balanceid']:='';
        end;
      end;
    Active:=true;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvckbOrgid.Text;
    if nvhlpUnit.Id <> 0 then
      log  := log +',[营运单位]:'+nvhlpUnit.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[营运线路]:'+nvhlproute.Text;
    if nvhlpschedule.Id <>0 then
      log := log +',[班次号]：'+nvhlpschedule.Text;
    if nvhelpVehicle.Id <> 0 then
      log := log +',[脱班车辆]：'+nvhelpVehicle.Text;
    if nvhlpCreateby.Id <> 0 then
      log  := log +',[操作人]:'+nvhlpCreateby.Text;
    if chkIsbalance.Checked then
      log := log +'，[已结算]';
    if chkIsnotbalance.Checked then
      log := log +'，[未结算]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->脱班班次情况查询','查询',log);
   end
end;

end.

