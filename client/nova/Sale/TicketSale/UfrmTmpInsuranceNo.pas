unit UFrmTmpInsuranceNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls,Services, DB,
  DBClient, jsonClientDataSet,UDMPublic,PubFn, ImgList,generics.Defaults,
  generics.Collections, Sockets,UIDCardReader;

type
  TIntfType=(JJRenShou,GZPinAn);
//打印九江模式保险线程，因为需求等待保险机返回结果，才知道是否要跳号
  TPrintJJInsureThread = class(TThread)
  private
    curJJInsure:TDictionary<String,Boolean>;//当前要打印的保险
    errormsg:String;  //出错信息 用于同步提示
    succInsurestr:string;
    cursellform:TCustomForm;

    polnumber:string; //POS机返回的保单号
    bkserial:String;// 交易流水号,交易后返回,每次都不同
    validateCode:String;//保单验证码

    insureid:Int64; //预保险保险ID

    postresult:boolean; //提交到服务端执行结果

    insuretype,seatno,schedulecode,ticketno,departdate,departtime,customername,idcard:string;
    departstationname,reachstationname:string;

    procedure syncincInsureNo; //用于同步跳号 线程安全
    procedure syncgetprintinsure; //用于同步取出待打印的保险信息
    procedure syncshowerror; //同步显示错误

    procedure JJPreSell;
    procedure JJSellCommit;
    procedure JJSellRollback;

    function gencmdstr(insurancestr:String):string;//组织请求字符串
    function handreturnstr(returnstr:string):Boolean; //校验处理返回字符串
  protected
    procedure Execute; override;
  public
    constructor Create(CreateSuspended: Boolean);
  end;

  TIdCardInfo = class(TPanel)
    private
      Fidcard:TIDCard;
      labseq,labname,labIdno:TLabel;
      nvedtname,nvedtIdno:TNovaEdit;
      procedure setIDCard(avalue:TIDCard);
    public
      constructor Create(AOwner: TComponent;seq:Integer);
      property idcard:TIDCard read Fidcard write setIDCard;
  end;

  TIdCardInfos = class(TPanel)
    private
      Fnum:Integer; //总需要身份证数量
      Fseq:Integer; //当前已获得身份证数量
      idcardinfolist:TList<TIdCardInfo>;
      procedure setNum(avalue:Integer);
      function GetItem(Index: Integer): TIdCardInfo;
    public
      constructor Create(AOwner: TComponent);
      procedure addnewIdCard(_idcard:TIDCard);
      property num:Integer read FNum write setNum;
      property Items[Index: Integer]: TIdCardInfo read GetItem; //default;
  end;

  TFrmTmpInsuranceNo = class(TSimpleEditForm)
    nvedtbillNo: TNovaEdit;
    nvedtBillNoRepeat: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    jcdsGetAllInsuretype: TjsonClientDataSet;
    TcpClient1: TTcpClient;
    jcdsJJPreSell: TjsonClientDataSet;
    jcdsJJSellCommit: TjsonClientDataSet;
    jcdsJJSellRollback: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    JJInsurePrintQueue:TList<TDictionary<TCustomForm,TDictionary<String,Boolean>>>;
    PrintJJInsureThread:TPrintJJInsureThread;
    function initInSurePrinter():boolean;
  public
    { Public declarations }
    function initJJInsure:Boolean; //初始化九江售保险模式
    procedure addInsurePrintToQueue(sellform:TCustomForm;insurePrint:TDictionary<String,Boolean>);
    function getInsureMoneyByDistance(distance:Int64):Currency; //按里程计算保费
    function getInsureTypeCodeByDistance(distance:Int64):String; //按里程取险种编码
  end;


var
  FrmTmpInsuranceNo: TFrmTmpInsuranceNo;
  curJJinsuranceno:string;
  cansellJJinsure:Boolean;//能否售九江模式保险


implementation
uses UFrmSellTicket,NovaPrint;

var
  intftype:TIntfType;
  FinsurePrint:TNovaPrint;

{$R *.dfm}

procedure TFrmTmpInsuranceNo.addInsurePrintToQueue(sellform: TCustomForm;
  insurePrint:TDictionary<String, Boolean>);
var _insurePrint:TDictionary<TCustomForm,TDictionary<String,Boolean>>;
    __insurePrint:TDictionary<String, Boolean>;
    tmpinsurestr:string;
