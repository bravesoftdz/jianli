unit UIDCardReader;

interface

uses Windows,SysUtils, Classes, Generics.Defaults,Generics.Collections,Forms,ExtCtrls,
     Graphics;

type
  //���֤��Ϣ
  TIDCard = class(TObject)
  private
    FName:String;//����
    FSex:String;//�Ա�
    FMZ:String;//����
    FBday:TDate;//����
    FAddr:String;//סַ
    FID:String;//���֤��
    FDep:String;//ǩ������
    FVld_S:TDate;//��Ч����_��ʼ
    FVld_E:TDate;//��Ч����_����
    FNewAddr:String;//����סַ
    Fphoto: TBitmap;//��Ƭ
  public
    constructor Create;
    property Name : String read FName;
    property Sex : String read FSex;
    property MZ : String read FMZ;
    property Bday : TDate read FBday;
    property Addr : String read FAddr;
    property ID : String read FID;
    property Dep : String read FDep;
    property Vld_S : TDate read FVld_S;
    property Vld_E : TDate read FVld_E;
    property NewAddr : String read FNewAddr;
    property photo : TBitmap read Fphoto;
  end;

  IIDCardfound = Interface
    ['{83C72C4E-9A64-4EF4-824E-C97148ABB935}']
    procedure cardfound(idcard:TIDCard);
  End;
  //���֤�����豸��
  TIDCardReader= class
  private
    FNotifies:TDictionary<IIDCardfound,Boolean>;
    timerSearchCard: TTimer; // ��ʱ��

    procedure timerSearchCardOnTimer(Sender: Tobject);

    function _strtodate(dstr:string):TDate;
  public
    class var idcardreader_ready:boolean;
    class function GetInstance(): TIDCardReader;
    class function NewInstance: TObject; override;
    procedure FreeInstance; override;
    procedure addObserver(cardfound:IIDCardfound;hintWhenCantCon:boolean=True;notifyOnlyOnActivate:Boolean=True);
    procedure removeObserver(cardfound:IIDCardfound);
  end;

implementation

uses CVRDLL;

var
  idcardreader:TIDCardReader = nil;//IC���豸����
const iPort=1001;
//1	����1
//2	����2
//3	����3
//4	����4
//1001	USB��1
//1002	USB��2
//1003	USB��3
//1004	USB��4

function getpeoplename(peoplecode:string):string;
begin
  case StrToIntDef(peoplecode,-1) of
    01:result:='��';
    02:result:='�ɹ�';
    03:result:='��';
    04:result:='��';
    05:result:='ά���';
    06:result:='��';
    07:result:='��';
    08:result:='׳';
    09:result:='����';
    10:result:='����';
    11:result:='��';
    12:result:='��';
    13:result:='��';
    14:result:='��';
    15:result:='����';
    16:result:='����';
    17:result:='������';
    18:result:='��';
    19:result:='��';
    20:result:='����';
    21:result:='��';
    22:result:='�';
    23:result:='��ɽ';
    24:result:='����';
    25:result:='ˮ';
    26:result:='����';
    27:result:='����';
    28:result:='����';
    29:result:='�¶�����';
    30:result:='��';
    31:result:='���Ӷ�';
    32:result:='����';
    33:result:='Ǽ';
    34:result:='����';
    35:result:='����';
    36:result:='ë��';
    37:result:='����';
    38:result:='����';
    39:result:='����';
    40:result:='����';
    41:result:='������';
    42:result:='ŭ';
    43:result:='���α��';
    44:result:='����˹';
    45:result:='���¿�';
    46:result:='�°�';
    47:result:='����';
    48:result:='ԣ��';
    49:result:='��';
    50:result:='������';
    51:result:='����';
    52:result:='���״�';
    53:result:='����';
    54:result:='�Ű�';
    55:result:='���';
    56:result:='��ŵ';
    97:result:='����';
    98:result:='���Ѫͳ�й�����ʿ';
  else
    result:='δ֪';
  end;
end;

{ TCardRWDevice }

