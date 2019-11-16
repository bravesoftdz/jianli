unit UTicketQuery;

interface
uses Classes,SysUtils,DB,Generics.Collections,jsonClientDataSet,Services,
      FunctionItemIntf,UDMPublic,Variants,StrUtils,PubFn,forms,Windows;
const refreshScheduleInterval = 5;  //超过5秒后刷新当前班次

type
 //班次查询条件类
ScheduleAskCondition =class
	public
    isnet:boolean;
    departDate:TDate;
	  departStationId:Int64;
    reachStationId:Int64;
    ScheduleId:Int64;
    ticketIdToBeChange:int64;//要改票的车票id值
    customerid:Int64;//订票顾客id
    districtcode:string; //发车站所属区域
    constructor create();
end;

TTicketQuery=class(TComponent)
  private
    FcdsDDDWorkways:TjsonClientDataSet;  //营运方式
    FcdsDDDschedulestatus:TjsonClientDataSet;    //班次状态
    FcdsDDDvehicletype:TjsonClientDataSet;    //车型类型
    FcdsDDDvehiclegrade:TjsonClientDataSet;   //车型等级
    FcdsDDDseattype:TjsonClientDataSet;      //票价座位类型

    FcdsSchedule:TjsonClientDataSet;    //班次查询
    FcdsScheduleSeats:TjsonClientDataSet;  //班次座位
    FcdsGetTickettypePrice:TjsonClientDataSet;  //取票种票价

    FcdsSeatshint:TjsonClientDataSet; //座位提示

    FAfterScheduleScroll:TDataSetNotifyEvent;
    FScheduleSeatStatus:TDictionary<Word,String>;
    FScheduleSeatTickettype:TDictionary<Word,String>;
    FScheduleSeattype:TDictionary<Word,String>;
    Fseatshint: TDictionary<Word, String>;  //座位图提示


    //当前是否查询联网班次
    isnet:Boolean;
    //初始化数据字典
    procedure initcdsDDD;
    function createCdsDDD(tablename,columnname:String):TjsonClientDataSet;
    //初始化班次查询
    procedure initcdsSchedule;
    function createField(_fieldname,_DisplayLabel:String;_fieldtype:TFieldType;_fieldlength,_Index:integer;_dataset:TDataSet):TField;
    function createLookupField(_fieldname,_DisplayLabel,_KeyFields,_LookupKeyFields,_LookupResultField:String;_fieldtype:TFieldType;_fieldlength,_Index:integer;_dataset,_LookupDataSet:TDataSet):TField;
    procedure ScheduleAfterScroll(DataSet: TDataSet);
    function refreshSeatsHint(scheduleplanid: int64): string;

  public
    FrefreshCurScheduleTime:DWORD;//刷新当前班次的
    delayrefresh:Boolean;//售票问讯是否延迟加载最新座位及票价信息
    constructor Create(AOwner: TComponent);overload;

    procedure refreshseatandprice();

    //查询班次
    function findSchedule(condition:ScheduleAskCondition):Integer;
    //查询联网班次
    function findNetSchedule(condition:ScheduleAskCondition):Integer;
    //取票种票价
    function GetTickettypePrice(departdate:TDate;tickettypecode:String;fullprice:Currency):Currency;

    property cdsSchedule:TjsonClientDataSet read FcdsSchedule;
    property cdsScheduleSeats:TjsonClientDataSet read FcdsScheduleSeats;
    //班次列表移动事件
    property AfterScheduleScroll:TDataSetNotifyEvent read FAfterScheduleScroll write FAfterScheduleScroll;
    //当前班次的座位状态
    property ScheduleSeatStatus:TDictionary<Word,String> read FScheduleSeatStatus;
    property ScheduleSeatTickettype:TDictionary<Word,String> read FScheduleSeatTickettype;
    property seatshint: TDictionary<Word, String> read Fseatshint;  //座位图提示

    //当前班次的座位类型
    property ScheduleSeattype:TDictionary<Word,String> read FScheduleSeattype;

end;

implementation

uses UFrmTicketQuery;

{ TTicketQuery }

constructor TTicketQuery.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  initcdsDDD;
  initcdsSchedule;
  FrmTicketQuery:=TfrmTicketQuery.Create(Self,self);
  Services.SysMainForm.ShowForm(FrmTicketQuery);
  delayrefresh:=StrToBoolDef(getParametervalue('1601',SysInfo.LoginUserInfo.OrgID),false);
