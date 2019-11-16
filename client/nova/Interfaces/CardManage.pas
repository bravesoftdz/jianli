unit CardManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Math, StdCtrls, ExtCtrls,
  Controls, Dialogs;

type
  TCardType = (All, FunctionCard, VipCard); // 磁卡类别 当为All时不区分磁卡类别，否则只读取对应的类别

  TCardManage = class(TComponent)
    CardOrderNo: Tedit; // 卡的序列号
    CardNoEdit: Tedit;
    // 扇区号         //地址           //密码 12位值ffffffffffff
    procedure SetConfig(_sector: integer; _address: integer;
      _password: string); // 参数设置

    procedure ReadCardNo(_edit: Tedit); // 输出卡号

    procedure ReadCardOrder(_edit: Tedit); // 输出序号

    Function GerCardOrder: string; // 取得卡序号

    procedure WriteCareNo(_CardNO: string); // 进行写卡操作
    procedure Timer1OnTimer(Sender: Tobject); // 读卡号操作
    procedure Quit();
    procedure SetSpSound(value: Boolean);
    procedure SetCardLength(value: integer); // 设置卡位数 6
    procedure SetSendKey(value: Boolean);
    Function GetStatus: Boolean;
    Function GetLastError: string;
    Procedure StartRead;
    Procedure StopRead;
    function RunStatus: string;
    Procedure PlayError;
  private
    { Private declarations }
    CARD_sector: integer; // 扇区号
    CARD_address: integer; // 地址
    CARD_password: array [0 .. 2] of string;
    CARD_CheckPWS: string;
    st: word; // 调用DLL返回参数
    icdev: longint; // 初始化返回参数
    FErr_Message: string; // 错误信息
    Err_line: integer; // 错误等级 1 为设备没有准备好(不提示)    2、设备没有初始化  3、磁卡类型不匹配

    _ReadOper: integer; // 是否重复读参数 1
    ToSendKey: Boolean; // 是否发送按键
    CardNoLength: integer; // 卡的位数
    SetSoundBP: Boolean; // 是否发出声音
    Timer1: TTimer; // 定时器
    WriteRunStatus: string;
    FCardType: TCardType;
    FCardTypeAdress: integer;
    FOnGetErr: TNotifyEvent;
    OldSequence: longword; // 序列号
    Function GetCardNo(): string; // 取得卡号
    Function GetCardSequence: integer; // 得到卡的序列号
    Function InitCard(port: integer; baud: integer): integer; // 初始化
    Function CheckCard(lv_cardkey: String): integer;
    // 检查磁卡是否有效 返回 2 - 无卡 3.4 - 验证错误 1正确    5卡重复
    // function  huxtoint(hexin: array of char): integer;//字符转换
    Function WriteCard(CardNo: string): integer; // 写入卡
    procedure SetRead(ReadOper: integer); // 设置是否过滤重复数据 1 默认 0 不需要
    function RCardOrderNo: Tedit;
    procedure WCardOrderNo(const value: Tedit);
    Procedure SendKeyDown(VKey: Byte; NumTimes: word; GenUpMsg: Boolean);
    procedure SendKeysBack(Key: char);
    Procedure KeyboardEvent(VKey, ScanCode: Byte; Flags: longint);
    procedure SendCardNo(CardNo: String);
    function RSetSendKey: Boolean;
    procedure WSetSendKey(const value: Boolean);
    function RCardLength: integer;
    procedure WSetCardLength(const value: integer);
    function RSoundBp: Boolean;
    procedure WSetSoundBP(const value: Boolean);
    Function GetCheckPws: string;
    Procedure SpSound;
    // 16->10
    function HexToInt(HexStr: string): integer;
    // Chr-> Hex
    Function StrtoFF(value: String): String;
    Function FFtoStr(value: String): String;
    procedure SetCardType(const value: TCardType);
    procedure SetCardTypeAdress(const value: integer);
    procedure SetErr_Message(const value: String);
    procedure SetOnGetErr(const value: TNotifyEvent);
  public
    constructor create(aOwner: TComponent); override;
    constructor Destory;
    Function DeviceInic: integer; // 设备初始化
    property ReadOper: integer read _ReadOper write SetRead;
    property RWCardOrderNo: Tedit read RCardOrderNo write WCardOrderNo;
    Property SendKey: Boolean read RSetSendKey Write WSetSendKey; // 设置是否发送按键
    Property CardLength: integer Read RCardLength Write WSetCardLength;
    Property SoundBp: Boolean Read RSoundBp Write WSetSoundBP;
    property CardType: TCardType read FCardType write SetCardType;
    property CardTypeAdress
      : integer read FCardTypeAdress write SetCardTypeAdress;
    property Err_Message: String read FErr_Message write SetErr_Message;
    property OnGetErr: TNotifyEvent read FOnGetErr write SetOnGetErr;
    property CardSequence: integer read GetCardSequence;
    { Public declarations }
  end;

  // 初始化串口  port：串口号，取值为0～3  20080421 ice改变此函数的可见范围 供工程调用
