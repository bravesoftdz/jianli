unit CardManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Math, StdCtrls, ExtCtrls,
  Controls, Dialogs;

type
  TCardType = (All, FunctionCard, VipCard); // �ſ���� ��ΪAllʱ�����ִſ���𣬷���ֻ��ȡ��Ӧ�����

  TCardManage = class(TComponent)
    CardOrderNo: Tedit; // �������к�
    CardNoEdit: Tedit;
    // ������         //��ַ           //���� 12λֵffffffffffff
    procedure SetConfig(_sector: integer; _address: integer;
      _password: string); // ��������

    procedure ReadCardNo(_edit: Tedit); // �������

    procedure ReadCardOrder(_edit: Tedit); // ������

    Function GerCardOrder: string; // ȡ�ÿ����

    procedure WriteCareNo(_CardNO: string); // ����д������
    procedure Timer1OnTimer(Sender: Tobject); // �����Ų���
    procedure Quit();
    procedure SetSpSound(value: Boolean);
    procedure SetCardLength(value: integer); // ���ÿ�λ�� 6
    procedure SetSendKey(value: Boolean);
    Function GetStatus: Boolean;
    Function GetLastError: string;
    Procedure StartRead;
    Procedure StopRead;
    function RunStatus: string;
    Procedure PlayError;
  private
    { Private declarations }
    CARD_sector: integer; // ������
    CARD_address: integer; // ��ַ
    CARD_password: array [0 .. 2] of string;
    CARD_CheckPWS: string;
    st: word; // ����DLL���ز���
    icdev: longint; // ��ʼ�����ز���
    FErr_Message: string; // ������Ϣ
    Err_line: integer; // ����ȼ� 1 Ϊ�豸û��׼����(����ʾ)    2���豸û�г�ʼ��  3���ſ����Ͳ�ƥ��

    _ReadOper: integer; // �Ƿ��ظ������� 1
    ToSendKey: Boolean; // �Ƿ��Ͱ���
    CardNoLength: integer; // ����λ��
    SetSoundBP: Boolean; // �Ƿ񷢳�����
    Timer1: TTimer; // ��ʱ��
    WriteRunStatus: string;
    FCardType: TCardType;
    FCardTypeAdress: integer;
    FOnGetErr: TNotifyEvent;
    OldSequence: longword; // ���к�
    Function GetCardNo(): string; // ȡ�ÿ���
    Function GetCardSequence: integer; // �õ��������к�
    Function InitCard(port: integer; baud: integer): integer; // ��ʼ��
    Function CheckCard(lv_cardkey: String): integer;
    // ���ſ��Ƿ���Ч ���� 2 - �޿� 3.4 - ��֤���� 1��ȷ    5���ظ�
    // function  huxtoint(hexin: array of char): integer;//�ַ�ת��
    Function WriteCard(CardNo: string): integer; // д�뿨
    procedure SetRead(ReadOper: integer); // �����Ƿ�����ظ����� 1 Ĭ�� 0 ����Ҫ
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
    Function DeviceInic: integer; // �豸��ʼ��
    property ReadOper: integer read _ReadOper write SetRead;
    property RWCardOrderNo: Tedit read RCardOrderNo write WCardOrderNo;
    Property SendKey: Boolean read RSetSendKey Write WSetSendKey; // �����Ƿ��Ͱ���
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

  // ��ʼ������  port�����ںţ�ȡֵΪ0��3  20080421 ice�ı�˺����Ŀɼ���Χ �����̵���
function rf_init(port: smallint; baud: longint): longint; stdcall; far;
external 'mwrf32.dll' name 'rf_init';
// �ͷŴ���
function rf_exit(icdev: longint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_exit';

implementation

function rf_load_key_hex(icdev: longint; mode, secnr: smallint;
  nkey: PAnsiChar): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_load_key_hex';
// Ѱ�����ܷ����ڹ���������ĳ�ſ������к�
function rf_card(icdev: longint; mode: smallint; snr: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_card';
// ��֤ĳһ��������
function rf_authentication(icdev: longint; mode, secnr: smallint): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_authentication';
// ����д������
// ����M1����һ�α���дһ���飬Ϊ16���ֽڣ�
// �� ����icdev��ͨѶ�豸��ʶ��
// _Adr��M1���������ַ��1��63���� _Data��Ҫд�������
function rf_write_hex(icdev: longint; adr: smallint; data: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_write_hex';
// ���ָ�������Ƿ��뿨������һ��
function rf_check_writehex(icdev, snr: longint; adr, authmode: smallint;
  data: PAnsiChar): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_check_writehex';
// ��ȡ��������һ�ζ�һ��������ݣ�Ϊ16���ֽ�
function rf_read_hex(icdev: longint; adr: smallint; data: PAnsiChar): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_read_hex';
// ��ʼ����ֵ��icdev��ͨѶ�豸��ʶ�� _Adr�����ַ��1��63��_Value����ʼֵ
// value=1000;                    /* ��value��ֵ*/
// st=rf_initval(icdev,1,value);        /*����1��ֵ��ʼ��Ϊ1000*/
function rf_initval(icdev: longint; adr: smallint; value: longint): smallint;
  stdcall; far; external 'mwrf32.dll' name 'rf_initval';
// ��ֹ�Ըÿ�����
function rf_halt(icdev: longint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_halt';
// ��Ƶ��дģ�鸴λ int _Msec����λʱ�䣬0��500������Ч
function rf_reset(icdev: longint; msec: smallint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_reset';
// �豸����
function rf_beep(icdev: longint; time: smallint): smallint; stdcall; far;
external 'mwrf32.dll' name 'rf_beep';
// ȡ�ö�д��Ӳ���汾�ţ��硰mwrf100_v3.0��  version[18];
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
  SendKey := False; // Ĭ�ϲ�����
  CardLength := 8; // һ�������洢16���ַ�,����Ϊ8λ����
  SoundBp := true;
  CARD_password[2] := 'ffffffffffff'; // 20080512 ice �����������������������ظ�ʱ�������������ѭ��N�β��ܸı�
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
    // timer1.Free;  ����������free 20080408 ice
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
    Err_line := 1; // ����ȼ�
    Err_Message := '��ʼ��������ȷ�϶�д���Ƿ��';
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

// ���ſ��Ƿ���Ч ���� 2 - �޿� 3.4 - ��֤����  1��ȷ    5���ظ�
function TCardManage.CheckCard(lv_cardkey: String): integer;
var
  l_cardkey: pansiChar;
  Sequence: longword; // ���к�
Begin
  rf_halt(icdev);
  st := rf_card(icdev, 1, @Sequence); // �ж��Ƿ��п�
  If st = 0 then
  Begin
    if Sequence = OldSequence then
    begin
      result := 5;
      exit;
    end;
    l_cardkey := PAnsiChar(AnsiString(lv_cardkey));
    //l_cardkey := '111fffffffff';
    st := rf_load_key_hex(icdev, 0, 2, l_cardkey); // ��֤��������
    If st = 0 then
    Begin
      st := rf_authentication(icdev, 0, CARD_sector); // �ж��Ƿ�Ƿ���
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

// ȡ�ÿ���
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
  if CardType <> All then // ȡ�ſ�����
  begin
    //getmem(l_readcardtype, 33);
    st := rf_read_hex(icdev,CARD_address, @l_readcardtype); // ��ȡ���ڵ�������
    If st <> 0 then
    Begin
      //freemem(l_readcardtype);
      result := 'error';
      exit;
    End
    else
    Begin
      s_cardtype := Copy(FFtoStr((l_readcardtype)), 1, 1); // ֻȡ��һλ
      //freemem(l_readcardtype);
      // 0 ���ܿ� 4�����
      if ((CardType = FunctionCard) and (s_cardtype = '0')) or
        ((CardType = VipCard) and (s_cardtype = '4')) then
      begin ; // �������¶�ȡ����
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
  st := rf_read_hex(icdev,CARD_address, @L_readcard); // ��ȡ���ڵ�������
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

// д�뿨
// ���� -1 д�����
// CardNo ����;
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
  // l_data32 := PAnsiChar(CARD_password+'FF078069FFFFFFFFFFFF'); //ȡ��Ĭ������
  l_data32 := PAnsiChar(AnsiString(Copy(CARD_password[0] + 'fffffffffffffffff', 1,
      length('000000000000')) + 'ff078069ffffffffffff')); // ȡ��Ĭ������
  // i := length(l_data32);
  st := rf_write_hex(icdev, CARD_sector * 4 + 3, l_data32); // д������
  if st <> 0 then
  begin
    Err_Message := '����У��ʧ�ܣ�';
    result := 2;
    exit;
  end;
  // ������ת���ɴ洢����
  // pickbh:= inttohex(icbh,1);
  pickbh := CardNo;
  i := 1;
  while i <= CardLength * 2 - length(pickbh) do
  Begin
    pickbh := '0' + pickbh;
  End;
  l_data32 := PAnsiChar(AnsiString(Copy(pickbh + '000000000000000000000000000000000', 1, 32)));
  // д�뿨��
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

// �õ��������к�
Function TCardManage.GetCardSequence: integer;
var
  Sequence: longword; // ���к�
begin
  st := rf_card(icdev, 1, @Sequence); // ȡ�����к�
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

// ���ö�ȡ���к�ʱ��Ϊ��ʾ�ı༭�� TEdit
function TCardManage.RCardOrderNo: Tedit;
begin
  result := CardOrderNo;
end;

// ��ȡ����
procedure TCardManage.ReadCardNo(_edit: Tedit);
begin
  CardNoEdit := _edit;
end;

procedure TCardManage.ReadCardOrder(_edit: Tedit); // ������
begin
  CardOrderNo := _edit;
end;

// �����Ƿ��Ͱ���
function TCardManage.RSetSendKey: Boolean;
begin
  result := ToSendKey;
end;

// ���������Ƿ񷢳�����
function TCardManage.RSoundBp: Boolean;
begin
  result := SetSoundBP
end;

/// ///////////////////���Ͱ���
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

// ���ò���
procedure TCardManage.SetConfig(_sector: integer; _address: integer;
  _password: string);
begin
  CARD_sector := _sector; // ������  0-15
  CARD_address := _sector * 4 + _address; // ��ַ   sector*4+address    /0 1 2
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

procedure TCardManage.SetRead(ReadOper: integer); // �����Ƿ�����ظ����� 1 Ĭ�� 0 ����Ҫ
begin
  _ReadOper := _ReadOper; // ���ö�ȡ����
end;

procedure TCardManage.SetSendKey(value: Boolean);
begin
  SendKey := value;
end;

procedure TCardManage.SetSpSound(value: Boolean);
begin
  SetSoundBP := value
end;

procedure TCardManage.Timer1OnTimer(Sender: Tobject); // ��ʱ������
var
  CardNo: string;
  flag: integer;

begin
  // �ж��Ƿ��п�����
  sleep(5);
  flag := CheckCard(CARD_CheckPWS);
  if flag <> 1 then
  begin
    LastCardNo := '';
    if flag = 2 then
      OldSequence := 0;
    exit;
  end;
  CardNo := GetCardNo(); // ȡ�ÿ���
  if CardNo = 'error' then
  begin
    Err_line := 2; // ����ȼ�
    Err_Message := '��ʼ�������豸ĩ��ʼ��';
  end
  else if CardNo = 'error Card type' then
  begin
    Err_line := 3; // ����ȼ�
    Err_Message := '�ſ�����������Ĵſ����Ͳ�ƥ�䣬�������ȷ�Ĵſ�!';
  end
  else
  begin
    if ((LastCardNo = '') or (LastCardNo <> CardNo)) and (_ReadOper = 1) then
    begin
      // ���ظ�ʱ��ȡ
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
    // lv_cardno:=strtoint(_CardNO);                       //ȡ�ÿ���
    lv_cardno := StrtoFF(_CardNO);
    lv_result := CheckCard(CARD_CheckPWS); // ���ſ��Ƿ���Ч
    if lv_result <> 0 then
      CheckCard(CARD_CheckPWS); // ���ſ��Ƿ���Ч
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
    lv_result := CheckCard(CARD_CheckPWS); // ���ſ��Ƿ���Ч
    if lv_result <> 0 then
      CheckCard(CARD_CheckPWS); // ���ſ��Ƿ���Ч
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
  if CardNoLength > 16 then // һ�������洢16���ַ�
    CardNoLength := 16;
end;

procedure TCardManage.WSetSendKey(const value: Boolean);
begin
  ToSendKey := value;
end;

// �����Ƿ񷢳�����
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
  // ȡ��ϵͳ״̬
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

// �ַ�ת��
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
    // ת�� FF ����
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
    // ת�� FF ����
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
  // Ĭ����ʾ��������û����Լ������дonGetErr�¼�
  if Assigned(OnGetErr) then
    OnGetErr(self)
  else
  begin
    if Err_line <> 1 then // û���豸�Ĵ�����ʾ
      showmessage(Err_Message);
  end;
end;

procedure TCardManage.SetOnGetErr(const value: TNotifyEvent);
begin
  FOnGetErr := value;
end;

end.
