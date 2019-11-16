unit UICcardRW;

interface

uses SysUtils, Classes, Generics.Defaults,Generics.Collections,Forms,ExtCtrls;

type
//***********************��˳���ܸı䣬������д�Ŀ����ҵ�*********************
//  0������ 1��ʻԱ�� 2����Ա�� 3����� 4Ա���� 5���㿨
//******************************************************************************
  TCardtypes=(VEHICLEREPORT,DRIVER,STEWARD,VIP,USER,VEHICLEUNIT);
  Icardfound = Interface
    ['{3A455988-9D76-4FD1-8BC9-C114E6A013B6}']
    procedure cardfound(cardSequenceNo:longword;icdev: longint);
  End;
  //IC���豸��
  TCardRWDevice= class
  private
    FNotifies:TList<Icardfound>;
    icdev: longint;//�豸��ʶ��
    cardSequenceNo:LongWord;//��ǰ�����к�
    timerSearchCard: TTimer; // ��ʱ��
    procedure timerSearchCardOnTimer(Sender: Tobject);
  public
    class function GetInstance(): TCardRWDevice;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(cardfound:Icardfound);
    procedure removeObserver(cardfound:Icardfound);
    function getErrorInfo(rs:Integer):String;//���ش�����Ϣ
  end;


///////////IC��Ĭ��ʵ�֣�ֻ��д�����ͺͿ��ţ�������USER,DRIVER,STEWARD,VEHICLEUNIT///////////////////////////////////////////////////////
  //�ſ���
  TBaseCard = class(TObject)
  private
    procedure setCardtype(_cartype : TCardtypes);
    procedure setNewcardNo(newcardno:AnsiString);
  protected
    Fisnew:Boolean; //�Ƿ��¿�
    FinternalSerialNo:Int64; //0����0��
    Fcardtype:TCardtypes; //������ 0����1��
    FcardNo:AnsiString;//8λ 0����2��
  public
    constructor Create;
    function writeCard:Integer;//д��
    function getErrorInfo(rs:Integer):String;//���ش�����Ϣ
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

    cartype_block:SmallInt; //������ 0����1��
    cardNo_block:SmallInt;//8λ 0����2��

    icdev: longint;//�豸��ʶ��

    procedure cardfound(cardSequenceNo:longword;icdev: longint);
    function writeCard(icCard:TBaseCard):Integer;//д��
  public
    class function GetInstance(): TBaseCardRW;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(iccardfound:IBaseCardfound;notifyOnlyOnActivate:Boolean=True);
    procedure removeObserver(iccardfound:IBaseCardfound);

    function getErrorInfo(rs:Integer):String;//���ش�����Ϣ
  end;
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////VIP��ʵ��////////////////////////////////////////////////////////////////////
  TCardGrade=(ONECARD,GENERAL,GOLD);
  //VIP�ſ���
  TVipCard = class(TObject)
  private
    Fisnew:Boolean; //�Ƿ��¿�
    issued:Boolean; //�Ƿ��ѷ���
    FinternalSerialNo:Int64; //0����0��
    Fcartype:TCardtypes; //������ 0����1��
    FcardNo:AnsiString;//8λ 0����2��

    FcardGrade:TCardGrade;  //0 1 2 ȡ�����ֵ� 1����0��
    Fmoney:Currency;//������λС�� 1����1��
    Famount:Currency;//������λС�� 1����2��
  public
    constructor Create;

//    procedure setNewcardNo(newcardno:AnsiString);
    procedure setNewcardGrade(newcardGrade:TCardGrade);
    procedure incrementmoney(changemoney:Currency); //�������
    procedure decrementmoney(changemoney:Currency); //�������
    procedure incrementamount(changeamount:Currency); //���ӻ���
    procedure decrementamount(changeamount:Currency); //���ٻ���

    function writeCard:Integer;//д��
    function getErrorInfo(rs:Integer):String;//���ش�����Ϣ

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

    cartype_block:SmallInt; //������ 0����1��
    cardNo_block:SmallInt;//8λ 0����2��
    cardGrade_block:SmallInt;  //0 1 2 ȡ�����ֵ� 1����0��
    money_block:SmallInt;//������λС�� 1����1��
    amount_block:SmallInt;//������λС�� 1����2��
    icdev: longint;//�豸��ʶ��

    procedure cardfound(cardSequenceNo:longword;icdev: longint);
    function writeCard(vipCard:TVipCard):Integer;//д��

  public
    class function GetInstance(): TVipcardRW;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(vipcardfound:Ivipcardfound;notifyOnlyOnActivate:Boolean=True);
    procedure removeObserver(vipcardfound:Ivipcardfound);

    function getErrorInfo(rs:Integer):String;//���ش�����Ϣ
  end;
