unit Dispatch;

interface

uses Classes, SysUtils, DB, Generics.Collections, jsonClientDataSet, Services,
  FunctionItemIntf, UDMPublic, Variants, StrUtils, NovaPrintoffline, PubFn,
  forms, windows, IniFiles, StdCtrls, ComCtrls, Constant;

type

  TRes = record
    flag: integer;
    msg: string;
  end;

  // 报班条件类
  TReportAskCondition = class
  public
    //可选
    vehicleunit: string;
    departtime: string;
    schedulecode: string;
    seatno: string;
    startstation: string;
    reachstation: string;
    signname: string;
    signunit: string;
    //

    departstationid: int64;
    departdate: TDate;
    createby: int64;
    scheduleplanid: int64;
    driver1id: int64;
    driver2id: int64;
    driver3id: int64;
    driver4id: int64;
    steward1id: int64;
    steward2id: int64;
    reportorgid: int64;
    scheduleid: int64;
    vehicleid: int64;
    isTempVehicle: boolean;
    vehicleno: string;
    unitid: int64;
    reason: string;
    balanceunitid: int64;
    vroadnores: string;
    vdriverlicenseres: string;
    vworknores: string;
    vnotenum: string;
    drivername: string;
    dqualificationres: string;
    ddrivinglicenseres: string;
    // ddrivinglicenseres: string;
    dworknores: string;
    driversign: string;
    drivername2: string;
    ddrivinglicenseres2: string;
    dworknores2: string;
    dqualificationres2: string;
    driversign2: string;
    classmember: string;
    dispatcher: string;
    stewardname: string;
    orderno: string;
    constructor create();
  end;

  TVehcileReport = class(TObject)
  private
    FvheicleisMustCheck: boolean; // 是否必须安检
    FisMustCheckwithout: boolean; // 无安检计划，是否必须安检v
    FShowmsg: boolean;
    // _res:TRes;
    _cardno: String;
    _vehicleno: String;
    _vehicleid: int64;
    _unitname: String;
    FAOwner:TComponent;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    FjsdsSaveReport: TjsonClientDataSet; // 报班
    FjscdQryVehiclecheck: TjsonClientDataSet; // 检查车辆安检信息
    FjcdsVehicledistance: TjsonClientDataSet; // 检查车辆行驶里程
    FjscdqryVehicleroute: TjsonClientDataSet; // 查询车辆的营运线路
    FjcsdQryVehicleinfo: TjsonClientDataSet; // 根据卡号查询车辆信息
    FjcsdQryScheduleplan: TjsonClientDataSet; //
    fjcsdShowValidate: TjsonClientDataSet; //
    fjcdsParameters: TjsonClientDataSet; //
    FjcsdQryVehicle: TjsonClientDataSet; //
  public
    departstationid: int64;
    res: TRes;
    p0030: string;
    p2038: string;
    p2026: string;
    p2023: String;
    p2011: string;
    p6002: string;
    p3025: string;
    p2032: string;
    p0143: string;
    p2013: string;
    p6008: string;
    p2033: string;
    p1819: string;
    p2888: string;
    property cardno: string read _cardno write _cardno;
    property vehicleno: string read _vehicleno write _vehicleno;
    property vehicleid: int64 read _vehicleid write _vehicleid;
    property unitname: string read _unitname write _unitname;
    // property res:TRes read _res write _res;
    property isShowmsg: boolean read FShowmsg write FShowmsg;
    property isMustCheckwithout
      : boolean read FisMustCheckwithout write FisMustCheckwithout;
    property vheicleisMustCheck
      : boolean read FvheicleisMustCheck write FvheicleisMustCheck;
    constructor create(AOwner: TComponent);
    procedure report(condition: TReportAskCondition);
    // 查询车辆营运线路信息
    property jscdqryVehicleroute: TjsonClientDataSet read FjscdqryVehicleroute;
    property jcsdQryVehicleinfo: TjsonClientDataSet read FjcsdQryVehicleinfo;
    property jcsdQryScheduleplan: TjsonClientDataSet read FjcsdQryScheduleplan;
    property jcdsVehicledistance: TjsonClientDataSet read FjcdsVehicledistance;
    property jcsdQryVehicle: TjsonClientDataSet read FjcsdQryVehicle;
    procedure qryVehicleroute(departdate: TDateTimePicker;
      departstationid: int64; cardno: string; serialnumber: String;
      vehicleid: int64);
    // 获取车辆安检信息
    function checkVehicle(var mmoReportInfo: TMemo; vehicleid: int64;
      departdate: string): boolean;
    // 获取车辆验证有效性
    function VehicleActive(vehicleid: int64; departdate: string): boolean;

    function QryVehicleinfo(cardno: string): TRes;

    function QryVehicledistance(vehicleid: int64): boolean;

    procedure QryScheduleplan(departdate: string; departstationid: int64;
      routeid: int64; vehicleid: int64; endstationid: int64);
    // 证件有效期提示
    function CheckValidate(vehicleid: int64; orgid: int64): TRes;

    procedure printReportbill(rpb: TReportAskCondition);

    procedure qryParameter();

    function QryVehicleById(vehicleid:Int64):Boolean;
  end;

