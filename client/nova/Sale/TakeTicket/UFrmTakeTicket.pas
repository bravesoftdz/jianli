unit UFrmTakeTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, StdCtrls, ExtCtrls, Buttons, ComCtrls, DB, DBClient,
  jsonClientDataSet;

type
  TFuncCallBack = function(pContext: HWND; pCode: PChar;
    lSize: Longint): integer; stdcall;

  TFrmTakeTicket = class(TBaseForm)
    pnl1: TPanel;
    grpticketinfo: TGroupBox;
    btnprint: TBitBtn;
    lbledtdepartstation: TLabeledEdit;
    lbledtreachstation: TLabeledEdit;
    lbledtschedule: TLabeledEdit;
    lbledtdepartdate: TLabeledEdit;
    lbledttickettype: TLabeledEdit;
    lbledtprice: TLabeledEdit;
    lbledtseatno: TLabeledEdit;
    chkhastaketicket: TCheckBox;
    lbledttaketickettime: TLabeledEdit;
    lbledtticketno: TLabeledEdit;
    grpticketno: TGroupBox;
    lblticketno: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblleaveticketnum: TLabel;
    lbledtselltime: TLabeledEdit;
    lbledtdeparttime: TLabeledEdit;
    bvl1: TBevel;
    tmrleaveticketnum: TTimer;
    tmrRefreshBill: TTimer;
    pgcquery: TPageControl;
    tsscan: TTabSheet;
    pnlview: TPanel;
    tsinput: TTabSheet;
    jcdsResult: TjsonClientDataSet;
    mmo1: TMemo;
    lbledtpassword: TLabeledEdit;
    btnquey: TBitBtn;
    jcdstaketicket: TjsonClientDataSet;
    btnstartscan: TButton;
    tsmultiinput: TTabSheet;
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure btnprintClick(Sender: TObject);
    procedure pgcqueryChange(Sender: TObject);
    procedure btnqueyClick(Sender: TObject);
    procedure lbledtpasswordKeyPress(Sender: TObject; var Key: Char);
    procedure btnstartscanClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    res:integer;//初始化值
    takeway:String;
    ticketnumhituser: integer;
    canprint: boolean; // 能否打印
    procedure refreshBill(silent: boolean = false);
    function initTicketNo(): boolean;
    //查询车票信息
    procedure query(eticketno,epassword:string);
  public
    { Public declarations }
  end;

var
  FrmTakeTicket: TFrmTakeTicket;
  barClass, strBarcode: String;
  DeCount, StopKey: integer;
  function AllInit(): integer; cdecl; external 'BarCat.dll';
  function DeInit(): integer; cdecl; external 'BarCat.dll';
  function SetCallbackFun(funcRecognise: TFuncCallBack; pContext: HWND): integer;
  cdecl; external 'BarCat.dll';
  procedure StartRead(lTimeout: Longint; lMultiResult: Longint;
  hPreviewWnd: HWND); cdecl; external 'BarCat.dll';
  procedure StopRead(); cdecl; external 'BarCat.dll';
  function SaveImage(szFileName: PChar): integer; cdecl; external 'BarCat.dll';

implementation

uses Services, PubFn, FunctionItemIntf;
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
function funcRecognise(pContext: HWND; pCode: PChar; lSize: Longint): integer;
  stdcall;
var
  i, iLen: Longint;
  szResult: PChar;
  newByte: array [0 .. 8] of Byte;
  EnCodeStr, CodeStr, Sqls: string;
begin
  EnCodeStr := '';
  iLen := 9; // 总位数为9位；
  if lSize = -1 then
  begin
     FrmTakeTicket.Mmo1.Lines.Add('扫描超时,请重新开始扫描...');
//     FrmTakeTicket.btn1Click(nil);
//     FrmTakeTicket.tmrstartscan.enabled:=True;
  end
  else if lSize = 0 then
  begin
    if (StopKey=1) then exit;
    CopyMemory(@newByte, pCode, iLen);
    for i := 1 to iLen - 1 do // 从八位处取数据
    begin
      EnCodeStr := EnCodeStr + IntToHex(newByte[i], 2);
    end;
    CodeStr := ZexToDec(EnCodeStr);
    FrmTakeTicket.Mmo1.Lines.Add('电子票号：'+CodeStr);
    FrmTakeTicket.query(CodeStr,'');
