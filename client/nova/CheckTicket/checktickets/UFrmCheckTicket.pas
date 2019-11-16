unit UFrmCheckTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHComboBox, NovaHelp, SeatPlan, UICcardRW,
  Generics.Collections, FunctionItemIntf, NovaPrint, UFrmDepartManagerEdit,
  NovaCheckedComboBox, Menus, MMSystem, UIDCardReader,IniFiles;

type
  TFrmCheckTicket = class(TSimpleCRUDForm, IBaseCardfound, IIDCardfound)
    Splitter1: TSplitter;
    GroupBox6: TGroupBox;
    Label2: TLabel;
    ChkAddCheck: TCheckBox;
    DpDepartDate: TDateTimePicker;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    NovaEdtTicketNo: TNovaEdit;
    ChkIsReproted: TCheckBox;
    NovaHelpEndStation: TNovaHelp;
    jcdsResultid: TLargeintField;
    jcdsResultdepartstation: TWideStringField;
    jcdsResultendstation: TWideStringField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultdepartdate: TDateField;
    jcdsResultcode: TWideStringField;
    jcdsResultvehicletypename: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultbuspark: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsResultschedulestatus: TWideStringField;
    jcdsResultplanvehiclebrandmodelid: TLargeintField;
    jcdsResultbrandname: TWideStringField;
    jcdsResultmodelcode: TWideStringField;
    jcdsResultislinework: TBooleanField;
    Panel2: TPanel;
    PcScheduleInfo: TPageControl;
    TabSheet1: TTabSheet;
    PaneNotOnline: TPanel;
    pnlseatplan: TPanel;
    TabSheet2: TTabSheet;
    GroupBox3: TGroupBox;
    Label6: TLabel;
    LabCheckeds: TLabel;
    Label8: TLabel;
    LabUnCheckeds: TLabel;
    Shape1: TShape;
    Label5: TLabel;
    LabDepartDate: TLabel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Label12: TLabel;
    LabDepartTime: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label23: TLabel;
    LabBusPark: TLabel;
    Bevel12: TBevel;
    Label25: TLabel;
    LabEndStation: TLabel;
    Label27: TLabel;
    LabCode: TLabel;
    PlanOnlineSchedule: TPanel;
    grp2: TGroupBox;
    nvdbgrdhcodelist: TNvDbgridEh;
    GroupBox7: TGroupBox;
    Label18: TLabel;
    LabOnlineCheckeds: TLabel;
    Shape2: TShape;
    Label26: TLabel;
    LabOnDepartdate: TLabel;
    Bevel19: TBevel;
    Bevel20: TBevel;
    Bevel22: TBevel;
    Label32: TLabel;
    LabOnEntrance: TLabel;
    Label34: TLabel;
    LabOnBusPark: TLabel;
    Bevel23: TBevel;
    Bevel24: TBevel;
    Label36: TLabel;
    LabOnReachStation: TLabel;
    Label38: TLabel;
    LabOnCode: TLabel;
    jcdsResultisreported: TBooleanField;
    jcdsResultisdeparted: TBooleanField;
    jcdsQrySeatstatus: TjsonClientDataSet;
    jscdCheckByTicketno: TjsonClientDataSet;
    jscdcancelCheckticket: TjsonClientDataSet;
    jscdQryVehicleReport: TjsonClientDataSet;
    dsVehicleReport: TDataSource;
    jcdsQryCheckticketeds: TjsonClientDataSet;
    jcdsResultvehiclereportid: TLargeintField;
    jcsdCheckallTickets: TjsonClientDataSet;
    jcdsDepartinvoice: TjsonClientDataSet;
    jcdsQryDetail: TjsonClientDataSet;
    jcdsResultroutename: TWideStringField;
    jcdsResultdistance: TIntegerField;
    ChkIsdepart: TCheckBox;
    pnl1: TPanel;
    lbl2: TLabel;
    tmrFlash: TTimer;
    tmGetCurInvoinNo: TTimer;
    jscdcancelDepartinvoices: TjsonClientDataSet;
    jcsdQryprintitem: TjsonClientDataSet;
    jcdsResultvehicleid: TLargeintField;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl4: TBevel;
    grp1: TGroupBox;
    lblBillnum: TLabel;
    lblBillno: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    dtpfromdatetime: TDateTimePicker;
    Label9: TLabel;
    NovaEdtSeatNo: TNovaEdit;
    jscdcheckBySeatno: TjsonClientDataSet;
    jscdcancelAllCheckticket: TjsonClientDataSet;
    NovaHCobEntrance: TNovaCheckedComboBox;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    jscdAuthCheck: TjsonClientDataSet;
    chkReportIsDepart: TCheckBox;
    jcdsResultjianpin: TWideStringField;
    Bevel1: TBevel;
    Label11: TLabel;
    LabChildnum: TLabel;
    jcdsResultcarrychildnum: TIntegerField;
    btnonecard: TToolButton;
    jcdsResultcanonecard: TBooleanField;
    btnreturnonecard: TToolButton;
    lbllineOneCardChecketdnum: TLabel;
    lblOneCardChecketdnum: TLabel;
    bvl3: TBevel;
    lbl1: TLabel;
    lbl3: TLabel;
    bvl5: TBevel;
    jcdsQryScheduleSeatstatus: TjsonClientDataSet;
    jcdsOthersells: TjsonClientDataSet;
    jcdsResultcheckeds: TIntegerField;
    TtnTotalCheck: TToolButton;
    ToolButton1: TToolButton;
    jcdsResultworktype: TWideStringField;
    jscdSchDepartinvoice: TjsonClientDataSet;
    Bevel2: TBevel;
    Label10: TLabel;
    LabLineUnCheck: TLabel;
    jcdsResultschtype: TWideStringField;
    jscdQryDeductfees: TjsonClientDataSet;
    NovaEdtCardNo: TNovaEdit;
    jcdsSetScheduleStatus: TjsonClientDataSet;
    jcdsAdjustPack: TjsonClientDataSet;
    jcdsResultscheduleid: TLargeintField;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    jcdsisnolyticket: TjsonClientDataSet;
    jcdscheckticketbyId: TjsonClientDataSet;
    Label13: TLabel;
    NovaHelpSchedule: TNovaHelp;
    jcdscheckticketno: TjsonClientDataSet;
    jsonQryVehSeateType: TjsonClientDataSet;
    jcdsCheckPrintPermission: TjsonClientDataSet;
    ToolButton2: TToolButton;
    jcdsFirstCheck: TjsonClientDataSet;
    Label14: TLabel;
    nvcbbstation: TNovaCheckedComboBox;
    jscdverifystation: TjsonClientDataSet;
    jcsdQryticketinfobyidcard: TjsonClientDataSet;
    jcdssecurityisture: TjsonClientDataSet;
    ToolButton3: TToolButton;
    jcdsFirstCheckSave: TjsonClientDataSet;
    jcdsResultdepartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    lbl4: TLabel;
    cbbNvehicleno: TNovaHelp;
    grp3: TGroupBox;
    lbllBillnum1: TLabel;
    lblBillno1: TLabel;
    lblabel15: TLabel;
    pm2: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    jcdsResultischecked: TBooleanField;
    jcdsQryFirstCheck: TjsonClientDataSet;
    jsonchangeticketstatus: TjsonClientDataSet;
    jcdsResultisbegincheck: TBooleanField;
    Label15: TLabel;
    NovaEditcertificateNo: TNovaEdit;
    procedure FormShow(Sender: TObject);
    procedure ChkAddCheckClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure ChkIsReprotedClick(Sender: TObject);
    procedure ChkNotReprotedClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure NovaEdtTicketNoEnter(Sender: TObject);
    procedure NovaEdtTicketNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton53Click(Sender: TObject);
    procedure tbtnPrinterClick(Sender: TObject);
    procedure tbtnExcelClick(Sender: TObject);
    procedure DpDepartDateChange(Sender: TObject);
    procedure tmrFlashTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure jscdQryVehicleReportAfterScroll(DataSet: TDataSet);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure NovaEdtTicketNoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure NovaHelpEndStationKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdhResultCellClick(Column: TColumnEh);
    procedure FormDeactivate(Sender: TObject);
    procedure nvdbgrdhcodelistCellClick(Column: TColumnEh);
    procedure NovaEdtSeatNoKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnCancelClick(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure NovaEdtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure chkReportIsDepartClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure btnonecardClick(Sender: TObject);
    procedure btnreturnonecardClick(Sender: TObject);
    procedure tbtn4Click(Sender: TObject);
    procedure tbtn5Click(Sender: TObject);
    procedure TtnTotalCheckClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NovaEdtCardNoChange(Sender: TObject);
    function isOnlyByticketnoAnddepartdate(ticketnoisnolyticketsell: string;
      departdateisnolyticketsell: String;certificateno:string): boolean;
    function checkByticketId(ticketsellid: int64;
      scheduleplanid1: int64): boolean;
    procedure NovaHelpScheduleKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton2Click(Sender: TObject);
    procedure nvdbgrdhcodelistDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure ToolButton3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure jcdsResultischeckedChange(Sender: TField);
    procedure NovaHCobEntranceExit(Sender: TObject);
    procedure tbtnInfoClick(Sender: TObject);
    procedure NovaEditcertificateNoEnter(Sender: TObject);
    procedure nvdbgrdhcodelistDblClick(Sender: TObject);
  private
    { Private declarations }
    curidcard: TIDCard;
    seatcount, seatwidth, seatheigth: integer;
    ischecked, noticketcheck, isjumpno, isprintdepartinvoices,
      isprintbynewticketno: boolean;
    curisauthorlatetocur: boolean;
    ismixcheck: boolean;
    isaotoreflash: boolean;
    ischeckbyseatno: boolean;
    isMouseCheckticket: boolean;
    isshowseathint: boolean;
    IsControlCheck: boolean;
    isPrintClick: boolean;
    isreprintotherpermission: boolean;
    serialnumber: String;
    SeatPlan: TSeatPlanChecked;
    checktickethelp: TSeatPicHelp;
    billPrint: TNovaPrint;
    billPackPrint: TNovaPrint;
    schplanidlist: TList<int64>;
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
    printPackValue: TDictionary<String, String>; // ���������
    multiplePacklist: TList < TDictionary < String, String >> ; // ������ݼ�
    multiplePackValueValue: TDictionary<String, String>;
    procedure clearScheduleInfo();
    procedure qryScheduleplan(); overload;
    procedure qryScheduleplan(scheduleplanid: int64); overload;
    // ���÷���ˮ�����ʾ��Ϣ
    procedure setScheduleInfo();
    // ������ˮ�����ʾ��Ϣ
    procedure setLineWorkScheduleinfo();
    // ��Ʊ�ż�Ʊ
    function checkByticketno(ticketno: String): boolean;
    // ����λ�ż�Ʊ����������λ��
    function checkBySeatno(seatno: String): boolean;
    // ����λ�ż�Ʊ������굥��
    function cancelCheckticket(ticketno: String): boolean;
    procedure clickseat(seatno: Word; ticketno: String; beforChecked: boolean;
      var afterChecked: boolean);
    procedure refreshBill; // ˢ�½��㵥��
    procedure refreshBill1; // ˢ�³��쵥��
    procedure departSch(invoincesno: String; iscomputeno: boolean);
    procedure onlydepartSch(); // ֻ����
    procedure departSchImpl(invoincesno: String; isreprint: boolean;
      iscomputeno: boolean);
    procedure iccardfound(icCard: TBaseCard);
    function PrintClink(scheduleid: int64): boolean; // ��ӡ�а�ǩ����
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
    function VerifyStation(ticketno: string): boolean; //У��Ʊ���Ƿ����ڷ���վ
    procedure cardfound(idcard: TIDCard);
  var
    reprotid: string;
    isshowticketno,isrealname: boolean;
    // flag1:Boolean;
    departdate1: String;
    jscdQryVehicleReportid :String;
  end;

var
  FrmCheckTicket: TFrmCheckTicket;

implementation

uses PubFn, Services, UDMPublic, UFrmMixCheckticket, UFrmChecktickets,
  UFrmCheckticketInfo, UFrmCancelCheckticket, UFrmBroadcast, DateUtils,
  UFrmHandInvoicesNo, UFrmCheckNTickets, UFrmRemoteCheckTicket,
  UFrmSumticketInfo, UFrmReprintByOldOrNewBillno, UFrmchoosecheckticket;
{$R *.dfm}

procedure TFrmCheckTicket.btnonecardClick(Sender: TObject);
var
  functionParm: TFunctionItemParameters;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
    exit;
  if ((not jcdsResult.FieldByName('islinework').AsBoolean) and
      ((not jcdsResult.FieldByName('isreported').AsBoolean)
        or jcdsResult.FieldByName('isdeparted').AsBoolean)) or
    (jcdsResult.FieldByName('islinework').AsBoolean and
      ((not jscdQryVehicleReport.Active) or
        (jscdQryVehicleReport.RecordCount = 0))) then
    exit;
  // �жϸð���Ƿ�����һ��ͨˢֹ�ϳ�
  if not jcdsResult.FieldByName('canonecard').AsBoolean then
  begin
    SysDialogs.ShowMessage('�ð�β�����һ��ͨˢ���ϳ���');
    exit;
  end;
  if jcdsResult.FieldByName('departdate').AsDateTime <> Trunc(Date) then
  begin
    SysDialogs.ShowMessage('һ��ͨˢ���ϳ�ֻ����Ե���İ�Σ�');
    exit;
  end;

  functionParm := TFunctionItemParameters.Create;
  functionParm.Add(jcdsResult.FieldByName('id').AsString);
  if jcdsResult.FieldByName('islinework').AsBoolean then
    functionParm.Add(jscdQryVehicleReport.FieldByName('id').AsString)
  else
    functionParm.Add(jcdsResult.FieldByName('vehiclereportid').AsString);
  functionParm.Add(NovaHCobEntrance.text);
  SysFunctionMgr.exec(StringToGUID('{51F3A99E-2748-4FE6-B0AD-B498EF283063}'),
    functionParm);
  jcdsResultAfterScroll(jcdsResult);
end;

procedure TFrmCheckTicket.btnreturnonecardClick(Sender: TObject);
var
  functionParm: TFunctionItemParameters;
begin
  inherited;
  functionParm := TFunctionItemParameters.Create;
  SysFunctionMgr.exec(StringToGUID('{02A6C5E1-4100-4B1B-9BB8-475D517DA0F3}'),
    functionParm);
  if jcdsResult.Active and (jcdsResult.RecordCount > 0) then
  begin
    jcdsResultAfterScroll(jcdsResult);
  end;
end;

function TFrmCheckTicket.cancelCheckticket(ticketno: String): boolean;
var
  nresult: integer;
  sresult: string;
  scheduleplanid: int64;
begin
  with jscdcancelCheckticket do
  begin
    Active := false;
    Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
    Params.ParamValues['ticketno'] := ticketno;
    execute;
    nresult := Params.ParamValues['flag'];
    sresult := Params.ParamValues['msg'];
    if nresult = 1 then
    begin
      lbl2.Caption := sresult;
      scheduleplanid := Params.ParamValues['scheduleplanid'];
      if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
        qryScheduleplan();
      jcdsResult.Locate('id', scheduleplanid, []);

      if jcdsResult.FieldByName('islinework').AsBoolean then
        setLineWorkScheduleinfo
      else
        setScheduleInfo;
      NovaEditcertificateNo.Clear;
      NovaEdtTicketNo.Clear;
      result := true;
    end
    else
    begin
      SysDialogs.Warning(sresult);
      NovaEdtTicketNo.SetFocus;
      NovaEdtTicketNo.SelectAll;
      if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
        qryScheduleplan();
      result := false;
    end;
  end;
end;

function TFrmCheckTicket.checkBySeatno(seatno: String): boolean;
var
  nresult: integer;
  sresult: string;
  // scheduleplanid: int64;
begin
  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  try
    with jscdcheckBySeatno do
    begin
      Active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      if (not jscdQryVehicleReport.Active) or
        (jscdQryVehicleReport.RecordCount = 0) then
      begin
        SysDialogs.ShowMessage('��û�б���������');
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        exit;
      end;
      Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
        .AsLargeInt;
      Params.ParamValues['vehiclereportid'] := jscdQryVehicleReport.FieldByName
        ('id').AsLargeInt;
      if ChkAddCheck.Checked then
        Params.ParamValues['islazycheck'] := true
      else
        Params.ParamValues['islazycheck'] := false;
      Params.ParamValues['seatno'] := seatno;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      Params.ParamValues['ticketentrance'] := NovaHCobEntrance.text;
      execute;
      nresult := Params.ParamValues['flag'];
      sresult := Params.ParamValues['msg'];
      if nresult = 1 then
      begin
        // ChkAddCheck.Checked:=false;
        setLineWorkScheduleinfo;
        lbl2.Caption := sresult;
        self.NovaEdtSeatNo.Clear;
        NovaEdtSeatNo.SetFocus;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := true;
      end
      else
      begin
        lbl2.Caption := sresult;
        if Pos('δ����', sresult) > 0 then
        begin
          qryScheduleplan();
        end;
        NovaEdtSeatNo.SetFocus;
        NovaEdtSeatNo.Clear;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := false;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('��Ʊ����ʧ�ܣ�' + E.Message);
      result := false;
    end;
  end;

end;

// ���������жϵ�ǰӦ�ý��г�Ʊ�ż�Ʊ����ͨ����ƱID���м�Ʊ
function TFrmCheckTicket.isOnlyByticketnoAnddepartdate
  (ticketnoisnolyticketsell: string;
  departdateisnolyticketsell: String;certificateno:string): boolean;
var
  nresult: integer;
  sresult: string;
begin
  with jcdsisnolyticket do
  begin
    Active := false;
    Params.ParamValues['ticketnoisonlyticket'] := ticketnoisnolyticketsell;
    Params.ParamValues['departdateisnolyticket'] := departdateisnolyticketsell;
    Params.ParamValues['certificateno'] := certificateno;
    execute;
    nresult := Params.ParamValues['flag'];
    // sresult := Params.ParamValues['msg'];
    if nresult = 2 then
    begin
      // try
      // begin
      Frmchoosecheckticket := TFrmchoosecheckticket.Create(self);

      with Frmchoosecheckticket do
      begin
        chooseticketno := ticketnoisnolyticketsell;
        departdate1 := departdateisnolyticketsell;
        if SysMainForm.showFormModal(Frmchoosecheckticket) = mrok then
        begin
          checkByticketId(ticketsellid, scheduleplanid1);
        end;
      end;
      // end;
      // finally
      // FreeAndNil(Frmchoosecheckticket);
      // end;
      result := false;
    end
    else if nresult = 1 then
    begin
      checkByticketno(trim(NovaEdtTicketNo.text));
      result := true;
    end
    else
    begin
      lbl2.Caption :='��Ʊ�Ų����ڣ�';
      result := true;
    end;

  end;

end;

// �������д�����ͬƱ��ѡ��ķ���
function TFrmCheckTicket.checkByticketId(ticketsellid: int64;
  scheduleplanid1: int64): boolean;
var
  nresult: integer;
  sresult: string;
  scheduleplanid: int64;
begin

  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  try
    with jcdscheckticketbyId do
    begin
      Active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      if jcdsResult.FieldByName('islinework').AsBoolean then
      begin
        if (not jscdQryVehicleReport.Active) or
          (jscdQryVehicleReport.RecordCount = 0) then
        begin
          Params.ParamValues['vehiclereportid'] := 0;
          { SysDialogs.ShowMessage('��û�б���������');
            if self.isaotoreflash then
            tmrFlash.Enabled := true;
            exit; }
        end
        else
          Params.ParamValues['vehiclereportid'] :=
            jscdQryVehicleReport.FieldByName('id').AsLargeInt;
      end
      else
      begin
        if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) and
          (jcdsResult.FieldByName('isreported').AsBoolean) then
        begin
          Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
            ('vehiclereportid').AsString;
        end
        else
        begin
          Params.ParamValues['vehiclereportid'] := 0;
        end;
      end;
      if ChkAddCheck.Checked then
        Params.ParamValues['islazycheck'] := true
      else
        Params.ParamValues['islazycheck'] := false;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      // Params.ParamValues['ticketno'] := ticketno;
      Params.ParamValues['ticketsellid'] := ticketsellid;
      // Params.ParamValues['ticketentrance'] := ticketentrance;
      // Params.ParamValues['ticketentrance'] := NovaHCobEntrance.text;
      execute;
      nresult := Params.ParamValues['flag'];
      sresult := Params.ParamValues['msg'];

      // if SysMainForm.showFormModal(Frmchoosecheckticket) = mrok then
      // begin
      // FreeAndNil(Frmchoosecheckticket);
      // end;

      if nresult = 1 then
      begin
        // sndPlaySound('chord.wav',SND_ASYNC);
        // scheduleplanid := Params.ParamValues['scheduleplanid'];
        scheduleplanid := scheduleplanid1;
        reprotid := Params.ParamValues['reportid'];
        if ((jcdsResult.Active) and (jcdsResult.RecordCount > 0)) then
        begin
          if (jcdsResult.FieldByName('id').AsLargeInt = scheduleplanid) then
          begin
            if jcdsResult.FieldByName('islinework').AsBoolean then
            begin
              setLineWorkScheduleinfo;
            end
            else
            begin
              setScheduleInfo;
              SeatPlan.Refresh;
              // SeatPlan.locateByTicketNo(ticketno, false);
            end;
          end
          else if scheduleplanid > 0 then
          begin
            dbgrdhResult.SelectedRows.CurrentRowSelected := false;
            jcdsResult.Locate('id', scheduleplanid, []);
            dbgrdhResult.SelectedRows.CurrentRowSelected := true;
            if jcdsResult.FieldByName('islinework').AsBoolean then
            begin
              setLineWorkScheduleinfo;
            end
            else
            begin
              SeatPlan.Refresh;
              // SeatPlan.locateByTicketNo(ticketno, false);
            end;
          end;
        end
        else
        begin
          // flag1 :=true;
          qryScheduleplan(scheduleplanid1);
          if jcdsResult.FieldByName('islinework').AsBoolean then
          begin
            //
          end
          else
          begin
            SeatPlan.Refresh;
            // SeatPlan.locateByTicketNo(ticketno, false);
          end;
        end;
        lbl2.Caption := sresult;
        NovaEditcertificateNo.Clear;
        NovaEdtTicketNo.Clear;
        // tmrFlash.Enabled := false;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := true;
      end
      else
      begin
        // messagebeep(MB_ICONERROR);
        sndPlaySound('chord.wav', SND_ASYNC);
        lbl2.Caption := sresult;
        if Pos('δ����', sresult) > 0 then
        begin
          // flag1 :=true;
          qryScheduleplan(scheduleplanid1);
        end;
        NovaEditcertificateNo.Clear;
        NovaEdtTicketNo.Clear;
        NovaEdtTicketNo.SetFocus;
        if not(jcdsResult.Active) then
        begin
          // flag1 :=true;
          qryScheduleplan(scheduleplanid1);
        end;

        // tmrFlash.Enabled := false;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := false;
      end;
      // FrmCheckTicket.Close;

    end;

  except
    on E: Exception do
    begin
      SysLog.WriteErr('��Ʊ����ʧ�ܣ�' + E.Message);
      result := false;
    end;
  end;