var
  vehReport: TVehcileReport;
  repAskCondition: TReportAskCondition;

implementation

{ TVehcileReport }
function TVehcileReport.QryVehicleById(vehicleid: Int64): Boolean;
begin
  with FjcsdQryVehicle do
  begin
      Active:=false;
      Params.ParamValues['vehicleid'] := vehicleid;
      Active:=true;
  end;
end;
function TVehcileReport.checkVehicle(var mmoReportInfo: TMemo;
  vehicleid: int64; departdate: string): boolean;
var
  nResult: integer;
  sResult: string;
  ischeckplan: boolean;
begin
  with FjscdQryVehiclecheck do
  begin
    Active := false;
    Params.ParamValues['vehiclereport.vehicleid'] := vehicleid;
    Params.ParamValues['vehiclereport.departdate'] := departdate;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      ischeckplan := Params.ParamByName('ischeckplan').Value;
      // NovaEdtCardNo.Clear;
      // 返回的-1未检 1合格 0不合格 2是无安检计划无需校验安检  3复检合格
      // -3 有安检计划，必须安检
      // -2,已发班里程大于设置需要重复安检，提示需要再次安检
      // -4未安检，但是可以报班
      if (mmoReportInfo <> nil) then
      begin
        mmoReportInfo.Lines.Insert(0, sResult);
      end;
      // 必须安检
      if FvheicleisMustCheck then
      begin
        // 1,无安检计划，也必须安检
        if isMustCheckwithout then
        begin
          if (nResult = 1) or (nResult = 3) then
          begin
            result := true;
          end
          else
          begin
            result := false;
          end;
        end
        else
        // 0,无安检计划，不用安检也可以报班
        begin
          if ischeckplan then
          begin
            // 若有计划就必须要安检
            if (nResult = 1) or (nResult = 3) then
            begin
              result := true;
            end
            else
            begin
              result := false;
            end;
          end
          else
          begin
            result := true;
          end;
        end
      end
      else
      begin
        result := true;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('获取车辆安检信息失败：' + E.Message);
      end;
    end;
  end;

end;