//    FrmTakeTicket.btnstartscan(nil);
//    FrmTakeTicket.tmrstartscan.enabled:=True;
  end;
  FrmTakeTicket.btnstartscan.Enabled:=True;
end;

procedure TFrmTakeTicket.btnstartscanClick(Sender: TObject);
begin
   btnstartscan.Enabled:=false;
   Mmo1.Lines.Add('扫描开始...');
   Mmo1.Lines.Add('');
   barClass:='';
   strBarcode:='';
   DeCount:=0;
   StopKey:=0;
   //设置回调
   SetCallbackFun(@funcRecognise,pnlview.Handle);
   //开始扫描
   StartRead(60000*60*24,0,pnlview.Handle);
end;

procedure TFrmTakeTicket.btnprintClick(Sender: TObject);
var
  parameters: TFunctionItemParameters;
begin
  inherited;
  btnprint.Enabled:=false;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount<>1) then
    exit;
  with jcdstaketicket do
  begin
    Active:=false;
    Params.ParamValues['takeway']:=takeway;
    Params.ParamValues['ticketno']:=SysInfo.LoginUserInfo.curBillNo.Items['Ticket'];
//    Params.ParamValues['eticketno']:=jcdsResult.FieldByName('eticketno').AsString;
//    Params.ParamValues['epassword']:=null;
    Params.ParamValues['tsoid']:=jcdsResult.FieldByName('tsoid').AsString;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      grpticketinfo.Enabled:=false;
      //保存到公共变量
      with sysinfo.LoginUserInfo do
      begin
        curBillNo.AddOrSetValue('Ticket',zerofill(IntToStr(strtoint64(curBillNo.Items['Ticket'])+1),
                                                  length(curBillNo.Items['Ticket'])));
        curBillNum.AddOrSetValue('Ticket',curBillNum.Items['Ticket']-1);
      end;
      parameters := TFunctionItemParameters.Create;
      parameters.CommaText := jcdsResult.FieldByName('id').AsString+',false';
      SysFunctionMgr.exec(StringToGUID('{ECFCAF62-D9B1-42E8-A5F7-3395FCD94E0C}'),
        parameters);
    end;
  end;
  if Sender<>nil then
  begin
    btnstartscanClick(nil);
  end;
end;

