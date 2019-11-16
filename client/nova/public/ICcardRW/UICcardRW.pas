unit UICcardRW;

interface

uses SysUtils, Classes, Generics.Defaults,Generics.Collections,Forms,ExtCtrls;

type
//***********************此顺序不能改变，否则已写的卡会乱掉*********************
//  0报到卡 1驾驶员卡 2乘务员卡 3贵宾卡 4员工卡 5结算卡
//******************************************************************************
  TCardtypes=(VEHICLEREPORT,DRIVER,STEWARD,VIP,USER,VEHICLEUNIT);
  Icardfound = Interface
    ['{3A455988-9D76-4FD1-8BC9-C114E6A013B6}']
    procedure cardfound(cardSequenceNo:longword;icdev: longint);
  End;
  //IC卡设备类
  TCardRWDevice= class
  private
    FNotifies:TList<Icardfound>;
    icdev: longint;//设备标识符
    cardSequenceNo:LongWord;//当前卡序列号
    timerSearchCard: TTimer; // 定时器
    procedure timerSearchCardOnTimer(Sender: Tobject);
  public
    class function GetInstance(): TCardRWDevice;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(cardfound:Icardfound);
    procedure removeObserver(cardfound:Icardfound);
    function getErrorInfo(rs:Integer):String;//返回错误信息
  end;


///////////IC卡默认实现，只读写卡类型和卡号，可用于USER,DRIVER,STEWARD,VEHICLEUNIT///////////////////////////////////////////////////////
  //磁卡类
  TBaseCard = class(TObject)
  private
    procedure setCardtype(_cartype : TCardtypes);
    procedure setNewcardNo(newcardno:AnsiString);
  protected
    Fisnew:Boolean; //是否新卡
    FinternalSerialNo:Int64; //0扇区0块
    Fcardtype:TCardtypes; //卡类型 0扇区1块
    FcardNo:AnsiString;//8位 0扇区2块
  public
    constructor Create;
    function writeCard:Integer;//写卡
    function getErrorInfo(rs:Integer):String;//返回错误信息
    property cardNo : AnsiString read FcardNo write setNewcardNo;
    property internalSerialNo : Int64 read FinternalSerialNo;
    property cardtype : TCardtypes read Fcardtype write setCardtype;
    property isnew : Boolean read Fisnew;
  end;

  IBaseCardfound = Interface
    ['{D2DDE73F-39F9-4A54-B7D8-E0A509CC6E03}']
    procedure iccardfound(icCard:TBaseCard);
  End;

  TBaseCardRW = class(TInterfacedObject,Icardfound)
  protected
    FNotifies:TDictionary<IBaseCardfound,Boolean>;
    newBlock3data_hex,newPasswordA_hex,newPasswordB_hex:AnsiString;
    defaultBlock3data_hex,defaultPasswordA_hex,defaultPasswordB_hex:AnsiString;
    invokeRS,loadmode:smallint;

    cartype_block:SmallInt; //卡类型 0扇区1块
    cardNo_block:SmallInt;//8位 0扇区2块

    icdev: longint;//设备标识符

    procedure cardfound(cardSequenceNo:longword;icdev: longint);
    function writeCard(icCard:TBaseCard):Integer;//写卡
  public
    class function GetInstance(): TBaseCardRW;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(iccardfound:IBaseCardfound;notifyOnlyOnActivate:Boolean=True);
    procedure removeObserver(iccardfound:IBaseCardfound);

    function getErrorInfo(rs:Integer):String;//返回错误信息
  end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////VIP卡实现////////////////////////////////////////////////////////////////////
  TCardGrade=(ONECARD,GENERAL,GOLD);
  //VIP磁卡类
  TVipCard = class(TObject)
  private
    Fisnew:Boolean; //是否新卡
    issued:Boolean; //是否已发卡
    FinternalSerialNo:Int64; //0扇区0块
    Fcartype:TCardtypes; //卡类型 0扇区1块
    FcardNo:AnsiString;//8位 0扇区2块

    FcardGrade:TCardGrade;  //0 1 2 取数据字典 1扇区0块
    Fmoney:Currency;//保留两位小数 1扇区1块
    Famount:Currency;//保留两位小数 1扇区2块
  public
    constructor Create;