/////////////////////////////////////////////////////////////////////////////////////////////////

procedure setCardTypeNOLength(cardtypes:TCardtypes;len:Integer);

function getCardtypeName(cardtype:TCardtypes):string;
function getCardgradeName(cardgrade:TCardGrade):string;

implementation

var
  cardRWDevice:TCardRWDevice = nil;//IC���豸����
  iccardRW : TBaseCardRW = nil; //IC��������д��������
  vipcardRW: TVipcardRW = nil; //VIP����д����


  cardtypeNOlengths:TDictionary<TCardtypes,Integer>;//��¼��ͬ���ֵĿ��ų���

  //���ַ����е�#0�滻���ַ�0
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
      raise Exception.Create('���ų��ȱ�������1��16֮��');
    end;
    if cardtypeNOlengths=nil then
      cardtypeNOlengths:=TDictionary<TCardtypes,Integer>.Create;
    if not cardtypeNOlengths.ContainsKey(cardtypes) then
      cardtypeNOlengths.Add(cardtypes,len)
    else
    begin
      if cardtypeNOlengths.Items[cardtypes]<>len then
      begin
        raise Exception.Create('�ÿ����͵ĳ������������ù�������������Ҫ���õĳ��Ȳ�һ�£�ϵͳ�쳣');
      end;
    end;
  end;

  function getcardtypename(cardtype:TCardtypes):String;
  begin
    case cardtype of
      VEHICLEREPORT: Result:='����������';
      VIP: Result:='�ͻ���';
      USER: Result:='Ա����';
      DRIVER: Result:='��ʻԱ��';
      STEWARD: Result:='����Ա��';
      VEHICLEUNIT: Result:='������λ��';
    else ;
      Result:='δ֪����';
    end;
  end;

  function getCardgradeName(cardgrade:TCardGrade):string;
  begin
    case cardgrade of
      ONECARD: Result:='һ��ͨ';
      GENERAL: Result:='�տ�';
      GOLD: Result:='��';
    else ;
      Result:='δ֪�ȼ�';
    end;
  end;

  function getcardnolength(cardtypes:TCardtypes):Integer;
  begin
    if (cardtypeNOlengths=nil) or (not cardtypeNOlengths.ContainsKey(cardtypes)) then
    begin
      raise Exception.Create('û������'+getcardtypename(cardtypes)+'�Ŀ��ų���');
    end;
    result:=cardtypeNOlengths.Items[cardtypes];
  end;

  //���ַ�������16�ֽ�
  function FillZeroToSixteenByte(str:AnsiString):AnsiString;
  begin
    Result:=str+copy('0000000000000000',1,16-length(str));
  end;

  // ����ת���ַ���ת����ʮ������
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

  // ����ת��ʮ������ת�����ַ���
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
  //�豸��������
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
  //ͨ�ú���
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
  //M1��ר�ú���
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
    //����,��֤���Ƿ����
    rf_halt(icdev);
    invokeRS:=rf_card(icdev,1,@_internalSerialNo);
    if invokeRS<>0 then exit;
    newvipcard:=TVipCard.Create;
    newvipcard.FinternalSerialNo:=_internalSerialNo;

    //ʹ��������װ������
    if loadmode>2 then
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if invokeRS<>0 then exit;
    //��֤����
    invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if invokeRS<>0 then
    begin
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //ʹ��Ĭ������װ������
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
      if invokeRS<>0 then exit;
      //��֤����
      invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
      if invokeRS<>0 then exit;
      newvipcard.Fisnew:=true;
    end
    else
    begin
      newvipcard.Fisnew:=false;
    end;

    if not newvipcard.isnew then  //���¿�����ȡ����
    begin
      //��������
      invokeRS:=rf_read_hex(icdev,cartype_block,@databuff);
      if invokeRS<>0 then Exit;
      newvipcard.Fcartype:=TCardtypes(StrToInt(String(HexToString(databuff)[1])));
      //��VIP�����˳�
      if newvipcard.Fcartype<>Tcardtypes.VIP then exit;
      //������
      invokeRS:=rf_read_hex(icdev,cardNo_block,@databuff);
      if invokeRS<>0 then Exit;
      newvipcard.FcardNo:=Copy(HexToString(databuff),1,getcardnolength(newvipcard.cardtype));

      //������
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //ʹ��������װ������
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(newPasswordA_hex));
      if invokeRS<>0 then exit;
      //��֤����
      invokeRS:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
      if invokeRS<>0 then
      begin
        rf_halt(icdev);
        invokeRS:=rf_card(icdev,1,@_internalSerialNo);
        if invokeRS<>0 then exit;
        //ʹ��Ĭ������װ������
        if loadmode>2 then
          invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordB_hex))
        else
          invokeRS:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordA_hex));
        if invokeRS<>0 then exit;
        //��֤����
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
        //�����ȼ�
        invokeRS:=rf_read_hex(icdev,cardGrade_block,@databuff);
        if invokeRS<>0 then Exit;
        newvipcard.FcardGrade:=Tcardgrade(StrToInt(HexToString(databuff)[1]));

        //�����
        invokeRS:=rf_read_hex(icdev,money_block,@databuff);
        if invokeRS<>0 then Exit;
        newvipcard.Fmoney:=StrToCurr(HexToString(databuff));
        //������
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
    vipcardRW.cartype_block:=beginsector*4+1; //������ 0����1��
    vipcardRW.cardNo_block:=beginsector*4+2;//8λ 0����2��
    vipcardRW.cardGrade_block:=beginsector*4+4;  //0 1 2 ȡ�����ֵ� 1����0��
    vipcardRW.money_block:=beginsector*4+5;//������λС�� 1����1��
    vipcardRW.amount_block:=beginsector*4+6;//������λС�� 1����2��
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
    raise Exception.Create('���������ǰ���ȶԿ���ʼ��');
  end;

  //����,��֤���Ƿ����
  rf_halt(icdev);
  Result:=rf_card(icdev,1,@_internalSerialNo);
  if Result<>0 then exit;
  if vipCard.FinternalSerialNo<>_internalSerialNo then
  begin
    result:=7701; //��ǰ���Ѿ�������
    exit;
  end;

  if not vipCard.issued then
  begin
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cardGrade_block div 4,PAnsiChar(defaultPasswordA_hex));
    if Result<>0 then exit;
    //��֤����
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
    //��֤����
    Result:=rf_authentication(icdev,loadmode,cardGrade_block div 4);
    if Result<>0 then exit;
  end;

  //д���
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(FormatCurr('0.00',vipCard.Fmoney))));
  Result:=rf_write_hex(icdev,money_block,writedate);
  if Result<>0 then Exit;
  //д����
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(FormatCurr('0.00',vipCard.Famount))));
  Result:=rf_write_hex(icdev,amount_block,writedate);
  if Result<>0 then Exit;

  //�����û�з�������ʾ�����Ƿ�������
  if not vipCard.issued then
  begin
    //д���ȼ�
    writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(inttostr(Integer(vipCard.FcardGrade)))));
    Result:=rf_write_hex(icdev,cardGrade_block,writedate);
    if Result<>0 then Exit;
    vipCard.issued:=True;
    //д������
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
    raise Exception.Create('VIP�����۲��߱�����TCustomForm����');
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
  //�رմ���
  Self.icdev:=0;
  rf_exit(self.icdev);
  cardRWDevice := nil;
