unit UFrmQuerySchedulePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmQuerySchedulePrice = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    NHelpRoute: TNovaHelp;
    NovaCkbOrg: TNovaCheckedComboBox;
    Label3: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpReachstation: TNovaHelp;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    nvhlpschedule: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure nvhlpScheduleKeyPress(Sender: TObject; var Key: Char);
    procedure nvhlpReachstationKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQuerySchedulePrice: TFrmQuerySchedulePrice;

implementation

uses PubFn,Services,UDMPublic;
{$R *.dfm}

procedure TFrmQuerySchedulePrice.FormShow(Sender: TObject);
begin
  inherited;
  dtpBdepartdate.Date:=now;
  dtpEdepartdate.Date:=now;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQuerySchedulePrice.NHelpRouteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
 if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmQuerySchedulePrice.nvhlpReachstationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
 if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmQuerySchedulePrice.nvhlpScheduleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
 if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmQuerySchedulePrice.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
   if Trunc(dtpBdepartdate.Date) >Trunc(dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    dtpBdepartdate.SetFocus;
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_org!id'] := NovaCkbOrg.GetSelectID;
     // 发车日期
    Params.ParamValues['filter_GED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpEdepartdate.Date);

    if  (Trim(NHelpRoute.Text)='') and (NHelpRoute.Id<=0)  then
    begin
     Params.ParamValues['filter_EQL_r!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] :=  NHelpRoute.Id;
    end;

    if (Trim(nvhlpReachstation.Text)<>'') then //or (nvhelpendstation.HelpFieldValue['id']>0) then
    begin
    Params.ParamValues['filter_EQL_sr!id']:= nvhlpReachstation.Id;
    end
    else
    begin
       Params.ParamValues['filter_EQL_sr!id']:= '';
    end;

      // 班次号
   if (not(Trim(nvhlpSchedule.Text) = '')) and (nvhlpSchedule.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpSchedule.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;
    Active := true;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
        +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(NovaCkbOrg.GetSelectID) <>'' then
      log := log +',[所属机构]：'+NovaCkbOrg.Text;
    if NHelpRoute.Id <> 0 then
      log := log +',[营运线路]:'+NHelpRoute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[班次号]：'+nvhlpschedule.Text;
    if nvhlpReachstation.Id <> 0 then
      log  := log +',[到站]:'+nvhlpReachstation.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->班次票价查询','查询',log);
  end;
end;

end.
