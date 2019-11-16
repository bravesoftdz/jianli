unit UFrmScheduleRunSituation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmScheduleRunSituation  = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lblstation: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl6: TLabel;
    dtpstartdate: TDateTimePicker;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlpVehicle: TNovaHelp;
    nvhlpvehicletype: TNovaHelp;
    nvhlpunit: TNovaHelp;
    pnl2: TPanel;
    grp2: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    jcdsScheduleplan: TjsonClientDataSet;
    jcdsUpdateSale: TjsonClientDataSet;
    spl1: TSplitter;
    grp3: TGroupBox;
    dbgrdhSoldList: TDBGridEh;
    grp5: TGroupBox;
    dbgrdh5: TDBGridEh;
    pnl3: TPanel;
    grp4: TGroupBox;
    spl2: TSplitter;
    nvdbgrdh3: TNvDbgridEh;
    grp6: TGroupBox;
    dbgrdh1: TDBGridEh;
    grp7: TGroupBox;
    dbgrdh2: TDBGridEh;
    grp8: TGroupBox;
    dbgrdh3: TDBGridEh;
    dsSold: TDataSource;
    jcdsSoldResult: TjsonClientDataSet;
    chkIsnotovertime: TCheckBox;
    chkIsovertime: TCheckBox;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultschedulename: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultreportvehicleno: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    blnfldResultisovertime: TBooleanField;
    blnfldResultissaleafterreport: TBooleanField;
    blnfldResultisdeparted: TBooleanField;
    wdstrngfldResultbuspark: TWideStringField;
    wdstrngfldResultticketentrance: TWideStringField;
    jcdsScheduleStatus: TjsonClientDataSet;
    wdstrngfldResultstatus: TWideStringField;
    wdstrngfldResultvcstatus: TWideStringField;
    blnfldResultissellable: TBooleanField;
    blnfldResultbegincheck: TBooleanField;
    wdstrngfldResultvtname: TWideStringField;
    blnfldResultislinework: TBooleanField;
    wdstrngfldResultvehicleno: TWideStringField;
    wdstrngfldResultunitname: TWideStringField;
    wdstrngfldResultworkways: TWideStringField;
    wdstrngfldResultviastation: TWideStringField;
    wdstrngfldResultdriver1: TWideStringField;
    wdstrngfldResultdriver2: TWideStringField;
    wdstrngfldResultdriver3: TWideStringField;
    wdstrngfldResultbrandmodelname: TWideStringField;
    wdstrngfldResultendroutename: TWideStringField;
    intgrfldResultseatnum: TIntegerField;
    intgrfldResultsoldeatnum: TIntegerField;
    intgrfldResultreservenum: TIntegerField;
    intgrfldResultfixedreserveseatnum: TIntegerField;
    intgrfldResultautocancelreserveseatnum: TIntegerField;
    intgrfldResultunautocancelreserveseatnum: TIntegerField;
    lrgntfldResultscheduleplanid: TLargeintField;
    lrgntfldResultscheduleid: TLargeintField;
    nvhlplenvehicle: TNovaHelp;
    lbl1: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsResultlocalsell: TIntegerField;
    jcdsResultothersell: TIntegerField;
    Label9: TLabel;
    CobDISTRICTTYPE: TNovaComboBox;
    Label1: TLabel;
    nvhlpplanunit: TNovaHelp;
    Label3: TLabel;
    cbbSellOrgid: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure nvhlprouteIdChange(Sender: TObject);
  private
   procedure refreshSold;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmScheduleRunSituation: TfrmScheduleRunSituation;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmScheduleRunSituation.FormCreate(Sender: TObject);
begin
  inherited;
 with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    NovaHCbbOrg.SetItemIndexByField('id',SysInfo.LoginUserInfo.StationID);
  end;
end;

procedure TfrmScheduleRunSituation.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now();
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
  cbbSellOrgid.Active := True;
  cbbSellOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
  //dtpenddate.Date := Now();
//  with jcdsResult do
//  begin
//    Active:= false;
//    Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
//    Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
//    Active := True;
//  end;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmScheduleRunSituation.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if jcdsResult.FieldByName('status').AsString = '1' then // 报停
  begin
    tbtnSave.Caption := '恢复';
  end
  else
  begin
    tbtnSave.Caption := '停班';
  end;
  refreshSold;
end;

procedure TfrmScheduleRunSituation.nvhlprouteIdChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TfrmScheduleRunSituation.refreshSold;
begin
  with jcdsSoldResult do
  begin
    Active := False;
    Params.ParamValues['scheduleplanid'] :=
    jcdsResult.FieldByName('scheduleplanid').AsInteger;
    Params.ParamValues['scheduleid'] :=
    jcdsResult.FieldByName('scheduleid').AsInteger;
    Active := True;
  end;
end;

procedure TfrmScheduleRunSituation.tbtnFilterClick(Sender: TObject);
var log: string;
begin
  inherited;
  jcdsResult.AfterScroll := nil;
with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['curstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_EQD_sp!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    //Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    if trim(nvhlpschedule.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.Id;
    end;
    if trim(nvhlproute.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;

    Params.ParamValues['filter_EQS_vrr!vehicleno'] := nvhlpVehicle.Text;

        if trim(nvhlplenvehicle.Text)= '' then
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := nvhlplenvehicle.Id;
    end;


    if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //是否加班班次
      begin
        Params.ParamValues['filter_EQB_sp!isovertime']:='true';
      end
    else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
      begin
        Params.ParamValues['filter_EQB_sp!isovertime']:='false';
      end
    else
      begin
        Params.ParamValues['filter_EQB_sp!isovertime']:='';
      end;

    if Trim(nvhlpvehicletype.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_vt!id'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_vt!id'] := nvhlpvehicletype.Id;
    end;

    if (Trim(nvhlpunit.Text) = '') or (nvhlpunit.Id=0) then
    begin
      Params.ParamValues['filter_EQL_vrr!unitid'] := null;
    end else
    begin
      Params.ParamValues['filter_EQL_vrr!unitid'] := nvhlpunit.Id;
    end;

    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_sp!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_sp!districttype'] := '';

    if (Trim(nvhlpplanunit.Text) = '') or (nvhlpplanunit.Id=0) then
    begin
      Params.ParamValues['filter_EQL_sv!planunitid'] := null;
    end else
    begin
      Params.ParamValues['filter_EQL_sv!planunitid'] := nvhlpplanunit.Id;
    end;

    Params.ParamValues['sellorgid'] := cbbSellOrgid.GetSelectID;

    Active:= true;

    log := '[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date) ;
    if Trim(NovaHCbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[当前调度站]：'+NovaHCbbOrg.Text;
    if nvhlpunit.Id <> 0 then
      log := log +',[班次状态]:'+nvhlpunit.Text;
    if nvhlproute.Id <>0 then
      log := log +',[线路]:'+nvhlproute.Text;
    if nvhlpschedule.Id<>0 then
      log  := log +',[班次]:'+nvhlpschedule.Text;
    if nvhlpvehicletype.Id <>0 then
      log := log +',[计划车型]:'+nvhlpvehicletype.Text;
    if nvhlplenvehicle.Id <> 0 then
      log := log +',[计划车辆]:'+nvhlplenvehicle.Text;
    if nvhlpVehicle.Id <>0 then
      log := log +',[报到车辆]:'+nvhlpVehicle.Text;
    if chkIsnotovertime.Checked then
      log := log +',[正班]';
    if chkIsovertime.Checked then
      log := log +',[加班]';


    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->客运站班次运营情况','查询',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
  end;
  refreshSold;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

end.


