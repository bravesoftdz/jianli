unit UPlusSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaComboBox, NovaEdit, NovaHelp, Buttons,
  NovaCheckedComboBox;

type
  TFrmPlusSchedule = class(TSimpleCRUDForm)
    lbl1: TLabel;
    Label2: TLabel;
    DpStartdate: TDateTimePicker;
    Label1: TLabel;
    DpEnddate: TDateTimePicker;
    Label3: TLabel;
    NovaHelpSchedule: TNovaHelp;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    Label9: TLabel;
    CobDISTRICTTYPE: TNovaComboBox;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    ImageList1: TImageList;
    Splitter1: TSplitter;
    NovaCkbOrg: TNovaCheckedComboBox;
    jcdsResultid: TLargeintField;
    jcdsResultorgname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultusername: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultvehcilepark: TWideStringField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultentranceid: TLargeintField;
    jcdsResultparkid: TLargeintField;
    jcdsResultcode: TWideStringField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultiscanmixcheck: TBooleanField;
    jcdsResultisoriginator: TBooleanField;
    jcdsResultisproprietary: TBooleanField;
    jcdsResultissaleafterreport: TBooleanField;
    jcdsResultissellreturnticket: TBooleanField;
    jcdsResultplanseatnum: TIntegerField;
    jcdsResultprintinfo: TWideStringField;
    jcdsResultremarks: TWideStringField;
    jcdsResultruntime: TFloatField;
    jcdsResulttype: TWideStringField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultviastation: TWideStringField;
    jcdsResultworktype: TWideStringField;
    jcdsResultworkways: TWideStringField;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcsdWorkType: TjsonClientDataSet;
    jcdsResultWORKTYPENAME: TWideStringField;
    jcdsResultWORKWAYSNAME: TWideStringField;
    jcdsResultDISTRICTTYPENAME: TWideStringField;
    jcdsResultTYPENAME: TWideStringField;
    jcdsResultISLINEWORK: TBooleanField;
    jcsdQryHandPrice: TjsonClientDataSet;
    jcsdQryHandPricescheduleid: TLargeintField;
    jcsdQryHandPricedepartstation: TWideStringField;
    jcsdQryHandPricereachstation: TWideStringField;
    jcsdQryHandPricevehicletype: TWideStringField;
    jcsdQryHandPriceseattype: TWideStringField;
    jcsdQryHandPricefullprice: TFloatField;
    jcsdQryHandPricehalfprice: TFloatField;
    jcsdQryHandPricestudentprice: TFloatField;
    jcsdQryHandPricetoplimitprice: TFloatField;
    jcsdQryHandPricelowerlimitprice: TFloatField;
    jcsdQryHandPriceseattypename: TWideStringField;
    jcsdQryHandPricevehicletypeid: TLargeintField;
    DsHandPrice: TDataSource;
    jcdsQrySeatType: TjsonClientDataSet;
    jcdsGenScheduleplan: TjsonClientDataSet;
    jcdsResultstarttime: TWideStringField;
    chkPlusSchedule: TCheckBox;
    chkSchedule: TCheckBox;
    jcdsResultisovertime: TBooleanField;
    jcdsResultorgid: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure qryHandprice(scheduleid: integer);
  public
    depstartdate,dependdate:TDateTime;
    { Public declarations }
  end;

var
  FrmPlusSchedule: TFrmPlusSchedule;

implementation

uses PubFn, Services, UPlusScheduleEdt, UDMPublic,
  UFrmOvertimeLog, UFrmOvertimePlaninfo,UFrmHandPriceEdt,
  UFrmPlusScheduleStation;
{$R *.dfm}

procedure TFrmPlusSchedule.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
  DpStartdate.Date := now - 10;
  DpEnddate.Date := now;
  DpStartdate.Checked:=False;
  DpEnddate.Checked:=False;  
  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;

  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;
  jcdstype.Active := false;
  jcdstype.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;

  jcdsQrySeatType.Active := false;
  jcdsQrySeatType.Active := true;
end;

procedure TFrmPlusSchedule.FormShow(Sender: TObject);
begin
  inherited;
  DpStartdate.Date:=now-30;
  DpEnddate.Date:=now;
end;

procedure TFrmPlusSchedule.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryHandprice(jcdsResult.FieldByName('id').AsInteger);
end;

