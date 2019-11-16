unit SellTicket;

interface

uses Classes, SysUtils, DB, Generics.Collections, jsonClientDataSet, Services,
  FunctionItemIntf, UDMPublic, Variants, StrUtils, NovaPrintoffline, PubFn,
  forms,
  windows, IniFiles, Constant, UICcardRW;

const
  refreshScheduleInterval = 5; // ����5���ˢ�µ�ǰ���

type
  // ��β�ѯ������
  ScheduleAskCondition = class
  public
    isnetway: integer;
    reachstationname: string;
    isnet: boolean;
    departDate: TDate;
    departStationId: Int64;
    reachStationId: Int64;
    ScheduleId: Int64;
    ticketIdToBeChange: Int64; // Ҫ��Ʊ�ĳ�Ʊidֵ
    customerid: Int64; // ��Ʊ�˿�id
    districtcode: string; // ����վ��������
    constructor create();
  end;

  TSellTicket = class(TComponent)
  private
    FcdsDDDWorkways: TjsonClientDataSet; // Ӫ�˷�ʽ
    FcdsDDDschedulestatus: TjsonClientDataSet; // ���״̬
    FcdsDDDvehicletype: TjsonClientDataSet; // ��������
    FcdsDDDvehiclegrade: TjsonClientDataSet; // ���͵ȼ�
    FcdsDDDseattype: TjsonClientDataSet; // Ʊ����λ����
    FcdsDDDseattype1: TjsonClientDataSet; // ������λ����
    FcdsDDDpaymethod: TjsonClientDataSet; // ֧����ʽ

    FcdsTicketType: TjsonClientDataSet; // Ʊ��
    FcdsSchedule: TjsonClientDataSet; // ��β�ѯ
    FcdsTicketBuffer: TjsonClientDataSet; // ��Ʊ�����
    FcdsScheduleSeats: TjsonClientDataSet; // �����λ
    FcdsLockSeats: TjsonClientDataSet; // ��λ
    FcdsUnLockSeats: TjsonClientDataSet; // ������λ
    FcdsGetTickettypePrice: TjsonClientDataSet; // ȡƱ��Ʊ��

    FcdsInsureBuffer: TjsonClientDataSet; // ���ջ����
    FcdsDDDCertificatetype: TjsonClientDataSet; // ֤������
    Fcdsinsuretype: TjsonClientDataSet; // ��������
    Fcdsquerycustomer: TjsonClientDataSet; // ��ѯ�˿���Ϣ
    FcdsSeatshint: TjsonClientDataSet; // ��λ��ʾ

    FCdsSchedulestopremark: TjsonClientDataSet; // ���ͣ���㱸ע
    FCdsDepartStation: TjsonClientDataSet; // ����վ��Ϣ
    FCdsScheduleQry: TjsonClientDataSet; // ��λ�����Ϣ

    FAfterScheduleScroll: TDataSetNotifyEvent;
    FScheduleSeatStatus: TDictionary<Word, String>;
    FScheduleSeattype: TDictionary<Word, String>;
    FScheduleSeatTickettype: TDictionary<Word, String>;
    FticketPrint: TNovaPrint;
    FservicefeePrint: TNovaPrint;
    FinsurePrint: TNovaPrint;
    FreturntripticketPrint: TNovaPrint;
    Fsellway: String;
    Fcansellinsure: boolean;
    Fcanrealnamesellticket: boolean;
    Fcanrealnamesellticket_route: boolean;
    Fcansellroundtrip: boolean;
    FPrintDepartTimeWhenislinework: boolean;
    untakechildInfo: String; // ������ͯ��ӡ����
    Fseatshint: TDictionary<Word, String>; // ��λͼ��ʾ

    insureoutputTxtFilename: string;
    insureoutputtxtformat: String;

    printlineScheduleSeatno: boolean; // ��ˮ���ӡ��λ��

    fulltickettypeAsDiscount: boolean; // ȫƱʱ Ʊ��С�����޼� �ʹ�ӡ ��

    // ��ǰ�Ƿ��ѯ�������
    isnet: boolean;
    ScheduleAfterScrollStack: TList<Int64>; // ScheduleAfterScrollִ�ж�ջ��ֻ�����һ�����������ִ����
    insuretypeid: String; // ��������id
    // ��ʼ��Ʊ��
    function initTicketNo(): boolean;
    // ��ʼ��������
    function initInsureNo(): boolean;
    // ��ʼ����Ʊ��ӡģ��
    function initTicketPrinter(): boolean;
    // ��ʼ�������Ѵ�ӡģ��
    function initServicefeePrinter(): boolean;
    // ��ʼ������Ʊ��ӡģ��
    function initReturntripticketPrint(): boolean;
    // ��ʼ��������ӡģ��
    function initInSurePrinter(): boolean;
    // ��ʼ����Ʊ����
    function initTicketType(): boolean;
    // ��ʼ����������
    function initInsureType(): boolean;
    // ��ʼ�������ֵ�
    procedure initcdsDDD;
    function createCdsDDD(tablename, columnname: String): TjsonClientDataSet;
    // ��ʼ����β�ѯ
    procedure initcdsSchedule;
    procedure initCdsTicketBuffer;
    procedure initcdsInsureBuffer;
    function createField(_fieldname, _DisplayLabel: String;
      _fieldtype: TFieldType; _fieldlength, _Index: integer;
      _dataset: TDataSet): TField;
    function createLookupField(_fieldname, _DisplayLabel, _KeyFields,
      _LookupKeyFields, _LookupResultField: String; _fieldtype: TFieldType;
      _fieldlength, _Index: integer; _dataset, _LookupDataSet: TDataSet)
      : TField;
    // procedure ScheduleAfterScroll(DataSet: TDataSet);

    function refreshSeatsHint(scheduleplanid: Int64): string;

    // ��ӡ��Ʊ
    function printTicket(): boolean;
    function printinsure(): boolean;
    procedure initInsureOutputConfig;
    function getInsureOutputText: String;
    procedure initCdsSchedulestopremark;
    procedure initCdsScheduleQry; // ��ѯ��λ�����Ϣ
    procedure initCdsDepartStation;
  public
    FrefreshCurScheduleTime: DWORD; // ˢ�µ�ǰ��ε�
    delayrefresh: boolean; // ��Ʊ��Ѷ�Ƿ��ӳټ���������λ��Ʊ����Ϣ
    totalPrice: Currency;
    endstation: String;
    isOpenApiUnlock: integer;
    isBuTicket: boolean;
    startstationprice: String;
    nvdbgrdhscheduleMoveByKey: boolean; // ���������ƶ�ʱ����������ѯ��̨��keydownΪtrue keyupΪfalse
    constructor CreateRePrint(AOwner: TComponent); overload;
    constructor create(AOwner: TComponent); overload;
    constructor create(AOwner: TComponent; sellway: String); overload;
    class function printTicketById(ticketsellid: Int64; isnet: boolean;
      curticketno: String = ''): boolean;

    procedure refreshseatandprice();
    function createCdsInsureBuffer(AOwner: TComponent): TjsonClientDataSet;

    // ���������ʾ��������
    procedure getInsureType(istypeid: String);

    // ���ݳ˿�ID��ȡ�˿�����
    function getCustomernameByID(customerid: Int64): String;

    // ��ѯ���
    function findSchedule(condition: ScheduleAskCondition): integer;
    // ��ѯ�������
    function findNetSchedule(condition: ScheduleAskCondition): integer;
    // ȡƱ��Ʊ��
    function GetTickettypePrice(ScheduleId: Int64; departDate: TDate;
      tickettypecode: String; fullprice: Currency): Currency;
    // ��Ʊ����
    function SellTicket(orderno: String; vipCard: TVipCard;
      discountpricenum: integer; openApinet: integer): boolean;
    // �۱��շ���
    function sellInsure(): boolean;
    // ������λ
    function lockSeat(orderno: TGUID; scheduleplanid: Int64;
      seatnos: TList<Word>; selectSeatStatus: TList<String>;
      selectSeattype: String; var seatnos_S: String): TDateTime; overload;
    function lockSeat(orderno: TGUID; scheduleplanid: Int64;
      seatnos: TList<Word>; selectSeatStatus: TList<String>;
      selectSeattype: String; var seatnos_S: String; tickettypes_S: String;
      pricess_S: string; var outJxsEticketid_S: string;
      takekidnum: integer): TDateTime; overload;
    function lockSeat(orderno: TGUID; scheduleplanid: Int64;
      selectSeattype: String; var seatnos_S: String): TDateTime; overload;

    function lockSeat(orderno: TGUID; scheduleplanid: Int64;
      selectSeattype: String; var seatnos_S: String; tickettypes_S: String;
      pricess_S: string; var outJxsEticketid_S: string;
      takekidnum: integer): TDateTime; overload;
    // ������λ
    function unlockSeat(orderno: TGUID; scheduleplanid: Int64;
      seatnos: TList<Word>): boolean; overload;
    function unlockSeat(orderno: TGUID; scheduleplanid: Int64): boolean;
      overload;
    function unlockSeat(orderno: TGUID): boolean; overload;

    function getTotalTicketBufferReceivablenum: Currency;
    function getTotalInsureBufferReceivablenum: Currency;
    // ȡ��ӡ��Ʊ����
    function getPrintTicketnum: integer;
    procedure ScheduleAfterScroll(DataSet: TDataSet);
    function delmsgAndCheckkeyup: boolean; // ������Ϣ���ж��Ƿ����ִ��

    property cdsTicketType: TjsonClientDataSet read FcdsTicketType;
    property cdsSchedule: TjsonClientDataSet read FcdsSchedule;
    property cdsTicketBuffer: TjsonClientDataSet read FcdsTicketBuffer;
    property cdsScheduleSeats: TjsonClientDataSet read FcdsScheduleSeats;
    property cdsDDDpaymethod: TjsonClientDataSet read FcdsDDDpaymethod;
    // ����б��ƶ��¼�
    property AfterScheduleScroll
      : TDataSetNotifyEvent read FAfterScheduleScroll write
      FAfterScheduleScroll;
    // ��ǰ��ε���λ״̬
    property ScheduleSeatStatus: TDictionary<Word,
      String>read FScheduleSeatStatus;
    property ScheduleSeatTickettype: TDictionary<Word,
      String>read FScheduleSeatTickettype;

    property seatshint: TDictionary<Word, String>read Fseatshint; // ��λͼ��ʾ

    // ��ǰ��ε���λ����
    property ScheduleSeattype: TDictionary<Word, String>read FScheduleSeattype;
    property cdsInsureBuffer: TjsonClientDataSet read FcdsInsureBuffer;
    // ���ջ����
    property cdsinsuretype: TjsonClientDataSet read Fcdsinsuretype; // ��������
    property cdsquerycustomer: TjsonClientDataSet read Fcdsquerycustomer;
    // �˿���Ϣ
    property sellway: String read Fsellway; // ��Ʊ��ʽ
    property cansellinsure: boolean read Fcansellinsure write Fcansellinsure;
    property canrealnamesellticket: boolean read Fcanrealnamesellticket write
      Fcanrealnamesellticket;
    property canrealnamesellticket_route
      : boolean read Fcanrealnamesellticket_route write
      Fcanrealnamesellticket_route;
    property cansellroundtrip
      : boolean read Fcansellroundtrip write Fcansellroundtrip;

  end;

implementation

uses UFrmSellTicket, UFrmChangeTicket, UFrmSellBookTicket, Ufrmsellticketend,
  Ufrmsellwayend;

{ TSellTicket }

constructor TSellTicket.create(AOwner: TComponent; sellway: String);
var
  FrmSellTicket: TFrmSellTicket;
begin
  // Create(AOwner);
  inherited create(AOwner);
  isBuTicket := false;
  nvdbgrdhscheduleMoveByKey := false;
  ScheduleAfterScrollStack := TList<Int64>.create;
  Fcansellinsure := getParametervalue('1022', SysInfo.LoginUserInfo.OrgID)
    = '1'; // �Ƿ��۱���
  Fcanrealnamesellticket := getParametervalue('9393',
    SysInfo.LoginUserInfo.OrgID) = '1'; // �Ƿ�ʵ������Ʊ
  Fcanrealnamesellticket_route := getParametervalue('9393',
    SysInfo.LoginUserInfo.OrgID) = '2'; // �Ƿ�ʵ������Ʊroute
  printlineScheduleSeatno := getParametervalue('1024',
    SysInfo.LoginUserInfo.OrgID) = '1';
  FPrintDepartTimeWhenislinework := getParametervalue('1031',
    SysInfo.LoginUserInfo.OrgID) = '1';
  untakechildInfo := getParametervalue('1039', SysInfo.LoginUserInfo.OrgID);
  if not initTicketType() then
    exit;
  if sellway[1] <> '8' then
  begin
    if not initTicketPrinter() then
      exit;
    if not initTicketNo() then
      exit;
    if Fcansellinsure then
    begin
      Fcansellinsure := initInsureType() and initInsureNo()
        and initInSurePrinter();
    end;
    Fcansellroundtrip := initReturntripticketPrint;
  end
  else
  begin
    Fcansellinsure := false;
    Fcanrealnamesellticket := false;
    Fcanrealnamesellticket_route := false;
  end;
  if ((sellway[1] = '1') or (sellway[1] = '2') or (sellway[1] = '4')) then
  begin
    if not initServicefeePrinter() then
      exit;
  end;
  initcdsDDD;
  initCdsTicketBuffer;
  initcdsSchedule;
  initcdsInsureBuffer;
  Fsellway := sellway;
  // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
  case sellway[1] of
    '4':
      FrmSellTicket := TFrmChangeTicket.create(Self, Self);
    '6':
      FrmSellTicket := TFrmSellBookTicket.create(Self, Self);
  else
    FrmSellTicket := TFrmSellTicket.create(Self, Self);
  end;
  initInsureOutputConfig;
  delayrefresh := StrToBoolDef(getParametervalue('1025',
      SysInfo.LoginUserInfo.OrgID), false);
  fulltickettypeAsDiscount := getParametervalue('1046',
    SysInfo.LoginUserInfo.OrgID) = '1'; // �Ƿ��۱���
  Services.SysMainForm.ShowForm(FrmSellTicket);
end;

constructor TSellTicket.create(AOwner: TComponent);
begin
  inherited create(AOwner);
  if not initTicketType() then
    exit;
  initcdsDDD;
  initCdsTicketBuffer;
end;

function TSellTicket.createCdsDDD(tablename, columnname: String)
  : TjsonClientDataSet;
begin
  result := TjsonClientDataSet.create(Self);
  with result do
  begin
    RemoteServer := DMPublic.jcon;
    QueryAddress := 'system/querydictionary';
    DataSourceName := 'diclist';
    Params.CreateParam(ftString, 'tablename', ptInput);
    Params.CreateParam(ftString, 'columnname', ptInput);

    Params.ParamValues['tablename'] := tablename;
    Params.ParamValues['columnname'] := columnname;
    Active := true;
  end;