end;

function TCardRWDevice.getErrorInfo(rs: Integer): String;
begin
  case rs of
    7701:Result:='��ǰ���Ѿ�������';
    0:Result:='��ȷ';
    1:Result:='�޿�';
    2:Result:='CRCУ���';
    3:Result:='ֵ���';
    4:Result:='δ��֤����';
    5:Result:='��żУ���';
    6:Result:='ͨѶ����';
    8:Result:='��������к�';
    10:Result:='��֤����ʧ��';
    11:Result:='���յ�����λ����';
    12:Result:='���յ������ֽڴ���';
    14:Result:='Transfer����';
    15:Result:='дʧ��';
    16:Result:='��ֵʧ��';
    17:Result:='��ֵʧ��';
    18:Result:='��ʧ��';
    $-10:Result:='PC���д��ͨѶ����';
    $-11:Result:='ͨѶ��ʱ';
    $-20:Result:='��ͨ�ſ�ʧ��';
    $-24:Result:='�����ѱ�ռ��';
    $-30:Result:='��ַ��ʽ����';
    $-31:Result:='�ÿ����ݲ���ֵ��ʽ';
    $-32:Result:='���ȴ���';
    $-40:Result:='ֵ����ʧ��';
    $-50:Result:='���е�ֵ������';
  else ;
    Result:='δ֪����';
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
    //��ʼ������
    //�� ����port�����ںţ�ȡֵΪ0��3
    //       baud��ΪͨѶ������9600��115200
    cardRWDevice.icdev:=rf_init(0,115200);
    if(cardRWDevice.icdev<=0) then
    begin
