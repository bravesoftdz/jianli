unit UFrmExecutePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  NovaHComboBox,UFrmScheduledeparttime, Menus;

type
  TFrmExecutePrice = class(TSimpleCRUDForm)
    GroupBox3: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    Label1: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Chkisoriginator: TCheckBox;
    Chkislinework: TCheckBox;
    Chkissellreturnticket: TCheckBox;
    CobDISTRICTTYPE: TNovaComboBox;
    CobWORKWAYS: TNovaComboBox;
    NcbbScheduleType: TNovaComboBox;
    NHelpRoute: TNovaHelp;
    NEdtScheduleHelpCode: TNovaEdit;
    NCbbWorkType: TNovaComboBox;
    ChkISPROPRIETARY: TCheckBox;
    Label3: TLabel;
    DpDepartDate: TDateTimePicker;
    Label5: TLabel;
    jcdsResultroutename: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultdistance: TIntegerField;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultendtime: TWideStringField;
    jcdsResultfixedreserveseatnum: TIntegerField;
    jcdsResulthighdistance: TIntegerField;
    jcdsResultiscanmixcheck: TBooleanField;
    jcdsResultislinework: TBooleanField;
    jcdsResultisoriginator: TBooleanField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultisproprietary: TBooleanField;
    jcdsResultissaleafterreport: TBooleanField;
    jcdsResultissellable: TBooleanField;
    jcdsResultissellreturnticket: TBooleanField;
    jcdsResultorgid: TLargeintField;
    jcdsResultruntime: TFloatField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultscheduletype: TWideStringField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultspacinginterval: TIntegerField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultstarttime: TWideStringField;
    jcdsResultunautocancelreserveseatnum: TIntegerField;
    jcdsResultworktype: TWideStringField;
    jcdsResultworkways: TWideStringField;
    jcdsResultreachstation: TWideStringField;
    jcsdWorkType: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;
    jcdsResultbuspark: TWideStringField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultisbegincheck: TBooleanField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultisreported: TBooleanField;
    jcdsResultstatus: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultautocancelreserveseatnum: TIntegerField;
    jcdsResultdistricttypename: TWideStringField;
    jcdsResultworktypename: TWideStringField;
    jcdsResultworkwaysname: TWideStringField;
    jcdsResultscheduletypename: TWideStringField;
    Chbisbegincheck: TCheckBox;
    Chbisreported: TCheckBox;
    Chbisdeparted: TCheckBox;
    NovaCobbScheduleStatus: TNovaComboBox;
    jcdsQryTicketprice: TjsonClientDataSet;
    jcdsQryTicketpricedepartstation: TWideStringField;
    jcdsQryTicketpricereachstation: TWideStringField;
    jcdsQryTicketpricefullprice: TFloatField;
    jcdsQryTicketpricehalfprice: TFloatField;
    jcdsQryTicketpriceissellable: TBooleanField;
    jcdsQryTicketpriceresidueseatnum: TIntegerField;
    jcdsQryTicketpriceseatnum: TIntegerField;
    jcdsQryTicketpriceseattype: TWideStringField;
    jcdsQryTicketpricesoldeatnum: TIntegerField;
    jcdsQryTicketpricestudentprice: TFloatField;
    jcdsQryTicketpricetoplimitprice: TFloatField;
    jcdsQryTicketpricelowerlimitprice: TFloatField;
    jcdsQrySeatType: TjsonClientDataSet;
    dsTicketprice: TDataSource;
    jcdsQryTicketpriceseattypename: TWideStringField;
    jcdsQryTicketpriceruntime: TFloatField;
    jcdsQryTicketpriceid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultbrandname: TWideStringField;
    jcdsResultbrandmodelid: TLargeintField;
    jcdsResultdriver1: TWideStringField;
    jcdsResultdriver2: TWideStringField;
    jcdsResultdriver3: TWideStringField;
    jcdsResultsteward1: TWideStringField;
    jcdsResultvehicletypename: TWideStringField;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsResultschedulestatus: TWideStringField;
    jcdsResultdepartdate: TDateField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsQryTicketpriceunautocancelreserveseatnum: TIntegerField;
    jcdsQryTicketpricefixedreserveseatnum: TIntegerField;
    jcdsQryTicketpriceautocancelreserveseatnum: TIntegerField;
    jcdsQryTicketpricestationservicefee: TFloatField;
    jcdsQryTicketpricefueladditionfee: TFloatField;
    jcdsQryTicketpricedistance: TLargeintField;
    jcdsQryTicketpricebalancedistance: TLargeintField;
    Label24: TLabel;
    Label25: TLabel;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsQryTicketpricemoreprice: TFloatField;
    blnfldResultischoose: TBooleanField;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    lbl8: TLabel;
    nvhlpDeparts: TNovaHelp;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure NvDbgridEh1CellClick(Column: TColumnEh);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton52Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    genscheduleplanlog,scheduleid: String;
    procedure query(routename: String);
    procedure qryTicketprice(scheduleplanid: int64);
  public
    { Public declarations }
  end;

