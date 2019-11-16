unit UFrmQueryBilldetailReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TfrmQueryBilldetailReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    novahcbbtype: TNovaHComboBox;
    nvhlprecipients: TNovaHelp;
    lbl5: TLabel;
    Label2: TLabel;
    novahcbbstorage: TNovaHComboBox;
    jcdsResultorgname: TWideStringField;
    jcdsResulttotal: TFloatField;
    jcdsResultleftnum: TFloatField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultsellbyname: TWideStringField;
    jcdsResultbtname: TWideStringField;
    jcdsResultbillno: TWideStringField;
    jcdsResultcaoffnum: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryBilldetailReport: TfrmQueryBilldetailReport;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryBilldetailReport.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  novahcbbtype.Active := False;
  novahcbbtype.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryBilldetailReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBilldetailReport.tbtnFilterClick(Sender: TObject);
var
  log:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//消除选择时间bug
  if nvckbOrgid.GetCount = 0 then
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
      Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date+1);
    if novahcbbstorage.ItemIndex>=0 then
      Params.ParamByName('storageid').Value :=novahcbbstorage.HelpFieldValue['id']
    else
      Params.ParamByName('storageid').Value :='';

    if novahcbbtype.ItemIndex>=0 then
      Params.ParamByName('billtypeid').Value :=novahcbbtype.HelpFieldValue['id']
    else
      Params.ParamByName('billtypeid').Value :='';

    if nvhlprecipients.id<=0 then
      Params.ParamByName('recipients').Value := ''
    else
      Params.ParamByName('recipients').Value := nvhlprecipients.Id;

    Active := True;


    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='领票日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[领票日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;

    log := log + ' 。[查询结果]:返回 ' + inttostr(recordcount) + ' 条记录！';
    SysLog.WriteLog('报表统计->站务分公司使用票证明细帐', '查询', log);
  end;

end;

end.
