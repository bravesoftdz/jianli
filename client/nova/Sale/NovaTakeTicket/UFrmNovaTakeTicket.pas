unit UFrmNovaTakeTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, StdCtrls, ExtCtrls, Buttons, ComCtrls, DB, DBClient,
  jsonClientDataSet, jpeg, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh,
  UIDCardReader;

type
  TFuncCallBack = function(pContext: HWND; pCode: PChar;
    lSize: Longint): integer; stdcall;
  TQueryBy = (IDCARDNO,ORDERNOANDTEL,PASSWORD,ETICKETNO);
  TFrmNovaTakeTicket = class(TBaseForm,IIDCardfound)
    pnl1: TPanel;
    grpticketinfo: TGroupBox;
    grpticketno: TGroupBox;
    lblticketno: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblleaveticketnum: TLabel;
    tmrleaveticketnum: TTimer;
    tmrRefreshBill: TTimer;
    pgcquery: TPageControl;
    tsscan: TTabSheet;
    pnlidinfo: TPanel;
    tsinput: TTabSheet;
    jcdsResult: TjsonClientDataSet;
    mmo1: TMemo;
    lbledtorderno: TLabeledEdit;
    btnquey: TBitBtn;
    jcdstaketicket: TjsonClientDataSet;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtName: TEdit;
    edtSex: TEdit;
    edtBday: TEdit;
    edtAddr: TEdit;
    edtMZ: TEdit;
    edtID: TEdit;
    edtDep: TEdit;
    edtVld: TEdit;
    edtNewAddr: TEdit;
    pnl2: TPanel;
    img1: TImage;
    tmrreadidcard: TTimer;
    pnl4: TPanel;
    NvDbgridEh1: TNvDbgridEh;
    ds1: TDataSource;
    lbledttelno: TLabeledEdit;
    btnprint: TBitBtn;
    tsidcardinput: TTabSheet;
    lbl12: TLabel;
    edtidcardinput: TEdit;
    btnquerybyidno: TBitBtn;
    tspasswordinput: TTabSheet;
    tstianyacode: TTabSheet;
    lbledtpassword: TLabeledEdit;
    btnquerybypassword: TBitBtn;
    jcds1: TjsonClientDataSet;
    btnstartscan: TButton;
    pnlview: TPanel;
    mmo2: TMemo;
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure btnprintClick(Sender: TObject);
    procedure pgcqueryChange(Sender: TObject);
    procedure btnqueyClick(Sender: TObject);
    procedure lbledtordernoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure ds1DataChange(Sender: TObject; Field: TField);
    procedure edtIDKeyPress(Sender: TObject; var Key: Char);
    procedure btnquerybyidnoClick(Sender: TObject);
    procedure btnquerybypasswordClick(Sender: TObject);
    procedure lbledtpasswordKeyPress(Sender: TObject; var Key: Char);
    procedure btnstartscanClick(Sender: TObject);
  private
    { Private declarations }
    res:integer;//初始化值

    takeway:String;
    ticketnumhituser: integer;
    canprint: boolean; // 能否打印

    curidcard: TIDCard;
    procedure refreshBill(silent: boolean = false);
    function initTicketNo(): boolean;
    //查询车票信息
    procedure query(queryby:TQueryBy;condition:String);overload;
    procedure EmptyEditCV;
    procedure ChangeDateChina( sInput:string; var sOutput:string );
    procedure ChangeDateDot( sInput:string; var sOutput:string );
    function checkticketselect:integer;
  public
    { Public declarations }
    procedure cardfound(idcard:TIDCard);
  end;
    ChA256 = array[0..255] of ansichar;

var
  FrmNovaTakeTicket: TFrmNovaTakeTicket;