end;

function TFrmCheckTicket.checkByticketno(ticketno: String): boolean;
var
  nresult: integer;
  sresult: string;
  scheduleplanid: int64;
begin
  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  try
    with jscdCheckByTicketno do
    begin
      Active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      if jcdsResult.FieldByName('islinework').AsBoolean then
      begin
        if (not jscdQryVehicleReport.Active) or
          (jscdQryVehicleReport.RecordCount = 0) then
        begin
          Params.ParamValues['vehiclereportid'] := 0;
          { SysDialogs.ShowMessage('��û�б���������');
            if self.isaotoreflash then
            tmrFlash.Enabled := true;
            exit; }
        end
        else
          Params.ParamValues['vehiclereportid'] :=
            jscdQryVehicleReport.FieldByName('id').AsLargeInt;
      end
      else
      begin
        if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) and
          (jcdsResult.FieldByName('isreported').AsBoolean) then
        begin
          Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
            ('vehiclereportid').AsString;
        end
        else
        begin
          Params.ParamValues['vehiclereportid'] := 0;
        end;
      end;
      if ChkAddCheck.Checked then
        Params.ParamValues['islazycheck'] := true
      else
        Params.ParamValues['islazycheck'] := false;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      // ͨ��Ʊ�ź�����ȷ����ǰҪ���м�Ʊ�������Ƿ����һ��
      Params.ParamValues['ticketno'] := ticketno;
      // Params.ParamValues['departdate1'] := formatdatetime('yyyy-mm-dd',DpDepartDate.Date);
      Params.ParamValues['ticketentrance'] := NovaHCobEntrance.text;
      execute;
      nresult := Params.ParamValues['flag'];
      sresult := Params.ParamValues['msg'];

      // else
      if nresult = 1 then
      begin
        // sndPlaySound('chord.wav',SND_ASYNC);
        scheduleplanid := Params.ParamValues['scheduleplanid'];
        reprotid := Params.ParamValues['reportid'];
        if ((jcdsResult.Active) and (jcdsResult.RecordCount > 0)) then
        begin
          if (jcdsResult.FieldByName('id').AsLargeInt = scheduleplanid) then
          begin
            if jcdsResult.FieldByName('islinework').AsBoolean then
            begin
              setLineWorkScheduleinfo;
            end
            else
            begin
              setScheduleInfo;
              SeatPlan.locateByTicketNo(ticketno, false);
            end;
          end
          else if scheduleplanid > 0 then
          begin
            dbgrdhResult.SelectedRows.CurrentRowSelected := false;
            jcdsResult.Locate('id', scheduleplanid, []);
            dbgrdhResult.SelectedRows.CurrentRowSelected := true;
            if jcdsResult.FieldByName('islinework').AsBoolean then
            begin
              setLineWorkScheduleinfo;
            end
            else
            begin
              SeatPlan.locateByTicketNo(ticketno, false);
            end;
          end;
        end
        else
        begin
          qryScheduleplan(scheduleplanid);
          if jcdsResult.FieldByName('islinework').AsBoolean then
          begin
            //
          end
          else
          begin
            SeatPlan.locateByTicketNo(ticketno, false);
          end;
        end;
        lbl2.Caption := sresult;
        NovaEdtTicketNo.Clear;
        NovaEditcertificateNo.Clear;
        NovaEdtTicketNo.SetFocus;
        // tmrFlash.Enabled := false;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := true;
      end
      else
      begin
        // messagebeep(MB_ICONERROR);
        sndPlaySound('chord.wav', SND_ASYNC);
        lbl2.Caption := sresult;
        if Pos('δ����', sresult) > 0 then
        begin
          qryScheduleplan();
        end;
        NovaEdtTicketNo.Clear;
        NovaEditcertificateNo.Clear;
        NovaEdtTicketNo.SetFocus;
        if not(jcdsResult.Active) then
          qryScheduleplan();
        // tmrFlash.Enabled := false;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
        result := false;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('��Ʊ����ʧ�ܣ�' + E.Message);
      result := false;
    end;
  end;
end;

procedure TFrmCheckTicket.ChkAddCheckClick(Sender: TObject);
begin
  inherited;
  NovaEdtTicketNo.SetFocus;
  tbtnDelete.Enabled := False;
  if ChkAddCheck.Checked then
    tbtnDelete.Enabled := False
    else
      tbtnDelete.Enabled := True;

  { if ChkAddCheck.Checked then
    begin
    DpDepartDate.Enabled := true;
    end
    else
    begin
    if (formatdatetime('yyyymmdd',
    DpDepartDate.Date) <> (formatdatetime('yyyymmdd', now))) then
    begin
    DpDepartDate.Date := now;
    qryScheduleplan();
    end;
    DpDepartDate.Enabled := false;
    end; }
end;

procedure TFrmCheckTicket.ChkIsReprotedClick(Sender: TObject);
begin
  inherited;
  qryScheduleplan();
end;

procedure TFrmCheckTicket.ChkNotReprotedClick(Sender: TObject);
begin
  inherited;
  qryScheduleplan();
end;

procedure TFrmCheckTicket.chkReportIsDepartClick(Sender: TObject);
var
  scheduleplanid: int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;

  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    with jcdsResult do
    begin
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    end;
    with jscdQryVehicleReport do
    begin
      jscdQryVehicleReport.AfterScroll := nil;
      Active := false;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
        DpDepartDate.Date);
      if chkReportIsDepart.Checked then
        Params.ParamValues['isdeparted'] := true
      else
        Params.ParamValues['isdeparted'] := false;
      Active := true;
     if (jscdQryVehicleReport.Active) and (jscdQryVehicleReport.RecordCount > 0) then
     begin
         LabOnlineCheckeds.Caption := jscdQryVehicleReport.FieldByName('tickets').AsString;
     end;
      jscdQryVehicleReport.AfterScroll := jscdQryVehicleReportAfterScroll;
      // jscdQryVehicleReport.Locate('id',curreportid,[]);
    end;
  end;
end;

procedure TFrmCheckTicket.clearScheduleInfo;
begin
  // self.LabSoldNum.Caption := '';
  self.LabCheckeds.Caption := '';
  lblOneCardChecketdnum.Caption := '';
  self.LabUnCheckeds.Caption := '';
  self.LabDepartDate.Caption := '';
  self.LabDepartTime.Caption := '';
  self.LabCode.Caption := '';
  // self.LabEntrance.Caption := '';
  self.LabBusPark.Caption := '';
  self.LabEndStation.Caption := '';
  LabOnlineCheckeds.Caption := '';
  LabLineUnCheck.Caption := '';
  lbllineOneCardChecketdnum.Caption := '';
  LabOnDepartdate.Caption := '';
  LabOnCode.Caption := '';
  LabOnReachStation.Caption := '';
  LabOnEntrance.Caption := '';
  LabOnBusPark.Caption := '';
  LabChildnum.Caption := '';
end;

procedure TFrmCheckTicket.clickseat(seatno: Word; ticketno: String;
  beforChecked: boolean; var afterChecked: boolean);
begin
  //У�鳵Ʊ�ķ���վ�Ƿ�ƥ��
//  if ticketno<>'' then
//  begin
//     if not self.VerifyStation(ticketno) then
//      begin
//         Exit;
//      end;
//  end;
  //���Ϊʵ���Ƽ�Ʊ,��֧��˫����Ʊ
  if isrealname then
  begin
      exit;
  end;

  if beforChecked then
  begin
    // //ȡ����Ʊ
    afterChecked := cancelCheckticket(ticketno);
  end
  else
  begin
    if (not jcdsResult.FieldByName('isreported').AsBoolean) then
    begin
      SysDialogs.Warning('�ð�λ�û������');
      afterChecked := beforChecked;
      exit;
    end;
    afterChecked := checkByticketno(ticketno); // ��Ʊ
  end;
end;

procedure TFrmCheckTicket.dbgrdhResultCellClick(Column: TColumnEh);
begin
  inherited;
  {if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) and
    (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    qryScheduleplan();
  end
  else
    NovaEdtTicketNo.SetFocus;  }
end;

procedure TFrmCheckTicket.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
    exit;
  FrmSumticketInfo := TFrmSumticketInfo.Create(self);
  with FrmSumticketInfo do
  begin
    grp1.Caption := jcdsResult.FieldByName('routename').AsString;
    scheduleplanid_s := jcdsResult.FieldByName('id').AsLargeInt;
    SysMainForm.showFormModal(FrmSumticketInfo);
  end;
end;

procedure TFrmCheckTicket.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;

   With dbgrdhResult do
       begin
          dbgrdhResult.Canvas.pen.mode:=pmmask;