//      raise Exception.Create('IC����д������ʼ��ʧ��,�����Ӻö�����');
      Application.MessageBox('IC����д������ʼ��ʧ��,�����Ӻö�����','��ʾ');
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
    //�Ҳ���������ʱ������Ƶ�ʼ��͡�
    cardRWDevice.timerSearchCard.Interval:=1000;
    cardRWDevice.icdev:=rf_init(0,115200);
    if(cardRWDevice.icdev<=0) then exit;
  end;
  cardRWDevice.timerSearchCard.Interval:=100;
  //Ѱ��,�����ڹ���������ĳ�ſ������к�
//0������ʾIDLEģʽ��һ��ֻ��һ�ſ�������
//1������ʾALLģʽ��һ�οɶԶ��ſ�������
//2������ʾָ����ģʽ��ֻ�����кŵ���snr�Ŀ��������߼��������У�
//   ע��ѡ��IDLEģʽ���ڶԿ����ж�д������ִ��rf_halt()rf_haltָ����ֹ��������ֻ�е��ÿ��뿪���ٴν��������ʱ����д�����ܹ��ٴζ������в�����
  rf_halt(icdev);
  st:=rf_card(icdev,1,@_internalSerialNo);
  if st=0 then
  begin
    if _internalSerialNo=cardSequenceNo then exit; //��û��
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
  Fcartype:=TCardtypes.VIP; //������
  FcardGrade:=TcardGrade.ONECARD;  //0 1 2 ȡ�����ֵ�
  FcardNo:='00000000';//8λ
  FinternalSerialNo:=0; //0����0��
  Fmoney:=0;//������λС��
  Famount:=0;//������λС��
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
    raise Exception.Create('VIP�����۲��߱�����TCustomForm����');
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
    //����,��֤���Ƿ����
    rf_halt(icdev);
    invokeRS:=rf_card(icdev,1,@_internalSerialNo);
    if invokeRS<>0 then exit;
    newiccard:=TBaseCard.Create;
    newiccard.FinternalSerialNo:=_internalSerialNo;

    //ʹ��������װ������
    if loadmode>2 then
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if invokeRS<>0 then exit;
    //��֤����
    invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if invokeRS<>0 then
    begin
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //ʹ��Ĭ������װ������
      if loadmode>2 then
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
      else
        invokeRS:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
      if invokeRS<>0 then exit;
      //��֤����
      invokeRS:=rf_authentication(icdev,loadmode,cartype_block div 4);
      if invokeRS<>0 then exit;
      newiccard.Fisnew:=true;
    end
    else
    begin
      newiccard.Fisnew:=false;
    end;

    if not newiccard.isnew then  //���¿�����ȡ����
    begin
      //��������
      invokeRS:=rf_read_hex(icdev,cartype_block,@databuff);
      if invokeRS<>0 then Exit;
      newiccard.Fcardtype:=TCardtypes(StrToInt(String(HexToString(databuff)[1])));
      //������
      invokeRS:=rf_read_hex(icdev,cardNo_block,@databuff);
      if invokeRS<>0 then Exit;
      newiccard.FcardNo:=Copy(HexToString(databuff),1,getcardnolength(newiccard.cardtype));
      newiccard.FcardNo:=ReplaceAllJ0ToS0(newiccard.FcardNo);
    end;