end;

function TSellTicket.createCdsInsureBuffer(AOwner: TComponent)
  : TjsonClientDataSet;
  function incEx(var i: integer): integer;
  begin
    inc(i);
    result := i;
  end;

var
  field: TField;
  i: integer;
begin
  result := TjsonClientDataSet.create(AOwner);
  with result do
  begin
    RemoteServer := DMPublic.jcon;
    QueryAddress := 'insurancesell/findEmptyInsurance';
    SaveAddress := 'insurancesell/sell';
    DataSourceName := 'insurancePrintInfos';
    UpdateDataSet := 'insurancePrintInfolist';
    refreshAfterApplyUpdates := true;
    Params.CreateParam(ftString, 'isnet', ptInput); // �Ƿ�����Ʊ
    Params.CreateParam(ftString, 'insuranceOrder.seller', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.orgid', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.startTicketNO', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.totalmoney', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.ip', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.ticketoutletsid', ptInput);
    Params.CreateParam(ftString, 'insuranceOrder.sellway', ptInput);
    Params.CreateParam(ftInteger, 'flag', ptOutput);
    Params.CreateParam(ftString, 'msg', ptOutput);
    i := -1;

    createField('sellid', '', ftLargeint, 0, incEx(i), result);
    createField('scheduleplanid', '', ftLargeint, 0, incEx(i), result);
    createField('distance', '', ftLargeint, 0, incEx(i), result);
    createField('customerid', '', ftLargeint, 0, incEx(i), result);
    createField('id', '', ftLargeint, 0, incEx(i), result);
    createField('insurersid', '', ftLargeint, 0, incEx(i), result);
    createField('insuretypeid', '', ftLargeint, 0, incEx(i), result);

    createField('schedulecode', '', ftWideString, 20, incEx(i), result);
    createField('departstationname', '', ftWideString, 30, incEx(i), result);
    createField('reachstationname', '', ftWideString, 30, incEx(i), result);
    createField('reachstationsecondname', '', ftWideString, 30, incEx(i),
      result);
    createField('departtime', '', ftWideString, 5, incEx(i), result);
    createField('ticketno', '', ftWideString, 30, incEx(i), result);
    createField('tickettype', '', ftWideString, 10, incEx(i), result);
    createField('certificateno', '', ftWideString, 50, incEx(i), result);
    createField('certificatetype', '', ftWideString, 10, incEx(i), result);
    createField('customername', '', ftWideString, 30, incEx(i), result);
    createField('education', '', ftWideString, 10, incEx(i), result);
    createField('familyaddress', '', ftWideString, 100, incEx(i), result);
    createField('familyphone', '', ftWideString, 20, incEx(i), result);
    createField('mobilephone', '', ftWideString, 20, incEx(i), result);
    createField('customerremarks', '', ftWideString, 100, incEx(i), result);
    createField('insuranceno', '', ftWideString, 30, incEx(i), result);
    createField('ticketoutletsname', '', ftWideString, 30, incEx(i), result);
    createField('paymethod', '', ftWideString, 10, incEx(i), result);

    createField('seatno', '', ftInteger, 0, incEx(i), result);
    createField('seatnostr', '', ftWideString, 20, incEx(i), result);
    createField('carrychildnum', '', ftInteger, 0, incEx(i), result);

    createField('isselfschedule', '', ftBoolean, 0, incEx(i), result);
    createField('issell', '', ftBoolean, 0, incEx(i), result);
    createField('islinework', '', ftBoolean, 0, incEx(i), result);

    createField('departdate', '', ftDate, 0, incEx(i), result);
    createField('selltime', '', ftDateTime, 0, incEx(i), result);
    createField('premium', '', ftFloat, 0, incEx(i), result);
    createField('insureamount', '', ftFloat, 0, incEx(i), result);
    createField('polnumber', '', ftWideString, 30, incEx(i), result);
    // ���չ�˾�ӿڷ��صı�����
    createField('emoney', '', ftFloat, 0, incEx(i), result); // �����˺����ս��
    createField('emmoney', '', ftFloat, 0, incEx(i), result); // �����˺�ҽ�Ʊ��ս��
    createField('reprintdatetime', '', ftWideString, 100, incEx(i), result);
    // ����Ʊ��Ʊʱ��

    createLookupField('certificatetypename', '', 'certificatetype', 'code',
      'value', ftWideString, 50, incEx(i), result, FcdsDDDCertificatetype);
    createLookupField('tickettypeprintname', '', 'tickettype', 'code',
      'printname', ftWideString, 50, incEx(i), result, FcdsTicketType);
    createLookupField('paymethodname', '', 'paymethod', 'code', 'value',
      ftWideString, 50, incEx(i), result, FcdsDDDpaymethod);
    if cansellinsure then
    begin
      createLookupField('insuretypename', '', 'insuretypeid', 'id', 'name',
        ftWideString, 50, incEx(i), result, Fcdsinsuretype);
    end;
  end;
end;

function TSellTicket.createField(_fieldname, _DisplayLabel: String;
  _fieldtype: TFieldType; _fieldlength, _Index: integer;
  _dataset: TDataSet): TField;
begin
  result := DefaultFieldClasses[_fieldtype].create(_dataset);
  with result do
  begin
    // name:=_dataset.Name+_fieldname;
    Size := _fieldlength;
    FieldName := _fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    DataSet := _dataset;
  end;
end;

function TSellTicket.createLookupField(_fieldname, _DisplayLabel, _KeyFields,
  _LookupKeyFields, _LookupResultField: String; _fieldtype: TFieldType;
  _fieldlength, _Index: integer; _dataset, _LookupDataSet: TDataSet): TField;
begin
  result := DefaultFieldClasses[_fieldtype].create(_dataset);
  with result do
  begin
    // name:=_dataset.Name+_fieldname;
    FieldName := _fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    Size := _fieldlength;

    FieldKind := fkLookup;
    KeyFields := _KeyFields;
    LookupKeyFields := _LookupKeyFields;
    LookupResultField := _LookupResultField;
    LookupDataset := _LookupDataSet;
    DataSet := _dataset;
  end;
end;

constructor TSellTicket.CreateRePrint(AOwner: TComponent);
begin
  inherited create(AOwner);
  if not initTicketType() then
  begin
    raise Exception.create('��ʼ����Ʊ����ʧ��');
  end;
  if not initTicketPrinter() then
  begin
    raise Exception.create('��ʼ����Ʊ��ӡģ��ʧ��');
  end;
  initcdsDDD;
  initCdsTicketBuffer;
end;

function TSellTicket.delmsgAndCheckkeyup: boolean;
var
  keychange: boolean;
begin
  OutputDebugString('nvdbgrdhschedule checking...');
  result := false;
  keychange := nvdbgrdhscheduleMoveByKey;
  Application.ProcessMessages;
  if keychange <> nvdbgrdhscheduleMoveByKey then
  begin
    OutputDebugString('nvdbgrdhschedule changeed');
  end;

  if (nvdbgrdhscheduleMoveByKey = true) or (ScheduleAfterScrollStack.Count = 0)
    then
  begin
    OutputDebugString('nvdbgrdhschedule stoprun');
    result := true;
  end;
end;

function TSellTicket.findNetSchedule(condition: ScheduleAskCondition): integer;
begin

end;

function TSellTicket.findSchedule(condition: ScheduleAskCondition): integer;
begin
  with FcdsSchedule do
  begin
    FcdsSchedule.AfterScroll := nil;
    Active := false;
    isnet := condition.isnet;
    if isnet then
    begin
      if condition.isnetway = 2 then
      begin
        Params.ParamValues['isnet'] := 2; // ʡ��������
      end
      else
      begin
        Params.ParamValues['isnet'] := 1; // ����������
      end;
    end
    else
    begin
      Params.ParamValues['isnet'] := 0; // ������
    end;
    // Params.ParamValues['isnet']:= isnet;

    Params.ParamValues['scheduleAskCondition.departDate'] := FormatDateTime
      ('yyyy-mm-dd', condition.departDate);
    Params.ParamValues['scheduleAskCondition.departStationId'] :=
      condition.departStationId;
    Params.ParamValues['scheduleAskCondition.reachStationId'] :=
      condition.reachStationId;
    Params.ParamValues['scheduleAskCondition.scheduleid'] :=
      condition.ScheduleId;
    Params.ParamValues['scheduleAskCondition.seller'] :=
      SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['scheduleAskCondition.ip'] := SysInfo.LocalHostAddress;
    Params.ParamValues['scheduleAskCondition.ticketoutletsid'] :=
      SysInfo.LoginUserInfo.ticketoutletsid;
    Params.ParamValues['scheduleAskCondition.sellway'] := Self.sellway;
    Params.ParamValues['scheduleAskCondition.ticketIdToBeChange'] :=
      condition.ticketIdToBeChange;
    Params.ParamValues['scheduleAskCondition.customerid'] :=
      condition.customerid;
    Params.ParamValues['scheduleAskCondition.districtcode'] :=
      condition.districtcode;
    Params.ParamValues['scheduleAskCondition.reachStationName'] :=
      condition.reachstationname;

    Active := true;

    FcdsSchedule.AfterScroll := ScheduleAfterScroll;
    FcdsSchedule.AfterScroll(FcdsSchedule);
    result := RecordCount;
  end;
end;

function TSellTicket.getInsureOutputText: String;
var
  seatnostr: String;
  departdatetime: TDateTime;
  formattxt_all: string;
  yesnotxt, yestxt, notxt: string;
  copystr, startnum, endnum: string;
  i: integer;
  _tmpstr: string;
  _tmpdatetime: TDateTime;
  _tmpticketno: string;
  _tmpboolean: boolean;
  _tmpticketprice: Currency;

begin
  // txtformat=${�ϳ�վ����}|${��ƱԱ����}|${��ƱԱ����}|${Ʊ��}${��κ�}|${��Ʊʱ��}|${��������ʱ��.format('yyyy-mm-dd hh:nn:ss')}|${��λ��}|${����վ����}|${Ʊ��}|${�ϳ�վ����}|${����վ����}
  result := insureoutputtxtformat;
  with cdsTicketBuffer do
  begin
    if FieldByName('islinework').AsBoolean then
    begin
      seatnostr := FieldByName('seatno').AsString; // '���̶�';
    end
    else
    begin
      seatnostr := FieldByName('seatnostr').AsString;
    end;
    departdatetime := _StrToDateTime(FormatDateTime('yyyy-mm-dd',
        FieldByName('departdate').AsDateTime) + ' ' + FieldByName('departtime')
        .AsString + ':00'); // ,'yyyy-mm-dd hh:nn:ss'
    // #��ͨ�������ϳ�վ���ơ��ϳ�վ���롢��ƱԱ���š���ƱԱ������Ʊ�š���κš���λ�š�����վ���롢����վ���ơ�Ʊ��
    result := StringReplace(result, '${��ƱԱ����}', SysInfo.LoginUserInfo.UserCode,
      [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${��ƱԱ����}', SysInfo.LoginUserInfo.UserName,
      [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${�ϳ�վ����}',
      FieldByName('departstationname').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${�ϳ�վ����}',
      FieldByName('departstationcode').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${Ʊ��}', FieldByName('ticketno').AsString,
      [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${��κ�}',
      FieldByName('schedulecode').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${��λ��}', seatnostr, [rfReplaceAll,
      rfIgnoreCase]);
    result := StringReplace(result, '${����վ����}',
      FieldByName('reachstationcode').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${����վ����}',
      FieldByName('reachstationname').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${Ʊ��}',
      format('%.2f', [FieldByName('price').AsCurrency]),
      [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${�˳�������}',
      FieldByName('customername').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${�˳������֤��}',
      FieldByName('certificateno').AsString, [rfReplaceAll, rfIgnoreCase]);
    result := StringReplace(result, '${���ƺ�}',
      FieldByName('planvehicleno').AsString, [rfReplaceAll, rfIgnoreCase]);
    // #����ʱ���������������ʱ�䡢��Ʊʱ��
    // #����ʱ���ʽ����${��������ʱ��.format(yyyy-mm-dd hh:nn:ss)}
    for i := 0 to 1 do
    begin
      if i = 0 then
      begin
        _tmpstr := '${��������ʱ��';
        _tmpdatetime := departdatetime;
      end
      else
      begin
        _tmpstr := '${��Ʊʱ��';
        _tmpdatetime := now;
      end;
      while Pos(_tmpstr, result) <> 0 do
      begin
        formattxt_all := Copy(result, Pos(_tmpstr, result) + length(_tmpstr),
          PosEx('}', result, Pos(_tmpstr, result)) - (Pos(_tmpstr,
              result) + length(_tmpstr)));
        if Trim(formattxt_all) <> '' then
        begin
          try
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              FormatDateTime(Copy(formattxt_all, length('.format(') + 1,
                  length(formattxt_all) - length('.format(') - 1),
                _tmpdatetime), [rfReplaceAll, rfIgnoreCase]);
          except
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              '��ʽ����������ʱ��ʧ��', [rfReplaceAll, rfIgnoreCase]);
          end;
        end
        else
        begin
          result := StringReplace(result, _tmpstr + formattxt_all + '}',
            datetimetostr(_tmpdatetime), [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end;

    // #��������������ͯ����Ʊ
    // #�������͸�ʽ��ʾ��: ${����ͯ.format(��,��)}
    for i := 0 to 1 do
    begin
      if i = 0 then
      begin
        _tmpstr := '${����ͯ';
        _tmpboolean := FieldByName('carrychildnum').AsInteger > 0;
      end
      else
      begin
        _tmpstr := '${��Ʊ';
        _tmpboolean := ((Self.sellway = '1') or (Self.sellway = '2'));
      end;
      while Pos(_tmpstr, result) <> 0 do
      begin
        formattxt_all := Copy(result, Pos(_tmpstr, result) + length(_tmpstr),
          PosEx('}', result, Pos(_tmpstr, result)) - (Pos(_tmpstr,
              result) + length(_tmpstr)));
        yesnotxt := Copy(formattxt_all, length('.format(') + 1,
          length(formattxt_all) - length('.format(') - 1);
        yestxt := Copy(yesnotxt, 1, Pos(',', yesnotxt) - 1);
        notxt := Copy(yesnotxt, Pos(',', yesnotxt) + 1);

        if Trim(formattxt_all) <> '' then
        begin
          if _tmpboolean then
          begin
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              yestxt, [rfReplaceAll, rfIgnoreCase]);
          end
          else
          begin
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              notxt, [rfReplaceAll, rfIgnoreCase]);
          end;
        end
        else
        begin
          result := StringReplace(result, _tmpstr + formattxt_all + '}',
            BoolToStr(_tmpboolean), [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end;

    // #Ʊ�Ž�ȡ��${Ʊ��.substring(1,7)}
    for i := 0 to 1 do
    begin
      _tmpstr := '${Ʊ��';
      _tmpticketno := FieldByName('ticketno').AsString;

      while Pos(_tmpstr, result) <> 0 do
      begin
        formattxt_all := Copy(result, Pos(_tmpstr, result) + length(_tmpstr),
          PosEx('}', result, Pos(_tmpstr, result)) - (Pos(_tmpstr,
              result) + length(_tmpstr)));
        copystr := Copy(formattxt_all, length('.copy(') + 1,
          length(formattxt_all) - length('.copy(') - 1);
        startnum := Copy(copystr, 1, Pos(',', copystr) - 1);
        endnum := Copy(copystr, Pos(',', copystr) + 1);
        if Trim(formattxt_all) <> '' then
        begin
          try
            _tmpticketno := Copy(_tmpticketno, StrToInt(startnum),
              StrToInt(endnum));
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              _tmpticketno, [rfReplaceAll, rfIgnoreCase]);
          except
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              '��ʽ��Ʊ��ʧ��', [rfReplaceAll, rfIgnoreCase]);
          end;
        end
        else
        begin
          result := StringReplace(result, _tmpstr + formattxt_all + '}',
            _tmpticketno, [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end;

    // #Ʊ��ȡ��: ${Ʊ��.trim()}
    for i := 0 to 1 do
    begin
      _tmpstr := '${Ʊ��';
      _tmpticketprice := StrToCurr(format('%.2f',
          [FieldByName('price').AsCurrency]));

      while Pos(_tmpstr, result) <> 0 do
      begin
        formattxt_all := Copy(result, Pos(_tmpstr, result) + length(_tmpstr),
          PosEx('}', result, Pos(_tmpstr, result)) - (Pos(_tmpstr,
              result) + length(_tmpstr)));
        if Trim(formattxt_all) <> '' then
        begin
          try
            _tmpticketprice := trunc(_tmpticketprice);
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              floattostr(_tmpticketprice), [rfReplaceAll, rfIgnoreCase]);
          except
            result := StringReplace(result, _tmpstr + formattxt_all + '}',
              'Ʊ��ȡ��ʧ��', [rfReplaceAll, rfIgnoreCase]);
          end;
        end
        else
        begin
          result := StringReplace(result, _tmpstr + formattxt_all + '}',
            floattostr(_tmpticketprice), [rfReplaceAll, rfIgnoreCase]);
        end;
      end;
    end;
  end;
end;

function TSellTicket.getPrintTicketnum: integer;
var
  bookmark: TBookmark;
  tOrhNum: integer;
begin
  result := 0;
  tOrhNum := 0;
  // ͳ�ƻ�����е�Ʊ��
  if FcdsTicketBuffer.Active then
  begin
    with FcdsTicketBuffer do
    begin
      if (FcdsTicketBuffer.FieldByName('tickettype').AsString = 'T') or
        (FcdsTicketBuffer.FieldByName('tickettype').AsString = 'H') then
      begin
        result := 1;
        exit;
      end;
      bookmark := GetBookmark;
      First;
      while not eof do
      begin
        if FieldByName('isroundtrip').AsBoolean then
          result := result + 2
        else
          result := result + 1;
        if (FieldByName('tickettype').AsString = 'T') or
          (FieldByName('tickettype').AsString = 'H') then
        begin
          tOrhNum := tOrhNum + 1;
        end;
        Next;
      end;
      if tOrhNum > 0 then
      begin
        result := result - tOrhNum + 1;
      end;
      GotoBookmark(bookmark);
    end;
  end;
end;

function TSellTicket.GetTickettypePrice(ScheduleId: Int64; departDate: TDate;
  tickettypecode: String; fullprice: Currency): Currency;
var
  exec: boolean;
begin
  result := 0;
  exec := false;
  if not Assigned(FcdsGetTickettypePrice) then
  begin
    FcdsGetTickettypePrice := TjsonClientDataSet.create(Self);
    with FcdsGetTickettypePrice do
    begin
      RemoteServer := DMPublic.jcon;
      SaveAddress := 'sell/findTickettypePrice';
      Params.CreateParam(ftString, 'scheduleid', ptInput);
      Params.CreateParam(ftString, 'departdate', ptInput);
      Params.CreateParam(ftString, 'tickettypecode', ptInput);
      Params.CreateParam(ftString, 'fullprice', ptInput);
      Params.CreateParam(ftCurrency, 'tickettypeprice', ptOutput);
      Params.CreateParam(ftInteger, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;
  with FcdsGetTickettypePrice do
  begin
    Params.ParamValues['scheduleid'] := ScheduleId;
    Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd',
      departDate);
    Params.ParamValues['tickettypecode'] := tickettypecode;
    Params.ParamValues['fullprice'] := fullprice;
    try
      Execute;
      exec := true;
    except
      on E: Exception do
        raise Exception.create('ȡƱ��ʧ��:' + E.Message);
    end;
    if exec then
    begin
      if Params.ParamValues['flag'] = 1 then
      begin
        result := Params.ParamByName('tickettypeprice').AsCurrency;
      end
      else
      begin
        result := -1;
        if (Params.ParamValues['msg'] = null) or
          (Params.ParamValues['msg'] = '') then
          raise Exception.create('ȡƱ��ʧ��:δ֪����')
        else
          raise Exception.create(Params.ParamValues['msg']);
      end;
    end;
  end;
end;

function TSellTicket.getTotalInsureBufferReceivablenum: Currency;
begin
  result := 0;
  // ͳ�ƻ�����еĽ��
  if (cdsInsureBuffer <> nil) and cdsInsureBuffer.Active then
  begin
    with cdsInsureBuffer do
    begin
      DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('issell').AsBoolean then
        begin
          result := result + FieldByName('premium').AsCurrency;
        end;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

function TSellTicket.getTotalTicketBufferReceivablenum: Currency;
begin
  result := 0;
  // ͳ�ƻ�����еĽ��
  if (cdsTicketBuffer <> nil) and cdsTicketBuffer.Active then
  begin
    with cdsTicketBuffer do
    begin
      DisableControls;
      First;
      while not eof do
      begin
        result := result + FieldByName('price').AsCurrency + FieldByName
          ('servicefee').AsCurrency;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TSellTicket.initcdsDDD;
begin
  if not Assigned(FcdsDDDWorkways) then
    FcdsDDDWorkways := createCdsDDD('schedule', 'workways'); // Ӫ�˷�ʽ
  if not Assigned(FcdsDDDschedulestatus) then
    FcdsDDDschedulestatus := createCdsDDD('schedulestatus', 'schedulestatus');
  // ���״̬
  if not Assigned(FcdsDDDvehicletype) then
    FcdsDDDvehicletype := createCdsDDD('vehicletype', 'type'); // ��������
  if not Assigned(FcdsDDDvehiclegrade) then
    FcdsDDDvehiclegrade := createCdsDDD('vehicletype', 'grade'); // ���͵ȼ�
  if not Assigned(FcdsDDDseattype) then
    FcdsDDDseattype := createCdsDDD('handprice', 'seattype'); // Ʊ����λ����
  if not Assigned(FcdsDDDseattype1) then
    FcdsDDDseattype1 := createCdsDDD('vehicle', 'seattype'); // Ʊ����λ����
  if not Assigned(FcdsDDDpaymethod) then
    FcdsDDDpaymethod := createCdsDDD('ticketsell', 'paymethod'); // ֧����ʽ
  if not Assigned(FcdsDDDCertificatetype) then
    FcdsDDDCertificatetype := createCdsDDD('customer', 'certificatetype');
  // ֤������
end;

procedure TSellTicket.initCdsDepartStation;
begin
  if not Assigned(FCdsDepartStation) then
  begin
    FCdsDepartStation := TjsonClientDataSet.create(Self);
    with FCdsDepartStation do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'base/liststation';
      DataSourceName := 'stationmap';
      Params.CreateParam(ftString, 'filter_EQS_s!code', ptInput);
    end;
  end;
end;

procedure TSellTicket.initcdsInsureBuffer;
  function incEx(i: integer): integer;
  begin
    inc(i);
    result := i;
  end;

var
  field: TField;
  i: integer;
begin
  if not Assigned(FcdsInsureBuffer) then
  begin
    FcdsInsureBuffer := createCdsInsureBuffer(Self);
  end;
end;

procedure TSellTicket.initcdsSchedule;
  function incEx(i: integer): integer;
  begin
    inc(i);
    result := i;
  end;

var
  i: integer;
begin
  if not Assigned(FcdsSchedule) then
  begin
    FcdsSchedule := TjsonClientDataSet.create(Self);
    with FcdsSchedule do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'sell/findSchedule';
      DataSourceName := 'preSaleSchedules';
      Params.CreateParam(ftString, 'isnet', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.departDate', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.departStationId',
        ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.reachStationId',
        ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.scheduleid', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.seller', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.ip', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.ticketoutletsid',
        ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.sellway', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.ticketIdToBeChange',
        ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.customerid', ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.districtcode',
        ptInput);
      Params.CreateParam(ftString, 'scheduleAskCondition.reachStationName',
        ptInput);

      i := -1;
      createField('routename', '', ftWideString, 60, incEx(i), FcdsSchedule);
      createField('returntripvaliddays', '', ftInteger, 0, incEx(i),
        FcdsSchedule);
      createField('schedulecode', '', ftWideString, 20, incEx(i), FcdsSchedule);
      createField('scheduleremarks', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('remarks', '', ftWideString, 100, incEx(i), FcdsSchedule);
      createField('schedulesynccode', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('departstationname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('departstationcode', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('reachstationname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('reachstationcode', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('reachstationsecondname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('isroundtrip', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('startstationname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('endstationname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planvehicletype', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planvehiclegrade', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planvehicleno', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planvehicletypecustomname', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planunitname', '', ftWideString, 60, incEx(i), FcdsSchedule);
      createField('planbrandmodel', '', ftWideString, 60, incEx(i),
        FcdsSchedule);
      createField('planbrandmodelid', '', ftLargeint, 0, incEx(i),
        FcdsSchedule);

      createField('id', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('autocancelreserveseatnum', '', ftInteger, 0, incEx(i),
        FcdsSchedule);
      createField('departdate', '', ftDate, 0, incEx(i), FcdsSchedule);
      createField('districttype', '', ftWideString, 10, incEx(i), FcdsSchedule);
      createField('endstationid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('endtime', '', ftWideString, 5, incEx(i), FcdsSchedule);
      createField('fixedreserveseatnum', '', ftInteger, 0, incEx(i),
        FcdsSchedule);
      createField('islinework', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isoriginator', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isovertime', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isproprietary', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('issaleafterreport', '', ftBoolean, 0, incEx(i),
        FcdsSchedule);
      createField('issellreturnticket', '', ftBoolean, 0, incEx(i),
        FcdsSchedule);
      createField('orgid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('runtime', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('scheduleid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('scheduletype', '', ftWideString, 10, incEx(i), FcdsSchedule);
      createField('spacinginterval', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('startstationid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('starttime', '', ftWideString, 5, incEx(i), FcdsSchedule);
      createField('unautocancelreserveseatnum', '', ftInteger, 0, incEx(i),
        FcdsSchedule);
      createField('worktype', '', ftWideString, 10, incEx(i), FcdsSchedule);
      createField('workways', '', ftWideString, 10, incEx(i), FcdsSchedule);

      createField('planunitid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('planvehicleid', '', ftLargeint, 0, incEx(i), FcdsSchedule);

      createField('departstationid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('reachstationid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('residueseatnum', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('seatnos', '', ftWideString, 300, incEx(i), FcdsSchedule);
      createField('seatnum', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('soldeatnum', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('carrychildnum', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('residuecarrychildnum', '', ftInteger, 0, incEx(i),
        FcdsSchedule);

      createField('distance', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('balancedistance', '', ftInteger, 0, incEx(i), FcdsSchedule);
      createField('fullprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('halfprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('studentprice', '', ftFloat, 0, incEx(i), FcdsSchedule);

      createField('moreprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('toplimitprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('lowerlimitprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('fueladditionfee', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('stationservicefee', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('seattype', '', ftWideString, 10, incEx(i), FcdsSchedule);
      createField('vcleseattype', '', ftWideString, 10, incEx(i), FcdsSchedule);
      // createField('runtime', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      // createField('issellable', '', ftBoolean,10, incEx(i), FcdsSchedule) ;
      // private orgid;

      createField('scheduleplanid', '', ftLargeint, 0, incEx(i), FcdsSchedule);
      createField('buspark', '', ftWideString, 50, incEx(i), FcdsSchedule);
      createField('departtime', '', ftWideString, 5, incEx(i), FcdsSchedule);
      createField('isbegincheck', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isdeparted', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isreported', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('isemptyvehicle', '', ftBoolean, 0, incEx(i), FcdsSchedule);
      createField('status', '', ftWideString, 10, incEx(i), FcdsSchedule);
      createField('ticketentrance', '', ftWideString, 50, incEx(i),
        FcdsSchedule);
      createField('ticketentrancename', '', ftWideString, 50, incEx(i),
        FcdsSchedule);
      createField('discountprice', '', ftFloat, 0, incEx(i), FcdsSchedule);
      createField('discountpriceticket', '', ftInteger, 0, incEx(i),
        FcdsSchedule);
      createField('endstation', '', ftWideString, 50, incEx(i), FcdsSchedule);
      createField('startstationprice', '', ftFloat, 0, incEx(i), FcdsSchedule);

      createLookupField('workwaysname', '', 'workways', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDWorkways);
      createLookupField('statusname', '', 'status', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDschedulestatus);
      createLookupField('planvehicletypename', '', 'planvehicletype', 'code',
        'value', ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDvehicletype);
      createLookupField('planvehiclegradename', '', 'planvehiclegrade', 'code',
        'value', ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDvehiclegrade);
      createLookupField('seattypename', '', 'seattype', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDseattype);
      // SysDialogs.showmessage( FcdsSchedule.FieldByName('seattype').AsString);
      // SysDialogs.showmessage( FcdsSchedule.FieldByName('vcleseattype').AsString);
      createLookupField('vcleseattypename', '', 'vcleseattype', 'code',
        'value', ftWideString, 50, incEx(i), FcdsSchedule, FcdsDDDseattype1);

    end;
  end;
end;

procedure TSellTicket.initCdsScheduleQry;
begin
  if not Assigned(FCdsScheduleQry) then
  begin
    FCdsScheduleQry := TjsonClientDataSet.create(Self);
    with FCdsScheduleQry do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'base/queryschedule';
      DataSourceName := 'schedulelist';
      Params.CreateParam(ftString, 'filter_EQL_s!id', ptInput);
    end;
  end;
end;

procedure TSellTicket.initCdsSchedulestopremark;
begin
  if not Assigned(FCdsSchedulestopremark) then
  begin
    FCdsSchedulestopremark := TjsonClientDataSet.create(Self);
    with FCdsSchedulestopremark do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'base/qrytheschedulestop';
      DataSourceName := 'schedulestoplist';
      Params.CreateParam(ftString, 'scheduleid', ptInput);
      Params.CreateParam(ftString, 'stationid', ptInput);
    end;
  end;
end;

procedure TSellTicket.initCdsTicketBuffer;
  function incEx(i: integer): integer;
  begin
    inc(i);
    result := i;
  end;

var
  field: TField;
  i: integer;
begin
  // ��·����Ρ�Ӫ�˷�ʽ���Ƿ�Ӱࡢ�������ڡ�����ʱ�䡢��λ�š�Ʊ�֣���ӡ��־����Ʊ�ۣ�ִ�мۣ����ϳ�վ�㡢����վ����վ��Ӧ���֡�
  // Ʊ�š���Ʊ����ͯ������/�ȼ�/����Զ��峵�����ƣ���������λ����Ʊ�ڡ����ƺš���λ��
  // ����ָ����=����Ʊ�ۡ���α�ע��ȼ�ͷ�(Ʊ�۹̶���)��վ��ѣ�Ʊ�۹̶������
  if not Assigned(FcdsTicketBuffer) then
  begin
    FcdsTicketBuffer := TjsonClientDataSet.create(Self);
    with FcdsTicketBuffer do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'sell/findTicketBuffer';
      SaveAddress := 'sell/sellTicket';
      DataSourceName := 'ticketsPrintInfo';
      UpdateDataSet := 'sellTickets';
      refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'discountpricenum', ptInput); // ��Ʊʱ������Ż�Ʊ��
      Params.CreateParam(ftString, 'hirebustotalprice', ptInput); // ����Ʊ�ܽ��
      Params.CreateParam(ftString, 'isnet', ptInput); // �Ƿ�����Ʊ
      Params.CreateParam(ftString, 'ticketsellid', ptInput); // �����ش�Ʊ
      Params.CreateParam(ftString, 'curticketno', ptInput); // ���ڻ�Ʊ���ش�Ʊ
      Params.CreateParam(ftString, 'ticketIdToBeChanges', ptInput);
      // Ҫ��Ʊ�ĳ�Ʊidֵ,���ڸ�ǩ
      Params.CreateParam(ftString, 'insuranceIdToBeChanges', ptInput);
      // Ҫ��Ʊ�ĳ�Ʊ��Ӧ����idֵ,���ڸ�ǩ

      Params.CreateParam(ftString, 'order.orgid', ptInput);
      Params.CreateParam(ftString, 'order.departstationcode', ptInput);
      Params.CreateParam(ftString, 'order.seller', ptInput);
      Params.CreateParam(ftString, 'order.sellername', ptInput);
      Params.CreateParam(ftString, 'order.batchno', ptInput);
      Params.CreateParam(ftString, 'order.startTicketNO', ptInput);
      Params.CreateParam(ftString, 'order.totalmoney', ptInput);
      Params.CreateParam(ftString, 'order.ip', ptInput);
      Params.CreateParam(ftString, 'order.ticketoutletsid', ptInput);
      Params.CreateParam(ftString, 'order.ticketoutletsname', ptInput);
      Params.CreateParam(ftString, 'order.sellway', ptInput);
      Params.CreateParam(ftString, 'order.orderno', ptInput);
      Params.CreateParam(ftString, 'order.vipcardno', ptInput);
      Params.CreateParam(ftString, 'order.vipgrade', ptInput);
      Params.CreateParam(ftString, 'order.vipmoney', ptInput);
      Params.CreateParam(ftString, 'order.vippoint', ptInput);

      Params.CreateParam(ftInteger, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
      i := -1;
      createField('id', '', ftLargeint, 0, incEx(i), FcdsTicketBuffer);
      createField('scheduleplanid', '', ftLargeint, 0, incEx(i),
        FcdsTicketBuffer);
      createField('departdate', '', ftDate, 0, incEx(i), FcdsTicketBuffer);

      createField('routename', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('startstationname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);
      createField('endstationname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);

      createField('scheduleid', '', ftLargeint, 0, incEx(i), FcdsTicketBuffer);
      createField('schedulecode', '', ftWideString, 20, incEx(i),
        FcdsTicketBuffer);
      createField('schedulesynccode', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('workways', '', ftWideString, 10, incEx(i), FcdsTicketBuffer);
      createLookupField('workwaysname', '', 'workways', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsTicketBuffer, FcdsDDDWorkways);

      createField('islinework', '', ftBoolean, 0, incEx(i), FcdsTicketBuffer);
      createField('isovertime', '', ftBoolean, 0, incEx(i), FcdsTicketBuffer);
      createField('scheduleremarks', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('orgid', '', ftLargeint, 0, incEx(i), FcdsTicketBuffer);

      createField('seattype', '', ftWideString, 10, incEx(i), FcdsTicketBuffer);
      createLookupField('seattypename', '', 'seattype', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsTicketBuffer, FcdsDDDseattype);

      // ����������λ����
      createField('vcleseattype', '', ftWideString, 10, incEx(i),
        FcdsTicketBuffer);
      createLookupField('vcleseattypename', '', 'vcleseattype', 'code',
        'value', ftWideString, 50, incEx(i), FcdsTicketBuffer,
        FcdsDDDseattype1);

      createField('departstationid', '', ftLargeint, 0, incEx(i),
        FcdsTicketBuffer);
      createField('reachstationid', '', ftLargeint, 0, incEx(i),
        FcdsTicketBuffer);
      createField('departstationcode', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('reachstationcode', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('departstationname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);
      createField('reachstationname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);
      createField('reachstationsecondname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);
      createField('departtime', '', ftWideString, 5, incEx(i),
        FcdsTicketBuffer);
      createField('distance', '', ftLargeint, 0, incEx(i), FcdsTicketBuffer);
      createField('tickettype', '', ftWideString, 10, incEx(i),
        FcdsTicketBuffer);
      createLookupField('tickettypeprintname', '', 'tickettype', 'code',
        'printname', ftWideString, 50, incEx(i), FcdsTicketBuffer,
        FcdsTicketType);

      createField('fullprice', '', ftFloat, 0, incEx(i), FcdsTicketBuffer);
      createField('discountrate', '', ftCurrency, 0, incEx(i),
        FcdsTicketBuffer);
      createField('price', '', ftFloat, 0, incEx(i), FcdsTicketBuffer);
      createField('moreprice', '', ftFloat, 0, incEx(i), FcdsTicketBuffer);
      createField('servicefee', '', ftFloat, 0, incEx(i), FcdsTicketBuffer);
      createField('toplimitprice', '', ftFloat, 0, incEx(i), FcdsTicketBuffer);
      createField('fueladditionfee', '', ftFloat, 0, incEx(i),
        FcdsTicketBuffer);
      createField('stationservicefee', '', ftFloat, 0, incEx(i),
        FcdsTicketBuffer);

      createField('ticketno', '', ftWideString, 30, incEx(i), FcdsTicketBuffer);
      createField('seatno', '', ftInteger, 0, incEx(i), FcdsTicketBuffer);
      createField('seatnostr', '', ftWideString, 20, incEx(i),
        FcdsTicketBuffer);
      createField('carrychildnum', '', ftInteger, 0, incEx(i),
        FcdsTicketBuffer);
      createField('ticketentrance', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('ticketentrancename', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('buspark', '', ftWideString, 50, incEx(i), FcdsTicketBuffer);

      createField('paymethod', '', ftWideString, 10, incEx(i),
        FcdsTicketBuffer);
      createLookupField('paymethodname', '', 'paymethod', 'code', 'value',
        ftWideString, 50, incEx(i), FcdsTicketBuffer, FcdsDDDpaymethod);

      createField('handticketoutletsid', '', ftLargeint, 0, incEx(i),
        FcdsTicketBuffer);
      createField('customerid', '', ftLargeint, 0, incEx(i), FcdsTicketBuffer);
      createField('certificatetype', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('certificateno', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);

      // createField('vehiclebrandmodelid', '', ftLargeint,0, incEx(i), FcdsTicketBuffer) ;
      // createField('vehicleid', '', ftLargeint,0, incEx(i), FcdsTicketBuffer) ;
      // createField('vehicletypeid', '', ftLargeint,0, incEx(i), FcdsTicketBuffer) ;
      createField('planvehicletype', '', ftWideString, 50, incEx(i),
        FcdsTicketBuffer);
      createField('planvehiclegrade', '', ftWideString, 50, incEx(i),
        FcdsTicketBuffer);
      createLookupField('planvehicletypename', '', 'planvehicletype', 'code',
        'value', ftWideString, 50, incEx(i), FcdsTicketBuffer,
        FcdsDDDvehicletype);
      createLookupField('planvehiclegradename', '', 'planvehiclegrade', 'code',
        'value', ftWideString, 50, incEx(i), FcdsTicketBuffer,
        FcdsDDDvehiclegrade);
      createField('planvehicletypecustomname', '', ftWideString, 30, incEx(i),
        FcdsTicketBuffer);
      createField('planunitname', '', ftWideString, 60, incEx(i),
        FcdsTicketBuffer);
      createField('planbrandmodel', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('planvehicleno', '', ftWideString, 20, incEx(i),
        FcdsTicketBuffer);
      createField('returntripvaliddays', '', ftInteger, 0, incEx(i),
        FcdsTicketBuffer);
      createField('isroundtrip', '', ftBoolean, 0, incEx(i), FcdsTicketBuffer);
      createField('customername', '', ftWideString, 20, incEx(i),
        FcdsTicketBuffer);
      createField('isaudited', '', ftBoolean, 0, incEx(i), FcdsTicketBuffer);
      createField('isauditpass', '', ftBoolean, 0, incEx(i), FcdsTicketBuffer);
      createField('schedulestopremark1', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('schedulestopremark2', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('schedulestopremark3', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('schedulestopremark4', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('schedulestopremark5', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('departstationdescription', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
      createField('departstationsecondname', '', ftWideString, 100, incEx(i),
        FcdsTicketBuffer);
    end;
  end;
end;

function TSellTicket.initInsureNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Insure') and
    (SysInfo.LoginUserInfo.curBillNum.Items['Insure'] > 0);
  if not result then
  begin
    functionParm := TFunctionItemParameters.create;
    functionParm.CommaText := 'Insure';
    SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
      functionParm);
    result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Insure') and
      (SysInfo.LoginUserInfo.curBillNum.Items['Insure'] > 0);
  end;
end;

procedure TSellTicket.initInsureOutputConfig;
var
  Ini: TIniFile;
  keyList: TStrings;
  i: integer;
begin
  if FileExists(ExtractFilePath(Paramstr(0)) + applicationCfgName) then
  begin
    Ini := TIniFile.create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    try
      insureoutputTxtFilename := Ini.ReadString('insureoutput', 'txtfilename',
        '');
      insureoutputTxtFilename := StringReplace(insureoutputTxtFilename,
        '${sellercode}', SysInfo.LoginUserInfo.UserCode, [rfReplaceAll,
        rfIgnoreCase]);

      insureoutputtxtformat := Ini.ReadString('insureoutput', 'txtformat', '');
    finally
      Ini.Free;
    end;
  end;
end;

function TSellTicket.initInSurePrinter: boolean;
var
  Ini: TIniFile;
  insureprinttype: integer;
begin
  result := false;
  try
    FinsurePrint := TNovaPrint.create(Self,
      TNovaPrint.GetTicketModelName('���յ�', 'Insure1'));
    Ini := TIniFile.create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    if FinsurePrint <> nil then
    begin
      insureprinttype := Ini.ReadInteger('printtypepara', 'printtype', 0);
      FinsurePrint.printtype := inttostr(insureprinttype);
      result := true;
    end
    else
    begin
      SysDialogs.Warning('��ʼ�����յ���ӡģ��ʧ�ܣ�δ֪���󣬲����۱���');
    end;
  except
    on E: Exception do
      SysDialogs.Warning('��ʼ�����յ���ӡģ��ʧ�ܣ�' + E.Message + '�������۱���');
  end;
end;

procedure TSellTicket.getInsureType(istypeid: String);
begin
  Self.insuretypeid := istypeid;
  initInsureType();
end;

function TSellTicket.initInsureType: boolean;
begin
  result := false;
  if not Assigned(Fcdsinsuretype) then
  begin
    Fcdsinsuretype := TjsonClientDataSet.create(Self);
    with Fcdsinsuretype do
    begin
      // QueryAddress := 'base/qryinsuretype';
      QueryAddress := 'base/queryInsuretype';
      RemoteServer := DMPublic.jcon;
      DataSourceName := 'insuretypemap';
      // Params.CreateParam(ftString,'userid',ptInput);
      // Params.CreateParam(ftString, 'filter_EQL_i!id', ptInput);
    end;
  end;
  with Fcdsinsuretype do
  begin
    Active := false;
    // Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
    // Params.ParamValues['filter_EQL_i!id'] := insuretypeid;
    Active := true;
    result := RecordCount > 0;
  end;
  if not result then
    SysDialogs.Warning('��ʼ�����ղ�Ʒʧ�ܣ������۱���');
end;

function TSellTicket.getCustomernameByID(customerid: Int64): string;
begin
  if not Assigned(Fcdsquerycustomer) then
  begin
    Fcdsquerycustomer := TjsonClientDataSet.create(Self);
    with Fcdsquerycustomer do
    begin
      QueryAddress := 'archive/findCustomer';
      RemoteServer := DMPublic.jcon;
      DataSourceName := 'customermap';
      Params.CreateParam(ftString, 'filter_EQL_c!id', ptInput);
    end;
  end;
  with Fcdsquerycustomer do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_c!id'] := customerid;
    Active := true;
    if RecordCount > 0 then
    begin
      result := FieldValues['name'];
    end;
  end;
end;

function TSellTicket.initReturntripticketPrint: boolean;
var
  Ini: TIniFile;
  returnprinttype: integer;
begin
  result := false;
  try
    FreturntripticketPrint := TNovaPrint.create(Self,
      TNovaPrint.GetTicketModelName('���̳�Ʊ', '���̳�Ʊ'));
    Ini := TIniFile.create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    if FreturntripticketPrint <> nil then
    begin
      returnprinttype := Ini.ReadInteger('printtypepara', 'printtype', 0);
      FreturntripticketPrint.printtype := inttostr(returnprinttype);
      result := true;
    end;
  except
    on E: Exception do
    end;
  end;

  function TSellTicket.initTicketNo: boolean;
  var
    functionParm: TFunctionItemParameters;
  begin
    result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
      (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
    if not result then
    begin
      functionParm := TFunctionItemParameters.create;
      functionParm.CommaText := 'Ticket';
      SysFunctionMgr.exec
        (StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'), functionParm);
      result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
        (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
    end;
  end;

  function TSellTicket.initTicketPrinter: boolean;
  var
    Ini: TIniFile;
    ticketprinttype: integer;
  begin
    inherited;
    result := false;
    try
      FticketPrint := TNovaPrint.create(Self,
        TNovaPrint.GetTicketModelName('��Ʊ', 'Ticket1'));
      Ini := TIniFile.create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
      if FticketPrint <> nil then
      begin
        ticketprinttype := Ini.ReadInteger('printtypepara', 'printtype', 0);
        FticketPrint.printtype := inttostr(ticketprinttype);
        result := true;
      end
      else
      begin
        SysDialogs.ShowError('��ʼ����Ʊ��ӡģ��ʧ�ܣ�δ֪����');
      end;
    except
      on E: Exception do
        SysDialogs.ShowError('��ʼ����Ʊ��ӡģ��ʧ�ܣ�' + E.Message);
    end;
  end;

  function TSellTicket.initServicefeePrinter: boolean;
  var
    Ini: TIniFile;
    feeprinttype: integer;
  begin
    inherited;
    result := false;
    try
      FservicefeePrint := TNovaPrint.create(Self,
        TNovaPrint.GetTicketModelName('��ӡ������', '��ӡ������'));
      Ini := TIniFile.create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
      if FservicefeePrint <> nil then
      begin
        feeprinttype := Ini.ReadInteger('printtypepara', 'printtype', 0);
        FservicefeePrint.printtype := inttostr(feeprinttype);
        result := true;
      end
      else
      begin
        SysDialogs.ShowError('��ʼ�������Ѵ�ӡģ��ʧ�ܣ�δ֪����');
      end;
    except
      on E: Exception do
        SysDialogs.ShowError('��ʼ�������Ѵ�ӡģ��ʧ�ܣ�' + E.Message);
    end;
  end;

  function TSellTicket.initTicketType: boolean;
  begin
    result := false;
    if not Assigned(FcdsTicketType) then
    begin
      FcdsTicketType := TjsonClientDataSet.create(Self);
      with FcdsTicketType do
      begin
        QueryAddress := 'base/findTickettypeByPermission';
        RemoteServer := DMPublic.jcon;
        DataSourceName := 'tickettypemap'; // tickettypes
        Params.CreateParam(ftString, 'userid', ptInput);
        // Params.CreateParam(ftString,'roleid',ptInput);
        Params.CreateParam(ftString, 'ticketoutletsid', ptInput);
      end;
    end;
    with FcdsTicketType do
    begin
      Active := false;
      Params.ParamValues['userid'] := SysInfo.LoginUserInfo.UserID;
      // Params.ParamValues['roleid']:=SysInfo.LoginUserInfo.RoleID;
      Params.ParamValues['ticketoutletsid'] :=
        SysInfo.LoginUserInfo.ticketoutletsid;
      Active := true;
      result := RecordCount > 0;
      if not result then
      begin
        SysDialogs.ShowError('��û��Ʊ����ƱȨ�ޣ�������Ʊ��');
      end;
    end;
  end;

  function TSellTicket.lockSeat(orderno: TGUID; scheduleplanid: Int64;
    seatnos: TList<Word>; selectSeatStatus: TList<String>;
    selectSeattype: String; var seatnos_S: String): TDateTime;
  var
    outJxsEticketid_S: String;
  begin
    outJxsEticketid_S := '';
    result := Self.lockSeat(orderno, scheduleplanid, seatnos, selectSeatStatus,
      selectSeattype, seatnos_S, '', '', outJxsEticketid_S, 0);
  end;

  function TSellTicket.lockSeat(orderno: TGUID; scheduleplanid: Int64;
    seatnos: TList<Word>; selectSeatStatus: TList<String>;
    selectSeattype: String; var seatnos_S: String; tickettypes_S: String;
    pricess_S: string; var outJxsEticketid_S: string;
    takekidnum: integer): TDateTime;
  var // seatnos_S:String;
    selectSeatStatus_S: String;
    seatno: Word;
    _selectSeatStatus: string;
  begin
    if not Assigned(FcdsLockSeats) then
    begin
      FcdsLockSeats := TjsonClientDataSet.create(Self);
      with FcdsLockSeats do
      begin
        SaveAddress := 'sell/lockSeat';
        RemoteServer := DMPublic.jcon;
        Params.CreateParam(ftString, 'isnet', ptInput);
        Params.CreateParam(ftString, 'orderno', ptInput);
        Params.CreateParam(ftString, 'scheduleplanid', ptInput);
        Params.CreateParam(ftString, 'seatnos_S', ptInput);
        Params.CreateParam(ftString, 'selectSeatStatus_S', ptInput);
        Params.CreateParam(ftString, 'selectSeattype', ptInput);
        Params.CreateParam(ftString, 'departdate', ptInput);
        Params.CreateParam(ftString, 'schedulesynccode', ptInput);
        Params.CreateParam(ftString, 'departstationcode', ptInput);

        Params.CreateParam(ftString, 'departtime', ptInput);
        Params.CreateParam(ftString, 'reachstationcode', ptInput);
        Params.CreateParam(ftString, 'tickettypes_S', ptInput);
        Params.CreateParam(ftString, 'pricess_S', ptInput);
        Params.CreateParam(ftString, 'routecode', ptInput);

        Params.CreateParam(ftInteger, 'flag', ptOutput);
        Params.CreateParam(ftString, 'msg', ptOutput);
        Params.CreateParam(ftString, 'outseatnos_S', ptOutput);
        Params.CreateParam(ftDateTime, 'unlocktime', ptOutput);
        Params.CreateParam(ftString, 'outJxsEticketid_S', ptOutput);
        Params.CreateParam(ftString, 'takekidnum', ptInput);
      end;
    end;
    seatnos_S := '';
    for seatno in seatnos do
      if seatnos_S = '' then
        seatnos_S := inttostr(seatno)
      else
        seatnos_S := seatnos_S + ',' + inttostr(seatno);
    selectSeatStatus_S := '';
    for _selectSeatStatus in selectSeatStatus do
      if selectSeatStatus_S = '' then
        selectSeatStatus_S := _selectSeatStatus
      else
        selectSeatStatus_S := selectSeatStatus_S + ',' + _selectSeatStatus;
    with FcdsLockSeats do
    begin
      Active := false;

      // Params.ParamValues['isnet']:= isnet;
      if isnet then
      begin
        Params.ParamValues['isnet'] := 1; // ����������
      end
      else
      begin
        Params.ParamValues['isnet'] := 0; // ������
      end;

      Params.ParamValues['orderno'] := ReplaceText
        (ReplaceText(GUIDToString(orderno), '{', ''), '}', '');
      Params.ParamValues['scheduleplanid'] := inttostr(scheduleplanid);
      Params.ParamValues['seatnos_S'] := seatnos_S;
      Params.ParamValues['selectSeatStatus_S'] := selectSeatStatus_S;
      Params.ParamValues['selectSeattype'] := selectSeattype;
      Params.ParamValues['departdate'] := FcdsSchedule.FieldByName('departdate')
        .AsString;
      Params.ParamValues['schedulesynccode'] := FcdsSchedule.FieldByName
        ('schedulesynccode').AsString;
      Params.ParamValues['departstationcode'] := FcdsSchedule.FieldByName
        ('departstationcode').AsString;

      Params.ParamValues['departtime'] := FcdsSchedule.FieldByName('departtime')
        .AsString;
      Params.ParamValues['reachstationcode'] := FcdsSchedule.FieldByName
        ('reachstationcode').AsString;
      Params.ParamValues['tickettypes_S'] := tickettypes_S;
      Params.ParamValues['pricess_S'] := pricess_S;
      Params.ParamValues['routecode'] := FcdsSchedule.FieldByName('remarks')
        .AsString;
      Params.ParamValues['takekidnum'] := takekidnum;
      try
        Execute;
        if Params.ParamValues['flag'] = 1 then
        begin
          result := Params.ParamByName('unlocktime').AsDateTime;
          seatnos_S := Params.ParamByName('outseatnos_S').AsString;
          if Params.ParamByName('outJxsEticketid_S').IsNull then
            outJxsEticketid_S := ''
          else
            outJxsEticketid_S := Params.ParamByName('outJxsEticketid_S')
              .AsString;
        end
        else
        begin
          if (Params.ParamValues['msg'] = null) or
            (Params.ParamValues['msg'] = '') then
            raise Exception.create('����λʧ��:δ֪����')
          else
            raise Exception.create(Params.ParamValues['msg']);
        end;
      except
        on E: Exception do
          raise Exception.create('����λʧ��:' + E.Message);
      end;
    end;
  end;

  function TSellTicket.lockSeat(orderno: TGUID; scheduleplanid: Int64;
    selectSeattype: String; var seatnos_S: String): TDateTime;
  var
    outJxsEticketid_S: String;
  begin
    outJxsEticketid_S := '';
    result := Self.lockSeat(orderno, scheduleplanid, selectSeattype, seatnos_S,
      '', '', outJxsEticketid_S, 0);
  end;

  function TSellTicket.lockSeat(orderno: TGUID; scheduleplanid: Int64;
    selectSeattype: String; var seatnos_S: String; tickettypes_S: String;
    pricess_S: string; var outJxsEticketid_S: string;
    takekidnum: integer): TDateTime;
  var // seatnos_S:String;
    selectSeatStatus_S: String;
    seatno: Word;
    _selectSeatStatus: string;
  begin
    if not Assigned(FcdsLockSeats) then
    begin
      FcdsLockSeats := TjsonClientDataSet.create(Self);
      with FcdsLockSeats do
      begin
        SaveAddress := 'sell/lockSeat';
        RemoteServer := DMPublic.jcon;
        Params.CreateParam(ftString, 'isnet', ptInput);
        Params.CreateParam(ftString, 'orderno', ptInput);
        Params.CreateParam(ftString, 'scheduleplanid', ptInput);
        Params.CreateParam(ftString, 'seatnos_S', ptInput);
        Params.CreateParam(ftString, 'selectSeatStatus_S', ptInput);
        Params.CreateParam(ftString, 'selectSeattype', ptInput);
        Params.CreateParam(ftString, 'departdate', ptInput);
        Params.CreateParam(ftString, 'schedulesynccode', ptInput);
        Params.CreateParam(ftString, 'departstationcode', ptInput);

        Params.CreateParam(ftString, 'departtime', ptInput);
        Params.CreateParam(ftString, 'reachstationcode', ptInput);
        Params.CreateParam(ftString, 'tickettypes_S', ptInput);
        Params.CreateParam(ftString, 'pricess_S', ptInput);
        Params.CreateParam(ftString, 'routecode', ptInput);

        Params.CreateParam(ftInteger, 'flag', ptOutput);
        Params.CreateParam(ftString, 'msg', ptOutput);
        Params.CreateParam(ftString, 'outseatnos_S', ptOutput);
        Params.CreateParam(ftDateTime, 'unlocktime', ptOutput);
        Params.CreateParam(ftString, 'outJxsEticketid_S', ptOutput);
        Params.CreateParam(ftString, 'takekidnum', ptInput);
      end;
    end;
    seatnos_S := '';
    // seatnos_S:=seatnos_S+','+inttostr(seatno);
    selectSeatStatus_S := '';
    // selectSeatStatus_S:=selectSeatStatus_S+','+_selectSeatStatus;
    with FcdsLockSeats do
    begin
      Active := false;

      Params.ParamValues['isnet'] := 2; // ʡ��������

      Params.ParamValues['orderno'] := ReplaceText
        (ReplaceText(GUIDToString(orderno), '{', ''), '}', '');
      Params.ParamValues['scheduleplanid'] := inttostr(scheduleplanid);
      Params.ParamValues['seatnos_S'] := seatnos_S;
      Params.ParamValues['selectSeatStatus_S'] := selectSeatStatus_S;
      Params.ParamValues['selectSeattype'] := selectSeattype;
      Params.ParamValues['departdate'] := FcdsSchedule.FieldByName('departdate')
        .AsString;
      Params.ParamValues['schedulesynccode'] := FcdsSchedule.FieldByName
        ('schedulecode').AsString;
      Params.ParamValues['departstationcode'] := FcdsSchedule.FieldByName
        ('departstationcode').AsString;

      Params.ParamValues['departtime'] := FcdsSchedule.FieldByName('departtime')
        .AsString;
      Params.ParamValues['reachstationcode'] := FcdsSchedule.FieldByName
        ('reachstationcode').AsString;
      Params.ParamValues['tickettypes_S'] := tickettypes_S;
      Params.ParamValues['pricess_S'] := pricess_S;
      Params.ParamValues['routecode'] := FcdsSchedule.FieldByName('remarks')
        .AsString;
      Params.ParamValues['takekidnum'] := takekidnum;
      try
        Execute;
        if Params.ParamValues['flag'] = 1 then
        begin
          result := Params.ParamByName('unlocktime').AsDateTime;
          seatnos_S := Params.ParamByName('outseatnos_S').AsString;
          if Params.ParamByName('outJxsEticketid_S').IsNull then
            outJxsEticketid_S := ''
          else
            outJxsEticketid_S := Params.ParamByName('outJxsEticketid_S')
              .AsString;
        end
        else
        begin
          if (Params.ParamValues['msg'] = null) or
            (Params.ParamValues['msg'] = '') then
            raise Exception.create('����λʧ��:δ֪����')
          else
            raise Exception.create(Params.ParamValues['msg']);
        end;
      except
        on E: Exception do
          raise Exception.create('����λʧ��:' + E.Message);
      end;
    end;
  end;

  function TSellTicket.printinsure: boolean;
  begin
    with FinsurePrint.SingleValue, cdsInsureBuffer do
    begin
      First;
      while not eof do
      begin
        if not FieldByName('issell').AsBoolean then
        begin
          Next;
          Continue;
        end;

        AddOrSetValue('certificatetypename',
          FieldByName('certificatetypename').AsString);
        AddOrSetValue('selltime', FieldByName('selltime').AsString);
        AddOrSetValue('ticketoutletsname',
          FieldByName('ticketoutletsname').AsString);

        AddOrSetValue('certificateno', FieldByName('certificateno').AsString);
        AddOrSetValue('customername', FieldByName('customername').AsString);
        AddOrSetValue('familyaddress', FieldByName('familyaddress').AsString);
        AddOrSetValue('familyphone', FieldByName('familyphone').AsString);
        AddOrSetValue('mobilephone', FieldByName('mobilephone').AsString);
        AddOrSetValue('insuranceno', FieldByName('insuranceno').AsString);

        AddOrSetValue('departdate', FieldByName('departdate').AsString);
        AddOrSetValue('schedulecode', FieldByName('schedulecode').AsString);
        AddOrSetValue('departstationname',
          FieldByName('departstationname').AsString);
        AddOrSetValue('reachstationname',
          FieldByName('reachstationname').AsString);
        AddOrSetValue('reachstationsecondname',
          FieldByName('reachstationsecondname').AsString);
        AddOrSetValue('tickettypeprintname',
          FieldByName('tickettypeprintname').AsString);
        AddOrSetValue('ticketno', FieldByName('ticketno').AsString);
        if FieldByName('carrychildnum').AsInteger < 1 then
          AddOrSetValue('carrychildnum', '')
        else
          AddOrSetValue('carrychildnum', FieldByName('carrychildnum').AsString);
        AddOrSetValue('premium', FieldByName('premium').AsString);
        AddOrSetValue('insureamount', FieldByName('insureamount').AsString);

        if FieldByName('islinework').AsBoolean then
        begin
          AddOrSetValue('islinework', '��ˮ��');
          AddOrSetValue('seatno', '���̶�');
          AddOrSetValue('departtime',
            FieldByName('departtime').AsString + 'ǰ�ϳ���Ч');
        end
        else
        begin
          AddOrSetValue('islinework', '');
          AddOrSetValue('seatno', FieldByName('seatnostr').AsString);
          AddOrSetValue('departtime', FieldByName('departtime').AsString);
        end;
        AddOrSetValue('sellbycode', SysInfo.LoginUserInfo.UserCode);
        AddOrSetValue('sellbyname', SysInfo.LoginUserInfo.UserName);
        if FieldByName('polnumber').IsNull then
        begin
          AddOrSetValue('polnumber', '');
        end
        else
        begin
          AddOrSetValue('polnumber', FieldByName('polnumber').AsString);
        end;
        AddOrSetValue('emoney', FieldByName('emoney').AsString); // �����˺����ս��
        AddOrSetValue('emmoney', FieldByName('emmoney').AsString); // �����˺�ҽ�Ʊ��ս��
        AddOrSetValue('reprintdatetime',
          FieldByName('reprintdatetime').AsString); // ����Ʊ��Ʊʱ��
        FinsurePrint.Print;
        Next;
      end;
    end;
  end;

  function TSellTicket.printTicket: boolean;
  var
    hasschedulestopremark: boolean;
    tmpprice: Currency;
    tmpfueladditionfee: Currency;
    tmpstationservicefee: Currency;
    tmpservicefee: Currency;
    tmpcarrychildnum: integer;
    ticketnonum: Int64;
    tOrhticketnum: Int64;
    certificateno: String;
  begin
    with FticketPrint.SingleValue, cdsTicketBuffer do
    begin
      First;
      while not eof do
      begin
        AddOrSetValue('departdate', FieldByName('departdate').AsString);

        AddOrSetValue('routename', FieldByName('routename').AsString);
        AddOrSetValue('startstationname',
          FieldByName('startstationname').AsString);
        AddOrSetValue('endstationname', FieldByName('endstationname').AsString);
        // if (FieldByName('isovertime').AsBoolean) and
        // (length(FieldByName('schedulecode').AsString) > 3) then
        // AddOrSetValue('schedulecode',
        // '+' + Copy(FieldByName('schedulecode').AsString, 2,
        // length(FieldByName('schedulecode').AsString)))
        // else
        // begin
        AddOrSetValue('schedulecode', FieldByName('schedulecode').AsString);
        // end;

        AddOrSetValue('workwaysname', FieldByName('workwaysname').AsString);

        AddOrSetValue('endstation', endstation);
        AddOrSetValue('startstationprice', startstationprice);
        AddOrSetValue('customername', '');
        AddOrSetValue('certificateno', '');
        if (FieldByName('tickettype').AsString = 'T') or
          (FieldByName('tickettype').AsString = 'H') then
        begin
          AddOrSetValue('customername', '');
          AddOrSetValue('certificateno', '');
        end
        else
        begin
          // if canrealnamesellticket  then //ʵ������Ʊ
          // begin
          if FieldByName('certificatetype').AsString = '0' then // ���֤
          begin
            // AddOrSetValue('customername',
            // getCustomernameByID(FieldByName('customerid').AsLargeInt));
            AddOrSetValue('customername', FieldByName('customername').AsString);
            certificateno := FieldByName('certificateno').AsString;
            if length(certificateno) = 15 then
            begin
              certificateno := StringReplace(certificateno,
                Copy(certificateno, 7, 6), '******', []);
            end
            else if length(certificateno) = 18 then
            begin
              certificateno := StringReplace(certificateno,
                Copy(certificateno, 7, 8), '********', []);
            end;

            AddOrSetValue('certificateno', certificateno);
          end;
          // end;
        end;

        if FieldByName('islinework').AsBoolean then
        begin
          AddOrSetValue('islinework', '��ˮ��');
          if printlineScheduleSeatno then
          begin
            AddOrSetValue('seatno', FieldByName('seatno').AsString);
          end
          else
          begin
            AddOrSetValue('seatno', '');
          end;
          AddOrSetValue('lineworkdeparttime',
            FieldByName('departtime').AsString);
          AddOrSetValue('lineworkseatno', FieldByName('seatno').AsString);
          if FPrintDepartTimeWhenislinework then
          begin
            AddOrSetValue('departtime', FieldByName('departtime').AsString);
          end
          else
          begin
            AddOrSetValue('departtime', '');
          end;
        end
        else
        begin
          AddOrSetValue('islinework', '');
          AddOrSetValue('seatno', FieldByName('seatnostr').AsString);
          AddOrSetValue('departtime', FieldByName('departtime').AsString);
          if not isnet then
          begin
            try
              initCdsScheduleQry;
              with FCdsScheduleQry do
              begin
                Active := false;
                Params.ParamValues['filter_EQL_s!id'] :=
                cdsTicketBuffer.FieldByName('scheduleid').AsString;
                Active := true;
                if (RecordCount > 0) and
                (not FieldByName('isaudited').AsBoolean) then
                begin
                  AddOrSetValue('seatno', '');
                end;
                if (RecordCount > 0) and
                (not FieldByName('isauditpass').AsBoolean) then
                begin
                  AddOrSetValue('departtime', '');
                end;
              end;
            except
            end;
          end;
          //������β���ӡ��λ�ź�ʱ��
//          if (not FieldByName('isaudited').AsBoolean) then
//          begin
//            AddOrSetValue('seatno', '');
//          end;
//          if (not FieldByName('isauditpass').AsBoolean) then
//          begin
//            AddOrSetValue('departtime', '');
//          end;
          AddOrSetValue('lineworkdeparttime', '');
          AddOrSetValue('lineworkseatno', '');

        end;
        if FieldByName('isovertime').AsBoolean then
          AddOrSetValue('isovertime', '�Ӱ�')
        else
          AddOrSetValue('isovertime', '');
        AddOrSetValue('scheduleremarks',
          FieldByName('scheduleremarks').AsString);

        AddOrSetValue('seattypename', FieldByName('seattypename').AsString);
        AddOrSetValue('vcleseattypename',
          FieldByName('vcleseattypename').AsString);
        AddOrSetValue('departstationname',
          FieldByName('departstationname').AsString);
        AddOrSetValue('reachstationname',
          FieldByName('reachstationname').AsString);
        AddOrSetValue('reachstationsecondname',
          FieldByName('reachstationsecondname').AsString);
        AddOrSetValue('distance', FieldByName('distance').AsString);

        if fulltickettypeAsDiscount and
          (FieldByName('tickettype').AsString = 'Q') and
          (FieldByName('fullprice').AsCurrency = FieldByName('price')
            .AsCurrency) and (FieldByName('fullprice').AsCurrency < FieldByName
            ('toplimitprice').AsCurrency) then
          AddOrSetValue('tickettypeprintname', '��')
        else
          AddOrSetValue('tickettypeprintname',
            FieldByName('tickettypeprintname').AsString);

        AddOrSetValue('fullprice', FieldByName('fullprice').AsString);
        AddOrSetValue('discountrate', FieldByName('discountrate').AsString);
        AddOrSetValue('price', FieldByName('price').AsString);
        AddOrSetValue('toplimitprice', FieldByName('toplimitprice').AsString);
        if (FieldByName('fueladditionfee').Value <> null) and
          (FieldByName('fueladditionfee').AsCurrency > 0) then
        begin
          AddOrSetValue('fueladditionfee',
            FieldByName('fueladditionfee').AsString);
          AddOrSetValue('containfuelsign', '����ȼ����');
          // �찲��վ���������Ʊ��ȼ�ͷѣ���Ʊ�ϴ�ӡ����ȼ������
        end
        else
        begin
          AddOrSetValue('fueladditionfee', '');
        end;

        AddOrSetValue('stationservicefee',
          FieldByName('stationservicefee').AsString);

        if FieldByName('servicefee').AsCurrency > 0 then
        begin
          if (sellway <> '') and ((sellway[1] = '1') or (sellway[1] = '2') or
              (sellway[1] = '4')) then
          begin
            AddOrSetValue('servicefee', '');
          end
          else
          begin
            AddOrSetValue('servicefee', FieldByName('servicefee').AsString);
          end;

        end
        else
        begin
          AddOrSetValue('servicefee', '');
        end;

        AddOrSetValue('ticketno', FieldByName('ticketno').AsString);

        if FieldByName('carrychildnum').AsInteger < 1 then
        begin
          AddOrSetValue('carrychildnum', '');
          AddOrSetValue('untakechildInfo', untakechildInfo);
        end
        else
        begin
          AddOrSetValue('untakechildInfo', '');
          AddOrSetValue('carrychildnum', FieldByName('carrychildnum').AsString);
        end;
        AddOrSetValue('ticketentrance', FieldByName('ticketentrance').AsString);
        AddOrSetValue('ticketentrancename',
          FieldByName('ticketentrancename').AsString);
        AddOrSetValue('buspark', FieldByName('buspark').AsString);
        AddOrSetValue('planvehicletypename',
          FieldByName('planvehicletypename').AsString);
        AddOrSetValue('planvehiclegradename',
          FieldByName('planvehiclegradename').AsString);
        AddOrSetValue('planvehicletypecustomname',
          FieldByName('planvehicletypecustomname').AsString);
        AddOrSetValue('planunitname', FieldByName('planunitname').AsString);
        AddOrSetValue('planvehicleno', FieldByName('planvehicleno').AsString);
        AddOrSetValue('planbrandmodel', FieldByName('planbrandmodel').AsString);
        AddOrSetValue('sellbycode', SysInfo.LoginUserInfo.UserCode);
        AddOrSetValue('sellbyname', SysInfo.LoginUserInfo.UserName);
        AddOrSetValue('ticketoutletsname',
          SysInfo.LoginUserInfo.ticketoutletsname);

        // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
        if sellway <> '' then
        begin
          case sellway[1] of
            '1', '2':
              AddOrSetValue('sellway', '��Ʊ');
            '4':
              AddOrSetValue('sellway', '��ǩ');
            '7':
              AddOrSetValue('sellway', '������Ʊ');
          else
            AddOrSetValue('sellway', '');
          end;
        end
        else
        begin
          AddOrSetValue('sellway', '�ش�');
        end;
        // ��ӡ��ʽ
        if FieldByName('paymethod').AsString <> '0' then
        begin
          AddOrSetValue('paymethodname', FieldByName('paymethodname').AsString);
        end
        else
        begin
          AddOrSetValue('paymethodname', '');
        end;
        // hasschedulestopremark := false;
        // if not isnet then
        // begin
        // try
        // initCdsSchedulestopremark;
        // with FCdsSchedulestopremark do
        // begin
        // Active := false;
        // Params.ParamValues['scheduleid'] := cdsTicketBuffer.FieldByName
        // ('scheduleid').AsString;
        // Params.ParamValues['stationid'] := cdsTicketBuffer.FieldByName
        // ('reachstationid').AsString;
        // Active := true;
        // if RecordCount > 0 then
        // begin
        // hasschedulestopremark := true;
        // end;
        // end;
        // except
        // end;
        // end;
        if not isnet then
        begin
          AddOrSetValue('schedulestopremark1',
            FieldByName('schedulestopremark1').AsString);
          AddOrSetValue('schedulestopremark2',
            FieldByName('schedulestopremark2').AsString);
          AddOrSetValue('schedulestopremark3',
            FieldByName('schedulestopremark3').AsString);
          AddOrSetValue('schedulestopremark4',
            FieldByName('schedulestopremark4').AsString);
          AddOrSetValue('schedulestopremark5',
            FieldByName('schedulestopremark5').AsString);
        end
        else
        begin
          AddOrSetValue('schedulestopremark1', '');
          AddOrSetValue('schedulestopremark2', '');
          AddOrSetValue('schedulestopremark3', '');
          AddOrSetValue('schedulestopremark4', '');
          AddOrSetValue('schedulestopremark5', '');
        end;
        // ��ӷ���վ �ڶ����Ժ�������ӡ��
        AddOrSetValue('departstationdescription', FieldByName('departstationdescription').AsString);
        AddOrSetValue('departstationsecondname', FieldByName('departstationsecondname').AsString);
        {try
          initCdsDepartStation;
          with FCdsDepartStation do
          begin
            Active := false;
            Params.ParamValues['filter_EQS_s!code'] :=
              cdsTicketBuffer.FieldByName('departstationcode').AsString;
            Active := true;
            if RecordCount = 1 then
            begin
              AddOrSetValue('departstationdescription',
                FCdsDepartStation.FieldByName('description').AsString);
              AddOrSetValue('departstationsecondname',
                FCdsDepartStation.FieldByName('secondname').AsString);
            end;
          end;
        except
        end;  }

        if (FieldByName('tickettype').AsString = 'T') or
          (FieldByName('tickettype').AsString = 'H') then
        begin
          tOrhticketnum := 0;
          tmpprice := 0;
          tmpfueladditionfee := 0;
          tmpstationservicefee := 0;
          tmpservicefee := 0;
          tmpcarrychildnum := 0;
          First;
          while not eof do
          begin
            if (FieldByName('tickettype').AsString = 'T') or
              (FieldByName('tickettype').AsString = 'H') then
            begin
              tmpprice := tmpprice + FieldByName('price').AsCurrency;
              if (FieldByName('fueladditionfee').Value <> null) and
                (FieldByName('fueladditionfee').AsCurrency > 0) then
                tmpfueladditionfee := tmpfueladditionfee + FieldByName
                  ('fueladditionfee').AsCurrency;
              tmpstationservicefee := tmpstationservicefee + FieldByName
                ('stationservicefee').AsCurrency;
              tmpservicefee := tmpservicefee + FieldByName('servicefee')
                .AsCurrency;
              tmpcarrychildnum := tmpcarrychildnum + FieldByName
                ('carrychildnum').AsInteger;
              tOrhticketnum := tOrhticketnum + 1;
            end;

            Next;
          end;
          // if (FieldByName('tickettype').AsString='H') and (totalPrice>0) then
          // begin
          // AddOrSetValue('price',CurrToStr(totalPrice) );
          // end
          // else
          // begin
          // AddOrSetValue('price', CurrToStr(tmpprice));
          // end;
          // AddOrSetValue('price', CurrToStr(tmpprice));
          {
            if totalPrice>0 then
            begin
            AddOrSetValue('price',CurrToStr(totalPrice) );
            end
            else
            begin
            AddOrSetValue('price', CurrToStr(tmpprice));
            end;
            }
          AddOrSetValue('price', CurrToStr(tmpprice));
          if tmpfueladditionfee > 0 then
            AddOrSetValue('fueladditionfee', CurrToStr(tmpfueladditionfee))
          else
            AddOrSetValue('fueladditionfee', '');
          AddOrSetValue('stationservicefee', CurrToStr(tmpstationservicefee));
          if tmpservicefee > 0 then
            AddOrSetValue('servicefee', CurrToStr(tmpservicefee))
          else
            AddOrSetValue('servicefee', '');
          if tmpcarrychildnum < 1 then
          begin
            AddOrSetValue('carrychildnum', '');
            AddOrSetValue('untakechildInfo', untakechildInfo);
          end
          else
          begin
            AddOrSetValue('untakechildInfo', '');
            AddOrSetValue('carrychildnum', inttostr(tmpcarrychildnum));
          end;
          // ����Ʊ�����Ʊ��ӡ���� --����λ���б�
          AddOrSetValue('tickettypeprintname',
            FieldByName('tickettypeprintname')
              .AsString + '(' + inttostr(tOrhticketnum) + '��)');
          // +'('+inttostr(cdsTicketBuffer.RecordCount)+'��)');
          // AddOrSetValue('seatno', '');
        end;
        FticketPrint.Print;
        if (FieldByName('tickettype').AsString = 'T') or
          (FieldByName('tickettype').AsString = 'H') then
        begin
          // ����Ʊ�����Ʊֻ��ӡһ��
          Break;
        end;

        if FieldByName('isroundtrip').AsBoolean then
        begin
          // ��ӡ�س�Ʊ
          FreturntripticketPrint.SingleValue.AddOrSetValue('carrychildnum',
            FieldByName('carrychildnum').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('departdate',
            FieldByName('departdate').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('departstationname',
            FieldByName('departstationname').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('departtime',
            FieldByName('departtime').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('distance',
            FieldByName('distance').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('price',
            FieldByName('price').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('reachstationname',
            FieldByName('reachstationname').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue('sellbycode',
            SysInfo.LoginUserInfo.UserCode);
          FreturntripticketPrint.SingleValue.AddOrSetValue('sellbyname',
            SysInfo.LoginUserInfo.UserName);
          FreturntripticketPrint.SingleValue.AddOrSetValue('ticketno',
            FieldByName('ticketno').AsString);
          FreturntripticketPrint.SingleValue.AddOrSetValue
            ('tickettypeprintname',
            FieldByName('tickettypeprintname').AsString);

          FreturntripticketPrint.SingleValue.AddOrSetValue
            ('returntripticketno',
            zerofill(inttostr(strtoint64(FieldByName('ticketno').AsString)
                  + 1), length(SysInfo.LoginUserInfo.curBillNo.Items['Ticket'])
              ));
          FreturntripticketPrint.SingleValue.AddOrSetValue('returntripdate',
            datetimetostr(FieldByName('departdate').AsDateTime + FieldByName
                ('returntripvaliddays').AsInteger));
          FreturntripticketPrint.Print;
        end;

        if ((sellway[1] = '1') or (sellway[1] = '2') or (sellway[1] = '4')) and
          (FieldByName('servicefee').AsCurrency > 0) then
        // ��Ʊ��ʽ�ǲ�Ʊ���ǩʱ��ӡ������
        begin
          if initServicefeePrinter() then // ��ʼ�������Ѵ�ӡģ��
          begin
            FservicefeePrint.SingleValue.AddOrSetValue('schedulecode',
              FieldByName('schedulecode').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('departstationname',
              FieldByName('departstationname').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('reachstationname',
              FieldByName('reachstationname').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('price',
              FieldByName('price').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('servicefee',
              FieldByName('servicefee').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('departdate',
              FieldByName('departdate').AsString);
            FservicefeePrint.SingleValue.AddOrSetValue('sellbycode',
              SysInfo.LoginUserInfo.UserCode);
            // if (sellway[1]='1') or (sellway[1]='2') then //��Ʊ����Ȩ��Ʊ
            // begin
            // if tnum = getPrintTicketnum then
            // begin
            // FservicefeePrint.SingleValue.AddOrSetValue('sellway', '��Ʊ');
            // FservicefeePrint.SingleValue.AddOrSetValue('servicefee', IntToStr(FieldByName('servicefee').AsInteger * getPrintTicketnum));
            // isBuTicket:=true;
            // FservicefeePrint.SingleValue.AddOrSetValue('ticketno',zerofill(IntToStr(strtoint64(FieldByName('ticketno').AsString)+1),
            // length(sysinfo.LoginUserInfo.curBillNo.Items['Ticket'])));
            // with Sysinfo.LoginUserInfo do
            // begin
            // curBillNo.AddOrSetValue('Ticket',
            // zerofill(inttostr(strtoint64(curBillNo.Items['Ticket']) + 1),
            // length(curBillNo.Items['Ticket'])));
            // curBillNum.AddOrSetValue('Ticket',
            // curBillNum.Items['Ticket'] - 1);
            // end;
            //
            // FservicefeePrint.Print;
            //
            // end;
            // end;

            if (sellway[1] = '4') and (getParametervalue('1066',
                SysInfo.LoginUserInfo.OrgID) = '1') then // ��ǩ
            begin
              FservicefeePrint.SingleValue.AddOrSetValue('ticketno',
                zerofill(inttostr(strtoint64(FieldByName('ticketno').AsString)
                      + 1),
                  length(SysInfo.LoginUserInfo.curBillNo.Items['Ticket'])));
              FservicefeePrint.SingleValue.AddOrSetValue('changeticketno',
                FieldByName('ticketno').AsString);

              FservicefeePrint.SingleValue.AddOrSetValue('sellway', '��ǩ');
              with SysInfo.LoginUserInfo do
              begin
                curBillNo.AddOrSetValue('Ticket',
                  zerofill(inttostr(strtoint64(curBillNo.Items['Ticket'])
                        + 1), length(curBillNo.Items['Ticket'])));
                curBillNum.AddOrSetValue('Ticket',
                  curBillNum.Items['Ticket'] - 1);
              end;

              FservicefeePrint.Print;
            end;

          end;
        end;

        Next;
      end;
      // ����1069���������Ʋ�Ʊ����Ȩ��Ʊ�Ƿ��ӡƾ֤ Ϊ0������ӡ��Ϊ1 ��ӡ
      if ((sellway[1] = '1') or (sellway[1] = '2') or (sellway[1] = '4')) and
        (FieldByName('servicefee').AsCurrency > 0) and
        (getParametervalue('1069', SysInfo.LoginUserInfo.OrgID) = '1') then
      // ��Ʊ��ʽ�ǲ�Ʊ���ǩʱ��ӡ������
      begin
        if initServicefeePrinter() then // ��ʼ�������Ѵ�ӡģ��
        begin
          FservicefeePrint.SingleValue.AddOrSetValue('schedulecode',
            FieldByName('schedulecode').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('departstationname',
            FieldByName('departstationname').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('reachstationname',
            FieldByName('reachstationname').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('price',
            FieldByName('price').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('servicefee',
            FieldByName('servicefee').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('departdate',
            FieldByName('departdate').AsString);
          FservicefeePrint.SingleValue.AddOrSetValue('sellbycode',
            SysInfo.LoginUserInfo.UserCode);
          if (sellway[1] = '1') or (sellway[1] = '2') then // ��Ʊ����Ȩ��Ʊ
          begin
            FservicefeePrint.SingleValue.AddOrSetValue('sellway', '��Ʊ');
            FservicefeePrint.SingleValue.AddOrSetValue('servicefee',
              inttostr(FieldByName('servicefee').AsInteger * getPrintTicketnum)
              );
            isBuTicket := true;
            FservicefeePrint.SingleValue.AddOrSetValue('ticketno',
              zerofill(inttostr(strtoint64(FieldByName('ticketno').AsString)
                    + 1),
                length(SysInfo.LoginUserInfo.curBillNo.Items['Ticket']))
              );
            with SysInfo.LoginUserInfo do
            begin
              curBillNo.AddOrSetValue('Ticket',
                zerofill(inttostr(strtoint64(curBillNo.Items['Ticket']) + 1),
                  length(curBillNo.Items['Ticket'])));
              curBillNum.AddOrSetValue('Ticket',
                curBillNum.Items['Ticket'] - 1);
            end;

            FservicefeePrint.Print;

          end;

        end;
      end;
    end;
  end;

  class function TSellTicket.printTicketById(ticketsellid: Int64;
    isnet: boolean; curticketno: String = ''): boolean;
  var
    SellTicket: TSellTicket;
  begin
    result := false;
    try
      SellTicket := TSellTicket.CreateRePrint(Application); // Create
      try
        with SellTicket.FcdsTicketBuffer do
        begin
          Params.ParamValues['ticketsellid'] := ticketsellid;
          Params.ParamValues['curticketno'] := curticketno;

          // Params.ParamValues['isnet']:=isnet;
          if isnet then
          begin
            Params.ParamValues['isnet'] := 1; // ����������
          end
          else
          begin
            Params.ParamValues['isnet'] := 0; // ������
          end;

          Active := true;
          if Params.ParamValues['flag'] = 1 then
          begin
            if RecordCount = 0 then
            begin
              SysDialogs.ShowError('�򲻵��ó�Ʊ���޷���ӡ');
            end
            else
            begin
              if Trim(curticketno) <> '' then
              begin
                // ���浽��������
                with SysInfo.LoginUserInfo do
                begin
                  curBillNo.AddOrSetValue('Ticket',
                    zerofill
                      (inttostr(strtoint64(curBillNo.Items['Ticket'])
                          + SellTicket.getPrintTicketnum),
                      length(curBillNo.Items['Ticket'])));
                  curBillNum.AddOrSetValue('Ticket',
                    curBillNum.Items['Ticket'] - SellTicket.getPrintTicketnum);
                end;
              end;
              result := SellTicket.printTicket;
              result := true;
            end;
          end
          else
          begin
            if Params.ParamByName('msg').IsNull then
              SysDialogs.Warning('��Ʊ���ش�Ʊʧ��:δ֪����')
            else
              SysDialogs.Warning(Params.ParamValues['msg']);
          end;
        end;
      finally
        SellTicket.Free;
      end;
    except
      ;
    end;
  end;

  procedure TSellTicket.refreshseatandprice;
  begin
    FrefreshCurScheduleTime := GetTickCount;
    if FScheduleSeatStatus = nil then
    begin
      FScheduleSeatStatus := TDictionary<Word, String>.create;
    end;
    ScheduleSeatStatus.Clear;
    if FScheduleSeattype = nil then
    begin
      FScheduleSeattype := TDictionary<Word, String>.create;
    end;
    ScheduleSeattype.Clear;
    if FScheduleSeatTickettype = nil then
    begin
      FScheduleSeatTickettype := TDictionary<Word, String>.create;
    end;
    ScheduleSeatTickettype.Clear;
    if (not FcdsSchedule.Active) or (FcdsSchedule.RecordCount = 0) then
      exit;
    // ����ˮ���
    if not FcdsSchedule.FieldByName('ISLINEWORK').AsBoolean then
    begin
      if FcdsScheduleSeats = nil then
      begin
        FcdsScheduleSeats := TjsonClientDataSet.create(Self);
        with FcdsScheduleSeats do
        begin
          RemoteServer := DMPublic.jcon;
          QueryAddress := 'sell/findScheduleseats';
          DataSourceName := 'scheduleseats';
          Params.CreateParam(ftString, 'isnet', ptInput);
          Params.CreateParam(ftString, 'scheduleplanid', ptInput);
          Params.CreateParam(ftString, 'sellway', ptInput);
          Params.CreateParam(ftString, 'ticketpriceid', ptInput);
          Params.CreateParam(ftString, 'departdate', ptInput);
          Params.CreateParam(ftString, 'schedulesynccode', ptInput);
          Params.CreateParam(ftString, 'departstationcode', ptInput);
          Params.CreateParam(ftString, 'reachstationcode', ptInput);
          Params.CreateParam(ftString, 'seattype', ptInput);
          Params.CreateParam(ftWideString, 'departtimeinput', ptInput);
          Params.CreateParam(ftInteger, 'residueseatnum', ptOutput);
          Params.CreateParam(ftInteger, 'seatnum', ptOutput);
          Params.CreateParam(ftCurrency, 'fullprice', ptOutput);
          Params.CreateParam(ftCurrency, 'halfprice', ptOutput);
          Params.CreateParam(ftCurrency, 'studentprice', ptOutput);
          Params.CreateParam(ftWideString, 'departtime', ptOutput);
          Params.CreateParam(ftInteger, 'flag', ptOutput);
          Params.CreateParam(ftString, 'msg', ptOutput);
        end;
      end;
      with FcdsScheduleSeats do
      begin
        Active := false;

        // Params.ParamValues['isnet']:=isnet;

        if isnet then
        begin
          Params.ParamValues['isnet'] := 1; // ����������
        end
        else
        begin
          Params.ParamValues['isnet'] := 0; // ������
        end;

        Params.ParamValues['scheduleplanid'] := FcdsSchedule.FieldByName
          ('scheduleplanid').AsString;
        Params.ParamValues['ticketpriceid'] := FcdsSchedule.FieldByName('id')
          .AsString;
        Params.ParamValues['sellway'] := Self.sellway;
        Params.ParamValues['departdate'] := FcdsSchedule.FieldByName
          ('departdate').AsString;
        Params.ParamValues['schedulesynccode'] := FcdsSchedule.FieldByName
          ('schedulesynccode').AsString;
        Params.ParamValues['departstationcode'] := FcdsSchedule.FieldByName
          ('departstationcode').AsString;
        Params.ParamValues['reachstationcode'] := FcdsSchedule.FieldByName
          ('reachstationcode').AsString;
        Params.ParamValues['seattype'] := FcdsSchedule.FieldByName('seattype')
          .AsString;
        Params.ParamValues['departtimeinput'] := FcdsSchedule.FieldByName
          ('departtime').AsWideString;
        Active := true;
        if Params.ParamValues['flag'] <> 1 then
        begin
          if (Params.ParamValues['msg'] = null) or
            (Params.ParamValues['msg'] = '') then
            raise Exception.create('ȡ��������ʧ��:δ֪����')
          else
            raise Exception.create('ȡ��������ʧ��:' + Params.ParamValues['msg']);
        end;
        FcdsSchedule.edit;
        FcdsSchedule.FieldByName('seatnum').AsInteger := Params.ParamByName
          ('seatnum').AsInteger;
        FcdsSchedule.FieldByName('residueseatnum').AsInteger :=
          Params.ParamByName('residueseatnum').AsInteger;
        if isnet and (FcdsSchedule.FieldByName('departtime')
            .AsWideString <> Params.ParamByName('departtime').AsWideString)
          then
        begin
          FcdsSchedule.FieldByName('departtime').AsWideString :=
            Params.ParamByName('departtime').AsWideString;
          SysDialogs.Confirm('��ʾ', '�ð�εķ���ʱ���Ѿ��ı䣬��ע�⣡');
        end;
        if isnet and ((FcdsSchedule.FieldByName('fullprice')
              .AsCurrency <> Params.ParamByName('fullprice').AsCurrency) or
            (FcdsSchedule.FieldByName('halfprice')
              .AsCurrency <> Params.ParamByName('halfprice').AsCurrency) or
            (FcdsSchedule.FieldByName('studentprice')
              .AsCurrency <> Params.ParamByName('studentprice').AsCurrency))
          then
        begin
          SysDialogs.Confirm('��ʾ', '�ð�ε�Ʊ���Ѿ��ı䣬��ע�⣡');
        end;
        FcdsSchedule.FieldByName('fullprice').AsCurrency := Params.ParamByName
          ('fullprice').AsCurrency;
        FcdsSchedule.FieldByName('halfprice').AsCurrency := Params.ParamByName
          ('halfprice').AsCurrency;
        FcdsSchedule.FieldByName('studentprice').AsCurrency :=
          Params.ParamByName('studentprice').AsCurrency;
        FcdsSchedule.post;
        First;
        while not eof do
        begin
          ScheduleSeattype.AddOrSetValue(FieldByName('seatno').AsInteger,
            FieldByName('seattype').AsString);
          ScheduleSeatStatus.AddOrSetValue(FieldByName('seatno').AsInteger,
            FieldByName('status').AsString);
          if (FieldByName('status').AsString = '2') or
            (FieldByName('status').AsString = '7') or
            (FieldByName('status').AsString = '8') then
          begin
            ScheduleSeatTickettype.AddOrSetValue
              (FieldByName('seatno').AsInteger,
              FieldByName('tickettype').AsString);
          end;
          Next;
        end;
      end;
      refreshSeatsHint(FcdsSchedule.FieldByName('scheduleplanid').AsLargeInt);
    end;
  end;

  function TSellTicket.refreshSeatsHint(scheduleplanid: Int64): string;
  begin
    if not Assigned(seatshint) then
      Fseatshint := TDictionary<Word, String>.create()
    else
      Fseatshint.Clear;
    if isnet then
      exit;
    if FcdsSeatshint = nil then
    begin
      FcdsSeatshint := TjsonClientDataSet.create(Self);
      with FcdsSeatshint do
      begin
        RemoteServer := DMPublic.jcon;
        QueryAddress := 'checkticket/qrySeatstatus';
        DataSourceName := 'seatstatuslist';
        Params.CreateParam(ftString, 'scheduleplanid', ptInput);
      end;
    end;
    with FcdsSeatshint do
    begin
      Active := false;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Active := true;
      if RecordCount > 0 then
      begin
        First;
        while (not eof) do
        begin
          seatshint.AddOrSetValue(FieldByName('seatno').AsInteger,
            FieldByName('hint').AsString);
          Next;
        end;
      end;
    end;
  end;

  procedure TSellTicket.ScheduleAfterScroll(DataSet: TDataSet);
  begin
    if nvdbgrdhscheduleMoveByKey then
      exit;
    ScheduleAfterScrollStack.Add(GetTickCount);
    OutputDebugString('nvdbgrdhschedule ScheduleAfterScroll--start');
    endstation := FcdsSchedule.FieldByName('endstation').AsString;
    startstationprice := FcdsSchedule.FieldByName('startstationprice').AsString;
    FrefreshCurScheduleTime := refreshScheduleInterval * 1000 + 1;
    if (not isnet) or (not delayrefresh) then
    begin
      if delmsgAndCheckkeyup() then
        exit;
      refreshseatandprice();
    end;
    if Assigned(FAfterScheduleScroll) then
    begin
      if delmsgAndCheckkeyup() then
        exit;
      FAfterScheduleScroll(FcdsSchedule);
    end;
    if delmsgAndCheckkeyup() then
      exit;
    ScheduleAfterScrollStack.Clear;
    OutputDebugString('nvdbgrdhschedule ScheduleAfterScroll--finsh');
  end;

  function TSellTicket.sellInsure(): boolean;
  begin
    result := false;
    with (cdsInsureBuffer) do
    begin
      if isnet then
      begin
        Params.ParamValues['isnet'] := 1; // ����������
      end
      else
      begin
        Params.ParamValues['isnet'] := 0; // ������
      end;

      Params.ParamValues['insuranceOrder.seller'] :=
        SysInfo.LoginUserInfo.UserID;
      Params.ParamValues['insuranceOrder.orgid'] := SysInfo.LoginUserInfo.OrgID;
      Params.ParamValues['insuranceOrder.startTicketNO'] :=
        SysInfo.LoginUserInfo.curBillNo.Items['Insure'];
      Params.ParamValues['insuranceOrder.totalmoney'] := CurrToStr
        (getTotalInsureBufferReceivablenum);
      Params.ParamValues['insuranceOrder.ip'] := SysInfo.LocalHostAddress;
      Params.ParamValues['insuranceOrder.ticketoutletsid'] :=
        SysInfo.LoginUserInfo.ticketoutletsid;
      Params.ParamValues['insuranceOrder.sellway'] := sellway;
      try
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('�۱��յ�ʧ��:δ֪����' + '�����˻����ѣ�');
        end;
        if Params.ParamValues['flag'] = 1 then
        begin
          // ���浽��������
          with SysInfo.LoginUserInfo do
          begin
            curBillNo.AddOrSetValue('Insure',
              zerofill(inttostr(strtoint64(curBillNo.Items['Insure'])
                    + RecordCount), length(curBillNo.Items['Insure'])));
            curBillNum.AddOrSetValue('Insure',
              curBillNum.Items['Insure'] - RecordCount);
          end;
          try
            printinsure;
          except
            on E: Exception do
              SysDialogs.ShowError(E.Message);
          end;
          result := true;
        end
        else
        begin
          if Params.ParamByName('msg').IsNull then
            SysDialogs.Warning('�۱��յ�ʧ��:δ֪����' + '�����˻����ѣ�')
          else
            SysDialogs.Warning(Params.ParamValues['msg'] + '�����˻����ѣ�');
        end;
      except
        on E: Exception do
          SysDialogs.Warning('�۱��յ�ʧ��:' + E.Message + '�����˻����ѣ�');
      end;
    end;
  end;

  function TSellTicket.SellTicket(orderno: String; vipCard: TVipCard;
    discountpricenum: integer; openApinet: integer): boolean;
  var
    insureoutputTxt: TStringList;
    seatnostr: string;
  begin
    result := false;
    with cdsTicketBuffer do
    begin
      if discountpricenum > 0 then
      begin
        Params.ParamValues['discountpricenum'] := discountpricenum;
      end
      else
      begin
        Params.ParamValues['discountpricenum'] := 0;
      end;

      if totalPrice > 0 then
      begin
        Params.ParamValues['hirebustotalprice'] := totalPrice;
      end
      else
      begin
        Params.ParamValues['hirebustotalprice'] := 0;
      end;

      // Params.ParamValues['isnet']:= isnet;
      if isnet then
      begin
        if openApinet = 1 then
        begin
          Params.ParamValues['isnet'] := 2; // ʡ��������
        end
        else
        begin
          Params.ParamValues['isnet'] := 1; // ����������
        end;
      end
      else
      begin
        Params.ParamValues['isnet'] := 0; // ������
      end;

      Params.ParamValues['order.seller'] := SysInfo.LoginUserInfo.UserID;
      Params.ParamValues['order.orderno'] := orderno;
      Params.ParamValues['order.orgid'] := SysInfo.LoginUserInfo.OrgID;
      Params.ParamValues['order.startTicketNO'] :=
        SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
      Params.ParamValues['order.totalmoney'] := CurrToStr
        (getTotalTicketBufferReceivablenum);
      Params.ParamValues['order.ip'] := SysInfo.LocalHostAddress;
      Params.ParamValues['order.ticketoutletsid'] :=
        SysInfo.LoginUserInfo.ticketoutletsid;
      Params.ParamValues['order.sellway'] := sellway;
      Params.ParamValues['order.departstationcode'] := cdsSchedule.FieldByName
        ('departstationcode').AsString;
      Params.ParamValues['order.sellername'] := SysInfo.LoginUserInfo.UserName;
      // Params.ParamValues['order.batchno']:= //�ӳٵ�������ٸ�ֵ
      Params.ParamValues['order.ticketoutletsname'] :=
        SysInfo.LoginUserInfo.ticketoutletsname;
      if vipCard = nil then
      begin
        Params.ParamValues['order.vipcardno'] := null;
        Params.ParamValues['order.vipgrade'] := null;
        Params.ParamValues['order.vipmoney'] := null;
        Params.ParamValues['order.vippoint'] := null;
      end
      else
      begin
        Params.ParamValues['order.vipcardno'] := vipCard.cardNo;
        Params.ParamValues['order.vipgrade'] := inttostr
          (integer(vipCard.cardGrade));
        Params.ParamValues['order.vipmoney'] := vipCard.money;
        Params.ParamValues['order.vippoint'] := vipCard.amount;
      end;
      try
        OutputDebugString(PWideChar('----��Ʊ���ú�̨----begin------'));
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('��Ʊʧ��:δ֪����');
        end;
        OutputDebugString(PWideChar('----��Ʊ���ú�̨----end------'));
        if Params.ParamValues['flag'] = 1 then
        begin
          result := true;
          // ���浽��������
          with SysInfo.LoginUserInfo do
          begin
            curBillNo.AddOrSetValue('Ticket',
              zerofill(inttostr(strtoint64(curBillNo.Items['Ticket'])
                    + getPrintTicketnum), length(curBillNo.Items['Ticket'])));
            curBillNum.AddOrSetValue('Ticket',
              curBillNum.Items['Ticket'] - getPrintTicketnum);
          end;
          // �����ı����

          if (insureoutputTxtFilename <> '') then
          begin
            insureoutputTxt := TStringList.create;
            First;
            while not eof do
            begin
              insureoutputTxt.Add(getInsureOutputText);
              Next;
            end;
            if not FileExists(insureoutputTxtFilename) then
            begin
              if not directoryexists(ExtractFilePath(insureoutputTxtFilename))
                then
              begin
                if ForceDirectories(ExtractFilePath(insureoutputTxtFilename))
                  then
                begin
                  insureoutputTxt.SaveToFile(insureoutputTxtFilename);
                end;
              end
              else
              begin
                insureoutputTxt.SaveToFile(insureoutputTxtFilename);
              end;
            end
            else
            begin
              insureoutputTxt.SaveToFile(insureoutputTxtFilename);
            end;
          end;

          try
            printTicket;
          except
            on E: Exception do
              SysDialogs.ShowError(E.Message);
          end;
        end
        else
        begin
          if Params.ParamByName('msg').IsNull then
            SysDialogs.Warning('��Ʊʧ��:δ֪����')
          else
            SysDialogs.Warning(Params.ParamValues['msg']);
        end;
      except
        on E: Exception do
          SysDialogs.Warning('��Ʊʧ��:' + E.Message);
      end;
    end;
  end;

  function TSellTicket.unlockSeat(orderno: TGUID;
    scheduleplanid: Int64): boolean;
  begin
    result := unlockSeat(orderno, scheduleplanid, nil);
  end;

  function TSellTicket.unlockSeat(orderno: TGUID): boolean;
  begin
    result := unlockSeat(orderno, 0);
  end;

  function TSellTicket.unlockSeat(orderno: TGUID; scheduleplanid: Int64;
    seatnos: TList<Word>): boolean;
  var
    seatnos_S: String;
    seatno: Word;
  begin
    result := false;
    if not Assigned(FcdsUnLockSeats) then
    begin
      FcdsUnLockSeats := TjsonClientDataSet.create(Self);
      with FcdsUnLockSeats do
      begin
        SaveAddress := 'sell/unlockSeat';
        RemoteServer := DMPublic.jcon;
        Params.CreateParam(ftString, 'isnet', ptInput);
        Params.CreateParam(ftString, 'orderno', ptInput);
        Params.CreateParam(ftString, 'scheduleplanid', ptInput);
        Params.CreateParam(ftString, 'departstationcode', ptInput);
        Params.CreateParam(ftString, 'seatnos_S', ptInput);
        Params.CreateParam(ftInteger, 'flag', ptOutput);
        Params.CreateParam(ftString, 'msg', ptOutput);
      end;
    end;
    seatnos_S := '';
    if seatnos <> nil then
      for seatno in seatnos do
        seatnos_S := seatnos_S + inttostr(seatno);
    with FcdsUnLockSeats do
    begin
      Active := false;

      // Params.ParamValues['isnet']:= isnet;
      if isnet then
      begin
        if isOpenApiUnlock = 1 then
        begin
          Params.ParamValues['isnet'] := 2; // ʡ��������
        end
        else
        begin
          Params.ParamValues['isnet'] := 1; // ����������
        end;

      end
      else
      begin
        Params.ParamValues['isnet'] := 0; // ������
      end;

      Params.ParamValues['orderno'] := ReplaceText
        (ReplaceText(GUIDToString(orderno), '{', ''), '}', '');
      if scheduleplanid <= 0 then
        Params.ParamValues['scheduleplanid'] := null
      else
        Params.ParamValues['scheduleplanid'] := inttostr(scheduleplanid);
      Params.ParamValues['departstationcode'] := cdsSchedule.FieldByName
        ('departstationcode').AsString;
      Params.ParamValues['seatnos_S'] := seatnos_S;
      try
        Execute;
        if Params.ParamValues['flag'] = 1 then
        begin
          result := true;
        end
        else
        begin
          if (Params.ParamValues['msg'] = null) or
            (Params.ParamValues['msg'] = '') then
            raise Exception.create('������λʧ��:δ֪����')
          else
            raise Exception.create(Params.ParamValues['msg']);
        end;
      except
        on E: Exception do
          raise Exception.create('������λʧ��:' + E.Message);
      end;
    end;
  end;

  { ScheduleAskCondition }

  constructor ScheduleAskCondition.create;
  begin
    isnetway := 0;
    isnet := false;
    departDate := trunc(now);
    departStationId := 0;
    reachStationId := 0;
    ScheduleId := 0;
    ticketIdToBeChange := 0;
    districtcode := '';
    reachstationname := '';
  end;

end.