//    procedure setNewcardNo(newcardno:AnsiString);
    procedure setNewcardGrade(newcardGrade:TCardGrade);
    procedure incrementmoney(changemoney:Currency); //增加余额
    procedure decrementmoney(changemoney:Currency); //减少余额
    procedure incrementamount(changeamount:Currency); //增加积分
    procedure decrementamount(changeamount:Currency); //减少积分

    function writeCard:Integer;//写卡
    function getErrorInfo(rs:Integer):String;//返回错误信息

    property cardNo : AnsiString read FcardNo;
    property cardGrade : TCardGrade read FcardGrade;
    property internalSerialNo : Int64 read FinternalSerialNo;
    property money : Currency read Fmoney;
    property amount : Currency read Famount;
    property cardtype : TCardtypes read Fcartype;
    property isnew : Boolean read Fisnew;

  end;

  Ivipcardfound = Interface
    ['{D218355B-6BCB-4B9D-8A5A-63C812911976}']
    procedure vipcardfound(vipCard:TVipCard);
  End;

  TVipcardRW = class(TInterfacedObject,Icardfound)
  private
    FNotifies:TDictionary<Ivipcardfound,Boolean>; //TList<>
    newBlock3data_hex,newPasswordA_hex,newPasswordB_hex:AnsiString;
    defaultBlock3data_hex,defaultPasswordA_hex,defaultPasswordB_hex:AnsiString;
    invokeRS,loadmode:smallint;

    cartype_block:SmallInt; //卡类型 0扇区1块
    cardNo_block:SmallInt;//8位 0扇区2块
    cardGrade_block:SmallInt;  //0 1 2 取数据字典 1扇区0块
    money_block:SmallInt;//保留两位小数 1扇区1块
    amount_block:SmallInt;//保留两位小数 1扇区2块
    icdev: longint;//设备标识符

    procedure cardfound(cardSequenceNo:longword;icdev: longint);
    function writeCard(vipCard:TVipCard):Integer;//写卡

  public
    class function GetInstance(): TVipcardRW;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(vipcardfound:Ivipcardfound;notifyOnlyOnActivate:Boolean=True);
    procedure removeObserver(vipcardfound:Ivipcardfound);

    function getErrorInfo(rs:Integer):String;//返回错误信息
  end;
/////////////////////////////////////////////////////////////////////////////////////////////////

procedure setCardTypeNOLength(cardtypes:TCardtypes;len:Integer);

function getCardtypeName(cardtype:TCardtypes):string;
function getCardgradeName(cardgrade:TCardGrade):string;

implementation

var
  cardRWDevice:TCardRWDevice = nil;//IC卡设备对象
  iccardRW : TBaseCardRW = nil; //IC卡基本读写操作对象
  vipcardRW: TVipcardRW = nil; //VIP卡读写对象


  cardtypeNOlengths:TDictionary<TCardtypes,Integer>;//记录不同卡种的卡号长度

  //将字符串中的#0替换成字符0
  function ReplaceAllJ0ToS0(s:String): String;
  var i:integer;
  begin
    for i := 1 to Length(s) do
      if s[i]=#0 then
        s[i]:='0';
    result:=s;
  end;

  procedure setCardTypeNOLength(cardtypes:TCardtypes;len:Integer);
  begin
    if (len=0) or (len>16) then
    begin
      raise Exception.Create('卡号长度被限制在1至16之间');
    end;
    if cardtypeNOlengths=nil then
      cardtypeNOlengths:=TDictionary<TCardtypes,Integer>.Create;
    if not cardtypeNOlengths.ContainsKey(cardtypes) then
      cardtypeNOlengths.Add(cardtypes,len)
    else
    begin
      if cardtypeNOlengths.Items[cardtypes]<>len then
      begin
        raise Exception.Create('该卡类型的长度曾经被设置过，但长度与您要设置的长度不一致，系统异常');
      end;
    end;
  end;

  function getcardtypename(cardtype:TCardtypes):String;
  begin
    case cardtype of
      VEHICLEREPORT: Result:='车辆报到卡';
      VIP: Result:='客户卡';
      USER: Result:='员工卡';
      DRIVER: Result:='驾驶员卡';
      STEWARD: Result:='乘务员卡';
      VEHICLEUNIT: Result:='车属单位卡';
    else ;
      Result:='未知卡种';
    end;
  end;

  function getCardgradeName(cardgrade:TCardGrade):string;
  begin
    case cardgrade of
      ONECARD: Result:='一卡通';
      GENERAL: Result:='普卡';
      GOLD: Result:='金卡';
    else ;
      Result:='未知等级';
    end;
  end;

  function getcardnolength(cardtypes:TCardtypes):Integer;
  begin
    if (cardtypeNOlengths=nil) or (not cardtypeNOlengths.ContainsKey(cardtypes)) then
    begin
      raise Exception.Create('没有设置'+getcardtypename(cardtypes)+'的卡号长度');
    end;
    result:=cardtypeNOlengths.Items[cardtypes];
  end;

  //将字符串补齐16字节
  function FillZeroToSixteenByte(str:AnsiString):AnsiString;
  begin
    Result:=str+copy('0000000000000000',1,16-length(str));
  end;

  // 类型转换字符串转换成十六进制
  function StringToHex(S: AnsiString): PAnsiChar;
  var I: Integer;
      rs:AnsiString;
  begin
    result:='';
    rs:= '';
    for I := 1 to length (S) do
      rs:= rs+IntToHex(ord(S[i]),2);
    result:=PAnsiChar(rs);
  end;

  // 类型转换十六进制转换成字符串
  function HexToString(H: AnsiString): AnsiString;
  var I: Integer;
  begin
     Result:= '';
    for I := 1 to length (H) div 2 do
      Result:= Result+ansiChar(StrToInt('$'+Copy(H,(I-1)*2+1,2)));
  end;