constructor TVehcileReport.create(AOwner: TComponent);
begin
  repAskCondition := TReportAskCondition.create;
  FAOwner:=AOwner;
  if not Assigned(FjsdsSaveReport) then
  begin
    FjsdsSaveReport := TjsonClientDataSet.create(nil);
    with FjsdsSaveReport do
    begin
      RemoteServer := DMPublic.jcon;
      // QueryAddress := 'sell/findTicketBuffer';
      SaveAddress := 'dispatch/vehicleReport';
      // DataSourceName := 'ticketsPrintInfo';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'departstationid', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.departdate', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.createby', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.driver1.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.driver2.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.driver3.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.driver4.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.reportorgid', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.scheduleid', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.steward1.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.steward2.id', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.vehicleid', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.isTempVehicle', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.vehiclebrandid', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.unitid', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.reason', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.balanceunitid', ptInput);
      Params.CreateParam(ftString, 'vehiclereport.scheduleplanid', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.orderno', ptInput);
      Params.CreateParam(ftString, 'vehicleno', ptInput); //
      Params.CreateParam(ftString, 'vdp.drivername', ptInput);
      Params.CreateParam(ftString, 'vdp.dqualificationres', ptInput);
      Params.CreateParam(ftString, 'vdp.vdriverlicenseres', ptInput);
      Params.CreateParam(ftString, 'vdp.vworknores', ptInput);
      Params.CreateParam(ftString, 'vdp.vroadnores', ptInput);
      Params.CreateParam(ftString, 'vdp.dworknores', ptInput);
      Params.CreateParam(ftString, 'vdp.vnotenum', ptInput);
      Params.CreateParam(ftString, 'vdp.dispatcher', ptInput);
      Params.CreateParam(ftString, 'vdp.driversign', ptInput);
      Params.CreateParam(ftString, 'vdp.stewardname', ptInput);
      Params.CreateParam(ftString, 'vdp.drivername2', ptInput);
      Params.CreateParam(ftString, 'vdp.ddrivinglicenseres', ptInput);
      Params.CreateParam(ftString, 'vdp.ddrivinglicenseres2', ptInput);
      Params.CreateParam(ftString, 'vdp.dqualificationres2', ptInput);
      Params.CreateParam(ftString, 'vdp.dworknores2', ptInput);
      Params.CreateParam(ftString, 'vdp.classmember', ptInput);
      Params.CreateParam(ftString, 'vdp.driversign2', ptInput);
      Params.CreateParam(ftInteger, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;

  if not Assigned(FjscdQryVehiclecheck) then
  begin
    FjscdQryVehiclecheck := TjsonClientDataSet.create(nil);
    with FjscdQryVehiclecheck do
    begin
      RemoteServer := DMPublic.jcon;
      // QueryAddress := 'sell/findTicketBuffer';
      SaveAddress := 'dispatch/qryVehiclecheckinfo';
      // DataSourceName := 'ticketsPrintInfo';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'vehiclereport.vehicleid', ptInput); //
      Params.CreateParam(ftString, 'vehiclereport.departdate', ptInput); //
      Params.CreateParam(ftBCD, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
      Params.CreateParam(ftBoolean, 'ischeckplan', ptOutput);
    end;
  end;

  if not Assigned(FjcdsVehicledistance) then
  begin
    FjcdsVehicledistance := TjsonClientDataSet.create(nil);
    with FjcdsVehicledistance do
    begin
      RemoteServer := DMPublic.jcon;
      // QueryAddress := 'sell/findTicketBuffer';
      SaveAddress := 'vehicledistance/qryVheicledistiance';
      // DataSourceName := 'ticketsPrintInfo';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'iscomparedate', ptInput); //
      Params.CreateParam(ftString, 'vehicleid', ptInput); //
      Params.CreateParam(ftBCD, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;

  if not Assigned(FjcsdQryVehicleinfo) then
  begin
    FjcsdQryVehicleinfo := TjsonClientDataSet.create(nil);
    with FjcsdQryVehicleinfo do
    begin
      RemoteServer := DMPublic.jcon;
      // QueryAddress := 'sell/findTicketBuffer';
      QueryAddress := 'dispatch/qryVehicleinfo';
      DataSourceName := 'list';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'cardno', ptInput); //
      Params.CreateParam(ftBCD, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;
  if not Assigned(FjcsdQryScheduleplan) then
  begin
    FjcsdQryScheduleplan := TjsonClientDataSet.create(nil);
    with FjcsdQryScheduleplan do
    begin
      RemoteServer := DMPublic.jcon;
      // QueryAddress := 'sell/findTicketBuffer';
      QueryAddress := 'dispatch/qryScheduleplanByCard';
      DataSourceName := 'scheduleplanlist';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'filter_EQD_p!departdate', ptInput); //
      Params.CreateParam(ftString, 'filter_EQL_ss!departstationid', ptInput); //
      Params.CreateParam(ftString, 'filter_EQL_r!id', ptInput); //
      Params.CreateParam(ftString, 'vehiclenoid', ptInput); //
      Params.CreateParam(ftString, 'filter_EQL_r!endstationid', ptInput); //

      // Params.CreateParam(ftBCD, 'flag', ptOutput);
      // Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;

  if not Assigned(fjcsdShowValidate) then
  begin
    fjcsdShowValidate := TjsonClientDataSet.create(nil);
    with fjcsdShowValidate do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'check/showValidate';
      // DataSourceName := 'ticketsPrintInfo';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'vehicleid', ptInput); //
      Params.CreateParam(ftString, 'orgid', ptInput); //
      Params.CreateParam(ftBCD, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;

  if not Assigned(FjscdqryVehicleroute) then
  begin
    FjscdqryVehicleroute := TjsonClientDataSet.create(nil);
    with FjscdqryVehicleroute do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'check/showValidate';
      // DataSourceName := 'ticketsPrintInfo';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'vehicleid', ptInput); //
      Params.CreateParam(ftString, 'orgid', ptInput); //
      Params.CreateParam(ftBCD, 'flag', ptOutput);
      Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;
  if not Assigned(fjcdsParameters) then
  begin
    fjcdsParameters := TjsonClientDataSet.create(nil);
    with fjcdsParameters do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'system/findParametersValue';
      DataSourceName := 'paramlistmap';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'code', ptInput); //
      Params.CreateParam(ftString, 'orgid', ptInput); //
      // Params.CreateParam(ftBCD, 'flag', ptOutput);
      // Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;
  if not Assigned(FjcsdQryVehicle) then
  begin
    FjcsdQryVehicle := TjsonClientDataSet.create(nil);
    with FjcsdQryVehicle do
    begin
      RemoteServer := DMPublic.jcon;
      QueryAddress := 'base/qryVehicleById';
      DataSourceName := 'vehiclemap';
      // UpdateDataSet := 'sellTickets';
      // refreshAfterApplyUpdates := true;
      Params.CreateParam(ftString, 'vehicleid', ptInput); //
      // Params.CreateParam(ftBCD, 'flag', ptOutput);
      // Params.CreateParam(ftString, 'msg', ptOutput);
    end;
  end;
end;

procedure TVehcileReport.printReportbill(rpb: TReportAskCondition);
var
  templtename: string;
begin
  templtename := TNovaPrint.GetTicketModelName('营运客车报班单', '报班单');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.create(FAOwner, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.create;
  printValue.Clear;
  printValue.Add('vehicleunit', rpb.vehicleunit);
  printValue.Add('vehicleno', rpb.vehicleno);
  printValue.Add('departtime', rpb.departtime);
  printValue.Add('schedulecode', rpb.schedulecode);
  printValue.Add('seatno', rpb.seatno);
  printValue.Add('drivername1', rpb.drivername);
  printValue.Add('drivername2', rpb.drivername2);
  printValue.Add('startstation', SysInfo.LoginUserInfo.stationName);
  printValue.Add('reachstation', rpb.reachstation);
  printValue.Add('departdate', FormatDateTime('yyyy-mm-dd',rpb.departdate));
  printValue.Add('signname', SysInfo.LoginUserInfo.UserName);
  printValue.Add('signunit', SysInfo.LoginUserInfo.OrgName);
  billPrint.SingleValue := printValue;
  billPrint.printtype:='0';
  billPrint.Print;
end;

procedure TVehcileReport.qryParameter;
begin
 with fjcdsParameters do
  begin
    Active := false;
    Params.ParamValues['code'] :=
      '''0030'',''2038'',''2026'',''2023'',''2011'',''6002'',''3025'',''2032'',''0143'',''6002'',''2013'',''6008'',''2033'',''1819'',''2888''';
    if sysinfo.LoginUserInfo.orgid <= 0 then
    begin
      Params.ParamValues['orgid'] := null;
    end
    else
    begin
      Params.ParamValues['orgid'] := sysinfo.LoginUserInfo.orgid;
    end;
    Active := true;
    if RecordCount > 0 then
    begin
      p0030 := FieldByName('0030').AsString;
      p2038 := FieldByName('2038').AsString;
      p2026 := FieldByName('2026').AsString;
      p2023 := FieldByName('2023').AsString;
      p2011 := FieldByName('2011').AsString;
      p6002 := FieldByName('6002').AsString;
      p3025 := FieldByName('3025').AsString;
      p2032 := FieldByName('2032').AsString;
      p0143 := FieldByName('0143').AsString;
      p6002 := FieldByName('6002').AsString;
      p2013 := FieldByName('2013').AsString;
      p6008 := FieldByName('6008').AsString;
      p2033 := FieldByName('2033').AsString;
      p1819 := FieldByName('1819').AsString;
      p2888 := FieldByName('2888').AsString;
    end;
  end;
end;

procedure TVehcileReport.QryScheduleplan(departdate: string;
  departstationid, routeid, vehicleid, endstationid: int64);
begin
  with FjcsdQryScheduleplan do
  begin
    Active := false;
    Params.ParamValues['filter_EQD_p!departdate'] := departdate;
    Params.ParamValues['filter_EQL_ss!departstationid'] := departstationid;
    if (routeid = 0) then
    begin
      Params.ParamValues['filter_EQL_r!id'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := routeid;
    end;
    if (endstationid = 0) then
    begin
      Params.ParamValues['filter_EQL_r!endstationid'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!endstationid'] := endstationid;
    end;

    Params.ParamValues['vehiclenoid'] := vehicleid;
    Active := true;
  end;
end;

function TVehcileReport.QryVehicledistance(vehicleid: int64): boolean;
var
  departdistance: integer;
  limitdistance: integer;
begin
  result := true;
  with FjcdsVehicledistance do
  begin
    Active := false;
    Params.ParamValues['vehicleid'] := vehicleid;
    Active := true;
    departdistance := FieldByName('departdistance').AsInteger;
    limitdistance := FieldByName('distancelimit').AsInteger;
    // 如果发班里程大于限制里程，提示不能报道
    if departdistance >= limitdistance then
    begin
      result := false;
      // SysDialogs.ShowMessage('该车辆的发班里程已大于限制里程,请激活该车辆的里程限制!');
      exit;
    end;
  end;
end;

function TVehcileReport.QryVehicleinfo(cardno: string): TRes;
begin
  with FjcsdQryVehicleinfo do
  begin
    Active := false;
    Params.ParamValues['cardno'] := cardno;
    Active := true;
    vehReport.res.flag := Params.ParamValues['flag'];
    vehReport.res.msg := Params.ParamValues['msg'];
  end;
end;

procedure TVehcileReport.qryVehicleroute(departdate: TDateTimePicker;
  departstationid: int64; cardno, serialnumber: String; vehicleid: int64);
begin
  with FjscdqryVehicleroute do
  begin
    Active := false;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      departdate.date);
    Params.ParamValues['departstationid'] := departstationid;
    Params.ParamValues['cardno'] := cardno;
    Params.ParamValues['serialnumber'] := serialnumber;
    if vehicleid > 0 then
      Params.ParamValues['vehicleid'] := null
    else
      Params.ParamValues['vehicleid'] := null;
    Active := true;
  end;
end;

procedure TVehcileReport.report(condition: TReportAskCondition);
var
  sResult, reason, log: string;
  nResult: integer;
begin
  with FjsdsSaveReport do
  begin
    Active := false;

    Params.ParamValues['departstationid'] := condition.departstationid;
    Params.ParamValues['vehiclereport.departdate'] := formatdatetime
      ('yyyy-mm-dd', condition.departdate);
    Params.ParamValues['vehiclereport.createby'] := condition.createby;
    Params.ParamValues['vehiclereport.scheduleplanid'] :=
      condition.scheduleplanid;

    if condition.driver1id > 0 then
      Params.ParamValues['vehiclereport.driver1.id'] := condition.driver1id
    else
      Params.ParamValues['vehiclereport.driver1.id'] := null;

    if condition.driver2id > 0 then
      Params.ParamValues['vehiclereport.driver2.id'] := condition.driver2id
    else
      Params.ParamValues['vehiclereport.driver2.id'] := null;

    if condition.driver3id > 0 then
      Params.ParamValues['vehiclereport.driver3.id'] := condition.driver3id
    else
      Params.ParamValues['vehiclereport.driver3.id'] := null;

    if condition.driver4id > 0 then
      Params.ParamValues['vehiclereport.driver4.id'] := condition.driver4id
    else
      Params.ParamValues['vehiclereport.driver4.id'] := null;

    if condition.steward1id > 0 then
      Params.ParamValues['vehiclereport.steward1.id'] := condition.steward1id
    else
      Params.ParamValues['vehiclereport.steward1.id'] := null;

    Params.ParamValues['vehiclereport.reportorgid'] := condition.reportorgid;
    Params.ParamValues['vehiclereport.scheduleid'] := condition.scheduleid;
    Params.ParamValues['vehiclereport.vehicleid'] := condition.vehicleid;
    Params.ParamValues['vehiclereport.orderno'] := condition.orderno;
    Params.ParamValues['vehiclereport.isTempVehicle'] :=
      condition.isTempVehicle;

    Params.ParamValues['vehicleno'] := condition.vehicleno;
    Params.ParamValues['vehiclereport.unitid'] := condition.unitid;
    Params.ParamValues['vehiclereport.reason'] := condition.reason;
    Params.ParamValues['vehiclereport.balanceunitid'] :=
      condition.balanceunitid;

    // 证件
    // 线路标识牌
    Params.ParamValues['vdp.vroadnores'] := condition.vroadnores;
    // 行驶证
    Params.ParamValues['vdp.vdriverlicenseres'] := condition.vdriverlicenseres;
    // '合格'

    Params.ParamValues['vdp.vworknores'] := condition.vworknores; // '合格'

    // 例检合格通知单（安检结果）
    Params.ParamValues['vdp.vnotenum'] := condition.vnotenum;

    // 第一个驾驶员
    Params.ParamValues['vdp.drivername'] := condition.drivername;

    Params.ParamValues['vdp.dqualificationres'] := condition.dqualificationres;
    // '合格'

    Params.ParamValues['vdp.ddrivinglicenseres'] :=
      condition.ddrivinglicenseres; // '合格'

    Params.ParamValues['vdp.dworknores'] := condition.dworknores; // ; '合格'

    Params.ParamValues['vdp.driversign'] := condition.driversign; //
    // 第二个驾驶员
    Params.ParamValues['vdp.drivername2'] := condition.drivername2;
    // NovaHelpcopilot1.Text;
    Params.ParamValues['vdp.ddrivinglicenseres2'] :=
      condition.ddrivinglicenseres2; // '合格'

    Params.ParamValues['vdp.dworknores2'] := condition.dworknores2; // '合格'

    Params.ParamValues['vdp.dqualificationres2'] :=
      condition.dqualificationres2; // '合格'
    Params.ParamValues['vdp.driversign2'] := condition.driversign2;

    Params.ParamValues['vdp.classmember'] := condition.classmember;
    Params.ParamValues['vdp.dispatcher'] := condition.dispatcher; //
    Params.ParamValues['vdp.stewardname'] := condition.stewardname;

    try
      Execute;
      res.flag := Params.ParamByName('flag').Value;
      res.msg := Params.ParamByName('msg').Value;
      if(res.flag=1) then
      begin
        if (vehReport.p2888 = '1') then
        begin
          vehReport.printReportbill(condition);
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车辆报到失败：' + E.Message);
      end;
    end;
  end;
end;

function TVehcileReport.CheckValidate(vehicleid: int64; orgid: int64): TRes;
begin
  with fjcsdShowValidate do
  begin
    Close;
    Params.ParamValues['vehicleid'] := vehicleid;
    Params.ParamValues['orgid'] := orgid;
    Execute;
    res.flag := Params.ParamByName('flag').Value;
    res.msg := Params.ParamByName('msg').Value;
  end;
  result := res;
end;

function TVehcileReport.VehicleActive(vehicleid: int64;
  departdate: string): boolean;
var
  nResult, temp: integer;
  sResult, distancemessage: string;
begin

  // 是否开启车辆二期维护有效期
  if getParametervalue('6006', sysinfo.LoginUserInfo.orgid) = '1' then
  begin
    // 查询车辆里程激活管理，取出二维有效期
    with FjcdsVehicledistance do
    begin
      Close;
      Params.ParamValues['vehicleid'] := vehicleid; // jscdqryVehicleroute.FieldByName('id').AsString;
      Params.ParamValues['iscomparedate'] := 'true';
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if (nResult <= 0) then
      begin
        sResult := Params.ParamByName('msg').Value;
        temp := Pos('该车辆还有', sResult);
        if temp > 0 then
        begin
          if distancemessage <> '' then
          begin
            sResult := Copy(sResult, 4);
            distancemessage := distancemessage + ',' + sResult;
          end
          else
            distancemessage := sResult;
        end
        else
        begin
          SysDialogs.Warning(sResult);
          result := false;
          exit;
        end;
      end;

    end;
  end;
  if distancemessage <> '' then
    SysDialogs.ShowInfo(distancemessage + ',达到二维期限！');
  distancemessage := '';
  result := true;

end;

{ ReportAskCondition }

constructor TReportAskCondition.create;
begin
  driver1id := 0;
  driver2id := 0;
  driver3id := 0;
  driver4id := 0;
  steward1id := 0;
  steward2id := 0;
end;

end.