begin
  _insurePrint:=TDictionary<TCustomForm,TDictionary<String,Boolean>>.create;
  __insurePrint:=TDictionary<String, Boolean>.Create;
  for tmpinsurestr in insurePrint.Keys do
  begin
    __insurePrint.Add(tmpinsurestr,insurePrint.Items[tmpinsurestr]);
  end;
  _insurePrint.add(sellform,__insurePrint);
  JJInsurePrintQueue.add(_insurePrint);
end;

function TPrintJJInsureThread.gencmdstr(insurancestr:String): string;
var tmpInsureStr:string;
begin
  if intftype=TIntfType.JJRenShou then
  begin
    result:=curJJinsuranceno+insurancestr;
    exit;
  end
  else if intftype=TIntfType.GZPinAn then
  begin
    tmpInsureStr:=copy(succInsurestr,2);
    ticketno:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    departdate:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);
    departtime:=Copy(departdate,11);
    departdate:=copy(departdate,1,10);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    schedulecode:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    seatno:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    //发到站
    departstationname:=copy(tmpInsureStr,1,pos('-',tmpInsureStr)-1);
    reachstationname:=copy(tmpInsureStr,pos('-',tmpInsureStr)+1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    //险种
    insuretype:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    //投保人姓名

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    //被保人姓名
    customername:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    idcard:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);

//    Params.ParamValues['insuranceno']:=curJJinsuranceno;

    //组织请求字符串
//   #N1;key;报文指令;返回码;返回信息;预留;发车日期;发车时间;业务系统的保单ID;旅客名称;身份证号;#0
    Result:='#N0;2014tdyygkcccqycl;Sell;1;1;;';
    Result:=Result+trim(departdate)+';'+trim(departtime)+';'+inttostr(insureid)+';'+customername+';'+idcard+';#0';
    exit;
  end;
end;

function TPrintJJInsureThread.handreturnstr(returnstr: string): Boolean;
var tmpresultstr:string;
begin
  if intftype=TIntfType.JJRenShou then
  begin
    result:=Pos('ok:',returnstr)>0;
    polnumber:=copy(returnstr,pos(':',returnstr)+1);
  end
  else
  begin
    //处理返回结果
    //接收报文 :  #N1;key;报文指令;返回码;返回信息;预留;业务系统的保单ID;交易流水号;保单号;保单验证码;#0
    //#N1;2014tdyygkcccqycl;Sell;1;生成保单成功. ;;176;1390138206918;12206151900113171193;kQIjbdUDXbsHypVAjy;#0
    tmpresultstr:=returnstr;
    tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
    tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
    tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
    result:=copy(tmpresultstr,1,pos(';',tmpresultstr)-1)='1';
    if result then
    begin
      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      bkserial:=copy(tmpresultstr,1,pos(';',tmpresultstr)-1);// 交易流水号,交易后返回,每次都不同

      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      polnumber:=copy(tmpresultstr,1,pos(';',tmpresultstr)-1); //POS机返回的保单号

      tmpresultstr:=copy(tmpresultstr,pos(';',tmpresultstr)+1);
      validateCode:=copy(tmpresultstr,1,pos(';',tmpresultstr)-1);//保单验证码
    end;
  end;
end;

function TFrmTmpInsuranceNo.getInsureMoneyByDistance(distance: Int64): Currency;
begin
  Result:=0;
  with jcdsGetAllInsuretype do
  begin
    First;
    while not eof do
    begin
      if (distance>=FieldByName('fromdistance').AsLargeInt)
        and (distance<=FieldByName('enddistance').AsLargeInt) then
      begin
        Result:=FieldByName('premium').AsCurrency;
        Break;
      end;
      Next;
    end;
  end;
  if Result=0 then
  begin
    raise Exception.Create('本机构保险险种设置有误,里程'+inttostr(distance)+'没有设置相应的险种!');
  end;
end;

function TFrmTmpInsuranceNo.getInsureTypeCodeByDistance(distance: Int64): String;
begin
  Result:='';
  with jcdsGetAllInsuretype do
  begin
    First;
    while not eof do
    begin
      if (distance>=FieldByName('fromdistance').AsLargeInt)
        and (distance<=FieldByName('enddistance').AsLargeInt) then
      begin
        Result:=FieldByName('insuretypecode').AsString;
        Break;
      end;
      Next;
    end;
  end;
  if Trim(Result)='' then
  begin
    raise Exception.Create('本机构保险险种设置有误,里程'+inttostr(distance)+'没有设置相应的险种!');
  end;