procedure TFrmTakeTicket.btnqueyClick(Sender: TObject);
begin
  inherited;
  if trim(lbledtpassword.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入电子票验证码！');
    exit;
  end;
  query('',trim(lbledtpassword.Text));
end;

procedure TFrmTakeTicket.FormActivate(Sender: TObject);
begin
  inherited;
  if res=0 then
  begin
    pgcquery.ActivePage:=tsscan;
    btnstartscanClick(nil);
  end
  else
  begin
    pgcquery.ActivePage:=tsinput;
  end;
  pgcqueryChange(nil);
end;

procedure TFrmTakeTicket.FormCreate(Sender: TObject);
//var
//  res:integer;
begin
  inherited;
  FrmTakeTicket:=self;
  mmo1.Clear;
  ticketnumhituser := StrToIntDef(getParametervalue('1013',SysInfo.LoginUserInfo.OrgID), 50);
  canprint := initTicketNo;
  res:=AllInit();
  if res<>0 then
  begin
    Application.MessageBox(PChar('初始化失败！'+chr(13)+'返回值：'+inttostr(res)),'提示信息',MB_OK+MB_ICONWarning);
  end;
end;

procedure TFrmTakeTicket.FormDeactivate(Sender: TObject);
begin
  if res=0 then
  begin
    StopKey:=1;
    StopRead();
    Mmo1.Lines.Add('扫描终止...');
    Mmo1.Lines.Add('');
  end
end;

procedure TFrmTakeTicket.FormDestroy(Sender: TObject);
begin
  inherited;
  DeInit();
end;

procedure TFrmTakeTicket.FormKeyUp(Sender: TObject; var Key: Word;
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
  else if (key=VK_F1) then
  begin
    pgcquery.ActivePage:=tsscan;
    pgcqueryChange(nil);
    if btnstartscan.Enabled then
    begin
      btnstartscanClick(nil);
    end;
  end
  else if (key=VK_F2)then
  begin
    pgcquery.ActivePage:=tsinput;
    pgcqueryChange(nil);
  end
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

function TFrmTakeTicket.initTicketNo: boolean;
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

procedure TFrmTakeTicket.lbledtpasswordKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    btnquey.Click;
  end;
end;

procedure TFrmTakeTicket.pgcqueryChange(Sender: TObject);
begin
  inherited;
  if pgcquery.ActivePage=tsscan then
  begin
    pgcquery.Height:=237;
    if mmo1.CanFocus then
    begin
      mmo1.SetFocus;
    end;
  end
  else if pgcquery.ActivePage=tsinput then

  begin
    pgcquery.Height:=88;
    if lbledtpassword.CanFocus then
    begin
      lbledtpassword.SetFocus;
    end;
  end
  else if pgcquery.ActivePage=tsmultiinput then
  begin
    pgcquery.Height:=88;
    if lbledtpassword.CanFocus then
    begin
      lbledtpassword.SetFocus;
    end;
  end;

end;

procedure TFrmTakeTicket.query(eticketno, epassword: string);
begin
  btnprint.Enabled:=False;
  grpticketinfo.Enabled:=false;
  lbledtdepartstation.Text:='';
  lbledtreachstation.Text:='';
  lbledtschedule.Text:='';
  lbledtdepartdate.Text:='';
  lbledttickettype.Text:='';
  lbledtprice.Text:='';
  lbledtseatno.Text:='';
  chkhastaketicket.Checked:=False;
  lbledttaketickettime.Text:='';
  lbledtticketno.Text:='';
  lbledtselltime.Text:='';
  lbledtdeparttime.Text:='';
  btnprint.Enabled:=false;
  if Trim(eticketno)<>'' then
  begin
    takeway:='0';
  end
  else
  begin
    takeway:='1';
  end;
  with jcdsResult do
  begin
    Active:=false;
    Params.ParamValues['eticketno']:=eticketno;
    Params.ParamValues['epassword']:=epassword;
    try
      Active:=True;
      if RecordCount=0 then
      begin
        SysDialogs.ShowInfo('找不到该电子车票');
      end
      else if RecordCount>1 then
      begin
        SysDialogs.ShowError('系统数据出错，查出多条数据!');
      end
      else
      begin
        grpticketinfo.Enabled:=true;
        lbledtdepartstation.Text:=FieldByName('departstationname').AsString;
        lbledtreachstation.Text:=FieldByName('reachstationname').AsString;
        lbledtschedule.Text:=FieldByName('schedulecode').AsString;
        lbledtdepartdate.Text:=FieldByName('departdate').AsString;
        lbledttickettype.Text:=FieldByName('tickettypename').AsString;
        lbledtprice.Text:=FieldByName('price').AsString;
        lbledtseatno.Text:=FieldByName('seatno').AsString;
        chkhastaketicket.Checked:=FieldByName('istaked').AsBoolean;
        lbledtselltime.Text:=FieldByName('selltime').AsString;
        lbledtdeparttime.Text:=FieldByName('departtime').AsString;
        if chkhastaketicket.Checked then
        begin
          lbledttaketickettime.Text:=FieldByName('taketime').AsString;
          lbledtticketno.Text:=FieldByName('ticketno').AsString;
          SysDialogs.ShowInfo('该电子票已经取票！');
        end
        else
        begin
          btnprint.Enabled:=canprint;
          if SysDialogs.Confirm('提示','请问要取票并打印吗？') then
          begin
            btnprintClick(nil);
          end;
        end;
      end;
    except
      on e:Exception do
        SysDialogs.ShowError(e.Message);
    end;
  end;
  pgcqueryChange(nil);
end;

procedure TFrmTakeTicket.refreshBill(silent: boolean);
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

procedure TFrmTakeTicket.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmTakeTicket.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

end.
