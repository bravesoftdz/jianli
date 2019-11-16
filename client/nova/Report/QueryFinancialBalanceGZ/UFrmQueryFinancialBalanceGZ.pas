unit UFrmQueryFinancialBalanceGZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryFinancialBalanceGZ  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryFinancialBalanceGZ: TfrmQueryFinancialBalanceGZ;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryFinancialBalanceGZ.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryFinancialBalanceGZ.jcdsResultAfterOpen(DataSet: TDataSet);
var  footers :TColumnFooterEh;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    
  end;
end;

procedure TfrmQueryFinancialBalanceGZ.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;

  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['orgids']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate']
          := FormatDateTime('yyyy-mm', dtpstartdate.Date)+'-01';
    Params.ParamValues['enddate']
          := FormatDateTime('yyyy-mm', dtpstartdate.Date)+'-31';
   
    log := '查询条件有：[售票月份]'+ formatdatetime('yyyy-MM',dtpstartdate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    //log := log+'。查询结果:返回 '+ inttostr(RecordCount) +' 条记录！';

    SysLog.WriteLog('报表统计->客运收入支出平衡表-赣州','查询',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='售票月份：'+ formatdatetime('yyyy-MM',now);

    Active:=true;
    end
end;

end.