//  barClass, strBarcode: String;
//  DeCount, StopKey: integer;
//  function AllInit(): integer; cdecl; external 'BarCat.dll';
//  function DeInit(): integer; cdecl; external 'BarCat.dll';
//  function SetCallbackFun(funcRecognise: TFuncCallBack; pContext: HWND): integer;
//  cdecl; external 'BarCat.dll';
//  procedure StartRead(lTimeout: Longint; lMultiResult: Longint;
//  hPreviewWnd: HWND); cdecl; external 'BarCat.dll';
//  procedure StopRead(); cdecl; external 'BarCat.dll';
//  function SaveImage(szFileName: PChar): integer; cdecl; external 'BarCat.dll';

implementation

uses CVRDLL,Services, PubFn, FunctionItemIntf;

const iPort=1001;

{$R *.dfm}

/// byte转二进制
function ByteToBin(Value: Byte): string;
const
  V: Byte = 1;
var
  i: integer;
begin
  for i := 7 downto 0 do
    if (V shl i) and Value <> 0 then
      Result := Result + '1 '
    else
      Result := Result + '0 ';
end;

function power1(x: int64; n: integer): int64;
var
  i: integer;
  m: int64;
begin
  m := x;
  if n = 0 then
  begin
    Result := 1;
    exit;
  end;

  for i := 1 to n - 1 do
    x := x * m;
  Result := x;
end;

function ZexToDec(Value: string; n: integer = 16): Variant;
var
  i, j: integer;
  V: Variant;
begin
  V := 0;
  if n <= 1 then
    exit;
  for i := Length(Value) downto 1 do
  begin
    if ord(Value[i]) > ord('9') then
      j := ord(Value[i]) - 55
    else
      j := strtoint(Value[i]);

    V := V + j * power1(n, Length(Value) - i);

  end;

  ZexToDec := V;
end;

/// 回调函数
//function funcRecognise(pContext: HWND; pCode: PChar; lSize: Longint): integer;
//  stdcall;
//var
//  i, iLen: Longint;
//  szResult: PChar;
//  newByte: array [0 .. 8] of Byte;
//  EnCodeStr, CodeStr, Sqls: string;
//begin
//  EnCodeStr := '';
//  iLen := 9; // 总位数为9位；
//  if lSize = -1 then
//  begin
//     FrmNovaTakeTicket.Mmo2.Lines.Add('扫描超时,请重新开始扫描...');
//  end
//  else if lSize = 0 then
//  begin
//    if (StopKey=1) then exit;
//    CopyMemory(@newByte, pCode, iLen);
//    for i := 1 to iLen - 1 do // 从八位处取数据
//    begin
//      EnCodeStr := EnCodeStr + IntToHex(newByte[i], 2);
//    end;
//    CodeStr := ZexToDec(EnCodeStr);
//    FrmNovaTakeTicket.Mmo2.Lines.Add('电子票号：'+CodeStr);
//    FrmNovaTakeTicket.query(TQueryby.ETICKETNO,CodeStr);
//  end;
//  FrmNovaTakeTicket.btnstartscan.Enabled:=True;
//end;

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

procedure TFrmNovaTakeTicket.btnprintClick(Sender: TObject);
var
  parameters: TFunctionItemParameters;