procedure TFrmPlusSchedule.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmPlusSchedule.qryHandprice(scheduleid: integer);
begin
  with jcsdQryHandPrice do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleid;
    Active := true;
  end;
end;

procedure TFrmPlusSchedule.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  FrmOvertimePlaninfo := TFrmOvertimePlaninfo.Create(self);
  try
    with FrmOvertimePlaninfo do
    begin
      scheduleid := jcdsResult.FieldByName('id').AsInteger;
      showModal;
    end;
  finally
    FreeAndNil(FrmOvertimePlaninfo);
  end;
end;

procedure TFrmPlusSchedule.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  FrmPlusScheduleStaion := TFrmPlusScheduleStaion.Create(self);
  try
    with FrmPlusScheduleStaion do
    begin
      Caption := '修改停靠站点';
      scheduleid:=jcdsResult.FieldByName('id').AsLargeInt;
      endstationid:=jcdsResult.FieldByName('endstationid').AsLargeInt;
      if SysMainForm.showFormModal(FrmPlusScheduleStaion, false) = mrok then
      begin
        //qryHandprice(jcdsResult.FieldByName('id').AsInteger);
      end;
    end;
  finally
    FreeAndNil(FrmPlusScheduleStaion);
  end;
end;

procedure TFrmPlusSchedule.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcsdQryHandPrice.Active then
    exit;

  if jcsdQryHandPrice.RecordCount = 0 then
  begin
    SysDialogs.ShowMessage('请先设置票价！');
    exit;
  end;
  FrmHandPriceEdt := TFrmHandPriceEdt.Create(self);
  try
    with FrmHandPriceEdt do
    begin
      Caption := '修改票价';
      createby := SysInfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaEditSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id := jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmHandPriceEdt, false) = mrok then
      begin
        qryHandprice(jcdsResult.FieldByName('id').AsInteger);
      end;
    end;
  finally
    FreeAndNil(FrmHandPriceEdt);
  end;
end;

procedure TFrmPlusSchedule.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (FormatDateTime('yyyymmdd', DpStartdate.Date) > FormatDateTime('yyyymmdd',
    DpEnddate.Date) )then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    AfterScroll := nil;
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_r!name'] := trim(NHelpRoute.Text);
    Params.ParamValues['filter_LIKES_s!code'] := trim(NovaHelpSchedule.Text);
    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!districttype'] := null;
   if DpStartdate.Checked then
   begin
    Params.ParamValues['filter_GED_s!createtime'] := formatdatetime
      ('yyyy-mm-dd', DpStartdate.Date) + ' 00:01:00';
    Params.ParamValues['filter_LED_s!createtime'] := formatdatetime
      ('yyyy-mm-dd', DpEnddate.Date) + ' 23:59:00';
    end
    else
    begin
      Params.ParamValues['filter_GED_s!createtime'] := null;
      Params.ParamValues['filter_LED_s!createtime'] := null;
    end;
      
    if (chkPlusSchedule.Checked)
      and (not chkSchedule.Checked) then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := true;
    end
    else if (not chkPlusSchedule.Checked)
      and (chkSchedule.Checked)  then
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := false;         
    end
    else
    begin
      Params.ParamValues['filter_EQB_s!isovertime'] := null;          
    end;
    Active := true;
    if RecordCount <= 0 then
    begin
      jcsdQryHandPrice.Close;
    end
    else
    begin
      qryHandprice(jcdsResult.FieldByName('id').AsInteger);
    end;
    AfterScroll := jcdsResultAfterScroll;
  end;
end;