//  function FillZeroToSixteenByte(str:PAnsiChar):PAnsiChar;

  {a example for your to try using .dll. add_s return i+1}
  function add_s(i: smallint): smallint; stdcall;far;external 'mwrf32.dll' name 'add_s';
  //设备操作函数
  function rf_beep(icdev:longint;time:smallint):smallint;stdcall;       far;external 'mwrf32.dll' name 'rf_beep';
  function rf_ctl_mode(icdev:longint;ctlmode:smallint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_ctl_mode';
  function rf_disp(icdev:longint;pt_mode:smallint;disp:longint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_disp';
  function rf_disp8(icdev:longint;len:longint;disp:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_disp8';
  function rf_disp_mode(icdev:longint;mode:smallint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_disp_mode';
  function rf_get_status(icdev:longint;status:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_get_status';
  function rf_gettimehex(icdev:longint;dis_time:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_gettimehex';
  function rf_reset(icdev:longint;msec:smallint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_reset';
  function rf_settimehex(icdev:longint;dis_time:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_settimehex';
  function rf_srd_eeprom(icdev:longint;offset,len:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_srd_eeprom';
  function rf_swr_eeprom(icdev:longint;offset,len:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_swr_eeprom';
  //通用函数
  function rf_card(icdev:longint;mode:smallint;snr:PAnsiChar):smallint;stdcall;far;external 'mwrf32.dll'name 'rf_card';
  function rf_decrypt(key:PAnsiChar;ptrsource:PAnsiChar;msglen:smallint;ptrdest:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_decrypt';
  function rf_encrypt(key:PAnsiChar;ptrsource:PAnsiChar;msglen:smallint;ptrdest:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_encrypt';
  function rf_exit(icdev: longint):smallint;stdcall;far;external 'mwrf32.dll'name 'rf_exit';
  function rf_halt(icdev:longint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_halt';
  function rf_init(port: smallint;baud:longint): longint; stdcall;far;external 'mwrf32.dll' name 'rf_init';
  function rf_load_key(icdev:longint;mode,secnr:smallint;nkey:PAnsiChar):smallint;stdcall;far;external 'mwrf32.dll' name 'rf_load_key';
  function rf_load_key_hex(icdev:longint;mode,secnr:smallint;nkey:PAnsiChar):smallint;stdcall;far;external 'mwrf32.dll' name 'rf_load_key_hex';
  function rf_read(icdev:longint;adr:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_read';
  function rf_read_hex(icdev:longint;adr:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_read_hex';
  function rf_write(icdev:longint;adr:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_write';
  function rf_write_hex(icdev:longint;adr:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_write_hex';
  //M1卡专用函数
  function rf_authentication(icdev:longint;mode,secnr:smallint):smallint;stdcall;far;external 'mwrf32.dll' name 'rf_authentication';
  function rf_changeb3(Adr:PAnsiChar;keyA:PAnsiChar;B0:PAnsiChar;B1:PAnsiChar;B2:PAnsiChar;B3:PAnsiChar;Bk:PAnsiChar;KeyB:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_changeb3';
  function rf_check_write(icdev,snr:longint;adr,authmode:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_check_write';
  function rf_check_writehex(icdev,snr:longint;adr,authmode:smallint;data:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_check_writehex';
  function rf_decrement(icdev:longint;adr:smallint;value:longint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_decrement';
  function rf_increment(icdev:longint;adr:smallint;value:longint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_increment';
  function rf_initval(icdev:longint;adr:smallint;value:longint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_initval';
  function rf_readval(icdev:longint;adr:smallint;value:PAnsiChar):smallint;stdcall;    far;external 'mwrf32.dll' name 'rf_readval';
  function rf_restore(icdev:longint;adr:smallint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_restore';
  function rf_transfer(icdev:longint;adr:smallint):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_transfer';
  //M1 CARD HIGH FUNCTION
  function rf_HL_decrement(icdev:longint;mode:smallint;secnr:smallint;value:longint;snr:longint;svalue,ssnr:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_HL_decrement';
  function rf_HL_increment(icdev:longint;mode:smallint;secnr:smallint;value,snr:longint;svalue,ssnr:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_HL_increment';
  function rf_HL_initval(icdev:longint;mode:smallint;secnr:smallint;value:longint;snr:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_HL_initval';
  function rf_HL_read(icdev:longint;mode,adr:smallint;snr:longint;sdata,ssnr:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_HL_read';
  function rf_HL_write(icdev:longint;mode,adr:smallint;ssnr,sdata:PAnsiChar):smallint;stdcall;  far;external 'mwrf32.dll' name 'rf_HL_write';


{ TVipcardRW }
procedure TVipcardRW.cardfound(cardSequenceNo: longword; icdev: Integer);
var newvipcard:TVipCard;
    _internalSerialNo:Int64;
    databuff:Array[0..31]of AnsiChar;
    observer:Ivipcardfound;
begin
    _internalSerialNo:=0;
    self.icdev:=icdev;
    //读卡,验证卡是否存在
    rf_halt(icdev);
    invokeRS:=rf_card(icdev,1,@_internalSerialNo);
    if invokeRS<>0 then exit;
    newvipcard:=TVipCard.Create;
    newvipcard.FinternalSerialNo:=_internalSerialNo;

    //使用新密码装载密码
    if loadmode>2 then
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if invokeRS<>0 then exit;
    //验证密码
    invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if invokeRS<>0 then
    begin
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //使用默认密码装载密码
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
      if invokeRS<>0 then exit;
      //验证密码
      invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
      if invokeRS<>0 then exit;
      newvipcard.Fisnew:=true;
    end
    else
    begin
      newvipcard.Fisnew:=false;
    end;

    if not newvipcard.isnew then  //非新卡，读取数据
    begin
      //读卡类型
      invokeRS:=rf_read_hex(icdev,cartype_block,@databuff);
      if invokeRS<>0 then Exit;
      newvipcard.Fcartype:=TCardtypes(StrToInt(String(HexToString(databuff)[1])));
      //非VIP卡，退出
      if newvipcard.Fcartype<>Tcardtypes.VIP then exit;
      //读卡号
      invokeRS:=rf_read_hex(icdev,cardNo_block,@databuff);
      if invokeRS<>0 then Exit;
      newvipcard.FcardNo:=Copy(HexToString(databuff),1,getcardnolength(newvipcard.cardtype));

      //换扇区
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //使用新密码装载密码
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordA_hex));
      if invokeRS<>0 then exit;
      //验证密码
      invokeRS:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
      if invokeRS<>0 then
      begin
        rf_halt(icdev);
        invokeRS:=rf_card(icdev,1,@_internalSerialNo);
        if invokeRS<>0 then exit;
        //使用默认密码装载密码
        if loadmode>2 then
          invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordB_hex))
        else
          invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordA_hex));
        if invokeRS<>0 then exit;
        //验证密码
        invokeRS:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
        if invokeRS<>0 then exit;
        newvipcard.issued:=False;
      end
      else
      begin
        newvipcard.issued:=True;
      end;

      if newvipcard.issued then
      begin
        //读卡等级
        invokeRS:=rf_read_hex(icdev,cardGrade_block,@databuff);
        if invokeRS<>0 then Exit;
        newvipcard.FcardGrade:=Tcardgrade(StrToInt(HexToString(databuff)[1]));

        //读余额
        invokeRS:=rf_read_hex(icdev,money_block,@databuff);
        if invokeRS<>0 then Exit;
        newvipcard.Fmoney:=StrToCurr(HexToString(databuff));
        //读积分
        invokeRS:=rf_read_hex(icdev,amount_block,@databuff);
        if invokeRS<>0 then Exit;
        newvipcard.Famount:=StrToCurr(string(HexToString(databuff)));
      end;
    end;
    for observer in FNotifies.Keys do
    begin
      if (not FNotifies.Items[observer])
        or (FNotifies.Items[observer]
            and TCustomForm(observer).CanFocus
//            and (Application.MainForm.Active)
//            and (Application.MainForm.ActiveControl<>nil)
//            and (TCustomForm(observer)=GetParentForm(Application.MainForm.ActiveControl,false))
            and (
                  (Application.MainForm.Active
                    and (Application.MainForm=GetParentForm(TCustomForm(observer),True))
                  )
                  or  (Application.MainForm<>GetParentForm(TCustomForm(observer),True))
                )

            ) then
      begin
        rf_beep(icdev,10);
        try
          observer.vipcardfound(newvipcard);
        except
        end;
      end;
    end;
end;

procedure TVipcardRW.FreeInstance;
begin
  inherited;
  TCardRWDevice.GetInstance.removeObserver(self);
  vipcardRW := nil;
end;

function TVipcardRW.getErrorInfo(rs: Integer): String;
begin
  result:=TCardRWDevice.GetInstance.getErrorInfo(rs);
end;

class function TVipcardRW.GetInstance: TVipcardRW;
begin
  if not Assigned(vipcardRW) then
  begin
    vipcardRW := TVipcardRW(TVipcardRW.NewInstance);
  end;
  Result := vipcardRW;
end;

class function TVipcardRW.NewInstance: TObject;
var beginsector:SmallInt;
begin
  if not Assigned(vipcardRW) then
  begin
    vipcardRW := TVipcardRW( inherited NewInstance);
    Result := vipcardRW;
    vipcardRW.FNotifies:=TDictionary<Ivipcardfound,Boolean>.Create;
    vipcardRW.newBlock3data_hex:='43690a52178b7f07886907243691b8a5';
    vipcardRW.newPasswordA_hex:=Copy(vipcardRW.newBlock3data_hex,1,12);
    vipcardRW.newPasswordB_hex:=Copy(vipcardRW.newBlock3data_hex,21,12);
    vipcardRW.defaultBlock3data_hex:='ffffffffffffff078069ffffffffffff';
    vipcardRW.defaultPasswordA_hex:=Copy(vipcardRW.defaultBlock3data_hex,1,12);
    vipcardRW.defaultPasswordB_hex:=Copy(vipcardRW.defaultBlock3data_hex,21,12);
    vipcardRW.invokeRS:=-1;
    vipcardRW.loadmode:=0;

    beginsector:=0;
    vipcardRW.cartype_block:=beginsector*4+1; //卡类型 0扇区1块
    vipcardRW.cardNo_block:=beginsector*4+2;//8位 0扇区2块
    vipcardRW.cardGrade_block:=beginsector*4+4;  //0 1 2 取数据字典 1扇区0块
    vipcardRW.money_block:=beginsector*4+5;//保留两位小数 1扇区1块
    vipcardRW.amount_block:=beginsector*4+6;//保留两位小数 1扇区2块
    try
      TCardRWDevice.GetInstance.addObserver(vipcardRW);
    except
      on e:Exception do
      begin
        TCardRWDevice.GetInstance.addObserver(vipcardRW);
        raise e;
      end;
    end;
  end;
  Result := vipcardRW;
end;

procedure TVipcardRW.removeObserver(vipcardfound: Ivipcardfound);
begin
  if FNotifies.ContainsKey(vipcardfound) then
  begin
    FNotifies.Remove(vipcardfound);
  end;
end;

function TVipcardRW.writeCard(vipCard:TVipCard): Integer;
var _internalSerialNo:Int64;
    writedate:PAnsiChar;
begin
  _internalSerialNo:=0;
  if vipCard.isnew then
  begin
    raise Exception.Create('贵宾卡发卡前请先对卡初始化');
  end;

  //读卡,验证卡是否存在
  rf_halt(icdev);
  Result:=rf_card(icdev,1,@_internalSerialNo);
  if Result<>0 then exit;
  if vipCard.FinternalSerialNo<>_internalSerialNo then
  begin
    result:=7701; //当前卡已经被换掉
    exit;
  end;

  if not vipCard.issued then
  begin
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordA_hex));
    if Result<>0 then exit;
    //验证密码
    Result:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
    if Result<>0 then exit;
  end
  else
  begin
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordA_hex));
    if Result<>0 then exit;
    //验证密码
    Result:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
    if Result<>0 then exit;
  end;

  //写余额
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(FormatCurr('0.00',vipCard.Fmoney))));
  Result:=rf_write_hex(icdev,money_block,writedate);
  if Result<>0 then Exit;
  //写积分
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(FormatCurr('0.00',vipCard.Famount))));
  Result:=rf_write_hex(icdev,amount_block,writedate);
  if Result<>0 then Exit;

  //如果还没有发卡，表示现在是发卡操作
  if not vipCard.issued then
  begin
    //写卡等级
    writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(inttostr(Integer(vipCard.FcardGrade)))));
    Result:=rf_write_hex(icdev,cardGrade_block,writedate);
    if Result<>0 then Exit;
    vipCard.issued:=True;
    //写新密码
    writedate:=PAnsiChar(Self.newBlock3data_hex);
    Result:=rf_write_hex(icdev,(amount_block div 4)*4 +3,writedate);
    if Result<>0 then Exit;
    vipCard.Fisnew:=false;
  end;
end;

procedure TVipcardRW.addObserver(vipcardfound: Ivipcardfound;notifyOnlyOnActivate:Boolean=true);
begin
  if not (vipcardfound is TCustomForm) then
  begin
    raise Exception.Create('VIP读卡观察者必须是TCustomForm子类');
  end;
  FNotifies.AddOrSetValue(vipcardfound,notifyOnlyOnActivate);
end;

{ TCardRWDevice }

procedure TCardRWDevice.addObserver(cardfound: Icardfound);
begin
  if not FNotifies.Contains(cardfound) then
    FNotifies.Add(cardfound);
end;

procedure TCardRWDevice.FreeInstance;
begin
  inherited;
  //关闭串口
  Self.icdev:=0;
  rf_exit(self.icdev);
  cardRWDevice := nil;
end;

function TCardRWDevice.getErrorInfo(rs: Integer): String;
begin
  case rs of
    7701:Result:='当前卡已经被换掉';
    0:Result:='正确';
    1:Result:='无卡';
    2:Result:='CRC校验错';
    3:Result:='值溢出';
    4:Result:='未验证密码';
    5:Result:='奇偶校验错';
    6:Result:='通讯出错';
    8:Result:='错误的序列号';
    10:Result:='验证密码失败';
    11:Result:='接收的数据位错误';
    12:Result:='接收的数据字节错误';
    14:Result:='Transfer错误';
    15:Result:='写失败';
    16:Result:='加值失败';
    17:Result:='减值失败';
    18:Result:='读失败';
    $-10:Result:='PC与读写器通讯错误';
    $-11:Result:='通讯超时';
    $-20:Result:='打开通信口失败';
    $-24:Result:='串口已被占用';
    $-30:Result:='地址格式错误';
    $-31:Result:='该块数据不是值格式';
    $-32:Result:='长度错误';
    $-40:Result:='值操作失败';
    $-50:Result:='卡中的值不够减';
  else ;
    Result:='未知错误';
  end;
end;

class function TCardRWDevice.GetInstance: TCardRWDevice;
begin
  if not Assigned(cardRWDevice) then
  begin
//    cardRWDevice := TCardRWDevice.Create();
    cardRWDevice := TCardRWDevice(TCardRWDevice.NewInstance);
  end;
  Result := cardRWDevice;
end;

class function TCardRWDevice.NewInstance: TObject;
begin
  if not Assigned(cardRWDevice) then
  begin
    cardRWDevice := TCardRWDevice( inherited NewInstance);
    cardRWDevice.icdev:=0;
    cardRWDevice.FNotifies:=TList<Icardfound>.Create;
    cardRWDevice.timerSearchCard:=TTimer.Create(Application);
    cardRWDevice.timerSearchCard.Enabled:=false;
    cardRWDevice.timerSearchCard.Interval:=100;
    cardRWDevice.timerSearchCard.OnTimer:=cardRWDevice.timerSearchCardOnTimer;
    //初始化串口
    //参 数：port：串口号，取值为0～3
    //       baud：为通讯波特率9600～115200
    cardRWDevice.icdev:=rf_init(0,115200);
    if(cardRWDevice.icdev<=0) then
    begin
//      raise Exception.Create('IC卡读写卡器初始化失败,请连接好读卡器');
      Application.MessageBox('IC卡读写卡器初始化失败,请连接好读卡器','提示');
    end
    else
    begin
      cardRWDevice.timerSearchCard.Enabled:=True;
    end;
//    ;
//    cardRWDevice.timerSearchCard.Enabled:=True;
  end;
  Result := cardRWDevice;
end;

procedure TCardRWDevice.removeObserver(cardfound: Icardfound);
begin
  if FNotifies.Contains(cardfound) then
    FNotifies.Remove(cardfound);
end;

procedure TCardRWDevice.timerSearchCardOnTimer(Sender: Tobject);
var st:integer;
    _internalSerialNo:Int64;
    cardfound: Icardfound;
begin
  _internalSerialNo:=0;
  if(cardRWDevice.icdev<=0) then
  begin
    //找不到读卡器时，运行频率减低。
    cardRWDevice.timerSearchCard.Interval:=1000;
    cardRWDevice.icdev:=rf_init(0,115200);
    if(cardRWDevice.icdev<=0) then exit;
  end;
  cardRWDevice.timerSearchCard.Interval:=100;
  //寻卡,返回在工作区域内某张卡的序列号
//0——表示IDLE模式，一次只对一张卡操作；
//1——表示ALL模式，一次可对多张卡操作；
//2——表示指定卡模式，只对序列号等于snr的卡操作（高级函数才有）
//   注：选择IDLE模式，在对卡进行读写操作，执行rf_halt()rf_halt指令中止卡操作后，只有当该卡离开并再次进入操作区时，读写器才能够再次对它进行操作。
  rf_halt(icdev);
  st:=rf_card(icdev,1,@_internalSerialNo);
  if st=0 then
  begin
    if _internalSerialNo=cardSequenceNo then exit; //卡没换
    cardSequenceNo:=_internalSerialNo;
    if FNotifies.Count>0 then
    begin
      for cardfound in FNotifies do
      begin
        try
          cardfound.cardfound(cardSequenceNo,icdev);
        except
        end;
      end;
    end;
  end
  else
  begin
    cardSequenceNo:=0;
    if st=-1 then
    begin
      rf_halt(icdev);
      rf_exit(self.icdev);
      Self.icdev:=0;
    end;
  end;
end;

{ TVipCard }

constructor TVipCard.Create;
begin
  Fcartype:=TCardtypes.VIP; //卡类型
  FcardGrade:=TcardGrade.ONECARD;  //0 1 2 取数据字典
  FcardNo:='00000000';//8位
  FinternalSerialNo:=0; //0扇区0块
  Fmoney:=0;//保留两位小数
  Famount:=0;//保留两位小数
  Fisnew:=true;
  issued:=false;
end;

procedure TVipCard.decrementamount(changeamount: Currency);
begin
  Famount:=Famount-changeamount;
end;

procedure TVipCard.decrementmoney(changemoney: Currency);
begin
  Fmoney:=Fmoney-changemoney;
end;

function TVipCard.getErrorInfo(rs: Integer): String;
begin
  result:=TVipcardRW.GetInstance.getErrorInfo(rs);
end;

procedure TVipCard.incrementamount(changeamount: Currency);
begin
  Famount:=Famount+changeamount;
end;

procedure TVipCard.incrementmoney(changemoney: Currency);
begin
  Fmoney:=Fmoney+changemoney;
end;

procedure TVipCard.setNewcardGrade(newcardGrade: TCardGrade);
begin
  Self.FcardGrade:=newcardGrade;
end;

function TVipCard.writeCard: Integer;
begin
  result:=TvipcardRW.GetInstance.writeCard(self);
end;



{ TICcardRW }

procedure TBaseCardRW.addObserver(iccardfound: IBaseCardfound;
  notifyOnlyOnActivate: Boolean);
begin
  if not (iccardfound is TCustomForm) then
  begin
    raise Exception.Create('VIP读卡观察者必须是TCustomForm子类');
  end;
  FNotifies.AddOrSetValue(iccardfound,notifyOnlyOnActivate);
end;

procedure TBaseCardRW.cardfound(cardSequenceNo: longword; icdev: Integer);
var newiccard:TBaseCard;
    _internalSerialNo:Int64;
    databuff:Array[0..31]of AnsiChar;
    observer:IBaseCardfound;
    writedate:PAnsiChar;
begin
    _internalSerialNo:=0;
    self.icdev:=icdev;
    //读卡,验证卡是否存在
    rf_halt(icdev);
    invokeRS:=rf_card(icdev,1,@_internalSerialNo);
    if invokeRS<>0 then exit;
    newiccard:=TBaseCard.Create;
    newiccard.FinternalSerialNo:=_internalSerialNo;

    //使用新密码装载密码
    if loadmode>2 then
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if invokeRS<>0 then exit;
    //验证密码
    invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if invokeRS<>0 then
    begin
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //使用默认密码装载密码
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
      if invokeRS<>0 then exit;
      //验证密码
      invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
      if invokeRS<>0 then exit;
      newiccard.Fisnew:=true;
    end
    else
    begin
      newiccard.Fisnew:=false;
    end;

    if not newiccard.isnew then  //非新卡，读取数据
    begin
      //读卡类型
      invokeRS:=rf_read_hex(icdev,cartype_block,@databuff);
      if invokeRS<>0 then Exit;
      newiccard.Fcardtype:=TCardtypes(StrToInt(String(HexToString(databuff)[1])));
      //读卡号
      invokeRS:=rf_read_hex(icdev,cardNo_block,@databuff);
      if invokeRS<>0 then Exit;
      newiccard.FcardNo:=Copy(HexToString(databuff),1,getcardnolength(newiccard.cardtype));
      newiccard.FcardNo:=ReplaceAllJ0ToS0(newiccard.FcardNo);
    end;

//**********下面的代码是为了兼容原南昌地区发的报到卡，转移原报到卡信息到新位置*****************
    if newiccard.isnew then
    begin
      //换扇区
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //判断第2扇区1块密码（2*4+1=9）
      invokeRS:=rf_load_key_hex(icdev,0,2,PAnsiChar('111fffffffff'));
      if invokeRS=0 then
      begin
        invokeRS:=rf_authentication(icdev,0,2);
        if invokeRS=0 then
        begin
          //读出原卡号
          invokeRS:=rf_read_hex(icdev,9,@databuff);
          if invokeRS<>0 then Exit;
          newiccard.FcardNo:=Copy(HexToString(databuff),1,6);
          newiccard.FcardNo:=ReplaceAllJ0ToS0(newiccard.FcardNo);
          newiccard.Fcardtype:=Tcardtypes.VEHICLEREPORT;
          //改原报到卡密码
          if (cardNo_block div 4) =2 then
            writedate:=PAnsiChar(Self.newBlock3data_hex)
          else
            writedate:=PAnsiChar(Self.defaultBlock3data_hex);
          invokeRS:=rf_write_hex(icdev,2*4+3,writedate);

          //将原报到卡信息按新方法写卡
          newiccard.writeCard;
        end;
      end;
    end;
//**********上面的代码是为了兼容原南昌地区发的报到卡，转移原报到卡信息到新位置*****************

    for observer in FNotifies.Keys do
    begin
      if (not FNotifies.Items[observer])
        or (FNotifies.Items[observer]
            and TCustomForm(observer).CanFocus
//            and (Application.MainForm.Active)
//            and (Application.MainForm.ActiveControl<>nil)
//            and (TCustomForm(observer)=GetParentForm(Application.MainForm.ActiveControl,false))
            and (
                  (Application.MainForm.Active
                    and (Application.MainForm=GetParentForm(TCustomForm(observer),True))
                  )
                  or  (Application.MainForm<>GetParentForm(TCustomForm(observer),True))
                )

            ) then
      begin
        rf_beep(icdev,10);
        try
          observer.iccardfound(newiccard);
        except
        end;
      end;
    end;

end;

procedure TBaseCardRW.FreeInstance;
begin
  inherited;
  TCardRWDevice.GetInstance.removeObserver(self);
  iccardRW := nil;
end;

function TBaseCardRW.getErrorInfo(rs: Integer): String;
begin
  result:=TCardRWDevice.GetInstance.getErrorInfo(rs);
end;

class function TBaseCardRW.GetInstance: TBaseCardRW;
begin
  if not Assigned(iccardRW) then
  begin
    iccardRW := TBaseCardRW(TBaseCardRW.NewInstance);
  end;
  Result := iccardRW;
end;

class function TBaseCardRW.NewInstance: TObject;
var beginsector:SmallInt;
begin
  if not Assigned(iccardRW) then
  begin
    iccardRW := TBaseCardRW( inherited NewInstance);
    Result := iccardRW;
    iccardRW.FNotifies:=TDictionary<IBaseCardfound,Boolean>.Create;
    iccardRW.newBlock3data_hex:='43690a52178b7f07886907243691b8a5';
    iccardRW.newPasswordA_hex:=Copy(iccardRW.newBlock3data_hex,1,12);
    iccardRW.newPasswordB_hex:=Copy(iccardRW.newBlock3data_hex,21,12);
    iccardRW.defaultBlock3data_hex:='ffffffffffffff078069ffffffffffff';
    iccardRW.defaultPasswordA_hex:=Copy(iccardRW.defaultBlock3data_hex,1,12);
    iccardRW.defaultPasswordB_hex:=Copy(iccardRW.defaultBlock3data_hex,21,12);
    iccardRW.invokeRS:=-1;
    iccardRW.loadmode:=0;

    beginsector:=0;
    iccardRW.cartype_block:=beginsector*4+1; //卡类型 0扇区1块
    iccardRW.cardNo_block:=beginsector*4+2;//8位 0扇区2块
    try
      TCardRWDevice.GetInstance.addObserver(iccardRW);
    except
      on e:Exception do
      begin
        TCardRWDevice.GetInstance.addObserver(iccardRW);
        raise e;
      end;
    end;
  end;
  Result := iccardRW;
end;

procedure TBaseCardRW.removeObserver(iccardfound: IBaseCardfound);
begin
  if FNotifies.ContainsKey(iccardfound) then
  begin
    FNotifies.Remove(iccardfound);
  end;
end;

function TBaseCardRW.writeCard(icCard: TBaseCard): Integer;
var _internalSerialNo:Int64;
    writedate:PAnsiChar;
begin
  _internalSerialNo:=0;
  //读卡,验证卡是否存在
  rf_halt(icdev);
  Result:=rf_card(icdev,1,@_internalSerialNo);
  if Result<>0 then exit;
  if icCard.FinternalSerialNo<>_internalSerialNo then
  begin
    result:=7701; //当前卡已经被换掉
    exit;
  end;
  if not icCard.isnew then
  begin
    //使用新密码装载密码
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if Result<>0 then exit;
    //验证密码
    Result:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if Result<>0 then exit;
  end
  else
  begin
    //使用默认密码装载密码
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
    if Result<>0 then exit;
    //验证密码
    Result:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if Result<>0 then exit;
  end;

  //写卡类型
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(inttostr(Integer(icCard.cardtype)))));
  Result:=rf_write_hex(icdev,cartype_block,writedate);
  if Result<>0 then Exit;
  //写卡号
  writedate:=StringToHex(FillZeroToSixteenByte(icCard.FcardNo));
  Result:=rf_write_hex(icdev,cardNo_block,writedate);
  if Result<>0 then Exit;
  if icCard.isnew then
  begin
    //写0扇区密码
    writedate:=PAnsiChar(Self.newBlock3data_hex);
    Result:=rf_write_hex(icdev,(cartype_block div 4)*4 +3,writedate);
    if Result<>0 then Exit;
    icCard.Fisnew:=False;
  end;
end;

{ TICCard }

constructor TBaseCard.Create;
begin
  Fcardtype:=TCardtypes.VIP; //卡类型
  FcardNo:='00000000';//8位
  FinternalSerialNo:=0; //0扇区0块
  Fisnew:=true;
end;

function TBaseCard.getErrorInfo(rs: Integer): String;
begin
  result:=TBaseCardRW.GetInstance.getErrorInfo(rs);
end;

procedure TBaseCard.setCardtype(_cartype: TCardtypes);
begin
  if not Self.isnew then
  begin
    raise Exception.Create('已经使用的卡不允许修改卡的类别');
  end;
  Self.Fcardtype:=_cartype;
end;

procedure TBaseCard.setNewcardNo(newcardno: AnsiString);
begin
  if not Self.isnew then
  begin
    raise Exception.Create('已经使用的卡不允许修改卡的卡号');
  end;
  self.FcardNo:=newcardno;
end;

function TBaseCard.writeCard: Integer;
begin
  if getcardnolength(self.cardtype)<>length(self.cardNo) then
  begin
    raise Exception.Create(getcardtypename(self.cardtype)+'长度应为'+inttostr(getcardnolength(self.cardtype))
                           +',实际长度为'+inttostr(length(self.cardNo))+'。不允许写卡');
  end;
  result:=TBaseCardRW.GetInstance.writeCard(self);
end;

Initialization
Finalization
  if Assigned(cardRWDevice) then FreeAndNil(cardRWDevice);
  if Assigned(iccardRW) then FreeAndNil(iccardRW);
  if Assigned(vipcardRW) then FreeAndNil(vipcardRW);
end.
