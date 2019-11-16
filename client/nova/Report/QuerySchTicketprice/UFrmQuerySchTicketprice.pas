unit UFrmQuerySchTicketprice;

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
  TfrmQuerySchTicketprice = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    chkend: TCheckBox;
    chkreach: TCheckBox;
    lbl5: TLabel;
    nvhlpRoute: TNovaHelp;
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
  frmQuerySchTicketprice: TfrmQuerySchTicketprice;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQuerySchTicketprice.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQuerySchTicketprice.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQuerySchTicketprice.tbtnFilterClick(Sender: TObject);
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
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
   { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  begin
    SysDialogs.Warning('同比日期天数差必须等于发车日期天数差!');
    Exit;
  end; }
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    //按到达站汇总
    if chkend.Checked then
    begin
      Params.ParamValues['filter_EQB_p!isbyend']:= 'true';
    end
    else
      Params.ParamValues['filter_EQB_p!isbyend']:= 'false';

      //含中途站汇总
    if chkreach.Checked then
    begin
      Params.ParamValues['filter_EQB_p!isbyreach']:= 'true';
    end
    else
      Params.ParamValues['filter_EQB_p!isbyreach']:= 'false';
    if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= '';
    end;
    Active := True;

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='票价执行日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[票价执行日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;

    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->站务分公司各班线票价情况汇总表','查询',log);
  end;

end;

end.
