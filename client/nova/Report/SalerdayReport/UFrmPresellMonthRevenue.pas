unit UFrmPresellMonthRevenue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,DateUtils;

type
  TFrmPresellMonthRevenue = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    dtpsellmonth: TDateTimePicker;
    NovaCkbOrg: TNovaCheckedComboBox;
    chkIsSellLocal: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPresellMonthRevenue: TFrmPresellMonthRevenue;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure TFrmPresellMonthRevenue.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpsellmonth.Date := IncMonth(Now,-1);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmPresellMonthRevenue.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if NovaCkbOrg.CheckedCount=0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['month'] := DateToStr(dtpsellmonth.Date);
    if chkIsSellLocal.Checked then
    begin
      Params.ParamValues['isSellLocal'] := 'true';
    end
    else
    begin
      Params.ParamValues['isSellLocal'] := 'false';
    end;
    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='售票月份：'+ formatdatetime('yyyy-mm',dtpsellmonth.Date);;
    Active := True;
    log := '查询条件有：[售票月份]从 '+ formatdatetime('yyyy-MM',dtpsellmonth.Date);
    if Trim(NovaCkbOrg.GetSelectID) <>'' then
      log := log +',[机构]：'+NovaCkbOrg.Text;
    if chkIsSellLocal.Checked then
      log := log +'，[勾选 本站售本站票]';
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->长途站预售票查询情况表（跨月汇总）','查询',log);
  end
end;

end.
