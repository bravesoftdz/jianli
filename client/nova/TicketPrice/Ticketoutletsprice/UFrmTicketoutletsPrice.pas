unit UFrmTicketoutletsPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmTicketoutletsPrice = class(TSimpleCRUDForm)
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
    NovaCkbOrg: TNovaCheckedComboBox;
    NEdtScheduleHelpCode: TNovaEdit;
    NCbbWorkType: TNovaComboBox;
    ChkISPROPRIETARY: TCheckBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    jcsdWorkType: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;

    jcdsResultroutename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultWORKTYPE: TWideStringField;
    jcdsResultWORKWAYS: TWideStringField;
    jcdsResultDISTRICTTYPE: TWideStringField;
    jcdsResultTYPE: TWideStringField;
    jcdsResultSTARTTIME: TWideStringField;
    jcdsResultRUNTIME: TFloatField;
    jcdsResultISPROPRIETARY: TBooleanField;
    jcdsResultISOVERTIME: TBooleanField;
    jcdsResultISSELLRETURNTICKET: TBooleanField;
    jcdsResultISLINEWORK: TBooleanField;
    jcdsResultISORIGINATOR: TBooleanField;
    jcdsResultISSALEAFTERREPORT: TBooleanField;
    jcdsResultISCANMIXCHECK: TBooleanField;
    jcdsResultPLANSEATNUM: TIntegerField;
    jcdsResultVIASTATION: TWideStringField;
    jcdsResultPRINTINFO: TWideStringField;
    jcdsResultREMARKS: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultusername: TWideStringField;
    jcdsResultWORKTYPENAME: TWideStringField;
    jcdsResultWORKWAYSNAME: TWideStringField;
    jcdsResultDISTRICTTYPENAME: TWideStringField;
    jcdsResultTYPENAME: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultvehcilepark: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultORGID: TLargeintField;
    jcdsResultROUTEID: TLargeintField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultCREATEBY: TLargeintField;
    jcdsResultUPDATEBY: TLargeintField;
    jcsdQryHandPrice: TjsonClientDataSet;
    DsHandPrice: TDataSource;
    jcsdQryHandPricescheduleid: TLargeintField;
    jcsdQryHandPricedepartstation: TWideStringField;
    jcsdQryHandPricereachstation: TWideStringField;
    jcsdQryHandPricevehicletype: TWideStringField;
    jcsdQryHandPriceseattype: TWideStringField;
    jcsdQryHandPricefullprice: TFloatField;
    jcsdQryHandPricehalfprice: TFloatField;
    jcsdQryHandPricestudentprice: TFloatField;
    jcdsQrySeatType: TjsonClientDataSet;
    jcsdQryHandPriceseattypename: TWideStringField;
    jcdsDelhandprice: TjsonClientDataSet;
    jcsdQryHandPricevehicletypeid: TLargeintField;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    wdstrngfldQryHandPriceseats: TWideStringField;
    jcsdQryCheckSchedule: TjsonClientDataSet;
    wdstrngfldQryHandPricebrandname: TWideStringField;
    wdstrngfldQryHandPricemodelcode: TWideStringField;
    jcsdQryHandPricerationseatnum: TIntegerField;
    jcsdQryHandPriceid: TLargeintField;
    jscdCopyStartprice: TjsonClientDataSet;
    jcsdQryHandPricedepartstationid: TLargeintField;
    jcsdQryHandPricereachstationid: TLargeintField;
    nvhelpTicketoutlets: TNovaHelp;
    lbl3: TLabel;
    jcdsResultoutletsname: TWideStringField;
    jcdsResultticketoutletsid: TLargeintField;
    jcsdQryHandPricedifprice: TFloatField;
    jcsdQryHandPriceticketoutletspriceid: TLargeintField;
    jcsdQryHandPriceendtime: TDateField;
    jcsdQryHandPricestarttime: TDateField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
    // log : String;
    procedure qryTicketoutletsprice(scheduleid, ticketoutletsid: integer);
  public
    { Public declarations }
    isusemoreprice: boolean;
  end;

var
  FrmTicketoutletsPrice: TFrmTicketoutletsPrice;

implementation

uses UFrmTicketoutletsPriceEdt, PubFn, UFrmDelTicketoutletsPrice,
  Services, UDMPublic;
{$R *.dfm}

procedure TFrmTicketoutletsPrice.FormShow(Sender: TObject);
var
  moreprice: string;