//          DefaultDrawColumnCell(Rect, DataCol, Column, State);
       end;
  // ��ͣ
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    Background := clRed; // clYellow;
    // dbgrdhResult.Canvas.Font.Color := clRed; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // ����
  if (jcdsResult.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clLtGray;
    // dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // �Ѱ�
  if (jcdsResult.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // ͣ��
  if (jcdsResult.FieldByName('status').AsString = '5') and not
    (gdSelected in State) then
  begin
    Background := clFuchsia;
    // dbgrdhResult.Canvas.Font.Color := clFuchsia;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('isdeparted').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmCheckTicket.departSch(invoincesno: String; iscomputeno: boolean);
begin
  if (iscomputeno) and (not checkBillno('BalanceBill')) then
    exit;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�δ������');
    exit;
  end;
  if (iscomputeno) and (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('�ð���Ѿ����࣡');
    exit;
  end;
  if not jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    if (LabUnCheckeds.Caption <> '') and (StrToInt(LabUnCheckeds.Caption) > 0)
      then
    begin
      if not SysDialogs.Confirm('��ʾ��Ϣ',
        '�ð�λ���' + LabUnCheckeds.Caption + '��δ�쳵Ʊ��ȷ�Ͻ��з����ӡ������') then
      begin
        exit;
      end;
    end
    else if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ��з����ӡ������') then
    begin
      exit;
    end;
  end
  else if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ��з����ӡ������') then
  begin
    exit;
  end;

  if getParametervalue('9033', Sysinfo.LoginUserInfo.OrgID) = '0' then
  // ��Ʊ���㵥��ӡʱ���Ƿ���Ҫ�����а����տ���Ч�������жϣ�0������Ҫ��1����Ҫ
  begin
    departSchImpl(invoincesno, false, iscomputeno);
  end;

  isPrintClick := true;
  // �Ƿ��ӡ������㵥��0������ӡ��1����ӡ
  if getParametervalue('8080', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    if getParametervalue('9033', Sysinfo.LoginUserInfo.OrgID) = '1' then
    begin
      with jcdsAdjustPack do
      begin
        Active := false;
        Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('scheduleid')
          .AsString;
        Params.ParamValues['startdate'] := formatdatetime('yyyy-MM-dd',
          DpDepartDate.DateTime);
        Params.ParamValues['enddate'] := formatdatetime('yyyy-MM-dd',
          DpDepartDate.DateTime);
        Active := true;
        if FieldByName('result').AsString = '1' then // �������տ����������а���û����Ʊ������
        begin
          // ����ӡ��Ʊ���㵥
          exit;
        end
        else
        begin
          departSchImpl(invoincesno, false, iscomputeno);
        end;
      end;
    end;
    isPrintClick := PrintClink(jcdsResult.FieldByName('scheduleid').AsLargeInt);
  end;

end;

procedure TFrmCheckTicket.departSchImpl(invoincesno: String;
  isreprint: boolean; iscomputeno: boolean);
var
  vehiclereportid, departinvoicesid, vehicleid, scheduleplanid: int64;
  nresult: integer;
  sresult, vehicleno,msg1: String;
  multipleValueValue: TDictionary<String, String>;
  schedulecode, departdate: string;
  departtime, departstation, endstation: string;
  routename, templtename: string;
  fulls, halfs, students, discounts, totalpsdistance: integer;
  totalpeople, psdistance: integer;
  totalfee, noagentbalanceprice,nostationbalanceprice,nostationtotalbalanceprice: double;
  i: integer;
begin
  fulls := 0;
  halfs := 0;
  students := 0;
  discounts := 0;
  totalpsdistance := 0;
  totalfee := 0;
  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jscdQryVehicleReport.Active then
      exit;
    if jscdQryVehicleReport.RecordCount = 0 then
      exit;
    vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    vehicleno := jscdQryVehicleReport.FieldByName('vehicleno').AsString;
    vehicleid := jscdQryVehicleReport.FieldByName('vehicleid').AsLargeInt;
  end
  else
  begin

    vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
  end;

  schedulecode := jcdsResult.FieldByName('code').AsString;
  departdate := jcdsResult.FieldByName('departdate').AsString;
  departtime := jcdsResult.FieldByName('departtime').AsString;
  departstation := jcdsResult.FieldByName('departstation').AsString;
  endstation := jcdsResult.FieldByName('endstation').AsString;
  routename := jcdsResult.FieldByName('routename').AsString;
  templtename := TNovaPrint.GetTicketModelName('���㵥', 'Ĭ�Ͻ��㵥');

  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);

  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

  notprintValue := getNotprintValue(Sysinfo.LoginUserInfo.OrgID, vehicleid,
    templtename);

  try
    with jcdsDepartinvoice do
    begin
      Active := false;
      Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['departinvoicesno'] := invoincesno;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      Params.ParamValues['isreprint'] := isreprint;
      Params.ParamValues['iscomputeno'] := iscomputeno;
      Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
        DpDepartDate.Date);
      Params.ParamValues['isprintbynewticketno'] := isprintbynewticketno;
      Active := true;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        if (RecordCount > 0) and (iscomputeno) then
        begin
          while not Eof do
          begin
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create
            else
              printValue.Clear;
            printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
            printValue.Add('seats', FieldByName('seatnum').AsString);
            printValue.Add('brandmodel', FieldByName('brandname').AsString);
            printValue.Add('vehicletype', FieldByName('vehicletype').AsString);
            printValue.Add('route', routename);
            printValue.Add('routedistance', FieldByName('distance').AsString);
            printValue.Add('schedulecode', schedulecode);
            printValue.Add('departdate', departdate);
            printValue.Add('departtime', departtime);
            printValue.Add('departstation', departstation);
            printValue.Add('checkedname', FieldByName('checkedname').AsString);
            printValue.Add('endstation', endstation);
            printValue.Add('freetickets', FieldByName('freetickets').AsString);
            printValue.Add('armtickets', FieldByName('armtickets').AsString);

            departinvoicesid := FieldByName('id').AsLargeInt;
            printValue.Add('invoicesno', FieldByName('invoicesno').AsString);
            printValue.Add('unit', FieldByName('unit').AsString);
            printValue.Add('ticketnum', FieldByName('ticketnum').AsString);
            printValue.Add('driver1', FieldByName('driver1').AsString);
            printValue.Add('driver2', FieldByName('driver2').AsString);
            printValue.Add('driver3', FieldByName('driver3').AsString);
            printValue.Add('driver4', FieldByName('driver4').AsString);
            printValue.Add('steward', FieldByName('steward').AsString);
            printValue.Add('remarks', FieldByName('remarks').AsString);
            printValue.Add('ticketoutlet',
              FieldByName('ticketoutname').AsString);
            printValue.Add('ticketoutletshort',
              FieldByName('ticketoutshort').AsString);
            printValue.Add('balanceunit', FieldByName('balanceunit').AsString);
            printValue.Add('balanceunitfullname', FieldByName('balanceunitfullname').AsString);   //20160422 ֮ǰ���㵥λȫ�Ʊ�ע�͵��ˣ�����Ҫ��򿪴˴�ӡ��
            printValue.Add('unitfullname', FieldByName('fullname').AsString);
            // �۷���ϸ��Ϊ�����ݼ�����
            with jscdQryDeductfees do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Active := true;
              if RecordCount > 0 then
              begin
                first;
                while (not Eof) do
                begin
                  printValue.Add(FieldByName('code').AsString,
                    FieldByName('deductmoney').AsString);
                  next;
                end;
              end;
            end;
            // �۷���ϸ��Ϊ�����ݼ�����
            printValue.Add('stationfee', FieldByName('stationfee').AsString);
//            printValue.Add('vehicleseattype', FieldByName('vehicleseattype').AsString);

            totalfee := FieldByName('totalamount').AsFloat - FieldByName
              ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;

             //��������վ��ѵĽ�����
            nostationbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat)/(FieldByName('ticketnum').AsInteger);
            nostationtotalbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat);

            //end


            noagentbalanceprice := FieldByName('agentfee').AsFloat + FieldByName
              ('balanceamount').AsFloat;
            printValue.Add('noagentbalanceprice',
              floattostr(noagentbalanceprice));
            printValue.Add('totalfee', floattostr(totalfee));

            printValue.Add('nostationbalanceprice',FloatToStr(nostationbalanceprice));//��������Դ����վ��ѵĽ�����
            printValue.Add('nostationtotalbalanceprice',FloatToStr(nostationtotalbalanceprice));//��������Դ����վ��ѵĽ����ܽ��


            if isreprint then
              printValue.Add('reprint', '�ش�')
            else
              printValue.Add('reprint', '');
            printValue.Add('agentfee', FieldByName('agentfee').AsString);
            printValue.Add('fueladditionfee',
              FieldByName('fueladditionfee').AsString);

            printValue.Add('otherfee', FieldByName('otherfee').AsString);
            printValue.Add('totalamount', FieldByName('totalamount').AsString);
            printValue.Add('balanceamount',
              FieldByName('balanceamount').AsString);
            if FieldByName('isovertime').AsBoolean then
              printValue.Add('isovertime', '�Ӱ�')
            else
              printValue.Add('isovertime', '');
            printValue.Add('printby', Sysinfo.LoginUserInfo.UserName);
            printValue.Add('printstation', Sysinfo.LoginUserInfo.OrgName);
            printValue.Add('printertime',
              formatdatetime('yyyy-mm-dd hh:mm', now));

            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            with jcdsQryDetail do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Active := true;
              if RecordCount > 0 then
              begin
                first;

                while (not Eof) do
                begin
                  multipleValueValue := TDictionary<String, String>.Create;
                  multipleValueValue.Add('fromstation',
                    FieldByName('fromstation').AsString);
                  multipleValueValue.Add('reachstation',
                    FieldByName('reachstation').AsString);
                  multipleValueValue.Add('fullpeople',
                    FieldByName('fullpeople').AsString);
                  multipleValueValue.Add('price',
                    FieldByName('price').AsString);
                  multipleValueValue.Add('halfpeople',
                    FieldByName('halfpeople').AsString);
                  multipleValueValue.Add('studentpeople', '0');
                  multipleValueValue.Add('discountpeople',
                    FieldByName('discountpeople').AsString);
                  multipleValueValue.Add('distance',
                    FieldByName('distance').AsString);
                  totalpeople := FieldByName('fullpeople')
                    .AsInteger + FieldByName('halfpeople').AsInteger
                    + FieldByName('discountpeople').AsInteger; //ȫ��Ʊ  ���Ʊ ����Ʊ����
                  psdistance := FieldByName('distance').AsInteger * totalpeople;
                  multipleValueValue.Add('psdistance', inttostr(psdistance));
                  multipleValueValue.Add('totalamount',
                    FieldByName('totalamount').AsString);
                  multipleValueValue.Add('balanceprice',
                    FieldByName('balanceprice').AsString);
                  multiplelist.Add(multipleValueValue);
                  multipleValueValue.Add('balanceamount',
                    FieldByName('balanceamount').AsString);
                 multipleValueValue.Add('noservicestationfee',
                    FieldByName('noservicestationfee').AsString);
//                  multipleValueValue.Add('noservicestationfee',
//                    FloatToStr((FieldByName('noservicestationfee').AsFloat)/(FieldByName('fullpeople').AsInteger)));  //����ֻ�۳�վ��ѵĽ��㵥�ۣ�������վ����
                  multipleValueValue.Add('noagentbalanceamount',
                    FieldByName('noagentbalanceamount').AsString);
                  fulls := fulls + FieldByName('fullpeople').AsInteger;
                  halfs := halfs + FieldByName('halfpeople').AsInteger;
                  students := 0;
//                  discounts := 0;
                  discounts := discounts + FieldByName('discountpeople').AsInteger;
                  totalpsdistance := totalpsdistance + psdistance;
                  next;
                end;
              end;
            end;
            // ��������ID �������ڻ�ȡ��վ��Ʊ���
            with jcdsOthersells do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Params.ParamValues['departdate'] := departdate;
              execute;
              printValue.Add('othersell',
                Params.ParamByName('othersells').Value);
            end;
            printValue.Add('fulls', inttostr(fulls));
            printValue.Add('halfs', inttostr(halfs));
            printValue.Add('students', inttostr(students));
            printValue.Add('discounts', inttostr(discounts));
            printValue.Add('totalpsdistance', inttostr(totalpsdistance));

            billPrint.SingleValue := printValue;
            billPrint.MultipleValue := multiplelist;
//            if (getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0') and
//            (jcdsResult.FieldByName('ischeckresult').AsString <> '0') then
//             begin
//
//             end
//             else
//             begin
//              billPrint.Print;
//             end;
////             billPrint.Print;
//            if ((jcdsResult.FieldByName('ischeckresult').AsString = '0') or (jcdsResult.FieldByName('ischeckresult').AsString = '2')) then
            msg1:=Params.ParamValues['msg1'];
            if  (msg1='securityisfalse')
            and ((getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0')) then
            begin  //����ϸ��ӡ
//               billPrint.Print;
            end
            else
            begin
              //���첻�ϸ� ������1��ʱ �ܴ�ӡ
                billPrint.Print;
            end;

            if isreprint then
            begin
              if isprintbynewticketno then
              begin
                // if isjumpno then
                // begin

                with Sysinfo.LoginUserInfo do
                begin
                  curBillNo.AddOrSetValue('BalanceBill',
                    zerofill
                      (inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                          + 1), length(curBillNo.Items['BalanceBill'])));
                  curBillNum.AddOrSetValue('BalanceBill',
                    curBillNum.Items['BalanceBill'] - 1);
                end;
                // end;
              end;
            end
            else
            begin
              with Sysinfo.LoginUserInfo do
              begin
                curBillNo.AddOrSetValue('BalanceBill',
                  zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                        + 1), length(curBillNo.Items['BalanceBill'])));
                curBillNum.AddOrSetValue('BalanceBill',
                  curBillNum.Items['BalanceBill'] - 1);
              end;
            end;

            ChkAddCheck.Checked := false;
            refreshBill;
            next;
          end;
          // SysDialogs.ShowMessage(sresult);
          lbl2.Caption := sresult;
          dtpfromdatetime.Time := now - 0.08;
          ChkIsdepart.Checked := false;
          qryScheduleplan(scheduleplanid);
          NovaEdtTicketNo.SetFocus;
        end;
        if not iscomputeno then
        begin
          qryScheduleplan(scheduleplanid);
        end;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
      if self.isaotoreflash then
        tmrFlash.Enabled := true;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�������ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmCheckTicket.DpDepartDateChange(Sender: TObject);
begin
  inherited;
  qryScheduleplan();
end;

procedure TFrmCheckTicket.FormActivate(Sender: TObject);
begin
  inherited;
  NovaEdtTicketNo.SetFocus;
  if self.isaotoreflash then
  begin
    tmrFlash.Enabled := false;
    tmrFlash.Enabled := true;
  end;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
    Sysinfo.CardManage.ReadCardNo(self.NovaEdtCardNo);
    Sysinfo.CardManage.StartRead;
  end;
end;

procedure TFrmCheckTicket.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(checktickethelp) then
    checktickethelp.Free;
  if Assigned(printValue) then
    printValue.Free;
  if Assigned(multiplelist) then
    multiplelist.Free;
  if Assigned(printPackValue) then
    printPackValue.Free;
  if Assigned(multiplePacklist) then
    multiplePacklist.Free;
  tmGetCurInvoinNo.Enabled := false;
  tmrFlash.Enabled := false;
  inherited;
end;

procedure TFrmCheckTicket.FormCreate(Sender: TObject);
var
  interval: String;
  intervaltime: integer;
begin
  inherited;
  isrealname := StrToBool(getParametervalue('3038',SysInfo.LoginUserInfo.OrgID)); //�Ƿ�ʵ���Ƽ�Ʊ
  if isrealname then
  begin
     Label15.Visible:= True;
     NovaEditcertificateNo.Visible:=True;
  end;

  // �Ƿ����ò�����ť
  if getParametervalue('0011', Sysinfo.LoginUserInfo.OrgID) = '1' then
    tbtnPrinter.Visible := true
  else
    tbtnPrinter.Visible := false;

  if getParametervalue('3013', Sysinfo.LoginUserInfo.OrgID) = '1' then
    grp1.Visible := true
  else
    grp1.Visible := false;
  // �����Ƿ�������
  if getParametervalue('3015', Sysinfo.LoginUserInfo.OrgID) = '1' then
    ismixcheck := true
  else
    ismixcheck := false;
   //���Ӳ������Ƴ��쵥���ڽ����ϵ���ʾ
  if getParametervalue('3045', Sysinfo.LoginUserInfo.OrgID) = '1' then
    grp3.Visible := true
  else
    grp3.Visible := false;
  // checkBillno;
  checkBillno('BalanceBill');
 
  try
    TBaseCardRW.GetInstance.addObserver(self);
  except
    TBaseCardRW.GetInstance.addObserver(self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    Sysinfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, Sysinfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    Sysinfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, Sysinfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, Sysinfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    Sysinfo.curBillLength.Items['Unit']);
  // NovaEdtTicketNo.MaxLength := Sysinfo.curBillLength.Items['Ticket'];
  if getParametervalue('3014', Sysinfo.LoginUserInfo.OrgID) = '1' then
    isshowseathint := true
  else
    isshowseathint := false;

  if getParametervalue('3025', Sysinfo.LoginUserInfo.OrgID) = '1' then
    isjumpno := true
  else
    isjumpno := false;
  if getParametervalue('3002', Sysinfo.LoginUserInfo.OrgID) = '1' then
    isMouseCheckticket := true
  else
    isMouseCheckticket := false;

  if getParametervalue('3011', Sysinfo.LoginUserInfo.OrgID) = '1' then
    IsControlCheck := true
  else
    IsControlCheck := false;

  if getParametervalue('3009', Sysinfo.LoginUserInfo.OrgID) = '1' then
    isaotoreflash := true
  else
    isaotoreflash := false;
  if isaotoreflash then
  begin
    // ��ȡˢ��ʱ��
    intervaltime := 60;
    interval := getParametervalue('3007', Sysinfo.LoginUserInfo.OrgID);
    try
      intervaltime := StrToInt(interval);
    except
      intervaltime := 60;
    end;
    tmrFlash.interval := intervaltime * 1000;
    tmrFlash.Enabled := true;
  end
  else
  begin
    tmrFlash.Enabled := false;
  end;
  btnonecard.Visible := getParametervalue('0013', Sysinfo.LoginUserInfo.OrgID)
    = '1';
  btnreturnonecard.Visible := btnonecard.Visible and (getParametervalue('7004',
      Sysinfo.LoginUserInfo.OrgID) = '1');
  lbllineOneCardChecketdnum.Visible := btnonecard.Visible;
  // bvl5.Visible := lbllineOneCardChecketdnum.Visible;
  lbl3.Visible := lbllineOneCardChecketdnum.Visible;
  lblOneCardChecketdnum.Visible := btnonecard.Visible;
  bvl3.Visible := lblOneCardChecketdnum.Visible;
  Bevel2.Visible := lbllineOneCardChecketdnum.Visible;
  lbl1.Visible := lblOneCardChecketdnum.Visible;
  if lblOneCardChecketdnum.Visible then
  begin
    Bevel7.Width := 660;
    Shape1.Width := 660;
  end
  else
  begin
    Bevel7.Width := 590;
    Shape1.Width := 590;
  end;
  if lbllineOneCardChecketdnum.Visible then
  begin
    Bevel19.Width := 643;
    Shape2.Width := 643;
  end
  else
  begin
    Bevel19.Width := 590;
    Shape2.Width := 590;
  end;
  nvcbbstation.Active := False;
  nvcbbstation.Active := True;
  nvcbbstation.CheckById(True,SysInfo.LoginUserInfo.StationID);
  checktickethelp := TSeatPicHelp.Create;

  TIDCardReader.GetInstance.addObserver(self, false, true);
  schplanidlist:= TList<Int64>.Create;
end;

procedure TFrmCheckTicket.FormDeactivate(Sender: TObject);
begin
  inherited;
  tmrFlash.Enabled := false;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
  end;
end;

procedure TFrmCheckTicket.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(self);
    TIDCardReader.GetInstance.removeObserver(self);
  except
  end;
end;