end;

function TTicketQuery.createCdsDDD(tablename,
  columnname: String): TjsonClientDataSet;
begin
  result:=TjsonClientDataSet.Create(self);
  with result do
  begin
    RemoteServer:=DMPublic.jcon;
    QueryAddress:='system/querydictionary';
    DataSourceName:='diclist';
    Params.CreateParam(ftString,'tablename',ptInput);
    Params.CreateParam(ftString,'columnname',ptInput);

    Params.ParamValues['tablename']:=tablename;
    Params.ParamValues['columnname']:=columnname;
    Active:=true;
  end;
end;

function TTicketQuery.createField(_fieldname,_DisplayLabel:String;_fieldtype:TFieldType;_fieldlength,_Index:integer;_dataset:TDataSet):TField;
begin
  result:= DefaultFieldClasses[_fieldtype].Create(_dataset);
  with result do
  begin
//    name:=_dataset.Name+_fieldname;
    size:=_fieldlength;
    FieldName:=_fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    DataSet:=_dataset;
  end;
end;

function TTicketQuery.createLookupField(_fieldname,_DisplayLabel,_KeyFields,_LookupKeyFields,_LookupResultField:String;_fieldtype:TFieldType;_fieldlength,_Index:integer;_dataset,_LookupDataSet:TDataSet):TField;
begin
  result:= DefaultFieldClasses[_fieldtype].Create(_dataset);
  with result do
  begin
//    name:=_dataset.Name+_fieldname;
    FieldName:=_fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    size:=_fieldlength;

    FieldKind := fkLookup;
    KeyFields := _KeyFields;
    LookupKeyFields := _LookupKeyFields;
    LookupResultField := _LookupResultField;
    LookupDataset := _LookupDataSet;
    DataSet:=_dataset;
  end;
end;

function TTicketQuery.findNetSchedule(condition: ScheduleAskCondition): Integer;
begin

end;