end;

procedure TFrmTmpInsuranceNo.bbtnCloseClick(Sender: TObject);
begin
  inherited;
  self.ModalResult:=mrCancel;
end;

procedure TFrmTmpInsuranceNo.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtbillNo.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入保险单证号');
    nvedtbillNo.SetFocus;
    exit;
  end;
  if trim(nvedtBillNoRepeat.Text)='' then
  begin
    SysDialogs.ShowInfo('请重复输入保险单证号');
    nvedtBillNoRepeat.SetFocus;
    exit;
  end;
  if not SameText(trim(nvedtbillNo.Text),Trim(nvedtBillNoRepeat.Text)) then
  begin
    SysDialogs.ShowError('两次输入的保险单证号不一致');
    nvedtbillNo.SetFocus;
    exit;
  end;
  curJJinsuranceno:=nvedtbillNo.Text;
  if not Assigned(PrintJJInsureThread) then
  begin
    PrintJJInsureThread:=TPrintJJInsureThread.Create(False);
  end;
  self.ModalResult:=mrOk;
end;

procedure TFrmTmpInsuranceNo.FormCreate(Sender: TObject);
begin
  inherited;
  curJJinsuranceno:='';
  cansellJJinsure:=false;
  JJInsurePrintQueue:=TList<TDictionary<TCustomForm,TDictionary<String,Boolean>>>.Create;
end;

procedure TFrmTmpInsuranceNo.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(PrintJJInsureThread) then
  begin
    PrintJJInsureThread.Terminate;
  end;
end;

procedure TFrmTmpInsuranceNo.FormShow(Sender: TObject);
begin
  inherited;
//  if trim(curJJinsuranceno)<>'' then
//  begin
//  end;
  nvedtbillNo.Text:=trim(curJJinsuranceno);
  nvedtBillNoRepeat.Text:=trim(curJJinsuranceno);
end;

function TFrmTmpInsuranceNo.initInSurePrinter: boolean;
begin
  result:=false;
  try
    FinsurePrint:=TNovaPrint.create(Self,TNovaPrint.GetTicketModelName('保险单','Insure1'));
    if FinsurePrint<>nil then
      result:=true
    else
      SysDialogs.Warning('初始化保险单打印模板失败，未知错误，不能售保险');
  except on E: Exception do
    SysDialogs.Warning('初始化保险单打印模板失败：'+e.Message+'，不能售保险');
  end;
end;

function TFrmTmpInsuranceNo.initJJInsure: Boolean;
begin
  if cansellJJinsure then
  begin
    Result:=true;
    exit;
  end;
  Result:=false;
  cansellJJinsure:=false;
  TcpClient1.RemoteHost:='127.0.0.1';
  TcpClient1.RemotePort:='7587';
  TcpClient1.Open;
  if TcpClient1.Connected then
  begin
    //连接上了表示是九江模式
    intftype:=TIntftype.JJRenShou;
  end
  else
  begin
    TcpClient1.RemoteHost:='127.0.0.1';
    TcpClient1.RemotePort:='9898';
    TcpClient1.Open;
    if TcpClient1.Connected then
    begin
      //连接上了表示是九江模式
      intftype:=TIntftype.GZPinAn;
    end
    else
    begin
      exit;
    end;
  end;

  //取险种里程相关数据
  jcdsGetAllInsuretype.Params.ParamValues['filter_EQL_t!orgid']:=SysInfo.LoginUserInfo.OrgID;
  jcdsGetAllInsuretype.Active:=True;
  if jcdsGetAllInsuretype.RecordCount=0 then
  begin
    SysDialogs.Warning('本机构没有设置保险险种,不能售保险');
    exit;
  end;

  if not initInSurePrinter() then
  begin
    exit;
  end;

  if (Trim(curJJinsuranceno)='') and (StrToInt64Def(Trim(curJJinsuranceno),0)<=0) then
  begin
    //让用户输入当前的保险凭证号
    SysMainForm.showFormModal(FrmTmpInsuranceNo,False);
  end;
  if (Trim(curJJinsuranceno)<>'') and (StrToInt64Def(Trim(curJJinsuranceno),0)>0) then
  begin
    Result:=True;
    cansellJJinsure:=true;
  end;
end;

{ TPrintJJInsureThread }

constructor TPrintJJInsureThread.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);
end;

procedure TPrintJJInsureThread.Execute;
var tmpstring:string;
    invokeresult:string;
    _curJJInsure:TDictionary<String,Boolean>;