procedure TFrmCheckTicket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // inherited;
  if (Key = vk_return) or (Key = vk_escape) then
    Key := 0;
  if (Key = vk_F1) then
  begin
    Key := 0;
    self.NovaEdtTicketNo.SetFocus;
  end
  else if (Key = vk_F9) and (tbtnExcel.Visible) then // ��Ʊ��ϸ
  begin
    Key := 0;
    tbtnExcelClick(Sender);
  end
  else if (Key = vk_F2) then // �����ӡ
  begin
    ToolButton53Click(Sender);
    Key := 0;
  end
  else if (Key = vk_F3) and (tbtnInsert.Visible) then // �˼�
  begin
    tbtnInsertClick(Sender);
    Key := 0;
  end
  else if (Key = vk_F4) and (GroupBox6.Enabled) then // ����
  begin
    if ChkAddCheck.Checked then
    begin
      ChkAddCheck.Checked := false;
      self.NovaEdtTicketNo.SetFocus;
    end
    else
    begin
      ChkAddCheck.Checked := true;
      self.NovaEdtTicketNo.SetFocus;
    end;
    Key := 0;
  end
  else if (Key = vk_F5) then // ����
  begin
    // tbtnEditClick(Sender);
    tbtnFilterClick(Sender); // ��Ϊ ˢ��
    Key := 0;
  end
  else if (Key = vk_F6) and (tbtnDelete.Visible) then // ȫ��
  begin
    tbtnDeleteClick(Sender);
    Key := 0;
  end
  else if (Key = vk_F7) and (ToolButton50.Visible) then // ���
  begin
    ToolButton50Click(Sender);
    Key := 0;
  end
  else if (Key = vk_F8) then // ȡ������
  begin
    // tbtnInfoClick(Sender);
    tbtn4Click(Sender);
    Key := 0;
  end
  else if (Key = VK_F10) then
  begin
    tbtnCancelClick(Sender);
    Key := 0;
  end
  else if (Key = VK_F12) then
  begin
    Key := 0;
    // grp3.Visible := true;
    NovaHelpEndStation.SetFocus;
  end;
end;

procedure TFrmCheckTicket.FormShow(Sender: TObject);
var
 Ini: TIniFile;
  tmpStringinfo_,fieldnamestr:string;
  tmpStringinfo:TStringBuilder;
    ts:Tstringlist;
    i : Integer;
begin
  inherited;
  if getParametervalue('3028', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    isprintdepartinvoices := true;
  end
  else
  begin
    isprintdepartinvoices := false;
//    if getParametervalue('3087', Sysinfo.LoginUserInfo.OrgID) = '1' then
//      ToolButton2.Enabled := True
//    else
//      ToolButton2.Enabled := False;

  end;
  try
    seatcount := StrToInt(getParametervalue('3029', Sysinfo.LoginUserInfo.OrgID)
      )+1;
    seatwidth := StrToInt(getParametervalue('3030', Sysinfo.LoginUserInfo.OrgID)
      );
    seatheigth := StrToInt(getParametervalue('3031',
        Sysinfo.LoginUserInfo.OrgID));
  except
    seatcount := 11;
    seatwidth := 56;
    seatheigth := 48;
  end;

  if (ToolButton2.Visible) and (ToolButton3.Visible) then
  begin
    try
       checkBillno('FirstBalanceBill');
    except
              on E: Exception do
            begin
              SysLog.WriteErr('���쵥��ʼ����' + E.Message);
            end;
      end;
  end;

  refreshBill;
  if (ToolButton2.Visible) and (ToolButton3.Visible) then
  begin
       refreshBill1;
  end;
  pnlseatplan.Caption := '';
  PlanOnlineSchedule.Caption := '';
  clearScheduleInfo;
  DpDepartDate.Date := now;
  // DpDepartDate.Enabled := false;
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := true;
  dtpfromdatetime.Time := now - 0.08;
  tbtnInfo.Caption:='��ʼ��Ʊ';
  with NovaHCobEntrance do
  begin
    Active := false;
    Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.OrgID;
    Active := true;
    NovaHCobEntrance.CheckAll(true);
  end;
  try
   Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + '\cache\' +sysinfo.LoginUserInfo.UserCode + '.ini');
   fieldnamestr := Ini.ReadString('Entranceinfo', 'entranceinfo', '');
      if Length(fieldnamestr)>0 then      //˵�������ļ��м�¼
      begin
         ts := Tstringlist.Create;
         ts.Delimiter:=',';
         ts.DelimitedText:=fieldnamestr;
         NovaHCobEntrance.CheckAll(false);
          for i:=0 to ts.Count-1 do
          begin
            NovaHCobEntrance.SetCheck(StrToInt(ts.Strings[i]),True);
          end;
      end
      else
        NovaHCobEntrance.CheckAll(true);
  finally
    Ini.Free;
  //            fieldnamestr.Free;
  end;
  tmGetCurInvoinNo.Enabled := true;
  NovaEdtTicketNo.SetFocus;
end;

procedure TFrmCheckTicket.iccardfound(icCard: TBaseCard);
begin
  serialnumber := '';
  if integer(icCard.cardtype) <> 0 then
  begin
    ShowMessage('�ÿ����Ǳ��������������ڱ�����');
  end
  else
  begin

    serialnumber := inttostr(icCard.internalSerialNo);
    NovaEdtCardNo.text := icCard.cardNo;

  end;
end;

procedure TFrmCheckTicket.HandleAuthority(const Key: TGUID; aEnable: boolean);
begin
  inherited;
  //
  if GUIDToString(Key) = '{8A68A0C4-AF0C-4555-A524-45DEAE6C671F}' then
  begin
    tbtnInsert.Visible := aEnable;
    N2.Visible := aEnable;
  end;
  // �ش�
  if GUIDToString(Key) = '{52D22BDD-B432-4C3F-BE3D-9BFC76028389}' then
  begin
    tbtn5.Visible := aEnable;
  end;
  // �ش����˷�����㵥Ȩ��
  if GUIDToString(Key) = '{44610C75-EEE4-4AFE-90E9-10137361857E}' then
  begin
    isreprintotherpermission := aEnable;
  end;
  // ����
  if GUIDToString(Key) = '{7870BA80-4DC9-4087-B7C7-239051217021}' then //
  begin
    ChkAddCheck.Visible := aEnable;
  end;
  // ���
  if GUIDToString(Key) = '{1E6C3D89-AA20-4E2A-98CA-E94DAC86C301}' then //
  begin
    ToolButton50.Visible := aEnable;
  end;
  // ȫ��
  if GUIDToString(Key) = '{5A948E37-5705-46E3-BB89-74108694EEC6}' then //
  begin
    tbtnDelete.Visible := aEnable;
  end;
  // ��ļ쵽��İ��
  if GUIDToString(Key) = '{823406AC-E759-4CB1-95F2-EB69A4B6E4EA}' then //
  begin
    curisauthorlatetocur := aEnable;
  end;

  // �����˼�
  if GUIDToString(Key) = '{F757F7A4-5AA6-429A-AE13-44A2E4049773}' then //
  begin
    ToolButton51.Visible := aEnable;
  end;
  // ��Ʊ��ϸ��Ϣ
  if GUIDToString(Key) = '{36E92E21-B1ED-4E04-9BE3-6BDF4A6CCB5A}' then
  begin
    tbtnExcel.Visible := aEnable;
  end;
  //����Ȩ��
  if GUIDToString(Key) = '{7D99A6FC-846D-492D-99FD-507F67692F18}' then
  begin
    tbtnCancel.Visible := aEnable;
  end;

  // �ؼ�
  if GUIDToString(Key) = '{739BF18A-18B8-4DBC-B5AB-913F4E2FFFA9}' then
  begin
    N1.Visible := aEnable;
  end;
  // �ֹ���

  if GUIDToString(Key) = '{80FAD918-6C36-476D-A68D-C4A007F79545}' then
  begin
    tbtnSave.Visible := aEnable;
  end;
  // �Ѽ�
  if GUIDToString(Key) = '{2AB12F5A-BCDB-4C1E-9D9A-28138CDF0469}' then
  begin
    ischecked := aEnable;
  end;

  // ��Ʊ����Ʊ
  if GUIDToString(Key) = '{D4580F48-71A2-4DDD-8ADE-07A3F5AF03EB}' then
  begin
    noticketcheck := aEnable;
  end;
  // ����
  if GUIDToString(Key) = '{A4C0E08C-3D31-44D3-9C80-F3E2734B9E57}' then
  begin
    tbtnEdit.Visible := aEnable;
  end;
  // ��
  if GUIDToString(Key) = '{E0AD3EDE-48AD-400A-8954-6C1A1CE74CBB}' then
  begin
    TtnTotalCheck.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{55FD0BD1-A269-4DFB-A9E8-E40F033F7AFE}' then
  begin
    ToolButton1.Visible := aEnable;
  end;
  //���쵥
  if GUIDToString(Key) = '{4F9C7945-472A-447E-8950-72C9A4DA7C1D}' then
  begin
    ToolButton2.Visible := aEnable;
  end;
  //�ش���쵥
   if GUIDToString(Key) = '{3B139970-A8A5-4E53-963B-015E13FEDE65}' then
  begin
    ToolButton3.Visible := aEnable;
  end;
  // ��Ʊ��ϸ���� ��ʾ Ʊ�� Ȩ��
  if GUIDToString(Key) = '{C1409D86-EA73-4929-AF7D-C52A9025388E}' then
  begin
    isshowticketno := aEnable;
  end;

end;

procedure TFrmCheckTicket.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jcdsResult do
  begin
    if FieldByName('islinework').AsBoolean then
    begin
      setLineWorkScheduleinfo;
    end
    else
    begin
      setScheduleInfo;
      NovaEdtTicketNo.SetFocus;
    end;
    try
    if FieldByName('isdeparted').AsBoolean then
    begin
      tbtnCancel.Visible := true;
    end;
    except
    on e:Exception do
    begin
      SysDialogs.ShowMessage(e.Message);
    end;
    end;

    if FieldByName('isbegincheck').AsBoolean then
    begin
      tbtnInfo.Caption :='�˳���Ʊ'
    end
    else
     tbtnInfo.Caption :='��ʼ��Ʊ' ;

  end;
end;

procedure TFrmCheckTicket.jcdsResultischeckedChange(Sender: TField);
var
  schplanid:int64;
begin
  inherited;
  schplanid:= jcdsResult.FieldByName('id').AsLargeInt;
  if jcdsResult.FieldByName('ischecked').AsBoolean then
  begin
    if schplanidlist.IndexOf(schplanid) = -1 then
    begin
      schplanidlist.Add(schplanid);
    end;
  end
  else
  begin
    if schplanidlist.IndexOf(schplanid) >= 0 then
    begin
      schplanidlist.Remove(schplanid);
    end;
  end;
end;

procedure TFrmCheckTicket.jscdQryVehicleReportAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not jscdQryVehicleReport.Active then
    exit;
  if jscdQryVehicleReport.RecordCount = 0 then
    exit;
  jscdQryVehicleReportid  :=  jscdQryVehicleReport.FieldByName('id').AsString;
  with jcdsQryCheckticketeds do
  begin
    close;
    Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
      .AsString;

    Params.ParamValues['vehiclereportid'] := jscdQryVehicleReport.FieldByName
      ('id').AsString;
    execute;
    LabOnlineCheckeds.Caption := inttostr(Params.ParamValues['checktickets']);
    LabLineUnCheck.Caption := inttostr(Params.ParamValues['unchecktickets']);
    lbllineOneCardChecketdnum.Caption := Params.ParamValues
      ['oneCardChecktickets'];
    // jscdQryVehicleReport.AfterScroll:=jscdQryVehicleReportAfterScroll;
  end;
  NovaEdtTicketNo.SetFocus;
end;

procedure TFrmCheckTicket.N1Click(Sender: TObject);
var
  nresult, seatno: integer;
  sresult: string;
  // scheduleplanid: int64;
begin

  // ShowMessage(IntToStr(SeatPlan.getFocusCellSeatNo()));
  seatno := SeatPlan.getFocusCellSeatNo();
  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  try
    with jscdAuthCheck do
    begin
      Active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
        .AsLargeInt;
      Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
        ('vehiclereportid').AsLargeInt;
      if ChkAddCheck.Checked then
        Params.ParamValues['islazycheck'] := true
      else
        Params.ParamValues['islazycheck'] := false;
      Params.ParamValues['seatno'] := seatno;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      Params.ParamValues['ticketentrance'] := NovaHCobEntrance.text;
      execute;
      nresult := Params.ParamValues['flag'];
      sresult := Params.ParamValues['msg'];
      if nresult = 1 then
      begin
        setScheduleInfo;
        lbl2.Caption := sresult;
        SeatPlan.locateBySeatNo(seatno);
        NovaEdtTicketNo.SetFocus;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
      end
      else
      begin
        lbl2.Caption := sresult;
        if Pos('δ����', sresult) > 0 then
        begin
          qryScheduleplan();
        end;
        NovaEdtTicketNo.SetFocus;
        if self.isaotoreflash then
          tmrFlash.Enabled := true;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�ؼ����ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmCheckTicket.N2Click(Sender: TObject);
var
  ticketno: string;
  seatno: integer;
begin
  inherited;
  seatno := SeatPlan.getFocusCellSeatNo();
  if SeatPlan.seatsticketno.ContainsKey(seatno) then
  begin
    ticketno := SeatPlan.seatsticketno.Items[seatno];
    cancelCheckticket(ticketno);
  end;
end;

procedure TFrmCheckTicket.N4Click(Sender: TObject);
begin
  inherited;
  //�Ҽ��˵���ȫѡ
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      jcdsResult.AfterScroll:=nil;
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischecked').value := true;
        next;
      end;
      jcdsResult.AfterScroll:=jcdsResultAfterScroll;
      jcdsResult.First;
    end;
  end;
end;

procedure TFrmCheckTicket.N5Click(Sender: TObject);
begin
  inherited;
  //�Ҽ��˵�����ѡ
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      jcdsResult.AfterScroll:=nil;
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischecked').value := not fieldbyname('ischecked').AsBoolean;
        next;
      end;
      jcdsResult.AfterScroll:=jcdsResultAfterScroll;
      jcdsResult.First;
    end;
  end;
end;

procedure TFrmCheckTicket.N6Click(Sender: TObject);
begin
  inherited;
  //�Ҽ��˵���ȡ��
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      jcdsResult.AfterScroll:=nil;
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischecked').value := false;
        next;
      end;
      jcdsResult.AfterScroll:=jcdsResultAfterScroll;
      jcdsResult.First;
    end;
  end;
end;

procedure TFrmCheckTicket.NovaEditcertificateNoEnter(Sender: TObject);
begin
  inherited;
  NovaEditcertificateNo.SelectAll;
end;

procedure TFrmCheckTicket.NovaEdtCardNoChange(Sender: TObject);
var
  log, sresult: string;
  nresult: integer;
begin
  if length(NovaEdtCardNo.text) = Sysinfo.curBillLength.Items['Vehicle'] then
  begin
    if trim(NovaEdtCardNo.text) = '' then
      exit;
    if not checkBillno('BalanceBill') then
      exit;
    // if not jcdsResult.Active then
    // exit;
    // if jcdsResult.RecordCount = 0 then
    // begin
    // tbtnFilterClick(Sender);
    // end;
    log := '���ţ�' + trim(NovaEdtCardNo.text) + '����ˢ�����������';
    SysLog.WriteLog('��Ʊ����->�ۺϼ�Ʊ', 'ˢ������', log);
    with jcdsSetScheduleStatus do
    begin
      Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
        DpDepartDate.Date);
      Params.ParamValues['cardno'] := trim(NovaEdtCardNo.text);
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if nresult = 1 then
      begin
        SysDialogs.ShowMessage(sresult);
      end
      else
      begin
        SysDialogs.Warning('���ţ�' + NovaEdtCardNo.text + sresult);
      end;

    end;
    NovaEdtCardNo.Clear;
  end;

end;

procedure TFrmCheckTicket.NovaEdtCodeKeyPress(Sender: TObject; var Key: Char);
var
  code: string;
begin
  inherited;
  if Key = #13 then
  begin
    // code := NovaEdtCode.text;
    // NovaEdtCode.Clear;
    // grp3.Visible := false;
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    if code = '' then
      exit;
    dbgrdhResult.SelectedRows.CurrentRowSelected := false;
    jcdsResult.Locate('code', code, []);
    dbgrdhResult.SelectedRows.CurrentRowSelected := true;
    NovaEdtTicketNo.SetFocus;
  end;
end;

procedure TFrmCheckTicket.NovaEdtSeatNoKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;
  if Key = #13 then
  begin
    if trim(NovaEdtSeatNo.text) = '' then
      exit;
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    if jcdsResult.FieldByName('islinework').AsBoolean then
    begin
      checkBySeatno(NovaEdtSeatNo.text);
    end
    else
    begin
      lbl2.Caption := '����ˮ�಻��ʹ����ˮ�ż�Ʊ��';
      NovaEdtSeatNo.Clear;
      self.NovaEdtTicketNo.SetFocus;
    end;
  end;
end;

procedure TFrmCheckTicket.NovaEdtTicketNoEnter(Sender: TObject);
begin
  inherited;
  NovaEdtTicketNo.SelectAll;
end;

procedure TFrmCheckTicket.NovaEdtTicketNoKeyPress(Sender: TObject;
  var Key: Char);
var
  templen: integer;
  ischeckticketno:String;
  id:String;
  checkedScheduleplanids : TStringList;//��ѡ��scheduleplanids
  i : Integer;//����listʹ��
  isInSelected : Boolean;//�жϳ�Ʊscheduleplanid�Ƿ��ڹ�ѡ�İ����
begin
  // inherited;
  if Key = #13 then
  begin
    //���Ϊʵ���Ƽ�Ʊ����鿴֤���ź�Ʊ���Ƿ�Ϊ��
    if isrealname then
    begin
        if trim(NovaEditcertificateNo.Text)='' then
        begin
          NovaEditcertificateNo.SetFocus;
          Exit;
        end;
        if trim(NovaEdtTicketNo.Text)='' then
        begin
          NovaEdtTicketNo.SetFocus;
          SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ��������֤����!');
          exit;
        end;
    end;
    
    ischeckticketno:=getParametervalue('3036',SysInfo.LoginUserInfo.OrgID);
    if (ischeckticketno<>'1')  and ( trim(NovaEdtTicketNo.Text) <>'') then
    begin

      if jcdsResult.FieldByName('id').AsString='' then
      begin
        SysDialogs.ShowMessage('��ѡ��ǰ���!');
        exit;
      end;

      SysLog.WriteErr('ischeckticketno='+ischeckticketno);

      with jcdscheckticketno  do
      begin
        Close;
        Params.ParamValues['ticketno']:=trim(NovaEditcertificateNo.Text);
        if isrealname then
        begin
          if trim(NovaEdtTicketNo.Text)='' then
          begin
            SysDialogs.ShowMessage('������֤���ţ�');
            exit;
          end;
          Params.ParamValues['certificateno']:=trim(NovaEdtTicketNo.Text);
        end
        else
        begin
          Params.ParamValues['certificateno']:='';
        end;

        Execute;
        id:=Params.ParamValues['id'];

        //idΪͨ��Ʊ�Ų鵽��scheduleplanid
        if id <> '' then
        begin
          if  schplanidlist.IndexOf(strtoint(id))=-1 then
          begin
            SysDialogs.ShowMessage('��Ʊ�ŵİ�β��ڹ�ѡ�İ���У�');
            exit;
          end;
        end
        else
        begin
          SysDialogs.ShowMessage('��Ʊ�ŵİ�β��ڹ�ѡ�İ���У�');
          exit;
        end;
        jcdsResult.Locate('id', id, []);   //��λ����Ʊ��Ӧ�İ�μƻ���¼
      end;
    end;
    if trim(NovaEdtTicketNo.text) = '' then
      exit;
    //У�鳵Ʊ�ķ���վ�Ƿ�ƥ��
//    if trim(NovaEdtTicketNo.Text)<>'' then
//    begin
//        if not self.VerifyStation(trim(NovaEdtTicketNo.Text)) then
//        begin
//           Exit;
//        end;
//    end;
//    if length(trim(NovaEdtTicketNo.text)) > Sysinfo.curBillLength.Items
//      ['Ticket'] then
//    begin
//      // NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, 3,
//      // length(NovaEdtTicketNo.text));
//      // �����ȡ�ĳ�Ʊ���ȴ���ϵͳƱ�ݳ��ȣ���Ӻ����ȡ������ϵͳ��Ʊ�ݳ���
//      templen := length(trim(NovaEdtTicketNo.text))
//        - Sysinfo.curBillLength.Items['Ticket'];
//      NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen + 1,
//        length(NovaEdtTicketNo.text));
//    end;
    // ����һ�����������жϵ�ǰƱ�źͷ�������ȷ���ĳ�Ʊ���Ƿ�Ψһ
    isOnlyByticketnoAnddepartdate(trim(NovaEdtTicketNo.text),
      trim(formatdatetime('yyyy-mm-dd', DpDepartDate.Date)),trim(NovaEditcertificateNo.Text));
    // if(isOnlyByticketnoAnddepartdate(trim(NovaEdtTicketNo.text),trim(formatdatetime('yyyy-mm-dd',DpDepartDate.Date)))) then
    // begin
    // checkByticketno(trim(NovaEdtTicketNo.text));
    // end
    // else
    // ShowMessage('checkbyid');
    // ���ж�Ʊ�ų��ȣ�������Ȳ��ԣ���ʾ���ó�Ʊ�����ڣ�����˲���������
    // if length(trim(NovaEdtTicketNo.text)) = Sysinfo.curBillLength.Items
    // ['Ticket'] then
    // begin
    // checkByticketno(trim(NovaEdtTicketNo.text));
    // end
    // else
    // begin
    // SysDialogs.Warning('�������Ʊ�ų��Ȳ��ԣ�');
    // end;
  end;
end;

procedure TFrmCheckTicket.NovaEdtTicketNoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if ((jcdsResult.Active) and (jcdsResult.RecordCount > 0)) then
  begin
    if Key = 40 then // ����
    begin
      if not jcdsResult.Eof then
      begin
        dbgrdhResult.SelectedRows.CurrentRowSelected := false;
        jcdsResult.next;
        dbgrdhResult.SelectedRows.CurrentRowSelected := true;
      end;
    end
    else if Key = 38 then // ����
    begin
      if not jcdsResult.Bof then
      begin
        dbgrdhResult.SelectedRows.CurrentRowSelected := false;
        jcdsResult.Prior;
        dbgrdhResult.SelectedRows.CurrentRowSelected := true;
      end;
    end;
  end;
end;

procedure TFrmCheckTicket.NovaHCobEntranceExit(Sender: TObject);
var
  Ini: TIniFile;
  tmpStringinfo_,fieldnamestr:string;
  tmpStringinfo:TStringBuilder;
  textStringinfo: Tstringlist;
  ts:Tstringlist;
  j, i : Integer;
begin
  inherited;
     Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + '\cache\' +sysinfo.LoginUserInfo.UserCode + '.ini');
     fieldnamestr := Ini.ReadString('Entranceinfo', 'entranceinfo', '');
     tmpStringinfo := TStringBuilder.Create;

     // ���ı����ֵת��list Ϊ�洢�ļ��ж���׼��
     textStringinfo := Tstringlist.Create;
     textStringinfo.Delimiter := ';'; // ���÷ָ���
     textStringinfo.DelimitedText := NovaHCobEntrance.text; // ���ô��ָ���ַ���
     for i := 0 to textStringinfo.Count - 1 do
     begin
       for j := 0 to NovaHCobEntrance.Items.Count do
       begin
         // if NovaHCobEntrance.Items[NovaHCobEntrance.ItemIndex] then
         // SysDialogs.ShowMessage(NovaHCobEntrance.Items[j]);

         if (NovaHCobEntrance.Items[j]) = textStringinfo.Strings[i] then
         begin
           tmpStringinfo.Append(j).Append(',');

         end;

       end;
     end;
     // Delete(tmpStringinfo,Length(tmpStringinfo.ToString),1);
     // tmpStringinfo_:= Copy(tmpStringinfo.ToString,2,Length(tmpStringinfo.ToString)-2);
     Ini.WriteString('Entranceinfo', 'entranceinfo', tmpStringinfo.tostring);
end;

procedure TFrmCheckTicket.NovaHelpEndStationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (NovaHelpEndStation.text <> '') and
    (NovaHelpEndStation.Id > 0) then
  begin
    qryScheduleplan();
  end;
end;

procedure TFrmCheckTicket.NovaHelpScheduleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (Key = #13) and (NovaHelpSchedule.text <> '') and
    (NovaHelpSchedule.Id > 0) then
  begin
    qryScheduleplan();
  end;
end;

procedure TFrmCheckTicket.nvdbgrdhcodelistCellClick(Column: TColumnEh);
begin
  inherited;
  NovaEdtTicketNo.SetFocus;
end;

procedure TFrmCheckTicket.nvdbgrdhcodelistDblClick(Sender: TObject);
begin
  inherited;
  jscdQryVehicleReportAfterScroll(jscdQryVehicleReport);
end;

procedure TFrmCheckTicket.nvdbgrdhcodelistDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
      With nvdbgrdhcodelist do
       begin
          nvdbgrdhcodelist.Canvas.pen.mode:=pmmask;
          DefaultDrawColumnCell(Rect, DataCol, Column, State);
       end;

end;

procedure TFrmCheckTicket.onlydepartSch;
var
  vehiclereportid, scheduleplanid: int64;
  nresult: integer;
  sresult: string;
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�δ������');
    exit;
  end;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('�ð���Ѿ����࣡');
    exit;
  end;
  if not jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    if (LabUnCheckeds.Caption <> '') and (StrToInt(LabUnCheckeds.Caption) > 0)
      then
    begin
      if not SysDialogs.Confirm('��ʾ��Ϣ',
        '�ð�λ���' + LabUnCheckeds.Caption + '��δ�쳵Ʊ��ȷ�Ͻ��з��������') then
      begin
        exit;
      end;
    end
    else if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ��з��������') then
    begin
      exit;
    end;
  end
  else if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ��з��������') then
  begin
    exit;
  end;
  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jscdQryVehicleReport.Active then
      exit;
    if jscdQryVehicleReport.RecordCount = 0 then
      exit;
    vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  end
  else
  begin
    vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  end;
  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

  with jscdSchDepartinvoice do
    try
      Active := false;
      Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        lbl2.Caption := sresult;
        dtpfromdatetime.Time := now - 0.08;
        qryScheduleplan(scheduleplanid);
        NovaEdtTicketNo.SetFocus;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�������ʧ�ܣ�' + E.Message);
      end;
    end;
end;

procedure TFrmCheckTicket.qryScheduleplan(scheduleplanid: int64);
var
  ticketentrance,checkedstationid: string;
  tempList: TList<int64> ;//��¼�ϴι�ѡ�İ�����ڴ˴β�ѯ���Ľ���еļ�¼������ϴ�ѡ�еļ�¼���˴�û�в�ѯ������Ӧ���Ƴ�
  I : Integer;//����ʹ��
begin
  inherited;
  // if not flag1 then
  // begin
  if NovaHCobEntrance.text = '' then
  begin
    SysDialogs.ShowMessage('��ѡ���Ʊ��');
    exit;
    // end;

  end;

  jcdsResult.AfterScroll := nil;

//  ������ģ������ѯ��ȡ����ѡ�����ע��
//  if schplanidlist <> nil then
//    schplanidlist.Clear;

  with jcdsResult do
  begin
    Active := false;
    // if flag1 then
    // begin
    // Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
    // Now);
    // end
    // else
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      DpDepartDate.Date);
    Params.ParamValues['reportorgid'] := Sysinfo.LoginUserInfo.OrgID;
    Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;

    if (NovaHCobEntrance.text <> '') then
    begin
      ticketentrance := NovaHCobEntrance.GetSelectID;
      // ticketentrance:='('+StringReplace(ticketentrance,';',',',[rfReplaceAll])+')';
      Params.ParamValues['filter_INS_ta!id'] := ticketentrance;
    end
    else
    begin
      Params.ParamValues['filter_INS_ta!id'] := null;
    end;

    {if (nvcbbstation.text <> '') then
    begin
      checkedstationid := nvcbbstation.GetSelectID;
      // ticketentrance:='('+StringReplace(ticketentrance,';',',',[rfReplaceAll])+')';
      Params.ParamValues['filter_INS_ss!departstationid'] := checkedstationid;
    end
    else
    begin
      Params.ParamValues['filter_INS_ss!departstationid'] := '('+inttostr(Sysinfo.LoginUserInfo.StationID)+')';
    end;   }
    Params.ParamValues['filter_EQL_ss!departstationid'] := sysinfo.LoginUserInfo.StationID;

    if (NovaHelpEndStation.Id > 0) and (trim(NovaHelpEndStation.text) <> '')
      then
      Params.ParamValues['filter_EQL_sp!endstationid'] := NovaHelpEndStation.Id
    else
      Params.ParamValues['filter_EQL_sp!endstationid'] := null;
    if (NovaHelpSchedule.Id > 0) and (trim(NovaHelpSchedule.text) <> '')
      then
      Params.ParamValues['filter_EQL_sp!scheduleid'] := NovaHelpSchedule.Id
    else
      Params.ParamValues['filter_EQL_sp!scheduleid'] := null;
    if (ChkIsReproted.Checked) then
      Params.ParamValues['filter_EQB_ss!isreported'] := true
    else
      Params.ParamValues['filter_EQB_ss!isreported'] := null;

    if ChkIsdepart.Checked then
      Params.ParamValues['filter_EQB_ss!isdeparted'] := false
    else
      Params.ParamValues['filter_EQB_ss!isdeparted'] := null;
    if dtpfromdatetime.Checked then // and (not flag1)
    begin
      Params.ParamValues['filter_GES_ss!departtime'] := formatdatetime('hh:mm',
        dtpfromdatetime.Time)
    end
    else
      Params.ParamValues['filter_GES_ss!departtime'] := null;
    if (cbbNvehicleno.Id>0) and (Trim(cbbNvehicleno.Text)<> '') then
        Params.ParamValues['filter_EQL_vr!vehicleid'] := cbbNvehicleno.Id
    else
        Params.ParamValues['filter_EQL_vr!vehicleid'] := null;
    try
    Active := true;
    except on e:Exception do
      ShowMessage(e.Message);
    end;
    if RecordCount > 0 then
    begin
      //������ģ������ѯ����ȡ��֮ǰ�Ĺ�ѡ
      with jcdsResult do
      begin
        try
          //tempList���������򴴽������������
          if (tempList = nil) then
            tempList := TList<Int64>.Create
          else
            tempList.Clear;

          DisableControls;
          first;
          while not eof do
          begin
            if schplanidlist.IndexOf(jcdsResult.FieldByName('id').AsInteger) >= 0 then
            begin
              //�������¼�еİ�μƻ�id������ϴι�ѡѡ�е�schplanidlist�У���ֵΪѡ��
              try
                jcdsResult.Edit;
                jcdsResult.FieldByName('ischecked').Value := 'True';
                tempList.add(jcdsResult.FieldByName('id').AsInteger);//�����ι��еļ�¼���뵽tempList��
              except
              on e : Exception do
                SysLog.WriteErr('�����ѯ���Զ���ѡ�ϴι�ѡ����쳣��' + e.Message);
              end;
//              jcdsResult.CanEdit := False;
            end;
            Next;
          end;
        finally
          EnableControls;
        end;
      end;
      for I := 0 to schplanidlist.Count - 1 do
      begin
        if (tempList.IndexOf(schplanidlist[I]) = -1) then
        begin
          schplanidlist.Remove(schplanidlist[I]);
          //�ϴι�ѡ�Ĳ��ڱ��β�ѯ���Ľ���У�����Ҫ�Ƴ����������û����ʾ��Σ�Ҳ���Լ�Ʊ������
        end;
      end;

      ToolButton50.Enabled := true; ;
      jcdsResult.Locate('id', scheduleplanid, []);
      // lbl2.Caption:='aaaaaaaaa'+IntToStr(scheduleplanid) ;
      dbgrdhResult.SelectedRows.CurrentRowSelected := true;
      if FieldByName('islinework').AsBoolean then
        setLineWorkScheduleinfo
      else
        setScheduleInfo;
    end
    else
    begin
      ToolButton50.Enabled := false;

    end;
    NovaEdtTicketNo.SetFocus;
  end;

  jcdsResult.AfterScroll := jcdsResultAfterScroll;
  jcdsResult.AfterScroll(nil);
end;

procedure TFrmCheckTicket.refreshBill;
begin
  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin
    lblBillno.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    lblBillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['BalanceBill']);
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    lblBillno.Caption := '';
    lblBillnum.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    // SysDialogs.Warning('�����ý��㵥�ţ�');
    // self.Close;
  end;
end;

procedure TFrmCheckTicket.refreshBill1;
begin
  //SysDialogs.ShowMessage('refresh!!!!');
  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('FirstBalanceBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('FirstBalanceBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['FirstBalanceBill'] > 0) then
  begin
    lblBillno1.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['FirstBalanceBill'];
    lbllBillnum1.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['FirstBalanceBill']);
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    lblBillno1.Caption := '';
    lbllBillnum1.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    // SysDialogs.Warning('�����ý��㵥�ţ�');
    // self.Close;
  end;
end;

procedure TFrmCheckTicket.qryScheduleplan;
var
  curid: int64;
begin
  inherited;
  // if not flag1 then
  // begin
  if IsControlCheck and (NovaHCobEntrance.Items.Count = 0) then
  begin
    SysDialogs.Warning('��ǰ������δ���ü�Ʊ�ڿ�����Ϣ��');
    exit;
    // end;
  end;
  curid := 0;
  if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    // lbl2.Caption:=IntToStr(curid);
  end;
  qryScheduleplan(curid);
end;

procedure TFrmCheckTicket.setLineWorkScheduleinfo;
var
  curreportid, scheduleplanid: int64;
begin
  // tbtnDelete.Enabled := false;
  PcScheduleInfo.ActivePageIndex := 1;
  with jcdsResult do
  begin
    LabOnDepartdate.Caption := FieldByName('departdate').AsString;
    LabOnCode.Caption := FieldByName('code').AsString;
    LabOnReachStation.Caption := FieldByName('endstation').AsString;
    LabOnEntrance.Caption := FieldByName('ticketentrance').AsString;
    LabOnBusPark.Caption := FieldByName('buspark').AsString;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
//    LabLineUnCheck.Caption := inttostr(checktickethelp.unchecktickets);
//    LabOnlineCheckeds.Caption := inttostr(checktickethelp.checktickets);
    LabOnlineCheckeds.Caption := jcdsResult.FieldByName('checkeds').AsString;
    LabLineUnCheck.Caption := inttostr(jcdsResult.FieldByName('soldeatnum').AsLargeInt-jcdsResult.FieldByName('checkeds').AsLargeInt);

  end;
  if (jscdQryVehicleReport.Active) and (jscdQryVehicleReport.RecordCount > 0)
   then
     curreportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  with jscdQryVehicleReport do
  begin
    Active := false;
    jscdQryVehicleReport.AfterScroll := nil;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      DpDepartDate.Date);
    if chkReportIsDepart.Checked then
      Params.ParamValues['isdeparted'] := true
    else
      Params.ParamValues['isdeparted'] := false;
    Active := true;
   if (jscdQryVehicleReport.Active) and (jscdQryVehicleReport.RecordCount > 0) then
   begin
       LabOnlineCheckeds.Caption := jscdQryVehicleReport.FieldByName('tickets').AsString;
   end;