function TTicketQuery.findSchedule(condition: ScheduleAskCondition): Integer;
begin
  with FcdsSchedule do
  begin
    FcdsSchedule.AfterScroll:=nil;
    active:=false;
    isnet:=condition.isnet;
    if isnet then
    begin
        Params.ParamValues['isnet']:=1 ; //1本集团联网
    end
    else
    begin
       Params.ParamValues['isnet']:=0 ; //0不联网
    end;


    Params.ParamValues['scheduleAskCondition.departDate']:= FormatDateTime('yyyy-mm-dd',condition.departDate);
    Params.ParamValues['scheduleAskCondition.departStationId']:=condition.departStationId;
    Params.ParamValues['scheduleAskCondition.reachStationId']:=condition.reachStationId;
    Params.ParamValues['scheduleAskCondition.scheduleid']:=condition.ScheduleId;
    Params.ParamValues['scheduleAskCondition.seller']:=SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['scheduleAskCondition.ip']:=SysInfo.LocalHostAddress;
    Params.ParamValues['scheduleAskCondition.ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
    Params.ParamValues['scheduleAskCondition.sellway']:='';
    Params.ParamValues['scheduleAskCondition.ticketIdToBeChange']:=condition.ticketIdToBeChange;
    Params.ParamValues['scheduleAskCondition.customerid']:=condition.customerid;
    Params.ParamValues['scheduleAskCondition.districtcode']:=condition.districtcode;

    Active:=True;
    FcdsSchedule.AfterScroll:=ScheduleAfterScroll;
    result:=RecordCount;
    First;
  end;
end;

function TTicketQuery.GetTickettypePrice(departdate: TDate;tickettypecode:String;
  fullprice: Currency): Currency;
var exec:boolean;
begin
  result:=0;
  exec:=false;
  if not Assigned(FcdsGetTickettypePrice) then
  begin
    FcdsGetTickettypePrice:=TjsonClientDataSet.Create(self);
    with FcdsGetTickettypePrice do
    begin
      RemoteServer:=DMPublic.jcon;
      SaveAddress:='sell/findTickettypePrice';
      Params.CreateParam(ftString,'departDate',ptInput);
      Params.CreateParam(ftString,'tickettypecode',ptInput);
      Params.CreateParam(ftString,'fullprice',ptInput);
      Params.CreateParam(ftCurrency,'tickettypeprice',ptOutput);
      Params.CreateParam(ftInteger,'flag',ptOutput);
      Params.CreateParam(ftString,'msg',ptOutput);
    end;
  end;
  with FcdsGetTickettypePrice do
  begin
    Params.ParamValues['departDate']:=FormatDateTime('',departdate);
    Params.ParamValues['tickettypecode']:=tickettypecode;
    Params.ParamValues['fullprice']:=fullprice;
    try
      Execute;
      exec:=true;
    except on E: Exception do
      raise Exception.Create('取票价失败:'+e.Message);
    end;
    if exec then
    begin
      if Params.ParamValues['flag']=1 then
      begin
        result:=Params.ParamByName('tickettypeprice').AsCurrency;
      end
      else
      begin
        result:=-1;
        if (Params.ParamValues['msg']=null) or (Params.ParamValues['msg']='') then
          raise Exception.Create('取票价失败:未知错误')
        else
          raise Exception.Create(Params.ParamValues['msg']);
      end;
    end;
  end;
end;

procedure TTicketQuery.initcdsDDD;
begin
  if not Assigned(FcdsDDDWorkways) then FcdsDDDWorkways:=createCdsDDD('schedule','workways');  //营运方式
  if not Assigned(FcdsDDDschedulestatus) then FcdsDDDschedulestatus:=createCdsDDD('schedulestatus','schedulestatus');    //班次状态
  if not Assigned(FcdsDDDvehicletype) then FcdsDDDvehicletype:=createCdsDDD('vehicletype','type');    //车型类型
  if not Assigned(FcdsDDDvehiclegrade) then FcdsDDDvehiclegrade:=createCdsDDD('vehicletype','grade');   //车型等级
  if not Assigned(FcdsDDDseattype) then FcdsDDDseattype:=createCdsDDD('handprice','seattype');      //票价座位类型
end;

procedure TTicketQuery.initcdsSchedule;
  function incEx(i:integer):integer;
  begin
    inc(i);
    result:=i;
  end;
  var i:integer;
begin
  if not Assigned(FcdsSchedule) then
  begin
    FcdsSchedule:=TjsonClientDataSet.Create(self);
    with FcdsSchedule do
    begin
      RemoteServer:=DMPublic.jcon;
      QueryAddress:='sell/findSchedule';
      DataSourceName:='preSaleSchedules';
      Params.CreateParam(ftString,'isnet',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.departDate',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.departStationId',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.reachStationId',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.scheduleid',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.seller',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.ip',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.ticketoutletsid',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.sellway',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.ticketIdToBeChange',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.customerid',ptInput);
      Params.CreateParam(ftString,'scheduleAskCondition.districtcode',ptInput);

      i:=-1;
      createField('routename', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('schedulecode', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('scheduleremarks', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('schedulesynccode', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('departstationname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('departstationcode', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('reachstationname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('reachstationcode', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('reachstationsecondname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('startstationname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('endstationname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planvehicletype', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planvehiclegrade', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planvehicleno', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planvehicletypecustomname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planunitname', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planbrandmodel', '', ftWideString,60, incEx(i), FcdsSchedule) ;
      createField('planbrandmodelid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;

      createField('id', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('autocancelreserveseatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('departdate', '', ftDate,0, incEx(i), FcdsSchedule) ;
      createField('districttype', '', ftWideString,10, incEx(i), FcdsSchedule) ;
      createField('endstationid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('endtime', '', ftWideString,5, incEx(i), FcdsSchedule) ;
      createField('fixedreserveseatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('islinework', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isoriginator', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isovertime', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isproprietary', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('issaleafterreport', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('issellreturnticket', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('orgid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('runtime', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('scheduleid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('scheduletype', '', ftWideString,10, incEx(i), FcdsSchedule) ;
      createField('spacinginterval', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('startstationid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('starttime', '', ftWideString,5, incEx(i), FcdsSchedule) ;
      createField('unautocancelreserveseatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('worktype', '', ftWideString,10, incEx(i), FcdsSchedule) ;
      createField('workways', '', ftWideString,10, incEx(i), FcdsSchedule) ;


      createField('planunitid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('planvehicleid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;


      createField('departstationid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('reachstationid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('residueseatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('seatnos', '', ftWideString,300, incEx(i), FcdsSchedule) ;
      createField('seatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('soldeatnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('carrychildnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('residuecarrychildnum', '', ftInteger,0, incEx(i), FcdsSchedule) ;

      createField('distance', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('balancedistance', '', ftInteger,0, incEx(i), FcdsSchedule) ;
      createField('fullprice', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('halfprice', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('studentprice', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('toplimitprice', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('lowerlimitprice', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('fueladditionfee', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('stationservicefee', '', ftFloat,0, incEx(i), FcdsSchedule) ;
      createField('seattype', '', ftWideString,10, incEx(i), FcdsSchedule) ;
    //	createField('runtime', '', ftFloat,0, incEx(i), FcdsSchedule) ;
    //	createField('issellable', '', ftBoolean,10, incEx(i), FcdsSchedule) ;
    //	private orgid;


      createField('scheduleplanid', '', ftLargeint,0, incEx(i), FcdsSchedule) ;
      createField('buspark', '', ftWideString,50, incEx(i), FcdsSchedule) ;
      createField('departtime', '', ftWideString,5, incEx(i), FcdsSchedule) ;
      createField('isbegincheck', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isdeparted', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isreported', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('isemptyvehicle', '', ftBoolean,0, incEx(i), FcdsSchedule) ;
      createField('status', '', ftWideString,10, incEx(i), FcdsSchedule) ;
      createField('ticketentrance', '', ftWideString,50, incEx(i), FcdsSchedule) ;

      createLookupField('workwaysname','','workways','code','value',ftWideString,50,incEx(i),FcdsSchedule,FcdsDDDWorkways);
      createLookupField('statusname','','status','code','value',ftWideString,50,incEx(i),FcdsSchedule,FcdsDDDschedulestatus);
      createLookupField('planvehicletypename','','planvehicletype','code','value',ftWideString,50,incEx(i),FcdsSchedule,FcdsDDDvehicletype);
      createLookupField('planvehiclegradename','','planvehiclegrade','code','value',ftWideString,50,incEx(i),FcdsSchedule,FcdsDDDvehiclegrade);
      createLookupField('seattypename','','seattype','code','value',ftWideString,50,incEx(i),FcdsSchedule,FcdsDDDseattype);
    end;
  end;
end;

procedure TTicketQuery.refreshseatandprice;
var
  scheduleplanid:int64;
begin
 { FrefreshCurScheduleTime:=GetTickCount;
  if FScheduleSeatStatus=nil then
  begin
    FScheduleSeatStatus:=TDictionary<Word,String>.Create;
  end;
  ScheduleSeatStatus.Clear;
  if FScheduleSeattype=nil then
  begin
    FScheduleSeattype:=TDictionary<Word,String>.Create;
  end;
  ScheduleSeattype.Clear;
  if FScheduleSeatTickettype=nil then
  begin
    FScheduleSeatTickettype:=TDictionary<Word,String>.Create;
  end;
  ScheduleSeatTickettype.Clear;
  if (not FcdsSchedule.active) or (FcdsSchedule.RecordCount=0) then exit;

  //非流水班次
  if not FcdsSchedule.FieldByName('ISLINEWORK').AsBoolean then
  begin
    if FcdsScheduleSeats=nil then
    begin
      FcdsScheduleSeats:=TjsonClientDataSet.Create(self);
      with FcdsScheduleSeats do
      begin
        RemoteServer:=DMPublic.jcon;
        QueryAddress:='sell/findScheduleseats';
        DataSourceName:='scheduleseats';
        Params.CreateParam(ftString,'isnet',ptInput);
        Params.CreateParam(ftString,'scheduleplanid',ptInput);
        Params.CreateParam(ftString,'sellway',ptInput);
        Params.CreateParam(ftString,'ticketpriceid',ptInput);
        Params.CreateParam(ftString,'departdate',ptInput);
        Params.CreateParam(ftString,'schedulesynccode',ptInput);
        Params.CreateParam(ftString,'departstationcode',ptInput);
        Params.CreateParam(ftString,'reachstationcode',ptInput);
        Params.CreateParam(ftString,'seattype',ptInput);
        Params.CreateParam(ftInteger,'residueseatnum',ptOutput);
        Params.CreateParam(ftInteger,'seatnum',ptOutput);
        Params.CreateParam(ftCurrency,'fullprice',ptOutput);
        Params.CreateParam(ftCurrency,'halfprice',ptOutput);
        Params.CreateParam(ftCurrency,'studentprice',ptOutput);
        Params.CreateParam(ftWideString,'departtime',ptOutput);
      end;
    end;
    with FcdsScheduleSeats do
    begin
      Active:=false;
      Params.ParamValues['isnet']:=isnet;
      Params.ParamValues['scheduleplanid']:=FcdsSchedule.FieldByName('scheduleplanid').AsString;
      scheduleplanid:=FcdsSchedule.FieldByName('scheduleplanid').AsInteger;
      Params.ParamValues['ticketpriceid']:=FcdsSchedule.FieldByName('id').AsString;
      Params.ParamValues['sellway']:='';
      Params.ParamValues['departdate']:=FcdsSchedule.FieldByName('departdate').AsString;
      Params.ParamValues['schedulesynccode']:=FcdsSchedule.FieldByName('schedulesynccode').AsString;
      Params.ParamValues['departstationcode']:=FcdsSchedule.FieldByName('departstationcode').AsString;
      Params.ParamValues['reachstationcode']:=FcdsSchedule.FieldByName('reachstationcode').AsString;
      Params.ParamValues['seattype']:=FcdsSchedule.FieldByName('seattype').AsString;
      Active:=true;
      FcdsSchedule.edit;
      FcdsSchedule.FieldByName('seatnum').AsInteger:=Params.ParamByName('seatnum').AsInteger;
      FcdsSchedule.FieldByName('residueseatnum').AsInteger:=Params.ParamByName('residueseatnum').AsInteger;
      FcdsSchedule.FieldByName('fullprice').AsCurrency:=Params.ParamByName('fullprice').AsCurrency;
      FcdsSchedule.FieldByName('halfprice').AsCurrency:=Params.ParamByName('halfprice').AsCurrency;
      FcdsSchedule.FieldByName('studentprice').AsCurrency:=Params.ParamByName('studentprice').AsCurrency;
      if isnet then
      begin
        FcdsSchedule.FieldByName('departtime').AsWideString:=Params.ParamByName('departtime').AsWideString;
      end;
      FcdsSchedule.post;
      First;
      while not eof do
      begin
        ScheduleSeattype.Add(FieldByName('seatno').AsInteger,FieldByName('seattype').AsString);
        ScheduleSeatStatus.Add(FieldByName('seatno').AsInteger,FieldByName('status').AsString);
        if (FieldByName('status').AsString='2')
          or (FieldByName('status').AsString='7')
          or (FieldByName('status').AsString='8') then
        begin
          ScheduleSeatTickettype.Add(FieldByName('seatno').AsInteger,FieldByName('tickettype').AsString);
        end;
        Next;
      end;
    end;
    //refreshSeatsHint(scheduleplanid);
  end; }
end;

function TTicketQuery.refreshSeatsHint(scheduleplanid: int64): string;
begin
  {if not Assigned(seatshint) then
    Fseatshint := TDictionary<Word, String>.Create()
  else
    Fseatshint.Clear;
  if isnet then exit;
  if FcdsSeatshint=nil then
  begin
    FcdsSeatshint:=TjsonClientDataSet.Create(self);
    with FcdsSeatshint do
    begin
      RemoteServer:=DMPublic.jcon;
      QueryAddress:='checkticket/qrySeatstatus';
      DataSourceName:='seatstatuslist';
      Params.CreateParam(ftString,'scheduleplanid',ptInput);
    end;
  end;
  with FcdsSeatshint do
  begin
    active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        seatshint.AddOrSetValue(FieldByName('seatno').AsInteger, FieldByName('hint').AsString);
        next;
      end;
    end;
  end;  }
end;

procedure TTicketQuery.ScheduleAfterScroll(DataSet: TDataSet);
begin
  FrefreshCurScheduleTime:=refreshScheduleInterval*1000+1;
  if (not isnet) or (not delayrefresh) then
  begin
    refreshseatandprice();
  end;
  if Assigned(FAfterScheduleScroll) then
  begin
    FAfterScheduleScroll(FcdsSchedule);
  end;
end;

{ ScheduleAskCondition }

constructor ScheduleAskCondition.create;
begin
  isnet:=false;
  departDate:=Trunc(Now);
  departStationId:=0;
  reachStationId:=0;
  ScheduleId:=0;
  ticketIdToBeChange:=0;
end;

end.
