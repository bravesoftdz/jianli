unit UFrmScheduleRouteBalanceRpt;

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
  TfrmScheduleRouteBalanceRpt = class(TSimpleCRUDForm)
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
    nvhlpvehicleno: TNovaHelp;
    lblendstationname: TLabel;
    nvhlpendstation: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ChangeDateOrder(dates: TDateTime);
  public
    { Public declarations }
  end;

var
  frmScheduleRouteBalanceRpt: TfrmScheduleRouteBalanceRpt;

implementation

uses SystemInstance, SysInfoIntf,PubFn,DateUtils;
{$R *.dfm}

procedure TfrmScheduleRouteBalanceRpt.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmScheduleRouteBalanceRpt.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  //dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmScheduleRouteBalanceRpt.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  peplodistance1: double;
  alldistance1: Int64;
  allseatnum1: Int64;
  checkticketnum1: Int64;
  truetake: double;
  _truetake: double;
  aa,log:string;
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '') then
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
  if Trunc(dtpenddate.Date-dtpstartdate.Date)>=31
    then
  begin
      SysDialogs.Warning('选择日期的天数差不能超过31天,请重新选择!');
    exit;
  end;
  ChangeDateOrder(dtpstartdate.Date);
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    if nvhlpvehicleno.Id>0 then
      Params.ParamValues['vehicleid'] := nvhlpvehicleno.Id
    else
      Params.ParamValues['vehicleid'] := '';
    if nvhlpendstation.Id > 0 then
    Params.ParamValues['stationid'] :=nvhlpendstation.HelpFieldValue['id']
    else
    Params.ParamValues['stationid'] :='';


    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Active := True;

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '查询条件有：发车日期从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',机构：'+nvckbOrgid.Text;
    if nvhlpvehicleno.Id <> 0 then
      log := log +',车牌:'+ nvhlpvehicleno.Text;
    if nvhlpendstation.Id <> 0 then
      log := log +',到站:'+ nvhlpendstation.Text;
    log := log+'。查询结果:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->班线结算统计表','查询',log);
  end;

end;

procedure TfrmScheduleRouteBalanceRpt.ChangeDateOrder(dates:TDateTime);
var I,orderDate,endDate,lastDateOfmm,temp:Integer;
    curcolumn:TColumnTitleEh;
begin
  inherited;

//  SysDialogs.ShowMessage('选择日期的月份；'+FormatDateTime('m',dtpstartdate.Date));
//  SysDialogs.ShowMessage('选择的日期'+FormatDateTime('d',dtpstartdate.Date));
//  SysDialogs.ShowMessage('当月最后一天：'+FormatDateTime('dd',EndOfTheMonth(dtpstartdate.Date)));
  //选择的开始日期
  orderDate := StrToInt(FormatDateTime('dd',dtpstartdate.Date));
  //选择的结束日期
  endDate := StrToInt(FormatDateTime('dd',dtpenddate.Date));
  //选择的开始日期当月最后一天
  lastDateOfmm := StrToInt(FormatDateTime('dd',EndOfTheMonth(dtpstartdate.Date)));
  temp :=0;
  // 选择的两个日期在同一月份
 if FormatDateTime('m',dtpstartdate.Date)=FormatDateTime('m',dtpenddate.Date)
 then
 begin
  for I := orderDate to endDate do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||人数';
    dbgrdhResult.Columns[3+temp].FieldName := 'date'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
  //把选择的日期以外不需要显示的隐藏
  if temp<=31 then
  begin
    for I := temp to 31 do
    begin
       dbgrdhResult.Columns[3+temp].Visible :=False;
       temp := temp+1;
    end;
  end;
 end
 else
 begin
  for I := orderDate to lastDateOfmm do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||人数';
    dbgrdhResult.Columns[3+temp].FieldName := 'date'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
    orderDate :=1;
   for I := orderDate to endDate do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||人数';
    dbgrdhResult.Columns[3+temp].FieldName := 'Bdate'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
   //把选择日期以外不需要显示的隐藏
  if temp<=31 then
  begin
    for I := temp to 31 do
    begin
       dbgrdhResult.Columns[3+temp].Visible :=False;
       temp := temp+1;
    end;
  end;

 end;
end;

end.