//    if (jscdQryVehicleReport.Active) and (jscdQryVehicleReport.RecordCount > 0)
//      then
//      curreportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;

    // jscdQryVehicleReportAfterScroll(dsVehicleReport.DataSet);
    jscdQryVehicleReport.AfterScroll := jscdQryVehicleReportAfterScroll;
    // ��ˮ���Ʊ�󣬻�ȡ�����ĳ�����������ˮ�ඨλ���ü�Ʊ������
//    if reprotid <> '' then
//      jscdQryVehicleReport.Locate('id', reprotid, [])
//    else
//      jscdQryVehicleReport.Locate('id', curreportid, []);
    if jscdQryVehicleReportid <> '' then
      jscdQryVehicleReport.Locate('id', jscdQryVehicleReportid, [])
    else
      jscdQryVehicleReport.Locate('id', curreportid, []);
    reprotid := '';
  end;
end;

// ���÷���ˮ�����ʾ��Ϣ
procedure TFrmCheckTicket.setScheduleInfo;
var
  planvehiclebrandmodelid: int64;
begin
  PcScheduleInfo.ActivePageIndex := 0;
  if not jcdsResult.Active then exit;
  if jcdsResult.RecordCount=0 then exit;
    
  with jcdsResult do
  begin
    checktickethelp.qryScheduleSeatstatus
      (jcdsResult.FieldByName('id').AsLargeInt);
    checktickethelp.qrySeatstatus(jcdsResult.FieldByName('id').AsLargeInt,
      isshowseathint);

    LabUnCheckeds.Caption := inttostr(checktickethelp.unchecktickets);
    LabCheckeds.Caption := inttostr(checktickethelp.checktickets);

    if ((not jcdsResult.FieldByName('islinework').AsBoolean)
        and jcdsResult.FieldByName('isreported').AsBoolean) or
      (jcdsResult.FieldByName('islinework')
        .AsBoolean and jscdQryVehicleReport.Active and
        (jscdQryVehicleReport.RecordCount > 0)) then
    begin
      with jcdsQryCheckticketeds do
      begin
        close;
        Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
          .AsLargeInt;
        if jcdsResult.FieldByName('islinework').AsBoolean then
          Params.ParamValues['vehiclereportid'] :=
            jscdQryVehicleReport.FieldByName('id').AsString
        else
          Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
            ('vehiclereportid').AsString;
        execute;
        lblOneCardChecketdnum.Caption := Params.ParamValues
          ['oneCardChecktickets']
      end;
    end
    else
    begin
      lblOneCardChecketdnum.Caption := '0';
    end;
    planvehiclebrandmodelid := jcdsResult.FieldByName('planvehiclebrandmodelid')
      .AsLargeInt;
    if not Assigned(SeatPlan) then
    begin
      SeatPlan := TSeatPlanChecked.Create(pnlseatplan);
      SeatPlan.ShowHint := isshowseathint;
      SeatPlan.PopupMenu := pm1;
      SeatPlan.defaultcellwidth := seatwidth;
      SeatPlan.defaultcellheight := seatheigth;
      SeatPlan.defaultcolcount := seatcount;
      SeatPlan.setShowspacename(false);
      SeatPlan.selectSeatStatus := checktickethelp.selectSeatStatus;
      // ��ѡ����λ
      SeatPlan.seatsStatus := checktickethelp.seatsStatus;
      SeatPlan.seatsTickettype := checktickethelp.seatsTickettype;
      SeatPlan.seatsticketno := checktickethelp.seatticketno;
      SeatPlan.seatsreachstationname := checktickethelp.seatStation;
      SeatPlan.seatscolor := checktickethelp.seatscolor;
      if isshowseathint then
        SeatPlan.seatshint := checktickethelp.seatshint;
      if isMouseCheckticket then
        SeatPlan.OnDbClickSeat := clickseat;
      with SeatPlan do
      begin
        setParent(self.pnlseatplan);
        Align := alClient;
      end;
    end;
    if planvehiclebrandmodelid > 0 then
    begin
      SeatPlan.brandModelid := planvehiclebrandmodelid;
    end
    else
    begin
      SeatPlan.brandModelid := 0;
    end;
    SeatPlan.Refresh;

    self.LabDepartDate.Caption := FieldByName('departdate').AsString;
    self.LabDepartTime.Caption := FieldByName('departtime').AsString;
    self.LabCode.Caption := FieldByName('code').AsString;
    self.LabBusPark.Caption := FieldByName('buspark').AsString;
    self.LabEndStation.Caption := FieldByName('endstation').AsString;
    LabChildnum.Caption := FieldByName('carrychildnum').AsString;
  end;
end;