begin
  inherited;
  btnprint.Enabled:=false;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount<1) then
    exit;
  jcdsResult.DisableControls;
  try
    jcdsResult.First;
    while not jcdsResult.Eof do
    begin
      if jcdsResult.FieldByName('isselected').AsBoolean then
      begin
        with jcdstaketicket do
        begin
          Active:=false;
          Params.ParamValues['takeway']:=takeway;
          Params.ParamValues['ticketno']:=SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
          Params.ParamValues['tsoid']:=jcdsResult.FieldByName('tsoid').AsString;
          Execute;
          if Params.ParamValues['msg']<>'' then
          begin
            SysDialogs.ShowMessage(Params.ParamValues['msg']);
          end;
          if Params.ParamValues['flag']=1 then
          begin
            jcdsResult.Edit;
            jcdsResult.FieldByName('istaked').AsBoolean:=true;
            jcdsResult.FieldByName('isselected').AsBoolean:=false;
            jcdsResult.FieldByName('taketime').AsDateTime:=Now;
            jcdsResult.Post;
            //保存到公共变量
            with sysinfo.LoginUserInfo do
            begin
              mmo1.Lines.Add('取票成功，票号：'+curBillNo.Items['Ticket']);
              curBillNo.AddOrSetValue('Ticket',zerofill(IntToStr(strtoint64(curBillNo.Items['Ticket'])+1),
                                                        length(curBillNo.Items['Ticket'])));
              curBillNum.AddOrSetValue('Ticket',curBillNum.Items['Ticket']-1);
            end;
            //调用重打
            parameters := TFunctionItemParameters.Create;
            parameters.CommaText := jcdsResult.FieldByName('id').AsString+',false';
            SysFunctionMgr.exec(StringToGUID('{ECFCAF62-D9B1-42E8-A5F7-3395FCD94E0C}'),
              parameters);
          end;
        end;
      end;
      jcdsResult.next;
    end;
  finally
    jcdsResult.EnableControls;
  end;
  if (Sender<>nil) and (res=0) and (pgcquery.ActivePage=tstianyacode) then
  begin
    btnstartscanClick(nil);
  end;
end;

procedure TFrmNovaTakeTicket.btnquerybyidnoClick(Sender: TObject);
begin
  if (Trim(edtidcardinput.Text)<>'') then
  begin
    query(TQueryBy.IDCARDNO,edtidcardinput.Text);
  end;
end;