function rf_init(port: smallint; baud: longint): longint; stdcall; far;
external 'mwrf32.dll' name 'rf_init';
// 释放串口
function rf_exit(icdev: longint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_exit';

implementation

function rf_load_key_hex(icdev: longint; mode, secnr: smallint;
  nkey: PAnsiChar): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_load_key_hex';
// 寻卡，能返回在工作区域内某张卡的序列号
function rf_card(icdev: longint; mode: smallint; snr: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_card';
// 验证某一扇区密码
function rf_authentication(icdev: longint; mode, secnr: smallint): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_authentication';
// 向卡中写入数据
// 对于M1卡，一次必须写一个块，为16个字节；
// 参 数：icdev：通讯设备标识符
// _Adr：M1卡——块地址（1～63）； _Data：要写入的数据
function rf_write_hex(icdev: longint; adr: smallint; data: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_write_hex';
// 检测指定数据是否与卡中数据一致
function rf_check_writehex(icdev, snr: longint; adr, authmode: smallint;
  data: PAnsiChar): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_check_writehex';
// 读取卡中数据一次读一个块的数据，为16个字节
function rf_read_hex(icdev: longint; adr: smallint; data: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_read_hex';
// 初始化块值：icdev：通讯设备标识符 _Adr：块地址（1～63）_Value：初始值
// value=1000;                    /* 给value赋值*/
// st=rf_initval(icdev,1,value);        /*将块1的值初始化为1000*/
function rf_initval(icdev: longint; adr: smallint; value: longint): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_initval';
// 中止对该卡操作
function rf_halt(icdev: longint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_halt';
// 射频读写模块复位 int _Msec：复位时间，0～500毫秒有效
function rf_reset(icdev: longint; msec: smallint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_reset';
// 设备操作
function rf_beep(icdev: longint; time: smallint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_beep';
// 取得读写器硬件版本号，如“mwrf100_v3.0”  version[18];
function rf_get_status(icdev: longint; status: PAnsiChar): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_get_status';
{ TCardManage }

const
  M_PORT = 0;
  M_BAND = 115200;
  ExtendedVKeys: set of Byte = [VK_Up, VK_Down, VK_Left, VK_Right, VK_Home,
    VK_End, VK_Prior, { PgUp } VK_Next,
  { PgDn } VK_Insert, VK_Delete];

var
  LastCardNo: String;

constructor TCardManage.create(aOwner: TComponent);
begin
  inherited;
  CardType := All;
  CardTypeAdress := 5;
  SendKey := False; // 默认不发送
  CardLength := 8; // 一个块最多存储16个字符,需求为8位长度
  SoundBp := true;
  CARD_password[2] := 'ffffffffffff'; // 20080512 ice 当三个密码中有任意两个重复时，当靠造成密码循环N次不能改变
  CARD_password[1] := 'ff078069ff';
  CARD_password[0] := '111ffffffff';
  Err_line := -1;
  WriteRunStatus := '0';
  CardOrderNo := Tedit.create(nil);
  DeviceInic;
end;

procedure TCardManage.Quit;
begin
  if Timer1 <> nil then
  begin
    Timer1.Enabled := False;
    // timer1.Free;  不能在这里free 20080408 ice
  end;
  If icdev > 0 Then
  begin
    st := rf_reset(icdev, 10);
    st := rf_exit(icdev);
    icdev := -1;
  end;
end;

constructor TCardManage.Destory;
begin
  if Timer1<>nil then
  begin
    Timer1.Enabled := False;
    Timer1.Free;
  end;
  CardOrderNo.Free;
  Quit();
end;

function TCardManage.DeviceInic: integer;
begin
  DeviceInic := InitCard(M_PORT, M_BAND);
  if result = 1 then
  begin
    DeviceInic := -1;
    Err_line := 1; // 错误等级
    Err_Message := '初始化错误，请确认读写器是否打开';
  end
  else
  begin
    Timer1 := TTimer.create(nil);
    DeviceInic := 0;
    Timer1.Interval := 500;
    Timer1.OnTimer := Timer1OnTimer;
    Timer1.Enabled := False;
    _ReadOper := 1;
    LastCardNo := '';
    Err_line := -1;
  end;
end;

function TCardManage.InitCard(port, baud: integer): integer;
Begin
  icdev := rf_init(port, baud);
  If icdev < 0 Then
  begin
    result := 1;
    exit;
  End
  else
  Begin
    SpSound;
    result := 0;
  End;
end;

// 检查磁卡是否有效 返回 2 - 无卡 3.4 - 验证错误  1正确    5卡重复
function TCardManage.CheckCard(lv_cardkey: String): integer;
var
  l_cardkey: pansiChar;
  Sequence: longword; // 序列号
Begin
  rf_halt(icdev);
  st := rf_card(icdev, 1, @Sequence); // 判断是否有卡
  If st = 0 then
  Begin
    if Sequence = OldSequence then
    begin
      result := 5;
      exit;
    end;
    l_cardkey := PAnsiChar(AnsiString(lv_cardkey));
    //l_cardkey := '111fffffffff';
    st := rf_load_key_hex(icdev, 0, 2, l_cardkey); // 验证卡的密码
    If st = 0 then
    Begin
      st := rf_authentication(icdev, 0, CARD_sector); // 判断是否非法卡
      If st = 0 then
      Begin
        OldSequence := Sequence;
        CardOrderNo.Text := inttostr(Sequence);
        result := 1;
      End
      else
      begin
        result := 4;
        GetCheckPws;
      end;
    End
    else
    begin
      result := 3;
      GetCheckPws;
    end;
  End
  else
  begin
    result := 2;
  end;
end;

// 取得卡号
function TCardManage.GetCardNo: string;
var
  L_readcard: array [0 .. 32] of AnsiChar;
  l_ret: array [0 .. 32] of AnsiChar;
  l_return: string;
  i, j: integer;
  l_readcardtype: array [0 .. 32] of AnsiChar;
  //l_readcardtype: PAnsiChar;
  s_cardtype: String;
Begin
  if CardType <> All then // 取磁卡类型
  begin
    //getmem(l_readcardtype, 33);
    st := rf_read_hex(icdev,CARD_address, @l_readcardtype); // 读取卡内的数据区
    If st <> 0 then
    Begin
      //freemem(l_readcardtype);
      result := 'error';
      exit;
    End
    else
    Begin
      s_cardtype := Copy(FFtoStr((l_readcardtype)), 1, 1); // 只取第一位
      //freemem(l_readcardtype);
      // 0 功能卡 4贵宾卡
      if ((CardType = FunctionCard) and (s_cardtype = '0')) or
        ((CardType = VipCard) and (s_cardtype = '4')) then
      begin ; // 继续向下读取卡号
      end
      else
      begin
        result := 'error Card type';
        exit;
      end;
    End;
  end;
  //getmem(L_readcard, 33);
  //st := rf_read_hex(icdev, 2*4+block, @databuff);
  st := rf_read_hex(icdev,CARD_address, @L_readcard); // 读取卡内的数据区
  If st <> 0 then
  Begin
   // freemem(L_readcard);
    result := 'error';
  End
  else
  Begin
    j := 0;
    while j <= CardLength * 2 - 1 do
    Begin
      l_ret[j] := L_readcard[j];
      j := j + 1;
    End;
    //freemem(L_readcard);
    l_return := FFtoStr((l_ret));
    result := l_return;
    i := 1;
    while i <= CardLength - length(l_return) do
    Begin
      result := '0' + result;
      i := i + 1;
    End;
  End;
end;

// 写入卡
// 返回 -1 写入错误
// CardNo 卡号;
function TCardManage.WriteCard(CardNo: String): integer;
var
  l_data32: PAnsiChar;
  pickbh: string;
  i: integer;
  hexkey: string;
  cardmode: integer;
  tempint: longword;
Begin
  hexkey := CARD_CheckPWS;
  st := rf_load_key_hex(icdev, 0, CARD_sector, PAnsiChar(AnsiString(hexkey)));
  cardmode := 1;

  st := rf_card(icdev, cardmode, @tempint);
  st := rf_authentication(icdev, 0, CARD_sector);
  // l_data32 := PAnsiChar(CARD_password+'FF078069FFFFFFFFFFFF'); //取得默认密码
  l_data32 := PAnsiChar(AnsiString(Copy(CARD_password[0] + 'fffffffffffffffff', 1,
      length('000000000000')) + 'ff078069ffffffffffff')); // 取得默认密码
  // i := length(l_data32);
  st := rf_write_hex(icdev, CARD_sector * 4 + 3, l_data32); // 写入密码
  if st <> 0 then
  begin
    Err_Message := '密码校验失败！';
    result := 2;
    exit;
  end;
  // 将卡号转换成存储数据
  // pickbh:= inttohex(icbh,1);
  pickbh := CardNo;
  i := 1;
  while i <= CardLength * 2 - length(pickbh) do
  Begin
    pickbh := '0' + pickbh;
  End;
  l_data32 := PAnsiChar(AnsiString(Copy(pickbh + '000000000000000000000000000000000', 1, 32)));
  // 写入卡号
  // i := length(l_data32);
  st := rf_write_hex(icdev, CARD_address, l_data32);
  if st <> 0 then
  begin
    result := -1;
    exit;
  end;
  result := 1;
  SpSound;
  SpSound;
end;

// 得到卡的序列号
Function TCardManage.GetCardSequence: integer;
var
  Sequence: longword; // 序列号
begin
  st := rf_card(icdev, 1, @Sequence); // 取得序列号
  GetCardSequence := Sequence;
end;

procedure TCardManage.KeyboardEvent(VKey, ScanCode: Byte; Flags: integer);
var
  KeyboardMsg: TMsg;
  Wait: Boolean;
begin
  Wait := true;
  keybd_event(VKey, ScanCode, Flags, 0);

  If (Wait) then
    While (PeekMessage(KeyboardMsg, 0, WM_KEYFIRST, WM_KEYLAST, PM_REMOVE)) do
    begin
      TranslateMessage(KeyboardMsg);
      DispatchMessage(KeyboardMsg);
    end;
end;

function TCardManage.RCardLength: integer;
begin
  result := CardNoLength
end;

// 配置读取序列号时做为显示的编辑框 TEdit
function TCardManage.RCardOrderNo: Tedit;
begin
  result := CardOrderNo;
end;

// 读取卡号
procedure TCardManage.ReadCardNo(_edit: Tedit);
begin
  CardNoEdit := _edit;
end;

procedure TCardManage.ReadCardOrder(_edit: Tedit); // 输出序号
begin
  CardOrderNo := _edit;
end;

// 配置是否发送按键
function TCardManage.RSetSendKey: Boolean;
begin
  result := ToSendKey;
end;

// 参数设置是否发出声音
function TCardManage.RSoundBp: Boolean;
begin
  result := SetSoundBP
end;

/// ///////////////////发送按键
procedure TCardManage.SendCardNo(CardNo: String);
var
  i: integer;
begin
  for i := 1 to length(CardNo) do
  begin
    SendKeyDown(vkKeyScan(CardNo[i]), 1, False);
  end;
end;

Procedure TCardManage.SendKeyDown(VKey: Byte; NumTimes: word;
  GenUpMsg: Boolean);
var
  Cnt: word;
  ScanCode: Byte;
  NumState: Boolean;
  KeyBoardState: TKeyboardState;
begin
  If (VKey = VK_NUMLOCK) then
  begin
    NumState := ByteBool(GetKeyState(VK_NUMLOCK) and 1);
    GetKeyBoardState(KeyBoardState);
    If NumState then
      KeyBoardState[VK_NUMLOCK] := (KeyBoardState[VK_NUMLOCK] and not 1)
    else
      KeyBoardState[VK_NUMLOCK] := (KeyBoardState[VK_NUMLOCK] or 1);
    SetKeyBoardState(KeyBoardState);
    exit;
  end;
  ScanCode := Lo(MapVirtualKey(VKey, 0));
  For Cnt := 1 to NumTimes do
    If (VKey in ExtendedVKeys) then
    begin
      KeyboardEvent(VKey, ScanCode, KEYEVENTF_EXTENDEDKEY);
      If (GenUpMsg) then
        KeyboardEvent(VKey, ScanCode, KEYEVENTF_EXTENDEDKEY or KEYEVENTF_KEYUP)
    end
    else
    begin
      KeyboardEvent(VKey, ScanCode, 0);
      If (GenUpMsg) then
        KeyboardEvent(VKey, ScanCode, KEYEVENTF_KEYUP);
    End;
end;

procedure TCardManage.SendKeysBack(Key: char);
begin
  SendKeyDown(vkKeyScan(Key), 1, False);
end;

procedure TCardManage.SetCardLength(value: integer);
begin
  if (value > 0) and (value < 16) then
    CardLength := value;
end;

// 设置参数
procedure TCardManage.SetConfig(_sector: integer; _address: integer;
  _password: string);
begin
  CARD_sector := _sector; // 扇区号  0-15
  CARD_address := _sector * 4 + _address; // 地址   sector*4+address    /0 1 2
  CARD_password[0] := _password;
  GetCheckPws;
end;

procedure TCardManage.StartRead;
begin
  if Timer1 <> nil then
    Timer1.Enabled := true;
end;

procedure TCardManage.StopRead;
begin
  if Timer1 <> nil then
    Timer1.Enabled := False;
end;

procedure TCardManage.SetRead(ReadOper: integer); // 设置是否过滤重复数据 1 默认 0 不需要
begin
  _ReadOper := _ReadOper; // 设置读取参数
end;

procedure TCardManage.SetSendKey(value: Boolean);
begin
  SendKey := value;
end;

procedure TCardManage.SetSpSound(value: Boolean);
begin
  SetSoundBP := value
end;

procedure TCardManage.Timer1OnTimer(Sender: Tobject); // 定时器操作
var
  CardNo: string;
  flag: integer;

begin
  // 判断是否有卡存在
  sleep(5);
  flag := CheckCard(CARD_CheckPWS);
  if flag <> 1 then
  begin
    LastCardNo := '';
    if flag = 2 then
      OldSequence := 0;
    exit;
  end;
  CardNo := GetCardNo(); // 取得卡号
  if CardNo = 'error' then
  begin
    Err_line := 2; // 错误等级
    Err_Message := '初始化错误，设备末初始化';
  end
  else if CardNo = 'error Card type' then
  begin
    Err_line := 3; // 错误等级
    Err_Message := '磁卡类型与所需的磁卡类型不匹配，请放置正确的磁卡!';
  end
  else
  begin
    if ((LastCardNo = '') or (LastCardNo <> CardNo)) and (_ReadOper = 1) then
    begin
      // 不重复时读取
      SpSound;
      CardNoEdit.Text := CardNo;
      if SendKey then
      begin
        SendCardNo(CardNo);
        SendKeysBack(#13);
      end;
    end;
    LastCardNo := CardNo;
  end;
end;

procedure TCardManage.WCardOrderNo(const value: Tedit);
begin
  CardOrderNo := value;
end;

procedure TCardManage.WriteCareNo(_CardNO: string);
var
  lv_cardno: string;
  lv_result: integer;
  IsOpen: Boolean;
begin
  IsOpen := GetStatus;
  if IsOpen then
  begin
    self.StopRead;
    // lv_cardno:=strtoint(_CardNO);                       //取得卡号
    lv_cardno := StrtoFF(_CardNO);
    lv_result := CheckCard(CARD_CheckPWS); // 检查磁卡是否有效
    if lv_result <> 0 then
      CheckCard(CARD_CheckPWS); // 检查磁卡是否有效
    // lv_result:=WriteCard(lv_cardno);
    if WriteCard(lv_cardno) = 1 then
    begin
      WriteRunStatus := '0';
    end
    else
    begin
      WriteRunStatus := '-1';
    end;
    self.Timer1.Enabled := true;
  end
  else
  begin
    lv_cardno := StrtoFF(_CardNO);
    lv_result := CheckCard(CARD_CheckPWS); // 检查磁卡是否有效
    if lv_result <> 0 then
      CheckCard(CARD_CheckPWS); // 检查磁卡是否有效
    if WriteCard(lv_cardno) = 1 then
    begin
      WriteRunStatus := '0';
    end
    else
    begin
      WriteRunStatus := '-1';
    end;
  end;
end;

procedure TCardManage.WSetCardLength(const value: integer);
begin
  if value >= 0 then
    CardNoLength := value;
  if CardNoLength > 16 then // 一个块最多存储16个字符
    CardNoLength := 16;
end;

procedure TCardManage.WSetSendKey(const value: Boolean);
begin
  ToSendKey := value;
end;

// 控制是否发出声音
procedure TCardManage.WSetSoundBP(const value: Boolean);
begin
  SetSoundBP := value;
end;

function TCardManage.GetLastError: string;
begin
  result := Err_Message;
end;

function TCardManage.GetStatus: Boolean;
begin
  // 取得系统状态
  if Timer1 <> nil then
  begin
    if Timer1.Enabled then
    begin
      result := true;
    end
    else
    begin
      result := False;
    end;
  end
  else
  begin
    result := False;
  end;
end;

function TCardManage.GetCheckPws: string;
begin
  if CARD_CheckPWS = CARD_password[0] then
  begin
    CARD_CheckPWS := CARD_password[1];
  end
  else if CARD_CheckPWS = CARD_password[1] then
  begin
    CARD_CheckPWS := CARD_password[2];
  end
  else
  begin
    CARD_CheckPWS := CARD_password[0];
  end;
end;

procedure TCardManage.SpSound;
begin
  if SoundBp then
    rf_beep(icdev, 10);
end;

Procedure TCardManage.PlayError;
begin
  rf_beep(icdev, 10);
end;

// 字符转换
{ function TCardManage.huxtoint(hexin: array of char): integer;
  var
  i,stoi,pwr:integer;
  s:char;
  ret:integer;
  Begin
  i:=0;
  ret:=0;
  while i<=CardLength*2-1 do
  Begin
  s:=hexin[i];
  stoi:=ord(s);
  If (stoi>=48) and (stoi<58) then stoi:=stoi-48;
  If stoi>=65 then stoi:=stoi-55;

  pwr:= CardLength-i ;
  If stoi>0 then
  ret:=ret+stoi*trunc(power(16,pwr-1));
  i:=i+1;
  End;
  result:=ret;
  end; }
/// //////////////////////////////////////////////////////////////////////////////16->10
function TCardManage.HexToInt(HexStr: string): integer;
var
  i: integer;
  s: string;
begin
  i := 0;
  //code := -1;
  result := 0;
  s := HexStr;
  while i <= length(s) - 1 do
  begin
    if result > ( High(result) div 16) then
    begin
      //code := i;
      exit;
    end;
    case s[i + 1] of
      '0' .. '9':
        result := result * 16 + Ord(s[i + 1]) - Ord('0');
      'a' .. 'f':
        result := result * 16 + Ord(s[i + 1]) - Ord('a') + 10;
      'A' .. 'F':
        result := result * 16 + Ord(s[i + 1]) - Ord('A') + 10;
    else
      //code := i;
      exit;
    end;
    inc(i);
  end
end;

Function TCardManage.StrtoFF(value: String): String;
var
  i: integer;

begin
  result := '';
  FOR i := 1 TO length(value) do
  begin
    // 转成 FF 类型
    result := result + inttohex(Ord(value[i]), 2);
  end;
end;

Function TCardManage.FFtoStr(value: String): String;
var
  i: integer;
  ch: char;
  FirstTime: Boolean;
begin
  result := '';
  FirstTime := False;
  FOR i := 0 TO trunc(length(value) / 2) - 1 do
  begin
    // 转成 FF 类型
    if (value[i * 2 + 1] + value[i * 2 + 1 + 1] <> '00') or (FirstTime) then
    begin
      FirstTime := true;
      ch := chr(HexToInt(value[i * 2 + 1] + value[i * 2 + 1 + 1]));
      result := result + ch;
    end;
  end;
  if result = '' then
  begin
    result := Copy(value, 1, CardLength);
  end;

end;

function TCardManage.RunStatus: string;
begin
  result := WriteRunStatus;
end;

function TCardManage.GerCardOrder: string;
begin
  result := CardOrderNo.Text;
end;

procedure TCardManage.SetCardType(const value: TCardType);
begin
  FCardType := value;
end;

procedure TCardManage.SetCardTypeAdress(const value: integer);
begin
  FCardTypeAdress := value;
end;

procedure TCardManage.SetErr_Message(const value: String);
begin
  FErr_Message := value;
  // 默认提示错误，如果用户想自己处理就写onGetErr事件
  if Assigned(OnGetErr) then
    OnGetErr(self)
  else
  begin
    if Err_line <> 1 then // 没有设备的错误不提示
      showmessage(Err_Message);
  end;
end;

procedure TCardManage.SetOnGetErr(const value: TNotifyEvent);
begin
  FOnGetErr := value;
end;

end.