procedure TFrmCheckTicket.tbtn4Click(Sender: TObject);
var
  reportid, curid: int64;
  nresult: integer;
  sresult: string;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
    exit;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    lbl2.Caption := '�ð�λ�δ���࣡';
    exit;
  end;
  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    if (not jscdQryVehicleReport.Active) or
      (jscdQryVehicleReport.RecordCount = 0) then
      exit;
    if (not jscdQryVehicleReport.FieldByName('isdeparted').AsBoolean) then
    begin
      lbl2.Caption := '�ð�λ�δ���࣡';
      exit;
    end;
    reportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  end
  else
    reportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  curid := jcdsResult.FieldByName('id').AsLargeInt;
  try
    with jscdcancelDepartinvoices do
    begin
      Active := false;
      Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := curid;
      Params.ParamValues['vehiclereportid'] := reportid;
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        // SysDialogs.ShowMessage(sresult);
        lbl2.Caption := sresult;
        qryScheduleplan(curid);
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('ȡ������ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmCheckTicket.tbtn5Click(Sender: TObject);
var  msg1:String;
begin
  inherited;
  if not checkBillno('BalanceBill') then
    exit;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
    with jcdssecurityisture do
    begin
      active:=false;
      Params.ParamValues['vehiclereportid']:=jcdsResult.FieldByName('vehiclereportid').AsString ;
      Execute;
      msg1:=Params.ParamValues['msg1'];
    end;
  if  (msg1='securityisfalse')
     and ((getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0')) then
     begin
       SysDialogs.ShowMessage('�ó����첻�ϸ񣬲������ش�');
        exit;
     end;

  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�δ������');
    exit;
  end;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�δ���࣡');
    exit;
  end;
  if not isreprintotherpermission then   //�鿴�Ƿ��д�ӡ���˽��㵥Ȩ��
  begin
    with jcdsCheckPrintPermission do
    begin
      Active := false;
      Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
        ('vehiclereportid').AsString;
      Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
        .AsString;
      Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('scheduleid')
        .AsString;
      Params.ParamValues['departdate'] := jcdsResult.FieldByName('departdate')
        .AsString;
      Execute;
      if Params.ParamValues['printpermission'] = 0 then
      begin
        SysDialogs.Warning('û���ش����˽��㵥Ȩ�ޣ�');
        exit;
      end;

    end;
  end;

  if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ����ش������') then
  begin
    exit;
  end;

  FrmReprintByOldOrNewBillno := TFrmReprintByOldOrNewBillno.Create(self);
  try
    with FrmReprintByOldOrNewBillno do
    begin
      Caption := '�ش���㵥';
      if SysMainForm.showFormModal(FrmReprintByOldOrNewBillno, false)
        = mrok then
      begin
        if isprintbynewbillno = 1 then
        begin
          isprintbynewticketno := false;
        end
        else if isprintbynewbillno = 2 then
        begin
          isprintbynewticketno := true;
        end
        else
        begin
          exit;
        end;
      end;
    end;
  finally
    FreeAndNil(FrmReprintByOldOrNewBillno);
  end;

  departSchImpl(Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'], true,
    true);
end;

procedure TFrmCheckTicket.tbtnCancelClick(Sender: TObject);
var  msg1:String;
begin
  inherited;
//   if (getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0') and
//       ((jcdsResult.FieldByName('ischeckresult').AsString <> '0') or
//        (jcdsResult.FieldByName('ischeckresult').AsString <> '2')) then
//        exit;
  with jcdssecurityisture do
  begin
     active:=false;
     Params.ParamValues['vehiclereportid']:=jcdsResult.FieldByName('vehiclereportid').AsString ;
     Execute;
     msg1:=Params.ParamValues['msg1'];
  end;
  if  (msg1='securityisfalse')
     and ((getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '0')) then
     begin
        SysDialogs.ShowMessage('�ó����첻�ϸ񣬲���������');
        exit;
     end;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  with FrmDepartManagerEdit do
  begin
    FrmDepartManagerEdit := TFrmDepartManagerEdit.Create(self);
    Caption := '�������㵥';
    sign := true;
    //�������㵥��ʱ���Ƿ���д��ƱԱ 0:�� 1:��
    if (getParametervalue('3066', Sysinfo.LoginUserInfo.OrgID) = '0') then
    begin
      nvhlpseller.Visible := False;
      Label3.Visible := False;
    end else
    begin
      nvhlpseller.Visible := True;
      Label3.Visible := True;
    end;
    scheduleplanid := jcdsResult.FieldByName('id').AsString;
    isdepartinvoices := '0';
    if jcdsResult.FieldByName('islinework').AsBoolean then
    begin
      if not jscdQryVehicleReport.Active then
        exit;
      if jscdQryVehicleReport.RecordCount = 0 then
        exit;
      reportvehicleid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    end
    else
      reportvehicleid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
    if SysMainForm.showFormModal(FrmDepartManagerEdit, false) = mrok then
    begin
      ChkAddCheck.Checked := false;
      tbtnFilterClick(self);
    end;
  end;
end;

procedure TFrmCheckTicket.tbtnDeleteClick(Sender: TObject);
var
  nresult, Count: integer;
  sresult,checkedstationid: string;
  curid: int64;
begin
  inherited;
  //���Ϊʵ���Ƽ�Ʊ����У��
  if isrealname then
  begin
      SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ������ȫ�죡');
      exit;
  end;
  // ȫ�����
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�û������');
    NovaEdtTicketNo.SetFocus;
    exit;
  end;
  if (jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('�ð���Ѿ����࣡');
    exit;
  end;
  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    SysDialogs.Warning('��ˮ��β���ʹ��ȫ�������');
    NovaEdtTicketNo.SetFocus;
    exit;
  end;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ����ȫ�������') then
    exit;
  try
    with jcsdCheckallTickets do
    begin
      Active := false;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName
        ('vehiclereportid').AsString;
      Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
        .AsString;
      Params.ParamValues['ticketentrance'] := NovaHCobEntrance.text;
      if (nvcbbstation.text <> '') then
      begin
        checkedstationid := nvcbbstation.GetSelectID;
        Params.ParamValues['filter_INS_t!departstationid'] := checkedstationid;
      end
      else
      begin
        Params.ParamValues['filter_INS_t!departstationid'] := null;
      end;
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        Count := Params.ParamByName('checktickets').Value;
        lbl2.Caption := 'ȫ��ɹ���ѡ�з���վ������' + inttostr(Count) + '��Ʊ��';
        qryScheduleplan(curid);
      end
      else
      begin
        SysDialogs.Warning(sresult);
        NovaEdtTicketNo.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('ȫ�����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmCheckTicket.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
   if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  curid := 0;
  //���Ϊʵ���Ƽ�Ʊ����У��
  if isrealname then
  begin
      SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ���������죡');
      exit;
  end;
  // �������
  FrmChecktickets := TFrmChecktickets.Create(self);
  try
    with FrmChecktickets do
    begin
      Caption := '��Ʊ����';
      if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
      begin
        curid := jcdsResult.FieldByName('id').AsLargeInt;
        inputdepartstationid:= nvcbbstation.GetSelectID;
        if (jcdsResult.FieldByName('islinework').AsBoolean) and
          (jscdQryVehicleReport.Active) and
          (jscdQryVehicleReport.RecordCount > 0) then
        begin
          vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
          curid := jscdQryVehicleReport.FieldByName('scheduleplanid')
            .AsLargeInt;
        end
        else
        begin
          vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
          curid := jcdsResult.FieldByName('id').AsLargeInt;
        end;
      end;
      if SysMainForm.showFormModal(FrmChecktickets, false) = mrok then
      begin
        lbl2.Caption := '��Ʊ����ɹ�';
        lbl2.Refresh;
        qryScheduleplan(curid);
      end;
    end;
  finally
    FreeAndNil(FrmChecktickets);
  end;
end;

procedure TFrmCheckTicket.tbtnExcelClick(Sender: TObject);
var
  reportid: int64;
begin
  // inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
    exit;

  FrmCheckticketInfo := TFrmCheckticketInfo.Create(self);
  with FrmCheckticketInfo do
  begin
    // ��ʾƱ��Ȩ��
    isshowticketnos := isshowticketno;
    if jcdsResult.FieldByName('islinework').AsBoolean then
    begin
      isworkline := true;
      { if not jscdQryVehicleReport.active then
        exit;
        if jscdQryVehicleReport.RecordCount = 0 then
        exit; }
      if (jscdQryVehicleReport.Active) and
        (jscdQryVehicleReport.RecordCount > 0) then
        vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    end;
    Caption := '����������Ʊ��Ϣ';
    chkNotChecked.Visible := ischecked;
    chkChecked.Checked := true;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    NovaEdtRoute.text := jcdsResult.FieldByName('routename').AsString;
    NovaEdtCode.text := jcdsResult.FieldByName('code').AsString;
    FrmCheckticketInfo.bbtnSave.Visible := noticketcheck;
    SysMainForm.showFormModal(FrmCheckticketInfo);
    tbtnFilterClick(self);
  end;
  self.NovaEdtTicketNo.SetFocus;
end;

procedure TFrmCheckTicket.tbtnFilterClick(Sender: TObject);
begin
  qryScheduleplan();
end;

procedure TFrmCheckTicket.tbtnInfoClick(Sender: TObject);
var  departstationid, vehiclereportid__,scheduleplanid: Integer;
   isbegincheck_,islinework:Boolean;
begin
  //inherited;
  if ( not  jcdsResult.Active) or (jcdsResult.RecordCount <= 0) then
  begin
    Exit;
  end;
  scheduleplanid := jcdsResult.FieldByName('id').AsInteger;
  departstationid := jcdsResult.FieldByName('departstationid').AsInteger;
  vehiclereportid__:=jcdsResult.FieldByName('vehiclereportid').AsInteger;
  islinework:=jcdsResult.FieldByName('islinework').AsBoolean;
  isbegincheck_ :=  jcdsResult.FieldByName('isbegincheck').AsBoolean;
  if vehiclereportid__<=0 then   //δ����
  begin
    SysDialogs.ShowMessage('�ð�λ�û�б���,���ܽ����Ʊ!');
    exit;
  end;

  with jsonchangeticketstatus do // �����Ʊ
  begin
    Active := False;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['departstationid'] := departstationid;
    if(isbegincheck_) then
      Params.ParamValues['isbegincheck'] := False
    else
      Params.ParamValues['isbegincheck'] := true;
    execute;
    if Params.ParamValues['flag'] = 1 then
    begin
  //      queryticket(scheduleplanid);
  //      Button7Click(Sender);
      // Locate('id', scheduleplanid, [])
      jcdsResult.Locate('id', scheduleplanid, []);
      qryScheduleplan(scheduleplanid);
    end
    else
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
  end;
end;

procedure TFrmCheckTicket.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  curid := 0;
  // �˼����
  FrmCancelCheckticket := TFrmCancelCheckticket.Create(self);
  try
    with FrmCancelCheckticket do
    begin
      Caption := '��Ʊ�˼����';
      isrealnamemix:=isrealname;
      if isrealnamemix then
      begin
        Label1.Visible:=True;
        edtcertificateno.Visible:=True;
      end;
      inputdepartstationid := nvcbbstation.Text;
      if SysMainForm.showFormModal(FrmCancelCheckticket, false) = mrok then
      begin
        curid := Id;
        self.lbl2.Caption := sresult;
        self.lbl2.Update;
        qryScheduleplan(curid);
        self.NovaEdtTicketNo.SetFocus;
      end;
    end;
  finally
    FreeAndNil(FrmCancelCheckticket);
  end;
end;

procedure TFrmCheckTicket.tbtnPrinterClick(Sender: TObject);
var
  curid: int64;
begin
  // inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if jcdsResult.FieldByName('islinework').AsBoolean then
    exit;
  // �㲥
  FrmBroadcast := TFrmBroadcast.Create(self);
  try
    with FrmBroadcast do
    begin
      Caption := '��ι㲥';
      departtime := LabDepartTime.Caption;
      ticketentrance := jcdsResult.FieldByName('ticketentrance').AsString;
      vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
      routename := jcdsResult.FieldByName('routename').AsString;
      departdate := jcdsResult.FieldByName('departdate').AsString;
      jianpin := jcdsResult.FieldByName('jianpin').AsString;
      NovaHelpSchedule.text := LabCode.Caption;
      lccontent := '�ÿ���:  ' + LabDepartTime.Caption + ' ����  ' +
        LabEndStation.Caption + ' �� ' + ticketentrance + ' �Ŵ�����Ʊ';
      MeContent.text := 'ǰ��' + LabEndStation.Caption + '������ÿ���ע�⣬��������' +
        LabCode.Caption + '�Σ�' + LabDepartTime.Caption + '�೵�������������뵽' +
        ticketentrance + '�ż�Ʊ�ڼ�Ʊ�ϳ���лл��';
      if SysMainForm.showFormModal(FrmBroadcast, false) = mrok then
      begin
        // qryScheduleplan(curid);
      end;
    end;
  finally
    FreeAndNil(FrmBroadcast);
  end;
end;

procedure TFrmCheckTicket.tbtnSaveClick(Sender: TObject);
var
  curno: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  FrmHandInvoicesNo := TFrmHandInvoicesNo.Create(self);
  try
    with FrmHandInvoicesNo do
    begin
      Caption := '�����ֹ�������Ϣ';
      if SysMainForm.showFormModal(FrmHandInvoicesNo, false) = mrok then
      begin
        curno := trim(NovaEdtInvoicesNo.text);
        departSch(curno, false);
      end;
    end;
  finally
    FreeAndNil(FrmHandInvoicesNo);
  end;

end;

procedure TFrmCheckTicket.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmCheckTicket.tmrFlashTimer(Sender: TObject);
begin
  inherited;
  qryScheduleplan();
end;

procedure TFrmCheckTicket.ToolButton1Click(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  //���Ϊʵ���Ƽ�Ʊ����У��
  if isrealname then
  begin
      SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ������Զ�죡');
      exit;
  end;
  curid := 0;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  FrmRemoteCheckTicket := TFrmRemoteCheckTicket.Create(self);
  try
    with FrmRemoteCheckTicket do
    begin
      Caption := 'Զ�̼�Ʊ����';
      dtpDepartdate.Time:=DpDepartDate.Time;
      if (jcdsResult.FieldByName('islinework').AsBoolean) then
      begin
        if not jscdQryVehicleReport.Active then
          exit;
        if jscdQryVehicleReport.RecordCount = 0 then
          exit;
        reportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
        vehicleno := jscdQryVehicleReport.FieldByName('vehicleno').AsString;
      end
      else
      begin
        reportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
        vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
      end;

      if SysMainForm.showFormModal(FrmRemoteCheckTicket, false) = mrok then
      begin
        self.lbl2.Caption := sresult;
        self.lbl2.Update;
        qryScheduleplan(curid);
        self.NovaEdtTicketNo.SetFocus;
      end;
    end;
  finally
    FreeAndNil(FrmRemoteCheckTicket);
  end;

end;

procedure TFrmCheckTicket.ToolButton2Click(Sender: TObject);
var
  multipleValueValue: TDictionary<String, String>;
  templtename,vehicleno,sresult: string;
  vehiclereportid,scheduleplanid,vehicleid,departinvoicesid: Largeint;
  nresult ,totalnum: Integer;
  islinework : Boolean;
  reachstationids,ticketnums:String;
//  vehiclereportid, scheduleplanid:Int64;

begin
  inherited;
   reachstationids:='';
  ticketnums:='';
  //��ӡ���쵥
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
  if getParametervalue('3028', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
    if getParametervalue('3087', Sysinfo.LoginUserInfo.OrgID) = '0' then
      exit;

      //����ˮ�� û�з��� �������ӡ
    if ((jcdsResult.FieldByName('isdeparted').asboolean) = False) and
    ((jcdsResult.FieldByName('islinework').asboolean) = False) then
    begin
      SysDialogs.Warning('�ð��δ���࣬���ɴ�ӡ���쵥!');
      exit;
    end;

//    SysDialogs.ShowMessage(jcdsFirstCheckSave.FieldByName('').AsString);
    islinework := jcdsResult.FieldByName('islinework').asboolean;
    vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;


    if islinework and (not jscdQryVehicleReport.Active) then
    Exit;

    //SysDialogs.ShowMessage(jscdQryVehicleReport.FieldByName('id').AsString + ':id---isdeparted:'
    //  + jscdQryVehicleReport.FieldByName('isdeparted').AsString);
    //������ˮ���Ƿ��ѷ���
    if islinework and (jscdQryVehicleReport.FieldByName('isdeparted').AsBoolean = False) then
    begin
      SysDialogs.Warning('�ð��δ���࣬���ɴ�ӡ���쵥!');
      exit;
    end;

    if (jcdsResult.FieldByName('islinework').AsBoolean) then
    begin
      vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    end
    else
    begin
      vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
    end;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

    templtename := TNovaPrint.GetTicketModelName('���쵥', '���쵥');
    if not Assigned(billPrint) then
      billPrint := TNovaPrint.Create(self, templtename);

    notprintValue := getNotprintValue(Sysinfo.LoginUserInfo.OrgID, vehicleid,
    templtename);

    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;


    if not Assigned(multiplelist) then
      multiplelist := TList < TDictionary < String, String >> .Create
    else
      multiplelist.Clear;

    //departinvoicesid := jcdsDepartinvoice.FieldByName('id').AsLargeInt;

    with jcdsFirstCheck do
    begin
        Active := false;
        //Params.ParamValues['departinvoicesid'] := departinvoicesid;
        Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
        Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id').AsLargeInt;
        if islinework then
        begin
          Params.ParamValues['vehiclereportid'] := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
          Params.ParamValues['islinework'] := islinework;
        end
        else
        begin
          Params.ParamValues['vehiclereportid'] := 0;
          Params.ParamValues['islinework'] := islinework;
        end;
        Active := true;

        if RecordCount > 0 then
        begin

            first;

            while (not Eof) do
            begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('reachstation',
                FieldByName('reachstation').AsString);
              try
              reachstationids:= reachstationids+FieldByName('reachstationid').AsString+',';
              Except on e: exception do
                showmessage(e.message);
              end;
              multipleValueValue.Add('ticketnum',
                FieldByName('ticketnum').AsString);
              ticketnums:=ticketnums+ FieldByName('ticketnum').AsString+',';
              totalnum := totalnum + FieldByName('ticketnum').AsInteger;
              multiplelist.Add(multipleValueValue);
              next;
            end;
        end;
        if islinework then
        begin
          vehicleno := jscdQryVehicleReport.FieldByName('vehicleno').AsString;
          vehicleid := jscdQryVehicleReport.FieldByName('vehicleid').AsLargeInt;
        end;
        printValue.Add('vehicleno', vehicleno);
        printValue.Add('departdate', jcdsResult.FieldByName('departdate').AsString);
        printValue.Add('totalnum',IntToStr(totalnum));
        printValue.Add('printName',Sysinfo.LoginUserInfo.UserName);
        printValue.Add('printcode',Sysinfo.LoginUserInfo.UserCode);
        printValue.Add('firstcheckinvoicesno',Sysinfo.LoginUserInfo.curBillNo.Items['FirstBalanceBill']);
        billPrint.SingleValue := printValue;
        billPrint.MultipleValue := multiplelist;

        with jcdsFirstCheckSave do
        begin
        try
          Params.ParamValues['firstcheck.orgid']:= SysInfo.LoginUserInfo.OrgID;
          Params.ParamValues['firstcheck.checkinvoicesno'] := Sysinfo.LoginUserInfo.curBillNo.Items['FirstBalanceBill'];
          Params.ParamValues['firstcheck.departdate']:= jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['firstcheck.departtime']:= jcdsResult.FieldByName('departtime').AsString;
          Params.ParamValues['firstcheck.routeid']:=  jcdsResult.FieldByName('routeid').AsString;
          Params.ParamValues['firstcheck.scheduleid']:= jcdsResult.FieldByName('scheduleid').AsString;
          params.ParamValues['firstcheck.departstationid']:= jcdsResult.FieldByName('departstationid').AsString;
          Params.ParamValues['firstcheck.reachstationid']:=  jcdsResult.FieldByName('endstationid').AsString;
          Params.ParamValues['firstcheck.vehicleid']:= vehicleid;//jcdsResult.FieldByName('vehicleid').AsLargeInt;
          Params.ParamValues['firstcheck.ticketnum']:=IntToStr(totalnum);
          Params.ParamValues['firstcheck.printway']:='0';
          Params.ParamValues['firstcheck.vehiclereportid'] := vehiclereportid;
          Params.ParamValues['reachstationids'] := reachstationids;
          Params.ParamValues['ticketnums'] :=ticketnums;
          //������վ����μƻ�ID����������ID����ȡ����ĳ�Ʊ��Ϣ
          Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
          Params.ParamValues['scheduleplanid'] := scheduleplanid;
          Params.ParamValues['vehiclereportid'] := vehiclereportid;
          Execute;
        Except on e:Exception do
          showmessage(e.Message);
        end;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        if(nresult<0) then
        begin
            SysDialogs.ShowMessage(sresult);
        end
        else
        begin
           billPrint.Print;
           with Sysinfo.LoginUserInfo do
           begin
            curBillNo.AddOrSetValue('FirstBalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['FirstBalanceBill'])
                  + 1), length(curBillNo.Items['FirstBalanceBill'])));
          curBillNum.AddOrSetValue('FirstBalanceBill',
            curBillNum.Items['FirstBalanceBill'] - 1);
          end;
          refreshbill1;
          NovaEdtTicketNo.SetFocus;
        end;
        end;
    end;
  end
  else
  begin
      SysDialogs.Warning('��ǰ���÷����ӡ���㵥,����ӡ���쵥!�������!');
  end;
end;

procedure TFrmCheckTicket.ToolButton3Click(Sender: TObject);
var
  multipleValueValue: TDictionary<String, String>;
  templtename,vehicleno,sresult: string;
  vehiclereportid,scheduleplanid,vehicleid,departinvoicesid: Largeint;
  nresult ,totalnum: Integer;
  islinework : Boolean;
  reachstationids,ticketnums:string;
begin
  inherited;
   //��ӡ���쵥
  if not jcdsResult.Active then
      exit;
  if jcdsResult.RecordCount = 0 then
      exit;
  if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ����ش������') then
  begin
    exit;
  end;
  FrmReprintByOldOrNewBillno := TFrmReprintByOldOrNewBillno.Create(self);
  try
    with FrmReprintByOldOrNewBillno do
    begin
      Caption := '�ش���쵥';
      if SysMainForm.showFormModal(FrmReprintByOldOrNewBillno, false) = mrok then
      begin
        if isprintbynewbillno = 1 then
        begin
          isprintbynewticketno := false;
        end
        else if isprintbynewbillno = 2 then
        begin
          isprintbynewticketno := true;
        end
        else
        begin
          exit;
        end;
      end;
    end;
  finally
    FreeAndNil(FrmReprintByOldOrNewBillno);
  end;

  //3028=0��ʾ�ۺϼ�Ʊ����ʱ�򲻴򵥣�3087��ʾ����ӡ���쵥
  if getParametervalue('3028', Sysinfo.LoginUserInfo.OrgID) = '0' then
  begin
    if getParametervalue('3087', Sysinfo.LoginUserInfo.OrgID) = '0' then
    begin
      SysDialogs.Warning('ϵͳ��ǰ���ò���ӡ���쵥������3087����!');
      exit;
    end;

    //����ˮ�� û�з��� �������ӡ
    if ((jcdsResult.FieldByName('isdeparted').asboolean) = False) and
    ((jcdsResult.FieldByName('islinework').asboolean) = False) then
    begin
      SysDialogs.Warning('�ð��δ����!');
      exit;
    end;

    islinework := jcdsResult.FieldByName('islinework').asboolean;
    vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;

    if islinework and (not jscdQryVehicleReport.Active) then
      Exit;

    //������ˮ���Ƿ��ѷ���
    if islinework and (jscdQryVehicleReport.FieldByName('isdeparted').AsBoolean = False) then
    begin
      SysDialogs.Warning('�ð��δ���࣬���ɴ�ӡ���쵥!');
      exit;
    end;

    if (jcdsResult.FieldByName('islinework').AsBoolean) then
    begin
      vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    end
    else
    begin
      vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
    end;

    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    templtename := TNovaPrint.GetTicketModelName('���쵥', '���쵥');
    if not Assigned(billPrint) then
      billPrint := TNovaPrint.Create(self, templtename);

    notprintValue := getNotprintValue(Sysinfo.LoginUserInfo.OrgID, vehicleid,
    templtename);

    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;


    if not Assigned(multiplelist) then
      multiplelist := TList < TDictionary < String, String >> .Create
    else
      multiplelist.Clear;

    //departinvoicesid := jcdsDepartinvoice.FieldByName('id').AsLargeInt;

    with jcdsQryFirstCheck do
    begin
        Active := false;
        Params.ParamValues['filter_EQD_f!departdate'] := formatdatetime('yyyy-MM-dd',DpDepartDate.DateTime);;
        Params.ParamValues['filter_EQS_s!code'] := jcdsResult.FieldByName('code').AsString;
        Params.ParamValues['filter_EQS_f!departtime'] := jcdsResult.FieldByName('departtime').AsString;
        Params.ParamValues['filter_EQB_f!status'] := '0'; //ֻ��ѯ����״̬
        Params.ParamValues['filter_EQL_f!orgid'] := SysInfo.LoginUserInfo.OrgID;
        Active := true;

        if not (jcdsQryFirstCheck.RecordCount > 0) then
        begin
          SysDialogs.ShowMessage('�ð��δ��ӡ���쵥�������ش�');
          Exit;
        end;

        //ԭ�����ش򣬲�ѯ֮ǰ�ĳ��쵥
        if not isprintbynewticketno then
        begin
          jcdsQryFirstCheck.First;
          while (not Eof) do
          begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('reachstation',
                FieldByName('reachstation').AsString);
              reachstationids:= reachstationids+jcdsQryFirstCheck.FieldByName('reachstationid').AsString+',';
              ticketnums:=ticketnums+ jcdsQryFirstCheck.FieldByName('ticketnum').AsString+',';
              multipleValueValue.Add('ticketnum',
                jcdsQryFirstCheck.FieldByName('ticketnum').AsString);
              totalnum := totalnum + jcdsQryFirstCheck.FieldByName('ticketnum').AsInteger;
              multiplelist.Add(multipleValueValue);
              next;
          end;

          if islinework then
          begin
            vehicleno := jcdsQryFirstCheck.FieldByName('vehicleno').AsString;
            vehicleid := jcdsQryFirstCheck.FieldByName('vehicleid').AsLargeInt;
          end;

          printValue.Add('vehicleno', vehicleno);
          printValue.Add('departdate', jcdsQryFirstCheck.FieldByName('departdate').AsString);
          printValue.Add('totalnum',IntToStr(totalnum));
          printValue.Add('printName',Sysinfo.LoginUserInfo.UserName);
          printValue.Add('printcode',Sysinfo.LoginUserInfo.UserCode);
        end ;


        //���µ����ش�����Ҫ���²�ѯ
        if isprintbynewticketno then
        begin
          with jcdsFirstCheck do
          begin
              Active := false;
              //Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
              Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id').AsLargeInt;
              if islinework then
              begin
                Params.ParamValues['vehiclereportid'] := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
                Params.ParamValues['islinework'] := islinework;
              end
              else
              begin
                Params.ParamValues['vehiclereportid'] := 0;
                Params.ParamValues['islinework'] := islinework;
              end;
              Active := true;

              if jcdsFirstCheck.RecordCount > 0 then
              begin
                  jcdsFirstCheck.first;
                  while (not Eof) do
                  begin
                    multipleValueValue := TDictionary<String, String>.Create;
                    multipleValueValue.Add('reachstation',
                      jcdsFirstCheck.FieldByName('reachstation').AsString);
                    reachstationids:= reachstationids + jcdsFirstCheck.FieldByName('reachstationid').AsString+',';
                    ticketnums:=ticketnums+ jcdsFirstCheck.FieldByName('ticketnum').AsString+',';
                    multipleValueValue.Add('ticketnum',
                      jcdsFirstCheck.FieldByName('ticketnum').AsString);
                    totalnum := totalnum + jcdsFirstCheck.FieldByName('ticketnum').AsInteger;
                    multiplelist.Add(multipleValueValue);
                    next;
                  end;
              end;

              if islinework then
              begin
                vehicleno := jscdQryVehicleReport.FieldByName('vehicleno').AsString;
                vehicleid := jscdQryVehicleReport.FieldByName('vehicleid').AsLargeInt;
              end;
              printValue.Add('vehicleno', vehicleno);
              printValue.Add('departdate', jcdsResult.FieldByName('departdate').AsString);
              printValue.Add('totalnum',IntToStr(totalnum));
              printValue.Add('printName',Sysinfo.LoginUserInfo.UserName);
              printValue.Add('printcode',Sysinfo.LoginUserInfo.UserCode);
              billPrint.SingleValue := printValue;
              billPrint.MultipleValue := multiplelist;
          end;
        end;


        if isprintbynewticketno then
        begin
          //��Ʊ���ش򣺱�����쵥
          with jcdsFirstCheckSave do
          begin
            try
              Params.ParamValues['firstcheck.orgid']:= SysInfo.LoginUserInfo.OrgID;
              Params.ParamValues['firstcheck.checkinvoicesno'] := Sysinfo.LoginUserInfo.curBillNo.Items['FirstBalanceBill'];
              Params.ParamValues['firstcheck.departdate']:= jcdsResult.FieldByName('departdate').AsString;
              Params.ParamValues['firstcheck.departtime']:= jcdsResult.FieldByName('departtime').AsString;
              Params.ParamValues['firstcheck.routeid']:=  jcdsResult.FieldByName('routeid').AsString;
              Params.ParamValues['firstcheck.scheduleid']:= jcdsResult.FieldByName('scheduleid').AsString;
              params.ParamValues['firstcheck.departstationid']:= jcdsResult.FieldByName('departstationid').AsString;
              Params.ParamValues['firstcheck.reachstationid']:=  jcdsResult.FieldByName('endstationid').AsString;
              Params.ParamValues['firstcheck.vehicleid']:= vehicleid; //jcdsResult.FieldByName('vehicleid').AsLargeInt;
              Params.ParamValues['firstcheck.ticketnum']:=IntToStr(totalnum);
              Params.ParamValues['firstcheck.printway']:='1';
              Params.ParamValues['reachstationids'] := reachstationids;
              Params.ParamValues['ticketnums'] :=ticketnums;

              //������վ����μƻ�ID����������ID����ȡ����ĳ�Ʊ��Ϣ
              Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
              Params.ParamValues['scheduleplanid'] := scheduleplanid;
              Params.ParamValues['vehiclereportid'] := vehiclereportid;
              Execute;
            Except on e:Exception do
              showmessage(e.Message);
            end;
            nResult := Params.ParamByName('flag').Value;
            sResult := Params.ParamByName('msg').Value;
            if(nresult <= 0) then
            begin
              SysDialogs.ShowMessage(sresult);
            end
            else
            begin
               //�ش���쵥�����µ����ش�
              printValue.Add('firstcheckinvoicesno',Sysinfo.LoginUserInfo.curBillNo.Items['FirstBalanceBill']);

              billPrint.SingleValue := printValue;
              billPrint.MultipleValue := multiplelist;

              with Sysinfo.LoginUserInfo do
              begin
                curBillNo.AddOrSetValue('FirstBalanceBill',
                zerofill(inttostr(strtoint64(curBillNo.Items['FirstBalanceBill'])
                  + 1), length(curBillNo.Items['FirstBalanceBill'])));
                curBillNum.AddOrSetValue('FirstBalanceBill',
                curBillNum.Items['FirstBalanceBill'] - 1);
              end;

              refreshbill1;   //ˢ�³��쵥��

              billPrint.Print;  //ִ�д�ӡ��������쵥�ɹ�����ִ�д�ӡ
              NovaEdtTicketNo.SetFocus;
            end;
          end;
        end
        else
        begin
          //ԭƱ���ش�
          printValue.Add('firstcheckinvoicesno',jcdsQryFirstCheck.FieldByName('checkinvoicesno').AsString);

          billPrint.SingleValue := printValue;
          billPrint.MultipleValue := multiplelist;

          billPrint.Print;  //ִ�д�ӡ��������쵥�ɹ�����ִ�д�ӡ
          NovaEdtTicketNo.SetFocus;
        end;
    end;
  end
  else
  begin
      SysDialogs.Warning('��ǰ���÷����ӡ���㵥,����ӡ���쵥!����3028����!');
  end;


end;

procedure TFrmCheckTicket.ToolButton50Click(Sender: TObject);
var
  curid: int64;
  curschseatstaus: TDictionary<Word, string>;
  i, checkdays: integer;
  isemptyseat: boolean;
  tmpvehiclereportid: int64;
begin
  // ������
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  { if (not jcdsResult.FieldByName('isreported').AsBoolean) then
    begin
    SysDialogs.Warning('�ð�λ�û������');
    exit;
    end;
    if (jcdsResult.FieldByName('isdeparted').AsBoolean) then
    begin
    SysDialogs.Warning('�ð���Ѿ����࣡');
    exit;
    end; }

  // 3019:����/�ش�/ע�����㵥����
  checkdays := StrToInt(getParametervalue('3019', Sysinfo.LoginUserInfo.OrgID));
  if DateOf(jcdsResult.FieldByName('departdate').AsDateTime + checkdays)
    < DateOf(now) then
  begin
    SysDialogs.ShowMessage('�ѳ����������㵥����,���ܻ�죡');
    exit;
  end;

  if (not jcdsResult.FieldByName('islinework').AsBoolean) and (not ismixcheck)
    then
  begin
    curschseatstaus := getScheduleSeatstatus
      (jcdsResult.FieldByName('id').AsLargeInt);

    for i := 1 to curschseatstaus.Count do
    begin
      if curschseatstaus.Items[i] = '0' then
      begin
        isemptyseat := true;
        break;
      end;
    end;
    if not isemptyseat then
    begin
      SysDialogs.ShowMessage('�ð����û�п�λ���������죡');
      exit;
    end;
  end;

  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jscdQryVehicleReport.Active then
      exit;
    if jscdQryVehicleReport.RecordCount = 0 then
      exit;
    tmpvehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  end
  else
  begin
    tmpvehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  end;

  // if  self.isaotoreflash then
  tmrFlash.Enabled := false;
  FrmMixCheckticket := TFrmMixCheckticket.Create(self);
  try
    with FrmMixCheckticket do
    begin
      Caption := '������';
      with jcdsResult do
      begin
        ischeckbyseatnocur := ischeckbyseatno;
        isauthorlatetocur := curisauthorlatetocur;
        scheduleplanid := FieldByName('id').AsLargeInt;
        curid := FieldByName('id').AsLargeInt;
        ticketentrance := NovaHCobEntrance.text;
        LabmFromStation.Caption := FieldByName('departstation').AsString;
        LabmEndStation.Caption := FieldByName('endstation').AsString;
        // LabmEntrance.Caption := FieldByName('ticketentrance').AsString;
        // LabmBusPark.Caption := FieldByName('buspark').AsString;
        LabOnDepartdate.Caption := FieldByName('departdate').AsString;
        LabCode.Caption := FieldByName('code').AsString;
        LabDepartTime.Caption := FieldByName('departtime').AsString;
        inputdepartstationid :=nvcbbstation.Text;
        // LabVehicleType.Caption := FieldByName('vehicletypename').AsString;
        // NovaEdtTicketNo.MaxLength := Sysinfo.curBillLength.Items['Ticket'];
        if FieldByName('islinework').AsBoolean then
        begin
          newschisworkline := true;
          LabSeatNum.Caption := jscdQryVehicleReport.FieldByName('seatnum')
            .AsString;
          LabVehicleNo.Caption := jscdQryVehicleReport.FieldByName('vehicleno')
            .AsString;
        end
        else
        begin
          newschisworkline := false;
          curbrandModelid := SeatPlan.brandModelid;
          LabSolds.Caption := FieldByName('soldeatnum').AsString;
          LabVehicleNo.Caption := FieldByName('vehicleno').AsString;
          LabSeatNum.Caption := FieldByName('seatnum').AsString;
          LabCheckeds.Caption := FieldByName('checkeds').AsString;
        end;
        vehiclereportid := tmpvehiclereportid;
      end;
    end;

    if SysMainForm.showFormModal(FrmMixCheckticket, false) = mrok then
    begin
      qryScheduleplan(curid);
      if self.isaotoreflash then
        tmrFlash.Enabled := true;
    end;
  finally
    FreeAndNil(FrmMixCheckticket);
  end;
end;

procedure TFrmCheckTicket.ToolButton51Click(Sender: TObject);
var
  scheduleplanid: int64;
  vehiclereportid: int64;
  nresult: integer;
  sresult,checkedstationid: string;
begin
  inherited;
  //���Ϊʵ���Ƽ�Ʊ����У��
  if isrealname then
  begin
      SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ�����������˼죡');
      exit;
  end;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('�ð�λ�δ������');
    exit;
  end;
  if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ��Ҫ�����˼죿') then
  begin
    exit;
  end;
  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jscdQryVehicleReport.Active then
      exit;
    if jscdQryVehicleReport.RecordCount = 0 then
      exit;
    vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  end
  else
  begin
    vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  end;
  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
  try
    with jscdcancelAllCheckticket do
    begin
      Active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      if (nvcbbstation.text <> '') then
      begin
        checkedstationid := nvcbbstation.GetSelectID;
        Params.ParamValues['filter_INS_t!departstationid'] := checkedstationid;
      end
      else
      begin
        Params.ParamValues['filter_INS_t!departstationid'] := null;
      end;
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        // SysDialogs.ShowMessage(sresult);
        lbl2.Caption := sresult;
        lbl2.Refresh;
        qryScheduleplan(scheduleplanid);
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�����˼����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmCheckTicket.ToolButton53Click(Sender: TObject);
begin
  if isprintdepartinvoices then
  begin
    if not checkBillno('BalanceBill') then
      exit;
    departSch(Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'], true);
  end
  else
  begin
    // jscdSchDepartinvoice
    onlydepartSch();
  end;
end;

procedure TFrmCheckTicket.TtnTotalCheckClick(Sender: TObject);
var
  tmpvehiclereportid: int64;
begin
  inherited;
  //���Ϊʵ���Ƽ�Ʊ����У��
  if isrealname then
  begin
      SysDialogs.ShowMessage('ʵ���Ƽ�Ʊ������ͨ�죡');
      exit;
  end;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;

  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jscdQryVehicleReport.Active then
      exit;
    if jscdQryVehicleReport.RecordCount = 0 then
      exit;
    tmpvehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
  end
  else
  begin
    tmpvehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  end;

  // �����
  FrmCheckNTickets := TFrmCheckNTickets.Create(self);
  try
    with FrmCheckNTickets do
    begin
      Caption := '��Ʊͨ�����';
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
      vehiclereportid := tmpvehiclereportid;
      if SysMainForm.showFormModal(FrmCheckNTickets, false) = mrok then
      begin
        qryScheduleplan(scheduleplanid);
        self.NovaEdtTicketNo.SetFocus;
      end;
    end;
  finally
    FreeAndNil(FrmCheckNTickets);
  end;
end;

function TFrmCheckTicket.PrintClink(scheduleid: int64): boolean;
var
  piecesnums: integer;
  totalfeemoney, balancetotalfeemoney: double;
  sendstationname: string;
begin
  try
    printPackValue := TDictionary<String, String>.Create;

    with jcdsQryPackItems do
    begin

      Active := false;

      Params.ParamValues['startdate'] := formatdatetime('yyyy-MM-dd',
        DpDepartDate.DateTime);
      Params.ParamValues['enddate'] := formatdatetime('yyyy-MM-dd',
        DpDepartDate.DateTime);

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '0';
      Params.ParamValues['isreprint'] := '0';

      Params.ParamValues['filter_GED_ss!departdate'] := formatdatetime
        ('yyyy-MM-dd', DpDepartDate.DateTime);
      Params.ParamValues['filter_LED_ss!departdate'] := formatdatetime
        ('yyyy-MM-dd', DpDepartDate.DateTime);
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

      Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

      Active := true;

      if RecordCount < 1 then
      begin
        // SysDialogs.ShowMessage('�ð��û���а�ǩ��!');
        result := false;
        exit;
      end;

      if not Assigned(billPackPrint) then
      begin
      billPackPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('�а�ǩ����', '������㵥'));
      end;

      multiplePacklist := TList < TDictionary < String, String >> .Create;
      while not Eof do
      begin
        sendstationname := FieldByName('sendstationname').AsString; // ����վ
        piecesnums := piecesnums + FieldByName('pieces').AsInteger; // �а��ܼ���
        totalfeemoney := totalfeemoney + FieldByName('totalfee').AsFloat; // �ܽ��
        balancetotalfeemoney := balancetotalfeemoney + FieldByName
          ('balancefeecountmoney').AsFloat; // �����ܽ��
        multiplePackValueValue := TDictionary<String, String>.Create;
        multiplePackValueValue.Add('tostationvalue',
          FieldByName('tostationname').AsString); // ��վ
        multiplePackValueValue.Add('pieces', FieldByName('pieces').AsString);
        // ����
        multiplePackValueValue.Add('totalfeemoney',
          FieldByName('totalfee').AsString); // ���
        multiplePackValueValue.Add('packno', FieldByName('packno').AsString);
        // �а����˵���
        // multiplePackValueValue.Add('shippricemoney',
        // FieldByName('shipprice').AsString); // ���˷�
        // multiplePackValueValue.Add('packfeemoney',
        // FieldByName('packfee').AsString); // ��װ��
        // multiplePackValueValue.Add('handfeemoney',
        // FieldByName('handfee').AsString); // װж��
        // multiplePackValueValue.Add('deliveryfeemoney',
        // FieldByName('deliveryfee').AsString); // �ͻ���
        // multiplePackValueValue.Add('transitfeemoney',
        // FieldByName('transitfee').AsString); // ��ת��
        // multiplePackValueValue.Add('insuredamountmoney',
        // FieldByName('insuredamount').AsString); // ������ֵ
        // multiplePackValueValue.Add('insurancefeemoney',
        // FieldByName('insurancefee').AsString); // ���۷�
        // multiplePackValueValue.Add('insurancemoney',
        // FieldByName('insurance').AsString); // ���շ�
        // multiplePackValueValue.Add('otherfeemoney',
        // FieldByName('otherfee').AsString); // ��������
        // multiplePackValueValue.Add('packpricemoney',
        // FieldByName('packprice').AsString); // ���ջ���
        multiplePackValueValue.Add('balancefeecountmoney',
          FieldByName('balancefeecountmoney').AsString); // ������
        multiplePacklist.Add(multiplePackValueValue);
        next;
      end;

      // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�

      printPackValue.Clear;

      if getParametervalue('8088', Sysinfo.LoginUserInfo.OrgID) = '1' then
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']); // ǩ������

        with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := formatdatetime
            ('yyyy-MM-dd', DpDepartDate.DateTime);
          Params.ParamValues['filter_LED_p!departdate'] := formatdatetime
            ('yyyy-MM-dd', DpDepartDate.DateTime);
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          execute;

        end;

        if not Assigned(billPackPrint) then
        begin
          billPackPrint := TNovaPrint.Create(self,
            TNovaPrint.GetTicketModelName('������㵥', '������㵥'));
        end;

        with Sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('BalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill']) + 1),
              length(curBillNo.Items['BalanceBill'])));
          curBillNum.AddOrSetValue('BalanceBill',
            curBillNum.Items['BalanceBill'] - 1);
        end;
        refreshBill;

      end
      else
      begin
        printPackValue.Add('singbillno', ''); // ǩ������
      end;

      printPackValue.Add('departdate',
        Params.ParamValues['packStockVo.departdate']); // ��������
      // ����ʱ��
      printPackValue.Add('departtime',
        Params.ParamValues['packStockVo.departtime']);
      printPackValue.Add('schedulevalue',
        Params.ParamValues['packStockVo.code']); // ���
      printPackValue.Add('vehiclevalue',
        Params.ParamValues['packStockVo.vehicleno']);
      // ���ƺ�
      printPackValue.Add('drivername',
        Params.ParamValues['packStockVo.drivername']);
      // ��ʻԱ
      printPackValue.Add('unitname',
        Params.ParamValues['packStockVo.unitname']); // Ӫ�˵�λ
      printPackValue.Add('sellbyname', Sysinfo.LoginUserInfo.UserName); // ǩ����
      printPackValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss',
          now));
      // ǩ��ʱ��
      printPackValue.Add('sendstation', sendstationname); // ǩ��վ

      printPackValue.Add('piecesnums', inttostr(piecesnums)); // �а�����
      printPackValue.Add('totalfeecountmoney', floattostr(totalfeemoney));
      // �ܽ��
      printPackValue.Add('balancetotalfeecountmoney',
        floattostr(balancetotalfeemoney)); // �����ܽ��

      result := true;
    end;
    billPackPrint.MultipleValue := multiplePacklist;

    billPackPrint.SingleValue := printPackValue;
    billPackPrint.Print;

  finally

  end;