procedure TIDCardReader.addObserver(cardfound: IIDCardfound;hintWhenCantCon:boolean=True;notifyOnlyOnActivate:Boolean=True);
var ID: Cardinal;
    initret:Integer;
begin
  if not (cardfound is TCustomForm) then
  begin
    raise Exception.Create('���֤�����۲��߱�����TCustomForm����');
  end;
  if not idcardreader.idcardreader_ready  then
  begin
    initret:=CVR_InitComm(iPort);
    idcardreader.idcardreader_ready:=initret=1;
    if not idcardreader.idcardreader_ready  then
    begin
      if hintWhenCantCon then
      begin
        Application.MessageBox('�������֤������ʧ��,�����Ӻú�,���´򿪱�ģ�飡','��ʾ');
      end;
      CVR_CloseComm();
      idcardreader:=nil;
      exit;
    end
    else
    begin
      GetManuID(@ID);
  //      mmo1.Lines.Add('��������ʼ���ɹ�,ID:'+inttostr(ID)+'����ſ���');
      idcardreader.timerSearchCard.Enabled:=True;
    end;
  end;
  FNotifies.AddOrSetValue(cardfound,notifyOnlyOnActivate);
end;

procedure TIDCardReader.FreeInstance;
begin
  inherited;
  //�رմ���
  idcardreader := nil;
end;

class function TIDCardReader.GetInstance: TIDCardReader;
begin
  if not Assigned(idcardreader) then
  begin
    idcardreader := TIDCardReader(TIDCardReader.NewInstance);
  end;
  Result := idcardreader;
end;

class function TIDCardReader.NewInstance: TObject;
begin
  if not Assigned(idcardreader) then
  begin
    idcardreader := TIDCardReader( inherited NewInstance);
    idcardreader.FNotifies:=TDictionary<IIDCardfound,Boolean>.Create;
    idcardreader.timerSearchCard:=TTimer.Create(Application);
    idcardreader.timerSearchCard.Enabled:=false;
    idcardreader.timerSearchCard.Interval:=500;
    idcardreader.timerSearchCard.OnTimer:=idcardreader.timerSearchCardOnTimer;
  end;
  Result := idcardreader;
end;

procedure TIDCardReader.removeObserver(cardfound: IIDCardfound);
begin
  if FNotifies.ContainsKey(cardfound) then
    FNotifies.Remove(cardfound);
end;

procedure TIDCardReader.timerSearchCardOnTimer(Sender: Tobject);
var cardfound: IIDCardfound;
  iRet:integer;

  iFileHandle,iFileLength: Integer;
  Buffer: PWideChar;

  sWZ :WideString;
  sDisp:string;

  idcard:TIDCard;
  needread:boolean;
begin
  timerSearchCard.Enabled:=false;
  try
    //�ж��Ƿ���Ҫ����
    needread:=false;
    for cardfound in FNotifies.Keys do
    begin
      if (not FNotifies.Items[cardfound])
        or (FNotifies.Items[cardfound]
            and TCustomForm(cardfound).CanFocus
            and (
                  (Application.MainForm.Active
                    and (Application.MainForm=GetParentForm(TCustomForm(cardfound),True))
                  )
                  or  (Application.MainForm<>GetParentForm(TCustomForm(cardfound),True))
                )

            ) then
      begin
        needread:=True;
        break;
      end;
    end;
    if not needread then exit;

    iRet := CVR_Authenticate();
    if iRet<>1 then exit;
    iRet := CVR_Read_Content(1);
    if iRet<>1 then exit;
    idcard:=TIDCard.Create;
    try
      iFileHandle := FileOpen(ExtractFilePath(Application.ExeName) +'wz.txt', fmOpenRead);
      iFileLength := FileSeek(iFileHandle,0,2);
      FileSeek(iFileHandle,0,0);
      Buffer := PWideChar(AllocMem(iFileLength +2));
      FileRead(iFileHandle, Buffer^, iFileLength);
      FileClose(iFileHandle);
      sWZ:=WideChartostring(buffer);

    try
        idcard.FName:=Trim(copy(sWZ,1,15));  //����
        delete(sWZ,1,15);
      except
        idcard.FName:='�ÿ�';
      end;
      try
      if (copy(sWZ,1,1)='1') then     //�Ա�
        idcard.FSex:='��'
      else
        idcard.FSex:='Ů';
      delete(sWZ,1,1);
      except
        idcard.FSex:='��'
      end;
      try
        //����
        sDisp:='';
        sDisp:=copy(sWZ,1,2);
        idcard.FMZ:= getpeoplename(sDisp);
        delete(sWZ,1,2);
      except
        idcard.FMZ:='δ֪' ;
      end;
      try
        //����
        idcard.FBday:=_strtodate(copy(sWZ,1,8));
        delete(sWZ,1,8);
      except
        idcard.FBday:=_strtodate('19801010') ;
      end;
      try
        //סַ
        idcard.FAddr:=Trim(copy(sWZ,1,35));
        delete(sWZ,1,35);
      except
        idcard.FAddr:='' ;
      end;
      try
      //���֤��
        idcard.FID:=Trim(copy(sWZ,1,18));
        delete(sWZ,1,18);
      except
        idcard.FID:='360735199102020012' ;
      end;