var
  FrmExecutePrice: TFrmExecutePrice;

implementation

uses UFrmGenExecutePrice, PubFn, UFrmExecutepriceItem, Services, UDMPublic,
  UFrmSchedulePlanSeatInfo, UFrmGenLog;
{$R *.dfm}

procedure TFrmExecutePrice.FormShow(Sender: TObject);
begin
  inherited;
  NHccbTicketEntrance.Active:=false;
  NHccbTicketEntrance.Active:=True;
  NHccbVehiclepark.Active:=false;
  NHccbVehiclepark.Active:=True;

  DpDepartDate.Date := now;
  with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    NovaHCbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;

  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;

  jcdstype.Active := false;
  jcdstype.Active := true;
  CobWORKWAYS.Active := false;
  CobWORKWAYS.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
  NcbbScheduleType.Active := false;
  NcbbScheduleType.Active := true;
  NCbbWorkType.Active := false;
  NCbbWorkType.Active := true;
  NovaCobbScheduleStatus.Active := false;
  NovaCobbScheduleStatus.Active := true;
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := true;

end;

procedure TFrmExecutePrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryTicketprice(jcdsResult.FieldByName('id').AsLargeInt);
end;

//全选
procedure TFrmExecutePrice.N1Click(Sender: TObject);
begin
  inherited;
    with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=true;
         next;
       end;
    end;
  end;
end;

//反选
procedure TFrmExecutePrice.N2Click(Sender: TObject);
begin
  inherited;
   with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=not fieldbyname('ischoose').AsBoolean;
         next;
       end;
    end;
  end;
end;

//取消
procedure TFrmExecutePrice.N3Click(Sender: TObject);
begin
  inherited;
    with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=false;
         next;
       end;
    end;
  end;
end;

procedure TFrmExecutePrice.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmExecutePrice.NvDbgridEh1CellClick(Column: TColumnEh);
var
  curticketype, curcaption: String;
  isPriceItem: boolean;
begin
  inherited;
  if not jcdsQryTicketprice.Active then
    exit;
  if jcdsQryTicketprice.RecordCount <= 0 then
    exit;
  isPriceItem := false;
  if (Column.FieldName = 'fullprice') then
  begin
    curticketype := 'Q';
    isPriceItem := true;
    curcaption := '全票票价组成项目明细';
  end;
{  else if (Column.FieldName = 'halfprice') then
  begin
    curticketype := 'B';
    isPriceItem := true;
    curcaption := '半票票价组成项目明细';
  end
  else if (Column.FieldName = 'studentprice') then
  begin
    curticketype := 'X';
    isPriceItem := true;
    curcaption := '学生票票价组成项目明细';
  end
  else if (Column.FieldName = 'toplimitprice') then
  begin
    curticketype := 'S';
    isPriceItem := true;
    curcaption := '上限票价组成项目明细';
  end; }
  if isPriceItem then
  begin
    FrmExecutepriceItem := TFrmExecutepriceItem.Create(self);
    with FrmExecutepriceItem do
    begin
      caption := curcaption;
      ticketpriceid := jcdsQryTicketprice.FieldByName('id').AsLargeInt;
      tickettype := curticketype;
      ShowModal;
    end;
  end;
end;

procedure TFrmExecutePrice.qryTicketprice(scheduleplanid: int64);
begin
  with jcdsQryTicketprice do
  begin
    Active := false;
    Params.ParamValues['scheduleplan.id'] := scheduleplanid;
    Active := true;
  end;
end;

procedure TFrmExecutePrice.query(routename: String);
var
  curid: int64;
