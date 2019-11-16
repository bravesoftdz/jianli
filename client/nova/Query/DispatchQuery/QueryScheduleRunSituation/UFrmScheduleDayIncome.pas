unit UFrmScheduleDayIncome;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, ComCtrls, StdCtrls, NovaHComboBox,
  NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh,Services,
  NvDbgridEh, ToolWin, ExtCtrls,PubFn, NovaCheckedComboBox;

type
  TFrmScheduleDayIncome = class(TSimpleCRUDForm)
    lbl6: TLabel;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    Label1: TLabel;
    dtpEndDate: TDateTimePicker;
    nvckbOrgid: TNovaCheckedComboBox;
    yes: TCheckBox;
    no: TCheckBox;
    lblsc: TLabel;
    nvcbbSchedulestatus: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleDayIncome: TFrmScheduleDayIncome;

implementation

{$R *.dfm}

procedure TFrmScheduleDayIncome.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbSchedulestatus.Active := False;
  nvcbbSchedulestatus.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;

end;

procedure TFrmScheduleDayIncome.tbtnFilterClick(Sender: TObject);
var log :string;
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
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
   if Trim(nvcbbSchedulestatus.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择班次状态！');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if ((yes.Checked) and (no.Checked = false)) then
    begin
      Params.ParamValues['isovertime'] := 'true';
    end else if ((yes.Checked = false) and (no.Checked)) then
    begin
      Params.ParamValues['isovertime'] := 'false';
    end else if ((yes.Checked) and (no.Checked)) then
    begin
      Params.ParamValues['isovertime']:=null;
    end else if ((yes.Checked = false) and (no.Checked = false)) then
    begin
      Params.ParamValues['isovertime']:=null;
    end;
    Params.ParamByName('schedulestatus').Value := nvcbbSchedulestatus.GetSelectID;

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEndDate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvckbOrgid.Text;
    if nvcbbSchedulestatus.GetSelectID <> '' then
      log := log +',[班次状态]:'+nvcbbSchedulestatus.Text;
    if yes.Checked then
      log := log +',[加班]';
    if no.Checked then
      log  := log +',[正班]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->客运每日班次营收统计表','查询',log);

  end
end;

end.