end;

function TFrmCheckTicket.VerifyStation(ticketno: string): boolean;
var
  checkedstationid,sResult:string;
  nResult,count:Int64;
begin
  result:=True;
  checkedstationid := nvcbbstation.GetSelectID;
  if checkedstationid='' then
  begin
     SysDialogs.ShowMessage('����վΪ�գ�');
     result:=False;
     Exit;
  end;
  with jscdverifystation do
  begin
    active := false;
    Params.ParamValues['ticketno'] := ticketno;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      DpDepartDate.Date);
    Params.ParamValues['filter_INS_t!departstationid'] := checkedstationid;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    if (nResult = 1) then
    begin
      count := Params.ParamByName('verifystation').Value;
      if count=0 then
      begin
//         SysDialogs.ShowMessage('����վ��ƥ�䣡��ȷ�Ϻ��ٴμ�Ʊ��');
         lbl2.Caption :=  '����վ��ƥ�䣡��ȷ�Ϻ��ٴμ�Ʊ��';
         result:=False;
      end;
    end
    else
    begin
      SysDialogs.ShowMessage('У�鷢��վʧ�ܣ�');
      result:=False;
    end;
  end;
end;

procedure TFrmCheckTicket.cardfound(idcard: TIDCard);
begin
  curidcard := idcard;
  if curidcard <> nil then
  begin
    if isrealname then
    begin
      NovaEditcertificateNo.text:= curidcard.id;
      exit;
    end;
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    with jcsdQryticketinfobyidcard do
    begin
      Active := false;
      Params.ParamValues['filter_EQD_ts!departdate'] := formatdatetime
        ('yyyy-mm-dd', DpDepartDate.Date);
      Params.ParamValues['filter_EQL_ts!scheduleid'] := jcdsResult.FieldByName
        ('scheduleid').AsInteger;
      Params.ParamValues['filter_EQS_c!certificateno'] := curidcard.id; // ���֤����
      Active := true;
      if RecordCount > 0 then
      begin
        NovaEdtTicketNo.text := FieldByName('ticketno').AsString;
      end;
    end;
  end;
end;

end.
