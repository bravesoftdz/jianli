unit UFrmQuerySchedulemerge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQuerySchedulemerge  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl7: TLabel;
    nvhelpUserinfoid: TNovaHelp;
    lbl2: TLabel;
    wdstrngfldResultoldschedulecode: TWideStringField;
    wdstrngfldResultnewschedulecode: TWideStringField;
    dtfldResultolddepartdate: TDateField;
    dtfldResultnewdepartdate: TDateField;
    intgrfldResultoldseatnum: TIntegerField;
    intgrfldResultnewseatnum: TIntegerField;
    wdstrngfldResultoldroutename: TWideStringField;
    wdstrngfldResultnewroutename: TWideStringField;
    wdstrngfldResultreason: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    blnfldResultiscancel: TBooleanField;
    wdstrngfldResultorgname: TWideStringField;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhDetail: TNvDbgridEh;
    grp2: TGroupBox;
    grp4: TGroupBox;
    tlb1: TToolBar;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    NvDbgridEh1: TNvDbgridEh;
    jcdsDetail: TjsonClientDataSet;
    dsDetailResult: TDataSource;
    wdstrngfldDetailoldseatno: TWideStringField;
    wdstrngfldDetailnewseatno: TWideStringField;
    wdstrngfldDetailticketno: TWideStringField;
    wdstrngfldDetailorgname: TWideStringField;
    wdstrngfldDetaildepartstaioname: TWideStringField;
    wdstrngfldDetailreachestationname: TWideStringField;
    wdstrngfldDetailticketype: TWideStringField;
    jcdsDetailprice: TFloatField;
    wdstrngfldDetailticketentrance: TWideStringField;
    wdstrngfldDetailbuspark: TWideStringField;
    wdstrngfldDetailticketoutletsname: TWideStringField;
    jcdsDetailselltime: TDateTimeField;
    wdstrngfldDetailcustomername: TWideStringField;
    wdstrngfldDetailcheckbyname: TWideStringField;
    wdstrngfldDetailticketstatus: TWideStringField;
    jcdsResultid: TIntegerField;
    jcdsDetailcarrychildnum: TIntegerField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldDetailstatusname: TWideStringField;
    nvhlproute: TNovaHelp;
    nvhlpScheduleold: TNovaHelp;
    nvhlpSchedulenew: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure refreshDetail;
  end;

var
  frmQuerySchedulemerge: TfrmQuerySchedulemerge;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQuerySchedulemerge.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  dtpEdepartdate.Checked := False;
end;

procedure TfrmQuerySchedulemerge.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
 if dsResult.DataSet.RecordCount<1 then
  begin
    jcdsDetail.Close;
  end;
end;

procedure TfrmQuerySchedulemerge.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  refreshDetail;
end;
procedure TfrmQuerySchedulemerge.refreshDetail;
begin
 if jcdsResult.RecordCount <= 0 then
 begin
    jcdsDetail.Close;
    exit;
 end;
    with jcdsDetail do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_smd!schedulemergeid'] :=
        jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;


end;


procedure TfrmQuerySchedulemerge.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
   if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  jcdsResult.AfterScroll := nil;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_sm!orgid']:= nvckbOrgid.GetSelectID;

//    if dtpBdepartdate.Checked then
//    begin                                                                     //发车日期
    Params.ParamValues['filter_GED_osp!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
//    end
//    else
//    begin
//       Params.ParamValues['filter_GED_osp!departdate'] :='';
//    end;
//    if dtpEdepartdate.Checked then
//    begin
    Params.ParamValues['filter_LED_osp!departdate'] :=  formatdatetime('c',dtpEdepartdate.Date);
//    end
//    else
//    begin
//      Params.ParamValues['filter_LED_osp!departdate'] :='';
//    end;

    if  (not (Trim(nvhlpSchedulenew.Text) = '')) and  (nvhlpSchedulenew.Id>0) then         //新班次号
      begin
        Params.ParamValues['filter_EQL_ns!id']:= nvhlpSchedulenew.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_ns!id']:= '';
      end;

    if  (not (Trim(nvhlpScheduleold.Text) = '')) and  (nvhlpScheduleold.Id>0) then      //原班次号
      begin
        Params.ParamValues['filter_EQL_os!id']:= nvhlpScheduleold.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_os!id']:= '';
      end;

    if  (not (Trim(nvhlpRoute.Text) = '')) and  (nvhlpRoute.Id>0) then      //原班次号
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

    if  (not (Trim(nvhelpUserinfoid.Text) = '')) and  (nvhelpUserinfoid.Id>0) then      //原班次号
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhelpUserinfoid.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;
    Active:=true;

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+nvckbOrgid.Text;
    if nvhlproute.Id <> 0 then
      log := log +',[营运线路]:'+nvhlproute.Text;
    if nvhlpScheduleold.Id <> 0 then
      log := log +',[原班次号]：'+nvhlpScheduleold.Text;
    if nvhlpSchedulenew.Id <> 0 then
      log  := log +',[新班次号]:'+nvhlpSchedulenew.Text;
    if nvhelpUserinfoid.Id <> 0 then
      log  := log +',[并班人]：'+nvhelpUserinfoid.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->并班情况查询','查询',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
  end;
  refreshDetail;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

end.

