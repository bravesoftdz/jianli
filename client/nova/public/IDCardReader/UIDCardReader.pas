unit UIDCardReader;

interface

uses Windows,SysUtils, Classes, Generics.Defaults,Generics.Collections,Forms,ExtCtrls,
     Graphics;

type
  //身份证信息
  TIDCard = class(TObject)
  private
    FName:String;//民族
    FSex:String;//性别
    FMZ:String;//民族
    FBday:TDate;//生日
    FAddr:String;//住址
    FID:String;//身份证号
    FDep:String;//签发机关
    FVld_S:TDate;//有效期限_开始
    FVld_E:TDate;//有效期限_截至
    FNewAddr:String;//最新住址
    Fphoto: TBitmap;//照片
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
  //身份证读卡设备类
  TIDCardReader= class
  private
    FNotifies:TDictionary<IIDCardfound,Boolean>;
    timerSearchCard: TTimer; // 定时器

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
  idcardreader:TIDCardReader = nil;//IC卡设备对象
const iPort=1001;
//1	串口1
//2	串口2
//3	串口3
//4	串口4
//1001	USB口1
//1002	USB口2
//1003	USB口3
//1004	USB口4

function getpeoplename(peoplecode:string):string;
begin
  case StrToIntDef(peoplecode,-1) of
    01:result:='汉';
    02:result:='蒙古';
    03:result:='回';
    04:result:='藏';
    05:result:='维吾尔';
    06:result:='苗';
    07:result:='彝';
    08:result:='壮';
    09:result:='布依';
    10:result:='朝鲜';
    11:result:='满';
    12:result:='侗';
    13:result:='瑶';
    14:result:='白';
    15:result:='土家';
    16:result:='哈尼';
    17:result:='哈萨克';
    18:result:='傣';
    19:result:='黎';
    20:result:='傈僳';
    21:result:='佤';
    22:result:='畲';
    23:result:='高山';
    24:result:='拉祜';
    25:result:='水';
    26:result:='东乡';
    27:result:='纳西';
    28:result:='景颇';
    29:result:='柯尔克孜';
    30:result:='土';
    31:result:='达斡尔';
    32:result:='仫佬';
    33:result:='羌';
    34:result:='布朗';
    35:result:='撒拉';
    36:result:='毛南';
    37:result:='仡佬';
    38:result:='锡伯';
    39:result:='阿昌';
    40:result:='普米';
    41:result:='塔吉克';
    42:result:='怒';
    43:result:='乌孜别克';
    44:result:='俄罗斯';
    45:result:='鄂温克';
    46:result:='德昂';
    47:result:='保安';
    48:result:='裕固';
    49:result:='京';
    50:result:='塔塔尔';
    51:result:='独龙';
    52:result:='鄂伦春';
    53:result:='赫哲';
    54:result:='门巴';
    55:result:='珞巴';
    56:result:='基诺';
    97:result:='其他';
    98:result:='外国血统中国籍人士';
  else
    result:='未知';
  end;
end;

{ TCardRWDevice }

procedure TIDCardReader.addObserver(cardfound: IIDCardfound;hintWhenCantCon:boolean=True;notifyOnlyOnActivate:Boolean=True);
var ID: Cardinal;
    initret:Integer;
begin
  if not (cardfound is TCustomForm) then
  begin
    raise Exception.Create('身份证读卡观察者必须是TCustomForm子类');
  end;
  if not idcardreader.idcardreader_ready  then
  begin
    initret:=CVR_InitComm(iPort);
    idcardreader.idcardreader_ready:=initret=1;
    if not idcardreader.idcardreader_ready  then
    begin
      if hintWhenCantCon then
      begin
        Application.MessageBox('连接身份证读卡器失败,请连接好后,重新打开本模块！','提示');
      end;
      CVR_CloseComm();
      idcardreader:=nil;
      exit;
    end
    else
    begin
      GetManuID(@ID);
  //      mmo1.Lines.Add('读卡器初始化成功,ID:'+inttostr(ID)+'。请放卡。');
      idcardreader.timerSearchCard.Enabled:=True;
    end;
  end;
  FNotifies.AddOrSetValue(cardfound,notifyOnlyOnActivate);
end;

procedure TIDCardReader.FreeInstance;
begin
  inherited;
  //关闭串口
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
    //判断是否需要读卡
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
        idcard.FName:=Trim(copy(sWZ,1,15));  //姓名
        delete(sWZ,1,15);
      except
        idcard.FName:='旅客';
      end;
      try
      if (copy(sWZ,1,1)='1') then     //性别
        idcard.FSex:='男'
      else
        idcard.FSex:='女';
      delete(sWZ,1,1);
      except
        idcard.FSex:='男'
      end;
      try
        //民族
        sDisp:='';
        sDisp:=copy(sWZ,1,2);
        idcard.FMZ:= getpeoplename(sDisp);
        delete(sWZ,1,2);
      except
        idcard.FMZ:='未知' ;
      end;
      try
        //生日
        idcard.FBday:=_strtodate(copy(sWZ,1,8));
        delete(sWZ,1,8);
      except
        idcard.FBday:=_strtodate('19801010') ;
      end;
      try
        //住址
        idcard.FAddr:=Trim(copy(sWZ,1,35));
        delete(sWZ,1,35);
      except
        idcard.FAddr:='' ;
      end;
      try
      //身份证号
        idcard.FID:=Trim(copy(sWZ,1,18));
        delete(sWZ,1,18);
      except
        idcard.FID:='360735199102020012' ;
      end;
//      Application.MessageBox(PWideChar(swz),'tt');
      //签发机关
      try
        idcard.FDep:=Trim(copy(sWZ,1,15));
        sDisp:='';
        delete(sWZ,1,15);
      except
        idcard.FDep:='360735199102020012' ;
      end;
      //有效期限
      try
        idcard.FVld_S:=_strtodate(copy(sWZ,1,8));
        delete(sWZ,1,8);
        if((trim(sWZ))='长期') then
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
        //idcard.FVld_E:='长期' ;
      end;

      try
        //最新住址
        idcard.FNewAddr:=Trim(copy(sWZ,1,35));

        //照片
        idcard.Fphoto.LoadFromFile(ExtractFilePath(Application.ExeName) +'zp.bmp');
      except
        //
      end;


//      windows.Beep(2800,200);
//       mmo1.Lines.Add('读身份证资料成功');

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
  //如 19760816
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