//**********����Ĵ�����Ϊ�˼���ԭ�ϲ��������ı�������ת��ԭ��������Ϣ����λ��*****************
    if newiccard.isnew then
    begin
      //������
      rf_halt(icdev);
      invokeRS:=rf_card(icdev,1,@_internalSerialNo);
      if invokeRS<>0 then exit;
      //�жϵ�2����1�����루2*4+1=9��
      invokeRS:=rf_load_key_hex(icdev,0,2,PAnsiChar('111fffffffff'));
      if invokeRS=0 then
      begin
        invokeRS:=rf_authentication(icdev,0,2);
        if invokeRS=0 then
        begin
          //����ԭ����
          invokeRS:=rf_read_hex(icdev,9,@databuff);
          if invokeRS<>0 then Exit;
          newiccard.FcardNo:=Copy(HexToString(databuff),1,6);
          newiccard.FcardNo:=ReplaceAllJ0ToS0(newiccard.FcardNo);
          newiccard.Fcardtype:=Tcardtypes.VEHICLEREPORT;
          //��ԭ����������
          if (cardNo_block div 4) =2 then
            writedate:=PAnsiChar(Self.newBlock3data_hex)
          else
            writedate:=PAnsiChar(Self.defaultBlock3data_hex);
          invokeRS:=rf_write_hex(icdev,2*4+3,writedate);

          //��ԭ��������Ϣ���·���д��
          newiccard.writeCard;
        end;
      end;
    end;
//**********����Ĵ�����Ϊ�˼���ԭ�ϲ��������ı�������ת��ԭ��������Ϣ����λ��*****************

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
    iccardRW.cartype_block:=beginsector*4+1; //������ 0����1��
    iccardRW.cardNo_block:=beginsector*4+2;//8λ 0����2��
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
  //����,��֤���Ƿ����
  rf_halt(icdev);
  Result:=rf_card(icdev,1,@_internalSerialNo);
  if Result<>0 then exit;
  if icCard.FinternalSerialNo<>_internalSerialNo then
  begin
    result:=7701; //��ǰ���Ѿ�������
    exit;
  end;
  if not icCard.isnew then
  begin
    //ʹ��������װ������
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(newPasswordA_hex));
    if Result<>0 then exit;
    //��֤����
    Result:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if Result<>0 then exit;
  end
  else
  begin
    //ʹ��Ĭ������װ������
    if loadmode>2 then
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordB_hex))
    else
      Result:=rf_load_key_hex(icdev,loadmode,cartype_block div 4,PAnsiChar(defaultPasswordA_hex));
    if Result<>0 then exit;
    //��֤����
    Result:=rf_authentication(icdev,loadmode,cartype_block div 4);
    if Result<>0 then exit;
  end;

  //д������
  writedate:=StringToHex(FillZeroToSixteenByte(AnsiString(inttostr(Integer(icCard.cardtype)))));
  Result:=rf_write_hex(icdev,cartype_block,writedate);
  if Result<>0 then Exit;
  //д����
  writedate:=StringToHex(FillZeroToSixteenByte(icCard.FcardNo));
  Result:=rf_write_hex(icdev,cardNo_block,writedate);
  if Result<>0 then Exit;
  if icCard.isnew then
  begin
    //д0��������
    writedate:=PAnsiChar(Self.newBlock3data_hex);
    Result:=rf_write_hex(icdev,(cartype_block div 4)*4 +3,writedate);
    if Result<>0 then Exit;
    icCard.Fisnew:=False;
  end;
end;

{ TICCard }

constructor TBaseCard.Create;
begin
  Fcardtype:=TCardtypes.VIP; //������
  FcardNo:='00000000';//8λ
  FinternalSerialNo:=0; //0����0��
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
    raise Exception.Create('�Ѿ�ʹ�õĿ��������޸Ŀ������');
  end;
  Self.Fcardtype:=_cartype;
end;

procedure TBaseCard.setNewcardNo(newcardno: AnsiString);
begin
  if not Self.isnew then
  begin
    raise Exception.Create('�Ѿ�ʹ�õĿ��������޸Ŀ��Ŀ���');
  end;
  self.FcardNo:=newcardno;
end;

function TBaseCard.writeCard: Integer;
begin
  if getcardnolength(self.cardtype)<>length(self.cardNo) then
  begin
    raise Exception.Create(getcardtypename(self.cardtype)+'����ӦΪ'+inttostr(getcardnolength(self.cardtype))
                           +',ʵ�ʳ���Ϊ'+inttostr(length(self.cardNo))+'��������д��');
  end;
  result:=TBaseCardRW.GetInstance.writeCard(self);
end;

Initialization
Finalization
  if Assigned(cardRWDevice) then FreeAndNil(cardRWDevice);
  if Assigned(iccardRW) then FreeAndNil(iccardRW);
  if Assigned(vipcardRW) then FreeAndNil(vipcardRW);
end.