procedure TFrmNovaTakeTicket.btnquerybypasswordClick(Sender: TObject);
begin
  if trim(lbledtpassword.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入取票验证码！');
    lbledtpassword.SetFocus;
    exit;
  end;
  query(TQueryBy.PASSWORD,lbledtpassword.Text);
end;

procedure TFrmNovaTakeTicket.btnqueyClick(Sender: TObject);
begin
  inherited;
  if trim(lbledtorderno.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入订单号！');
    lbledtorderno.SetFocus;
    exit;
  end;
  if trim(lbledttelno.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入乘车人手机号！');
    lbledttelno.SetFocus;
    exit;
  end;
  query(TQueryBy.ORDERNOANDTEL,trim(lbledtorderno.Text)+','+Trim(lbledttelno.Text));
end;

procedure TFrmNovaTakeTicket.btnstartscanClick(Sender: TObject);
begin
//   btnstartscan.Enabled:=false;
//   Mmo2.Lines.Add('扫描开始...');
//   Mmo2.Lines.Add('');
//   barClass:='';
//   strBarcode:='';
//   DeCount:=0;
//   StopKey:=0;
//   //设置回调
//   SetCallbackFun(@funcRecognise,pnlview.Handle);
//   //开始扫描
//   StartRead(60000*60*24,0,pnlview.Handle);
end;

procedure TFrmNovaTakeTicket.cardfound(idcard: TIDCard);
begin
  curidcard:=idcard;
  try
    if curidcard<>nil then
    begin
      edtName.Text:=curidcard.Name;  //姓名
      edtSex.Text:=curidcard.Sex;
      EdtMZ.Text:= curidcard.MZ;
      EdtBday.Text:=DateToStr(curidcard.Bday);
      EdtAddr.Text:=curidcard.Addr;
      EdtID.Text:=curidcard.ID;
      EdtDep.Text:=curidcard.Dep;
      EdtVld.Text:=DateToStr(curidcard.Vld_S)+'至'+DateToStr(curidcard.Vld_E);
      EdtNewAddr.Text:=curidcard.NewAddr;
      img1.Picture.Assign(curidcard.photo);
      img1.Visible := TRUE;

      windows.Beep(2800,200);
      mmo1.Lines.Add('读身份证资料成功');
      pgcquery.ActivePage:=tsscan;
      self.Update;
      query(TQueryBy.IDCARDNO,edtID.Text);
    end;
  except
//    on e:Exception do
//    SysDialogs.ShowMessage(e.Message);
  end;
end;

procedure TFrmNovaTakeTicket.FormActivate(Sender: TObject);
begin
  inherited;
  if TIDCardReader.idcardreader_ready then
  begin
    if pgcquery.ActivePage<>tsscan then
    begin
      pgcquery.ActivePage:=tsscan;
    end;
    Mmo1.Lines.Add('扫描开始...........');
    Mmo1.Lines.Add('');
  end
  else if (res=0) and tstianyacode.TabVisible then
  begin
    pgcquery.ActivePage:=tstianyacode;
    btnstartscanClick(nil);
  end
  else
  begin
    if pgcquery.ActivePage=tsscan then
    begin
      pgcquery.ActivePage:=tsinput;
    end
    else if pgcquery.ActivePage=tstianyacode then
    begin
      pgcquery.ActivePage:=tspasswordinput;
    end;
  end;
  pgcqueryChange(nil);
end;

procedure TFrmNovaTakeTicket.FormCreate(Sender: TObject);
var ID: Cardinal;
    initret:Integer;
begin
  inherited;
  res:=-1;
  FrmNovaTakeTicket:=self;

  mmo1.Clear;
  ticketnumhituser := StrToIntDef(getParametervalue('1013',SysInfo.LoginUserInfo.OrgID), 50);
  canprint := initTicketNo;
  TIDCardReader.GetInstance.addObserver(Self);

  mmo2.Clear;
  res:=-1;
//  res:=AllInit();
//  if res<>0 then
//  begin
//    Application.MessageBox(PChar('天雅二维码设备初始化失败！'+chr(13)+'返回值：'+inttostr(res)),'提示信息',MB_OK+MB_ICONWarning);
//  end;
tstianyacode.TabVisible:=false;
//tspasswordinput.TabVisible:=False;
end;

procedure TFrmNovaTakeTicket.FormDeactivate(Sender: TObject);
begin
  Mmo1.Lines.Add('扫描终止........');
  Mmo1.Lines.Add('');
//  if res=0 then
//  begin
//    StopKey:=1;
//    StopRead();
//    Mmo2.Lines.Add('扫描终止...');
//    Mmo2.Lines.Add('');
//  end
end;

procedure TFrmNovaTakeTicket.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TIDCardReader.GetInstance.removeObserver(Self);
  except
  end;
//  DeInit();
end;

procedure TFrmNovaTakeTicket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var continueDealKey:Boolean;
    winControl:TWinControl;
    i:integer;
    functionParm: TFunctionItemParameters;
begin
  continueDealKey:=false;
  winControl:=GetParentForm(self).ActiveControl;
  if (Shift<>[]) then
  begin
    continueDealKey:=True;
  end
  else if Key=39  then
  begin
     if pgcquery.ActivePage=tsscan then
     begin
         pgcquery.ActivePage:=tsinput;
         pgcqueryChange(nil);
     end
     else if pgcquery.ActivePage=tsinput then
     begin
          pgcquery.ActivePage:=tsidcardinput;
          pgcqueryChange(nil);
     end
     else if pgcquery.ActivePage=tsidcardinput then
     begin
          pgcquery.ActivePage:=tspasswordinput;
          pgcqueryChange(nil);
     end;
  end
  else if Key=37 then
  begin
     if pgcquery.ActivePage=tspasswordinput then
     begin
          pgcquery.ActivePage:=tsidcardinput;
          pgcqueryChange(nil);
     end
     else if pgcquery.ActivePage=tsidcardinput then
     begin
          pgcquery.ActivePage:=tsinput;
          pgcqueryChange(nil);
     end
     else if pgcquery.ActivePage=tsinput then
     begin
          pgcquery.ActivePage:=tsscan;
          pgcqueryChange(nil);
     end;
  end
  {
  else if (key=VK_F1) then
  begin
    pgcquery.ActivePage:=tsscan;
    pgcqueryChange(nil);
  end
  else if (key=VK_F2)then
  begin
    pgcquery.ActivePage:=tsinput;
    pgcqueryChange(nil);
  end
  else if (key=VK_F3)then
  begin
    pgcquery.ActivePage:=tsidcardinput;
    pgcqueryChange(nil);
  end
  else if (key=VK_F4) and tspasswordinput.TabVisible then
  begin
    pgcquery.ActivePage:=tspasswordinput;
    pgcqueryChange(nil);
  end
  else if (key=VK_F5) and tstianyacode.TabVisible then
  begin
    pgcquery.ActivePage:=tstianyacode;
    pgcqueryChange(nil);
    if btnstartscan.Enabled then
    begin
      btnstartscanClick(nil);
    end;
  end
   }


  else if (key=VK_F12) and btnprint.Enabled then
  begin
    btnprintClick(btnprint);
  end
  else if (key=VK_RETURN) or (Key=VK_ESCAPE) then
  begin
    continueDealKey:=false;
  end
  else
  begin
    continueDealKey:=True;
  end;
  if not continueDealKey then
  begin
    key:=0;
  end;
end;

function TFrmNovaTakeTicket.initTicketNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  Result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
    (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
  if not Result then
  begin
    functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := 'Ticket';
    SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
      functionParm);
    Result := SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') and
      (SysInfo.LoginUserInfo.curBillNum.Items['Ticket'] > 0);
  end;
end;

procedure TFrmNovaTakeTicket.lbledtordernoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    btnquey.Click;
  end;
end;

procedure TFrmNovaTakeTicket.lbledtpasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
    btnquerybypasswordClick(nil);
end;

procedure TFrmNovaTakeTicket.pgcqueryChange(Sender: TObject);
begin
  inherited;
  if pgcquery.ActivePage=tsscan then
  begin
    pgcquery.Height:=220;
    if mmo1.CanFocus then
    begin
      mmo1.SetFocus;
    end;
  end
  else if pgcquery.ActivePage=tstianyacode then
  begin
    pgcquery.Height:=237;
    if mmo2.CanFocus then
    begin
      mmo2.SetFocus;
    end;
  end
  else
  begin
    pgcquery.Height:=88;
    if (pgcquery.ActivePage=tsinput) and lbledtorderno.CanFocus then
      lbledtorderno.SetFocus
    else if (pgcquery.ActivePage=tsidcardinput) and edtidcardinput.CanFocus then
      edtidcardinput.SetFocus
    else if (pgcquery.ActivePage=tspasswordinput) and lbledtpassword.CanFocus then
      lbledtpassword.SetFocus;
  end;
end;

procedure TFrmNovaTakeTicket.query(queryby: TQueryBy; condition: String);
var sl:TStringList;
begin
  with jcdsResult do
  begin
    Active:=false;
    takeway:='1';
    Params.ParamValues['idcardno']:=null;
    Params.ParamValues['orderno']:=null;
    Params.ParamValues['mobilephone']:=null;
    Params.ParamValues['eticketno']:=null;
    Params.ParamValues['epassword']:=null;
    case queryby of
      TQueryBy.IDCARDNO: begin
                           Params.ParamValues['idcardno']:=condition;
                           takeway:='0';
                         end;
      TQueryBy.ORDERNOANDTEL: begin
                                sl:=TStringList.Create;
                                sl.CommaText:=condition;
                                Params.ParamValues['orderno']:=sl.Strings[0];
                                Params.ParamValues['mobilephone']:=sl.Strings[1];
                                FreeAndNil(sl);
                              end;
      TQueryBy.PASSWORD:Params.ParamValues['epassword']:=condition;
      TQueryBy.ETICKETNO:begin
                           Params.ParamValues['eticketno']:=condition;
                           takeway:='0';
                         end;
    end;
    try
      Active:=True;
      if RecordCount=0 then
      begin
        SysDialogs.ShowInfo('找不到电子车票');
        exit;
      end;
      if (checkTicketSelect=1) and btnprint.Enabled then
      begin
        if SysDialogs.Confirm('提示','请问要取票并打印吗？') then
        begin
          btnprintClick(nil);
        end;
      end;
    except
      on e:Exception do
        SysDialogs.ShowError(e.Message);
    end;
  end;
end;

procedure TFrmNovaTakeTicket.refreshBill(silent: boolean);
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('Ticket')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') then
  begin
    lblticketno.Caption := SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
    lblleaveticketnum.Caption := IntToStr
      (SysInfo.LoginUserInfo.curBillNum.Items['Ticket']);
    // 提示用户
    tmrleaveticketnum.Enabled :=
      (ticketnumhituser > SysInfo.LoginUserInfo.curBillNum.Items['Ticket']);
  end
  else
  begin
    tmrleaveticketnum.Enabled := false;
    if not silent then
      SysDialogs.Warning('车票没有初始化，不允许电子票取票！');
    lblticketno.Caption := '0';
    lblleaveticketnum.Caption := '0';
  end;
end;

procedure TFrmNovaTakeTicket.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmNovaTakeTicket.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

procedure TFrmNovaTakeTicket.ChangeDateChina( sInput:string; var sOutput:string );
var
   sYY, sMM, sDD :string;
begin
     //如 19760816
     sYY:=copy(sInput,1,4);
     sMM:=copy(sInput,5,2);
     sDD:=copy(sInput,7,2);
     sOutput:=Format('%s%s%s%s%s%s',[sYY,'年',sMM,'月',sDD,'日']);
end;

procedure TFrmNovaTakeTicket.ChangeDateDot( sInput:string; var sOutput:string );
var
   sYY, sMM, sDD :string;
   sYY2, sMM2, sDD2 :string;
begin
     // 2004070120240701
     sYY:=copy(sInput,1,4);
     sMM:=copy(sInput,5,2);
     sDD:=copy(sInput,7,2);

     sYY2:=copy(sInput,9,4);
     sMM2:=copy(sInput,13,2);
     sDD2:=copy(sInput,15,2);
     sOutput:=Format('%s%s%s%s%s',[sYY,'.',sMM,'.',sDD]);
     sOutput:=sOutput+'-'+Format('%s%s%s%s%s',[sYY2,'.',sMM2,'.',sDD2]);
end;

function TFrmNovaTakeTicket.checkticketselect:integer;
var bk:TBookmark;
begin
  result:=0;
  btnprint.Enabled:=false;
  with jcdsResult do
  begin
    if (not Active) or (RecordCount<=0) then
    begin
      Exit;
    end;
    bk:=GetBookmark;
    DisableControls;
    try
      First;
      while not eof do
      begin
        if FieldByName('isselected').AsBoolean then
        begin
          Inc(result);
        end;
        Next;
      end;
    finally
      GotoBookmark(bk);
      EnableControls;
    end;
  end;
  btnprint.Enabled:=(Result>0) and canprint;
end;

procedure TFrmNovaTakeTicket.ds1DataChange(Sender: TObject; Field: TField);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then exit;
  if (field.FieldName='isselected') then
  begin
    if (field.DataSet.fieldbyname('istaked').AsBoolean)
    then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('isselected').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
    checkTicketSelect;
  end;
end;

procedure TFrmNovaTakeTicket.edtIDKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) then
  begin
    btnquerybyidnoClick(nil);
  end;
end;

procedure TFrmNovaTakeTicket.EmptyEditCV;
begin
    EdtName.Clear;
    EdtSex.Clear;
    EdtMZ.Clear;
    EdtBday.Clear;
    EdtAddr.Clear;
    EdtID.Clear;
    EdtDep.Clear;
    EdtVld.Clear;
    EdtNewAddr.Clear;
    Img1.Visible:=false;
end;

end.