//      Application.MessageBox(PWideChar(swz),'tt');
      //ǩ������
      try
        idcard.FDep:=Trim(copy(sWZ,1,15));
        sDisp:='';
        delete(sWZ,1,15);
      except
        idcard.FDep:='360735199102020012' ;
      end;
      //��Ч����
      try
        idcard.FVld_S:=_strtodate(copy(sWZ,1,8));
        delete(sWZ,1,8);
        if((trim(sWZ))='����') then
        begin
           //idcard.FVld_E:=_strtodate(copy(sWZ,1,8));
           delete(sWZ,1,8);
        end
        else
        begin
           idcard.FVld_E:=_strtodate(copy(sWZ,1,8));
            delete(sWZ,1,8);
        end;
      except
        //idcard.FVld_E:='����' ;
      end;

      try
        //����סַ
        idcard.FNewAddr:=Trim(copy(sWZ,1,35));

        //��Ƭ
        idcard.Fphoto.LoadFromFile(ExtractFilePath(Application.ExeName) +'zp.bmp');
      except
        //
      end;


//      windows.Beep(2800,200);
//       mmo1.Lines.Add('�����֤���ϳɹ�');

      if FNotifies.Count>0 then
      begin
        for cardfound in FNotifies.Keys do
        begin
          if (not FNotifies.Items[cardfound])
            or (FNotifies.Items[cardfound]
                and TCustomForm(cardfound).CanFocus
                and (
                      (Application.MainForm.Active
                        and (Application.MainForm=GetParentForm(TCustomForm(cardfound),True))
                      )
                      or  (Application.MainForm<>GetParentForm(TCustomForm(cardfound),True))
                    )

                ) then
          begin
            try
              cardfound.cardfound(idcard);
            except
            end;
          end;
        end;

      end;
    finally
       FreeMem(Buffer);
    end;
  finally
    timerSearchCard.Enabled:=true;
  end;
end;

function TIDCardReader._strtodate(dstr: string): TDate;
var
  sYY, sMM, sDD :string;
begin
  //�� 19760816
  sYY:=copy(dstr,1,4);
  sMM:=copy(dstr,5,2);
  sDD:=copy(dstr,7,2);
  result:=EncodeDate(StrToInt(sYY),StrToInt(sMM),StrToInt(sDD));
end;

{ TIDCard }

constructor TIDCard.Create;
begin
  FName:='';
  FSex:='';
  FMZ:='';
//  FBday:='';
  FAddr:='';
  FID:='';
  FDep:='';
//  FVld:='';
  FNewAddr:='';
  Fphoto:=TBitmap.Create;
end;


Initialization
Finalization
  if Assigned(idcardreader) then FreeAndNil(idcardreader);
end.