begin
  inherited;
  // moreprice:=  getParametervalue('5001', Sysinfo.LoginUserInfo.OrgID);
  // if moreprice='1' then
  // isusemoreprice:=true;
  // if isusemoreprice then
  // NvDbgridEh1.Columns[9].Visible:=true
  // else
  // NvDbgridEh1.Columns[9].Visible:=false;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true, sysinfo.LoginUserInfo.OrgID);
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

end;

procedure TFrmTicketoutletsPrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryTicketoutletsprice(jcdsResult.FieldByName('id').AsInteger,
    jcdsResult.FieldByName('ticketoutletsid').AsInteger);
end;

procedure TFrmTicketoutletsPrice.NHelpRouteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmTicketoutletsPrice.qryTicketoutletsprice(scheduleid,
  ticketoutletsid: integer);
begin
  with jcsdQryHandPrice do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleid;
    Params.ParamValues['ticketoutletsid'] := ticketoutletsid;
    Active := true;
  end;
end;

procedure TFrmTicketoutletsPrice.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult: integer;
begin
  if not jcdsResult.Active then
    exit;
  if not jcsdQryHandPrice.Active then
    exit;
  FrmDelTicketoutletsPrice := TFrmDelTicketoutletsPrice.Create(Self);
  with FrmDelTicketoutletsPrice do
  begin
    Caption := '删除票价差额信息';
    scheduleid := jcsdQryHandPrice.FieldByName('scheduleid').AsInteger;
    NovaHelpSchedule.Id := scheduleid;
    vehicletypeid := jcsdQryHandPrice.FieldByName('vehicletypeid').AsInteger;
    NovaHelpSchedule.Text := jcdsResult.FieldByName('code').AsString;
    NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    routeid := jcdsResult.FieldByName('routeid').AsInteger;
    NovaHelpRoute.Id := routeid;
    OrgID := jcdsResult.FieldByName('orgid').AsInteger;
    NvHelpTickeoutlets.Text := jcdsResult.FieldByName('outletsname').AsString;

    ticketoutletsid := jcdsResult.FieldByName('ticketoutletsid').AsLargeInt;
    if SysMainForm.showFormModal(FrmDelTicketoutletsPrice) = mrok then
    begin
      // tbtnFilterClick(Sender);
      qryTicketoutletsprice(jcdsResult.FieldByName('id').AsInteger,
        jcdsResult.FieldByName('ticketoutletsid').AsInteger)
    end;
  end;

end;

procedure TFrmTicketoutletsPrice.tbtnEditClick(Sender: TObject);
var
  curscheduleid, ticketoutletsid: integer;
begin
  inherited;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  with jcsdQryCheckSchedule do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id').AsInteger;
    Active := true;
//    if RecordCount = 0 then
//    begin
//      SysDialogs.Warning('该班次还没有排班信息！');
//      exit;
//    end;
  end;
  FrmTicketoutletsPriceEdt := TFrmTicketoutletsPriceEdt.Create(Self);
  try
    with FrmTicketoutletsPriceEdt do
    begin
      Caption := '售票点票价差额设置';
      createby := sysinfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaEditSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id := jcdsResult.FieldByName('id').AsInteger;
      curscheduleid := jcdsResult.FieldByName('id').AsInteger;
      saveorupdateflag:=2;
      //修改时隐藏，只修改票价差
      dtpFromDate.Visible:=False;
      EndDate.Visible:=False;
      chkdate.Visible:=False;
      chkiscopyvehicletype.Visible:=False;
      lbl2.Visible:=False;
      lbl4.Visible:=False;
      if ((jcsdQryHandPrice.Active) and (jcsdQryHandPrice.RecordCount > 0)) then
      begin
        vehicletypeid := jcsdQryHandPrice.FieldByName('vehicletypeid')
          .AsLargeInt;
        ticketoutletsid := jcdsResult.FieldByName('ticketoutletsid').AsLargeInt;
        nvhelpTicketoutlets.Text := jcdsResult.FieldByName('outletsname')
          .AsString;
        ticketoutletspriceid := jcsdQryHandPrice.FieldByName
          ('ticketoutletspriceid').AsInteger;
        // 时间
//        if jcsdQryHandPrice.FieldByName('starttime').AsString <> '' then
//        begin

          dtpFromDate.DateTime := jcsdQryHandPrice.FieldByName('starttime')
            .AsDateTime;
          EndDate.DateTime := jcsdQryHandPrice.FieldByName('endtime')
            .AsDateTime;
