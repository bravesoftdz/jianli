unit UFrmQueryScheduleCheckSum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,UDMPublic,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,Services;

type
  TFrmQueryScheduleCheckSum = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl11: TLabel;
    lbl5: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label9: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBdepartdate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    nvhelpSchedule: TNovaHelp;
    nvhelpRoute: TNovaHelp;
    nvhelpUserid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryScheduleCheckSum: TFrmQueryScheduleCheckSum;

implementation
   uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TFrmQueryScheduleCheckSum.FormCreate(Sender: TObject);
begin
  inherited;
   nvckbOrgid.Active:=false;
   nvckbOrgid.Active:=true;
   nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmQueryScheduleCheckSum.FormShow(Sender: TObject);
begin
  inherited;
  self.dtpBdepartdate.Date:=now;
  self.dtpEdepartdate.Date:=now;
end;

procedure TFrmQueryScheduleCheckSum.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    // 发车日期
    Params.ParamValues['filter_GED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpEdepartdate.Date);


    if (not(Trim(nvhelpSchedule.Text) = '')) and (nvhelpSchedule.Id > 0) then
    // 班次号     //班次
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhelpSchedule.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhelpRoute.Text) = '')) and (nvhelpRoute.Id > 0) then // 线路
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhelpRoute.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then // 打单员
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    Active := true;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvckbOrgid.Text;
    if nvhelpRoute.Id <> 0 then
      log := log +',[营运线路]:'+nvhelpRoute.Text;
    if nvhelpSchedule.Id <> 0 then
      log := log +',[班次号]：'+nvhelpSchedule.Text;
    if nvhelpUserid.Id <> 0 then
      log  := log +',[检票员]:'+nvhelpUserid.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->班次检票汇总表','查询',log);
  end;
end;
end.
