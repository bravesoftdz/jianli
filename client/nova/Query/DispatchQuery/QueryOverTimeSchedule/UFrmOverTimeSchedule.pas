unit UFrmOverTimeSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmOverTimeSchedule  = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    lblroute: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    pnl2: TPanel;
    grp2: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    spl1: TSplitter;
    lbl3: TLabel;
    nvhlpBalanceUnit: TNovaHelp;
    nvhlpUnit: TNovaHelp;
    nvhlpBUnit: TNovaHelp;
    nvhlproute: TNovaHelp;
    lbl6: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lblsc: TLabel;
    nvcbbSchedulestatus: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOverTimeSchedule: TfrmOverTimeSchedule;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmOverTimeSchedule.FormCreate(Sender: TObject);
begin
  inherited;
 with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    //nvHcbbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
    NovaHCbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
end;

procedure TfrmOverTimeSchedule.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  nvcbbSchedulestatus.Active := False;
  nvcbbSchedulestatus.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmOverTimeSchedule.tbtnFilterClick(Sender: TObject);
var selectids,st,results,log :string;temp:Integer ;
begin
  inherited;
   if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['curstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_GED_sp!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['filter_LED_sp!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
  if trim(nvhlproute.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;

   if Trim(nvhlpunit.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_vrr!reportunit'] := null;
    end else
    begin
      Params.ParamValues['filter_EQS_vrr!reportunit'] := nvhlpunit.Text;
    end;

    if Trim(nvhlpBUnit.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_vrr!balanceid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_vrr!balanceid'] := nvhlpBUnit.Id;
    end;
    selectids :=   nvcbbSchedulestatus.GetSelectID;
    selectids:=Copy(selectids,2,Length(selectids)-2);
    for st in selectids do
    begin
      if Pos(',',st)>0 then
        results:=results+st
      else
        results:=results+'''' +st+'''';
    end;
    results :='('+results+')';
    Params.ParamByName('filter_INS_ss!status').Value := results;
    Active:= true;
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '查询条件有：[发车日期从] '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(NovaHCbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[当前调度站]：'+NovaHCbbOrg.Text;
    if nvhlpRoute.Id <> 0 then
      log  := log +',[线路]:'+nvhlpRoute.Text;
    if  nvhlpUnit.Id <> 0 then
      log := log +',[经营单位]：'+nvhlpUnit.Text;
    if nvhlpBUnit.Id <> 0 then
      log := log +',[结算单位]：'+nvhlpBUnit.Text;
    if Trim(nvcbbSchedulestatus.GetSelectID) <>'' then
      log := log+',[班次状态]：'+nvcbbSchedulestatus.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('调度查询->客运站加班次情况查询','查询',log);
  end;
end ;
end.

