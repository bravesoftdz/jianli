unit UFrmInsuranceReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmInsuranceReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    sellOrgid: TNovaCheckedComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    nvhelpUserid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsuranceReport: TFrmInsuranceReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmInsuranceReport.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True  then
    begin
       dtpEselldate.Checked := True;
    end;
   if  dtpBselldate.Checked =False then
    begin
       dtpEselldate.Checked := False;
    end;
end;

procedure TFrmInsuranceReport.dtpenddateChange(Sender: TObject);
begin
  inherited;
  dtpEselldate.DateTime := dtpenddate.DateTime + 31;
end;

procedure TFrmInsuranceReport.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True  then
  begin
     dtpBselldate.Checked := True;
  end;
 if  dtpEselldate.Checked =False then
  begin
     dtpBselldate.Checked := False;
  end;
end;

procedure TFrmInsuranceReport.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  dtpBselldate.DateTime := dtpstartdate.DateTime - 31;
end;

procedure TFrmInsuranceReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dtpBselldate.DateTime := dtpstartdate.DateTime - 31;
  dtpEselldate.DateTime := dtpenddate.DateTime + 31;
  sellOrgid.Active := False;
  sellOrgid.Active := True;
end;

procedure TFrmInsuranceReport.tbtnFilterClick(Sender: TObject);
var log : string;
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
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_i!orgid'] := sellOrgid.GetSelectID;
      Params.ParamValues['orgids'] := sellOrgid.GetSelectID;
      Params.ParamValues['filter_GED_i!selltime'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01';
      Params.ParamValues['filter_LED_i!selltime'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59';
      Params.ParamValues['begindate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01';
      Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59';
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpBselldate.Date);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
      Params.ParamValues['departbegindate'] := FormatDateTime('yyyy-mm-dd',dtpBselldate.Date);
      Params.ParamValues['departenddate'] := FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
      if Trim(nvhelpRoute.Text) = '' then
        Params.ParamValues['routeid'] := ''
      else
        params.ParamValues['routeid'] := nvhelpRoute.Id;
      if Trim(nvhelpUserid.text) = '' then
      begin
        params.ParamValues['filter_EQL_i!sellby'] := '';
        params.ParamValues['returnOrcanceluserid'] := '';
      end
      else
      begin
        params.ParamValues['filter_EQL_i!sellby'] := nvhelpUserid.Id;
        params.ParamValues['returnOrcanceluserid'] := nvhelpUserid.Id;
      end;
    Active := True;

    log := '查询条件有：[售票日期]从 '+ FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01'
      +'至'+FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59'
      +',[发车日期] 从'+FormatDateTime('yyyy-mm-dd',dtpBselldate.Date)
      +'至'+ FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
    if Trim(sellOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+sellOrgid.Text;
    if nvhelpRoute.Id <> 0 then
      log := log +',[线路]：'+nvhelpRoute.Text;
    if nvhelpUserid.Id <>0 then
      log := log +',[售票员]:'+nvhelpUserid.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->售票员保险销售统计','查询',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
  end;
end;

end.