begin
  inherited;
  while not Terminated do
  begin
    //同步方法从lastJJInsure取出要打印的保险
    Synchronize(syncgetprintinsure);
    if (curJJInsure=nil) or (curJJInsure.Count=0) then
    begin
      Sleep(100);
      Continue;
    end;

    _curJJInsure:=curJJInsure;
    //售保险
    for tmpstring in _curJJInsure.Keys do
    begin
      if not _curJJInsure.Items[tmpstring] then
      begin
        succInsurestr:=tmpstring;
        //循环发送socket指定  判断调用结果来跳号
        FrmTmpInsuranceNo.TcpClient1.Close;
        FrmTmpInsuranceNo.TcpClient1.Open;
        if not FrmTmpInsuranceNo.TcpClient1.Connected then
        begin
          errormsg:='售保险出错："无法连接保险服务程序"。请退保险费或重打保险';
          Synchronize(syncshowerror);
          Break;
        end;
        synchronize(JJPreSell);
        if not postresult then
        begin
          Synchronize(syncshowerror);
          break;
        end;

        FrmTmpInsuranceNo.TcpClient1.Sendln(gencmdstr(tmpstring));
//        FrmTmpInsuranceNo.TcpClient1.WaitForData(2000);
        invokeresult:=FrmTmpInsuranceNo.TcpClient1.Receiveln();

        //error:保存失败,程序异常,请查看pos连接是否正常
        //ok:8888361000000309
        //判断调用结果来跳号
        if handreturnstr(invokeresult) then
        begin
          synchronize(JJSellCommit);
          //跳号
          Synchronize(syncincInsureNo);
        end
        else
        begin
          synchronize(JJSellRollback);
          errormsg:='售保险出错："'+invokeresult+'"。请退保险费或重打保险';
          Synchronize(syncshowerror);
          Break;
        end;
      end;
    end;
  end;
end;

procedure TPrintJJInsureThread.JJPreSell;
var tmpInsureStr:string;
begin
  postresult:=false;
  errormsg:='';
  with FrmTmpInsuranceNo.jcdsJJPreSell do
  begin
    close;
    tmpInsureStr:=copy(succInsurestr,2);
    Params.ParamValues['ticketno']:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    Params.ParamValues['insuretypecode']:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    Params.ParamValues['customername']:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);
    tmpInsureStr:=copy(tmpInsureStr,pos('|',tmpInsureStr)+1);
    Params.ParamValues['certificateno']:=copy(tmpInsureStr,1,pos('|',tmpInsureStr)-1);
    Params.ParamValues['insuranceno']:=curJJinsuranceno;
    try
      Execute;
      if Params.ParamValues['flag']=1 then
      begin
        postresult:=true;
        //保存预存的ID值
        insureid:=Params.ParamValues['insureid'];
      end
      else
      begin
        if (Params.ParamValues['msg']=null) or (trim(Params.ParamValues['msg'])='') then
          errormsg:='数据库预售保险失败，未知错误!'
        else
          errormsg:=Params.ParamValues['msg'];
      end;
    except
      on E: Exception do
        errormsg:='数据库预售保险失败，'+e.Message;
    end;
  end;
end;

procedure TPrintJJInsureThread.JJSellCommit;
begin
  postresult:=false;
  errormsg:='';
  with FrmTmpInsuranceNo.jcdsJJSellCommit do
  begin
    close;
    Params.ParamValues['insuranceno']:=curJJinsuranceno;
    Params.ParamValues['polnumber']:=polnumber;
    //传入流水号、校验码
    Params.ParamValues['bkserial']:=bkserial;
    Params.ParamValues['validateCode']:=validateCode;
    try
      Execute;
      if Params.ParamValues['flag']=1 then
      begin
        postresult:=true;
      end
      else
      begin
        if (Params.ParamValues['msg']=null) or (trim(Params.ParamValues['msg'])='') then
          errormsg:='数据库确认售保险失败，未知错误!'
        else
          errormsg:=Params.ParamValues['msg'];
      end;
    except
      on E: Exception do
        errormsg:='数据库确认售保险失败，'+e.Message;
    end;
  end;
end;