begin
  inherited;
  jcdsResult.AfterScroll:=nil;
  curid := 0;
  if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_sp!orgid'] :=NovaHCbbOrg.HelpFieldValue['orgid'];
    //NovaCkbOrg.GetSelectID;
    if nvhlpDeparts.Id>0 then
      Params.ParamValues['filter_EQL_ss!departstationid'] :=nvhlpDeparts.Id
    else
      Params.ParamValues['filter_EQL_ss!departstationid'] :=null;


    Params.ParamValues['filter_LIKES_r!name'] := routename;
    Params.ParamValues['filter_LIKES_s!code'] := trim
      (NEdtScheduleHelpCode.Text);
    if CobWORKWAYS.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_sp!workways'] := inttostr
        (CobWORKWAYS.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_sp!workways'] := '';
    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_sp!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_sp!districttype'] := '';
    if NCbbWorkType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_sp!worktype'] := inttostr
        (NCbbWorkType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_sp!worktype'] := '';
    if NcbbScheduleType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_sp!scheduletype'] := inttostr
        (NcbbScheduleType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_sp!scheduletype'] := '';
    if Chkislinework.Checked then
      Params.ParamValues['filter_EQB_sp!islinework'] := true
    else
      Params.ParamValues['filter_EQB_sp!islinework'] := null;
    if Chkisoriginator.Checked then
      Params.ParamValues['filter_EQB_sp!isoriginator'] := true
    else
      Params.ParamValues['filter_EQB_sp!isoriginator'] := null;
    if Chkissellreturnticket.Checked then
      Params.ParamValues['filter_EQB_sp!issellreturnticket'] := true
    else
      Params.ParamValues['filter_EQB_sp!issellreturnticket'] := null;
    if ChkISPROPRIETARY.Checked then
      Params.ParamValues['filter_EQB_sp!isproprietary'] := true
    else
      Params.ParamValues['filter_EQB_sp!isproprietary'] := null;
    Params.ParamValues['filter_EQD_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', DpDepartDate.Date);
    if NovaCobbScheduleStatus.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_ss!status'] := inttostr
        (NovaCobbScheduleStatus.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_ss!status'] := '';
    if Chbisbegincheck.Checked then
      Params.ParamValues['filter_EQB_ss!isbegincheck'] := true
    else
      Params.ParamValues['filter_EQB_ss!isbegincheck'] := null;
    if Chbisdeparted.Checked then
      Params.ParamValues['filter_EQB_ss!isdeparted'] := true
    else
      Params.ParamValues['filter_EQB_ss!isdeparted'] := null;
    if Chbisreported.Checked then
      Params.ParamValues['filter_EQB_ss!isreported'] := true
    else
      Params.ParamValues['filter_EQB_ss!isreported'] := null;

    if NHccbTicketEntrance.ItemIndex>=0 then
      Params.ParamValues['filter_EQS_ss!ticketentrance'] := NHccbTicketEntrance.Text
    else
      Params.ParamValues['filter_EQS_ss!ticketentrance'] :=null;

     if NHccbVehiclepark.ItemIndex>=0 then
      Params.ParamValues['filter_EQS_ss!buspark'] := NHccbVehiclepark.Text
    else
      Params.ParamValues['filter_EQS_ss!buspark'] :=null;
    Active := true;
    if RecordCount <= 0 then
    begin
      jcdsQryTicketprice.Close;
      jcdsQryTicketprice.Close;
    end
    else
    begin
      if curid > 0 then
        jcdsResult.Locate('id', curid, []);
      qryTicketprice(jcdsResult.FieldByName('id').AsLargeInt);
    end;
  end;
  jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmExecutePrice.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  //NovaCkbOrg.CheckAll(true);
  NCbbWorkType.ItemIndex := -1;
  NHelpRoute.Clear;
  NEdtScheduleHelpCode.Clear;
  ChkISPROPRIETARY.Checked := false;
  Chkisoriginator.Checked := false;
  Chkissellreturnticket.Checked := false;
  Chkislinework.Checked := false;
  CobWORKWAYS.ItemIndex := -1;
  CobDISTRICTTYPE.ItemIndex := -1;
  NcbbScheduleType.ItemIndex := -1;
  CobWORKWAYS.ItemIndex := -1;
  DpDepartDate.Date := now;
  NovaCobbScheduleStatus.ItemIndex := -1;
  tbtnFilterClick(Sender);
end;

procedure TFrmExecutePrice.tbtnEditClick(Sender: TObject);
// var
// curid:Int64;
begin
  inherited;
  if (jcdsResult.Active = false) or (jcdsResult.RecordCount < 0) then
  begin
    exit;
  end;
  // curid:=self.jcdsResult.FieldByName('id').AsLargeInt;
  FrmSchedulePlanSeatInfo := TFrmSchedulePlanSeatInfo.Create(self);
  with FrmSchedulePlanSeatInfo do
  begin
    try
      caption := '班次营运计划座位信息';
      brandModelid := jcdsResult.FieldByName('brandmodelid').AsLargeInt;
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
      NovaEdtSchedule.Text := jcdsResult.FieldByName('code').asstring;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').asstring;
      NovaEdtPlanVehicle.Text := jcdsResult.FieldByName('vehicleno').asstring;
      NovaEdtBrand.Text := jcdsResult.FieldByName('brandname').asstring;
      // rationseatnum:=jcdsResult.FieldByName('rationseatnum').AsInteger;
      if SysMainForm.showFormModal(FrmSchedulePlanSeatInfo) = mrOk then
      begin
        // tbtnFilter.Click;
        // jcdsResult.Locate('id',curid,[]);
      end;
    finally
      // FreeAndNil(FrmSchedulePlanSeatInfo);
    end;
  end;
end;

procedure TFrmExecutePrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  query(trim(NHelpRoute.Text));
end;

procedure TFrmExecutePrice.tbtnInsertClick(Sender: TObject);
var
  scheduleplanid: int64;
begin
  inherited;
  scheduleplanid := 0;
  FrmGenExecutePrice := TFrmGenExecutePrice.Create(self);
  with FrmGenExecutePrice do
  begin
    caption := '制作营运计划';
    createby := SysInfo.LoginUserInfo.UserID;
    if NovaHCbbOrg.ItemIndex>=0 then
      orgid:=NovaHCbbOrg.HelpFieldValue['orgid']
    else
      orgid := Sysinfo.LoginUserInfo.orgid;
    if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
    begin
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').asstring;
      NovaHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('code').asstring;
      NovaHelpSchedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
      scheduleplanid := jcdsResult.FieldByName('id').AsInteger;
    end;
    DTPBuildStartDay.Mindate := Date;
    if DpDepartDate.Date>=Now then
    begin
      DTPBuildStartDay.Date := DpDepartDate.Date;
      DTPBuildEndDay.Date := DpDepartDate.Date;
    end
    else
    begin
      DTPBuildStartDay.Date := now;
      DTPBuildEndDay.Date := now;
    end;

    if SysMainForm.showFormModal(FrmGenExecutePrice,false) = mrOk then
    begin
      genscheduleplanlog := scheduleplanlog;
      query(NHelpRoute.Text);
//      if scheduleplanid > 0 then
//        qryTicketprice(scheduleplanid);
    end;
  end;

end;

procedure TFrmExecutePrice.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  FrmGenLog := TFrmGenLog.Create(self);
  with FrmGenLog do
  begin
    Memo1.Clear;
    Memo1.Text:=genscheduleplanlog;
    ShowModal;
  end;
end;

procedure TFrmExecutePrice.ToolButton52Click(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
   if not dsResult.DataSet.Active then
      Exit;
    if dsResult.DataSet.RecordCount < 1 then
      Exit;
    with jcdsResult do
    begin
      DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('ischoose').AsBoolean then
        begin
           scheduleid  := scheduleid+ FieldByName('scheduleid').AsString+',';
        end ;
        Next;
      end;
      EnableControls;
    end;
    if scheduleid='' then
    begin
      SysDialogs.ShowMessage('请选择班次');
      Exit;
    end ;
    scheduleid:=Copy(scheduleid,1,Length(scheduleid)-1);
     scheduleid  := '('+scheduleid+')';
   with frmScheduledeparttime do
  begin
    frmScheduledeparttime := TfrmScheduledeparttime.Create(Self);
    with jcdsResult do
    begin
      Active:=False;
      Params.ParamValues['filter_EQL_s!orgid']:= NovaHCbbOrg.HelpFieldValue['orgid'];
      Params.ParamValues['filter_INS_s!id']:=scheduleid;
      Params.ParamValues['filter_EQD_sts!departdate'] := formatdatetime('yyyy-mm-dd',DpDepartDate.Date);  //售票日期
      Active:=true;
    end ;
    ShowModal;
    scheduleid :='' ;
  end;

end;

end.
