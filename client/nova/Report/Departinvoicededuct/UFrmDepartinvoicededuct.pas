unit UFrmDepartinvoicededuct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaCheckedComboBox;

type
  TFrmDepartinvoicededuct = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbbdepart: TNovaHComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicededuct: TFrmDepartinvoicededuct;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmDepartinvoicededuct.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
  cbbdepart.Active := False;
  cbbdepart.Active := True;
end;

procedure TFrmDepartinvoicededuct.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

procedure TFrmDepartinvoicededuct.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
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
  if trim(cbbOrgid.GetSelectID) = '' then
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
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := cbbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if Trim(cbbdepart.Text) <> '' then
      Params.ParamValues['printorgid'] := cbbdepart.HelpFieldValue['id']
    else
      Params.ParamValues['printorgid'] := '';
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbbOrgid.GetSelectID) <>'' then
      log := log +',[机构]：'+cbbOrgid.Text;
    if Trim(cbbdepart.Text) <> '' then
      log := log +',[开运量单位]:'+ cbbdepart.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->固定扣费项目查询','查询',log);

  end;

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

end;

end.