procedure TPrintJJInsureThread.JJSellRollback;
begin
  postresult:=false;
  errormsg:='';
  with FrmTmpInsuranceNo.jcdsJJSellRollback do
  begin
    close;
    Params.ParamValues['insuranceno']:=curJJinsuranceno;
    try
      Execute;
      if Params.ParamValues['flag']=1 then
      begin
        postresult:=true;
      end
      else
      begin
        if (Params.ParamValues['msg']=null) or (trim(Params.ParamValues['msg'])='') then
          errormsg:='数据库回滚售保险失败，未知错误!'
        else
          errormsg:=Params.ParamValues['msg'];
      end;
    except
      on E: Exception do
        errormsg:='数据库回滚售保险失败，'+e.Message;
    end;
  end;
end;

procedure TPrintJJInsureThread.syncgetprintinsure;
var firstPrint:TDictionary<TCustomForm,TDictionary<String,Boolean>>;
    tmpform:TCustomForm;
begin
  if FrmTmpInsuranceNo.JJInsurePrintQueue.Count=0 then
  begin
    curJJInsure:=nil;
  end
  else
  begin
    firstPrint:=FrmTmpInsuranceNo.JJInsurePrintQueue.Items[0];
    for tmpform in firstPrint.Keys do
    begin
      cursellform:=tmpform;
      curJJInsure:=firstPrint.Items[cursellform];
    end;
  end;
end;

procedure TPrintJJInsureThread.syncincInsureNo;
var firstprint:TDictionary<TCustomForm,TDictionary<String,Boolean>>;
    tmpInsureStr:string;
    printfinsh:boolean;
begin
  printfinsh:=true;
  firstprint:=FrmTmpInsuranceNo.JJInsurePrintQueue.Items[0];
  firstprint.Items[cursellform].Items[succInsurestr]:=True;
  //同时更新form中的
  if TFrmSellTicket(cursellform).lastJJInsure.ContainsKey(succInsurestr) then
  begin
    TFrmSellTicket(cursellform).lastJJInsure.Items[succInsurestr]:=True;
  end;
  for tmpInsureStr in firstprint.Items[cursellform].Keys do
  begin
    if not firstprint.Items[cursellform].Items[tmpInsureStr] then
    begin
      printfinsh:=false;
      Break;
    end;
  end;
  if printfinsh then
  begin
    //打印完成后从打印列表删除
    FrmTmpInsuranceNo.JJInsurePrintQueue.Remove(firstprint);
    curJJInsure:=nil;
    if intftype=TIntfType.GZPinAn then
    begin
      with FinsurePrint.SingleValue do
      begin
        AddOrSetValue('certificatetypename','身份证');
        AddOrSetValue('selltime',DateTimeToStr(Now));
        AddOrSetValue('ticketoutletsname', SysInfo.LoginUserInfo.ticketoutletsname);

        //insuretype,seatno,schedulecode,,,departtime,
        AddOrSetValue('certificateno', idcard);
        AddOrSetValue('customername', customername);
        AddOrSetValue('familyaddress', '');
        AddOrSetValue('familyphone', '');
        AddOrSetValue('mobilephone', '');
        AddOrSetValue('insuranceno', curJJinsuranceno);

        AddOrSetValue('departdate', departdate);
        AddOrSetValue('schedulecode', schedulecode);
        AddOrSetValue('departstationname', departstationname);
        AddOrSetValue('reachstationname', reachstationname);
        AddOrSetValue('reachstationsecondname', '');
        AddOrSetValue('tickettypeprintname','');
        AddOrSetValue('ticketno', ticketno);
        AddOrSetValue('carrychildnum', '');
        AddOrSetValue('premium', '2');
        AddOrSetValue('insureamount', '');

        AddOrSetValue('islinework', '');
        AddOrSetValue('seatno', seatno);
        AddOrSetValue('departtime', departtime);

        AddOrSetValue('sellbycode', SysInfo.LoginUserInfo.UserCode);
        AddOrSetValue('sellbyname', SysInfo.LoginUserInfo.UserName);
        AddOrSetValue('polnumber', polnumber);

        FinsurePrint.Print;
      end;
    end;
    curJJinsuranceno:=PubFn.zerofill(IntToStr(StrToInt64(curJJinsuranceno)+1),Length(curJJinsuranceno));
  end;
end;

procedure TPrintJJInsureThread.syncshowerror;
begin
  TFrmSellTicket(cursellform).btnprintinsure.Visible:=True;
  //出错时从打印队列删除
  FrmTmpInsuranceNo.JJInsurePrintQueue.Remove(FrmTmpInsuranceNo.JJInsurePrintQueue.Items[0]);
  curJJInsure:=nil;
  SysDialogs.Warning(errormsg);