//        end
//        else
//        begin
//          chkdate.Checked := false;
//        end;
      end;
      if SysMainForm.showFormModal(FrmTicketoutletsPriceEdt, false) = mrok then
      begin
        qryTicketoutletsprice(curscheduleid, ticketoutletsid);
      end;

    end;
  finally
    FreeAndNil(FrmTicketoutletsPriceEdt);
  end;
end;

procedure TFrmTicketoutletsPrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    if NHelpRoute.Id > 0 then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;
    Params.ParamValues['filter_LIKES_s!code'] := trim
      (NEdtScheduleHelpCode.Text);
    if CobWORKWAYS.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!workways'] := inttostr
        (CobWORKWAYS.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!workways'] := '';
    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!districttype'] := '';
    if NCbbWorkType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!worktype'] := inttostr
        (NCbbWorkType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!worktype'] := '';
    if NcbbScheduleType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!type'] := inttostr
        (NcbbScheduleType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!type'] := '';
    if Chkislinework.Checked then
      Params.ParamValues['filter_EQB_s!islinework'] := true
    else
      Params.ParamValues['filter_EQB_s!islinework'] := null;
    if Chkisoriginator.Checked then
      Params.ParamValues['filter_EQB_s!isoriginator'] := true
    else
      Params.ParamValues['filter_EQB_s!isoriginator'] := null;
    if Chkissellreturnticket.Checked then
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := true
    else
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := null;
    if ChkISPROPRIETARY.Checked then
      Params.ParamValues['filter_EQB_s!isproprietary'] := true
    else
      Params.ParamValues['filter_EQB_s!isproprietary'] := null;

    if nvhelpTicketoutlets.Id > 0 then // 售票点
    begin
      Params.ParamValues['filter_EQL_tp!id'] := nvhelpTicketoutlets.Id;
      // log := log+ '[售票点]:'+nvhelpTicketoutlets.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQL_tp!id'] := null;
    end;

    Active := true;
    if RecordCount <= 0 then
    begin
      // jcdsScheduleStop.Close;
      // jcdsScheduleLong.Close;
    end
    else
    begin
      qryTicketoutletsprice(jcdsResult.FieldByName('id').AsInteger,
        jcdsResult.FieldByName('ticketoutletsid').AsInteger);
    end;
  end;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmTicketoutletsPrice.tbtnInsertClick(Sender: TObject);
var
  curscheduleid, ticketoutletsid: integer;
begin
  inherited;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  with jcsdQryCheckSchedule do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id').AsInteger;
    Active := true;
//    if RecordCount = 0 then
//    begin
//      SysDialogs.Warning('该班次还没有排班信息！');
//      exit;
//    end;
  end;
  FrmTicketoutletsPriceEdt := TFrmTicketoutletsPriceEdt.Create(Self);
  try
    with FrmTicketoutletsPriceEdt do
    begin
      Caption := '售票点票价差额设置';
      createby := sysinfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaEditSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id := jcdsResult.FieldByName('id').AsInteger;
      curscheduleid := jcdsResult.FieldByName('id').AsInteger;
      saveorupdateflag:=1;
      if ((jcsdQryHandPrice.Active) and (jcsdQryHandPrice.RecordCount > 0)) then
      begin
        vehicletypeid := jcsdQryHandPrice.FieldByName('vehicletypeid')
          .AsLargeInt;
        ticketoutletsid := jcdsResult.FieldByName('ticketoutletsid').AsLargeInt;
        nvhelpTicketoutlets.Text := jcdsResult.FieldByName('outletsname')
          .AsString;
        ticketoutletspriceid := jcsdQryHandPrice.FieldByName
          ('ticketoutletspriceid').AsInteger;
        // 时间
//        if jcsdQryHandPrice.FieldByName('starttime').AsString <> '' then
//        begin

          dtpFromDate.DateTime := jcsdQryHandPrice.FieldByName('starttime')
            .AsDateTime;
          EndDate.DateTime := jcsdQryHandPrice.FieldByName('endtime')
            .AsDateTime;
//        end
//        else
//        begin
//          chkdate.Checked := false;
//        end;
      end;
      if SysMainForm.showFormModal(FrmTicketoutletsPriceEdt, false) = mrok then
      begin
        qryTicketoutletsprice(curscheduleid, ticketoutletsid);
      end;

    end;
  finally
    FreeAndNil(FrmTicketoutletsPriceEdt);
  end;
end;

end.