procedure TFrmPlusSchedule.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount=0) then
  begin
     SysDialogs.ShowInfo('请选择加班的模版！');
     Exit;
  end;
  FrmPlusScheduleEdt := TFrmPlusScheduleEdt.Create(self);
  try
    with FrmPlusScheduleEdt do
    begin
      Caption := '班次加班操作';
      createby := SysInfo.LoginUserInfo.UserID;
         scheduleid:=jcdsResult.FieldByName('id').AsLargeInt;
         curorgid:=jcdsResult.FieldByName('orgid').AsLargeInt;
         NHelpRoute.Text:=jcdsResult.FieldByName('routename').AsString;
         NHelpRoute.Id:=jcdsResult.FieldByName('routeid').AsLargeInt;
         //NEdtPLANSEATNUM.Text:=jcdsResult.FieldByName('planseatnum').AsString;
         NHccbTicketEntrance.SetItemIndexByField('id',jcdsResult.FieldByName('entranceid').AsLargeInt); 
         NHccbVehiclepark.SetItemIndexByField('id',jcdsResult.FieldByName('parkid').AsLargeInt);
         NEdtRuntime.Text:=jcdsResult.FieldByName('runtime').AsString;           
         CobWORKTYPE.SetItemIndexByCode(jcdsResult.FieldByName('worktype').AsString) ;
         CobWORKWAYS.SetItemIndexByCode(jcdsResult.FieldByName('workways').AsString) ;
         CobDISTRICTTYPE.SetItemIndexByCode(jcdsResult.FieldByName('districttype').AsString) ; 
         CobTYPE.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString) ; 
         ChkISORIGINATOR.Checked:=jcdsResult.FieldByName('isoriginator').AsBoolean;
         ChkISSALEAFTERREPORT.Checked:=jcdsResult.FieldByName('issaleafterreport').AsBoolean;  
         ChkISSELLRETURNTICKET.Checked:=jcdsResult.FieldByName('issellreturnticket').AsBoolean;  
         ChkISCANMIXCHECK.Checked:=jcdsResult.FieldByName('iscanmixcheck').AsBoolean;  
         ChkISPROPRIETARY.Checked:=jcdsResult.FieldByName('isproprietary').AsBoolean;  
         NEdtPRINTINFO.Text:=jcdsResult.FieldByName('printinfo').AsString;                                                     
      if SysMainForm.showFormModal(FrmPlusScheduleEdt, false) = mrok then
      begin
        curid := Id;
        depstartdate := editstartdate;
        dependdate:= editenddate;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
        if getParametervalue('2015',SysInfo.LoginUserInfo.OrgID)='1' then
          tbtnSaveClick(sender);
      end;
    end;
  finally
    FreeAndNil(FrmPlusScheduleEdt);
  end;

end;

procedure TFrmPlusSchedule.tbtnSaveClick(Sender: TObject);
var
  scheduleid, createby: int64;
  nResult: integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要生成班次'+jcdsResult.FieldByName('code').AsString+'的运营计划吗？') then
    exit;
  scheduleid := jcdsResult.FieldByName('id').AsLargeInt;
  createby := SysInfo.LoginUserInfo.UserID;
  screen.Cursor := crHourGlass;
//  self.Enabled := false;

  with jcdsGenScheduleplan do
  begin
    try
      Active := false;
      Params.ParamByName('scheduleplanlog.typeid').Value := scheduleid;
      Params.ParamByName('scheduleplanlog.type').Value := '2';
      Params.ParamByName('scheduleplanlog.operationtype').Value := 'C';
      Params.ParamByName('scheduleplanlog.createby').Value := createby;
      Params.ParamByName('scheduleplanlog.ip').Value :=
        SysInfo.LocalHostAddress;
      Params.ParamByName('scheduleplanlog.orgid')
        .Value := SysInfo.LoginUserInfo.OrgID;
      Params.ParamByName('scheduleplanlog.startdate').Value :=  formatdatetime('yyyy-mm-dd',depstartdate);
      Params.ParamByName('scheduleplanlog.enddate').Value :=  formatdatetime('yyyy-mm-dd',dependdate);
      Active := true;
      nResult := Params.ParamByName('flag').Value;
      if nResult = 1 then
      begin
        jcdsGenScheduleplan.first;
        FrmOvertimeLog := TFrmOvertimeLog.Create(self);
        with FrmOvertimeLog do
        begin
          Memo1.Clear;
          begin
            while not jcdsGenScheduleplan.Eof do
            begin
              Memo1.lines.Add(trim(FieldByName('result').AsString) + #13);
              jcdsGenScheduleplan.next;
            end;
          end;
          showModal;
        end;
      end;
      Close;
      //self.Enabled := true;
      screen.Cursor := crDefault;
    except
      on E: Exception do
      begin
       // self.Enabled := true;
        screen.Cursor := crDefault;
        SysLog.WriteErr('加班营运计划生成失败：' + E.Message);
      end;
    end;
  end;
end;

end.
