unit UFrmEachTickeIncomeSumRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping;

type
  TFrmEachTickeIncomeSumRpt = class(TSimpleCRUDForm)
    Label10: TLabel;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEachTickeIncomeSumRpt: TFrmEachTickeIncomeSumRpt;

implementation
  uses PubFn, Services;
{$R *.dfm}

procedure TFrmEachTickeIncomeSumRpt.FormShow(Sender: TObject);
begin
  inherited;
  NovaChkSaleOrg.Active := False;
  NovaChkSaleOrg.Active := true;
  NovaChkSaleOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBselldate.Date:=now;
  dtpEselldate.Date:=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmEachTickeIncomeSumRpt.tbtnFilterClick(Sender: TObject);
var days:Integer;
    log : string;
begin
  inherited;
 if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  days :=StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID));
  if   days <= Trunc(dtpEselldate.Date-dtpBselldate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('+IntToStr(days)+'),请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_ts!orgid'] := NovaChkSaleOrg.GetSelectID;
    Params.ParamValues['filter_GED_ts!selldate']
                        :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime);
    Params.ParamValues['filter_LED_ts!selldate']
                        :=  formatdatetime('yyyy-mm-dd',dtpEselldate.DateTime);
    Active := true;

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);

    log := '查询条件有：[售票日期]：'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' 至 '+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
    if Trim(NovaChkSaleOrg.GetSelectID) <>'' then
      log := log +',[售票机构]：'+NovaChkSaleOrg.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->各站互售互退营收汇总表','查询',log);
  end;
end;

end.