end;

{ TIdCardInfo }

constructor TIdCardInfo.Create(AOwner: TComponent;seq:Integer);
begin
  inherited Create(AOwner);
  labseq:=TLabel.Create(Self);
  labseq.Parent:=self;
  labseq.Caption:=IntToStr(seq)+'、';
  labseq.Width:=20;
  labseq.Font.Style:=[fsBold];
//  labseq.Align:=alLeft;
  labseq.Left:=0;
  labname:=TLabel.Create(Self);
  labname.Parent:=self;
  labname.Caption:='姓名';
  labname.Width:=40;
//  labname.Align:=alLeft;
  labname.Left:=labseq.Left+labseq.Width;
  nvedtname:=TNovaEdit.Create(self);
  nvedtname.Parent:=Self;
  nvedtname.Width:=60;
//  nvedtname.Align:=alLeft;
  nvedtname.Left:=labname.Left+labname.Width;
  labIdno:=TLabel.Create(Self);
  labIdno.Parent:=self;
  labIdno.Caption:='身份证号';
  labIdno.Width:=60;
//  labIdno.Align:=alLeft;
  labIdno.Left:=nvedtname.Left+nvedtname.Width;
  nvedtIdno:=TNovaEdit.Create(self);
  nvedtIdno.Parent:=self;
  nvedtIdno.Width:=180;
//  nvedtIdno.Align:=alLeft;
  nvedtIdno.Left:=labIdno.Left+labIdno.Width;
  self.Parent:=TWinControl(AOwner);
  self.Width:=labseq.Width+labname.Width+nvedtname.Width+labIdno.Width+nvedtIdno.Width+self.BevelWidth*2; //nvedtIdno.Left+nvedtIdno.Width;
  self.Height:=30;
  self.Top:=self.Parent.Height;
  Align:=alTop;
end;

procedure TIdCardInfo.setIDCard(avalue: TIDCard);
begin
  Fidcard:=avalue;
  nvedtname.Text:=Fidcard.Name;
  nvedtIdno.Text:=Fidcard.ID;
  self.Update;
end;

{ TIdCardInfos }

procedure TIdCardInfos.addnewIdCard(_idcard: TIDCard);
var nextseq:integer;
begin
  if Fnum<=0 then exit;
  idcardinfolist.Items[(Fseq mod Fnum)].idcard:=_idcard;
  Inc(Fseq);
end;

constructor TIdCardInfos.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Fnum:=0;
  Fseq:=0;
  idcardinfolist:=TList<TIdCardInfo>.create;
  Margins.Left := 2;
  Margins.Top := 2;
  Margins.Right := 2;
  Margins.Bottom := 2;
  BevelInner := bvRaised;
  BevelKind := bkSoft;
  BevelOuter := bvLowered;
  BevelWidth := 3;
  Visible := False;
  Width:=380;
  self.Parent:=TWinControl(AOwner);
  self.Height:=0;
  TabStop:=false;
  self.Enabled:=false;
end;

function TIdCardInfos.GetItem(Index: Integer): TIdCardInfo;
begin
  result:=idcardinfolist.Items[Index];
end;

procedure TIdCardInfos.setNum(avalue: Integer);
var thedeleteIdCardInfo:TIdCardInfo;
begin
  while avalue<Fnum do
  begin
    thedeleteIdCardInfo:=idcardinfolist.Items[idcardinfolist.Count-1];
    idcardinfolist.Remove(thedeleteIdCardInfo);
    self.RemoveControl(thedeleteIdCardInfo);
    FreeAndNil(thedeleteIdCardInfo);
    Dec(Fnum);
  end;
  while avalue>Fnum do
  begin
    if Fnum>0 then
    begin
      self.Height:=Fnum*(idcardinfolist.Items[0].Height+idcardinfolist.Items[0].BevelWidth*2);
    end
    else
    begin
      self.Height:=0;
    end;
    idcardinfolist.Add(TIdCardInfo.Create(Self,Fnum+1));
    inc(Fnum);
  end;
  if Fnum>0 then
  begin
    self.Height:=Fnum*(idcardinfolist.Items[0].Height)+self.BevelWidth*6;
//    self.Width:=idcardinfolist.Items[0].Width+self.BevelWidth*4;
    self.Update;
  end
  else if Fnum=0 then
  begin
    self.Visible:=false;
  end;
end;

end.
