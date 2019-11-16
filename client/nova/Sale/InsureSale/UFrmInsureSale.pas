unit UFrmInsureSale;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit,services,PubFn,StrUtils,UDMPublic,
  NovaPrint,FunctionItemIntf;

type
  TFrmInsureSale = class(TSimpleCRUDForm)
    pnlleft: TPanel;
    rbticketno: TRadioButton;
    rbschedule: TRadioButton;
    pnlinput: TPanel;
    pnlticketno: TPanel;
    pnlschedule: TPanel;
    nvedtticketnos: TNovaEdit;
    dtpdepartdate: TDateTimePicker;
    nvhelpschedule: TNovaHelp;
    nvedtseatno: TNovaEdit;
    lblschedule: TLabel;
    lblseatno: TLabel;
    gbinsureno: TGroupBox;
    lblinsureno: TLabel;
    lbl7: TLabel;
    lblleaveinsurenum: TLabel;
    lbl12: TLabel;
    tmrleaveinsurenum: TTimer;
    tmrRefreshBill: TTimer;
    procedure rbticketnoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure nvedtticketnosKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveinsurenumTimer(Sender: TObject);
    procedure nvhelpscheduleKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure dbgrdhResultKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
//    FcdsDDDschedulestatus:TjsonClientDataSet;    //班次状态
    FcdsDDDseattype:TjsonClientDataSet;      //票价座位类型
    FcdsDDDpaymethod:TjsonClientDataSet;  //支付方式
    FcdsDDDsellway:TjsonClientDataSet;  //售票方式
    FcdsDDDticketstatus:TjsonClientDataSet;  //车票状态
    FcdsTicketType:TjsonClientDataSet;  //票种

    FinsurePrint:TNovaPrint;
    cdsInsureBuffer:TjsonClientDataSet;
    FcdsDDDCertificatetype:TjsonClientDataSet;  //证件类型
    Fcdsinsuretype:TjsonClientDataSet;  //保险类型
    Fcdsinsuretypeitem: TjsonClientDataSet;//保险类型区间

    ticketnumhituser:integer;

    needCustomerOnSellinsure:Boolean; //售保险是否弹出顾客信息录入框（不需要时默认顾客ID为0）
    setDefaultCustomerOnSellinsure:Boolean; //售保险是否默认填写顾客信息（默认顾客ID为0）

    function initInsureType: Boolean;
    function initInsureTypeitem: Boolean;
    function initTicketType: Boolean;
    procedure initjcdsResult;
    function initInsureNo: boolean;
    function initInsurePrinter: boolean;
    procedure refreshBill(silent:boolean=false);
    function createCdsInsureBuffer(AOwner:TComponent): TjsonClientDataSet;
    function setBillNoCondition(billnoEdit:TNovaEdit):boolean;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmInsureSale: TFrmInsureSale;

implementation

uses UFrmInsureSaleend;
const maxticketnum = 50;
      defaultCustomerID=1;

{$R *.dfm}

procedure TFrmInsureSale.FormShow(Sender: TObject);
begin
  inherited;
  rbticketno.Checked:=true;
end;

procedure TFrmInsureSale.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{623665BB-3104-4D29-9212-34BAB334931E}' then //售保险
  begin
    tbtnInsert.Enabled:=aEnable;
  end;
end;

function TFrmInsureSale.initInsureNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  Result:=SysInfo.LoginUserInfo.curBillNum.ContainsKey('Insure') and (SysInfo.LoginUserInfo.curBillNum.Items['Insure']>0);
  if not result then
  begin
    functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := 'Insure';
    SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),functionParm);
    Result:=SysInfo.LoginUserInfo.curBillNum.ContainsKey('Insure') and (SysInfo.LoginUserInfo.curBillNum.Items['Insure']>0);
  end;
end;

function TFrmInsureSale.initInsurePrinter: boolean;
begin
  result:=false;
  try
    FinsurePrint:=TNovaPrint.create(Self,TNovaPrint.GetTicketModelName('保险单','Insure1'));
    if FinsurePrint<>nil then
      result:=true
    else
      SysDialogs.ShowError('初始化保险单打印模板失败，未知错误');
  except on E: Exception do
    SysDialogs.ShowError('初始化保险单打印模板失败：'+e.Message);
  end;
end;

procedure TFrmInsureSale.initjcdsResult;
var i:integer;
begin
  with jcdsResult do
  begin
    i:=-1;
    createField('isselfschedule', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('reachstationsecondname', '', ftWideString,100, incEx(i), jcdsResult) ;
    createField('distance', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('carrychildnum', '', ftInteger,0, incEx(i), jcdsResult) ;

    createField('isselected', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('id', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('scheduleplanid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('orgid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('sellby', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('departstationid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('reachstationid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('scheduleid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('insuranceid', '', ftLargeint,0, incEx(i), jcdsResult) ;

    createField('seatno', '', ftInteger,0, incEx(i), jcdsResult) ;

    createField('ischecked', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('isdepartinvoices', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('islinework', '', ftBoolean,0, incEx(i), jcdsResult) ;

    createField('selltime', '', ftDateTime,0, incEx(i), jcdsResult) ;
    createField('departdate', '', ftDate,0, incEx(i), jcdsResult) ;

    createField('premium', '', ftFloat,0, incEx(i), jcdsResult) ;
    createField('fullprice', '', ftFloat,0, incEx(i), jcdsResult) ;
    createField('price', '', ftFloat,0, incEx(i), jcdsResult) ;
    createField('servicefee', '', ftFloat,0, incEx(i), jcdsResult) ;

    createField('departtime', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('paymethod', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('ticketno', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('sellway', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('ticketstatus', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('tickettype', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('seattype', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('insurancepaymethod', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('insuranceno', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('schedulecode', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('customername', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('departstationname', '', ftWideString,10, incEx(i), jcdsResult) ;
    createField('reachstationname', '', ftWideString,10, incEx(i), jcdsResult) ;

    createLookupField('tickettypeprintname','','tickettype','code','printname',ftWideString,50,incEx(i),jcdsResult,FcdsTicketType);
    createLookupField('paymethodname','','paymethod','code','value',ftWideString,50,incEx(i),jcdsResult,FcdsDDDpaymethod);
    createLookupField('insurancepaymethodname','','insurancepaymethod','code','value',ftWideString,50,incEx(i),jcdsResult,FcdsDDDpaymethod);
    createLookupField('sellwayname','','sellway','code','value',ftWideString,50,incEx(i),jcdsResult,FcdsDDDsellway);
    createLookupField('ticketstatusname','','ticketstatus','code','value',ftWideString,50,incEx(i),jcdsResult,FcdsDDDticketstatus);

  end;
end;

function TFrmInsureSale.initTicketType: Boolean;
begin
  result:=false;
  if not Assigned(FcdsTicketType) then
  begin
    FcdsTicketType:=TjsonClientDataSet.Create(self);
    with FcdsTicketType do
    begin
      QueryAddress:='base/findTickettypeByPermission';
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='tickettypemap';
      Params.CreateParam(ftString,'userid',ptInput);
//      Params.CreateParam(ftString,'roleid',ptInput);
      Params.CreateParam(ftString,'ticketoutletsid',ptInput);
    end;
  end;
  with FcdsTicketType do
  begin
    active:=false;
    Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
//    Params.ParamValues['roleid']:=SysInfo.LoginUserInfo.RoleID;
    Params.ParamValues['ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
    Active:=True;
    result:=RecordCount>0;
  end;
end;

procedure TFrmInsureSale.dbgrdhResultKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (tbtnInsert.Visible) and (tbtnInsert.Enabled) then
  begin
    tbtnInsertClick(Sender);
    Key := 0;
  end;
end;

procedure TFrmInsureSale.dsResultDataChange(Sender: TObject; Field: TField);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then exit;
  if (field.FieldName='isselected') then
  begin
    if (field.DataSet.FieldByName('ticketstatus').AsString<>'0') or (not field.DataSet.FieldByName('insuranceid').IsNull) then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('isselected').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
  end;
end;

procedure TFrmInsureSale.FormActivate(Sender: TObject);
begin
  inherited;
  if rbticketno.Checked then
  begin
    rbticketnoClick(rbticketno);
  end
  else if rbschedule.Checked then
  begin
    rbticketnoClick(rbschedule);
  end
  else
  begin
    rbticketno.Checked:=true;
  end;
end;

procedure TFrmInsureSale.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  ticketnumhituser:=StrToIntDef(getParametervalue('1013',SysInfo.LoginUserInfo.OrgID),50);
  dtpdepartdate.Date:=date();
  FcdsDDDseattype:=createCdsDDD('handprice','seattype',self);      //票价座位类型
  FcdsDDDpaymethod:=createCdsDDD('ticketsell','paymethod',self);      //支付方式
  FcdsDDDsellway:=createCdsDDD('ticketsell','sellway',self);  //售票方式
  FcdsDDDticketstatus:=createCdsDDD('ticketsell','ticketstatus',self);  //车票状态
  FcdsDDDCertificatetype:=createCdsDDD('customer','certificatetype',self); //证件类型
  initInsureType;
  initInsureTypeitem;
  initTicketType;
  initjcdsResult;
  tbtnInsert.Enabled:=initInsureNo and initInsurePrinter;
  refreshBill;
  cdsInsureBuffer:=createCdsInsureBuffer(self);
  tmrRefreshBill.Enabled:=True;
  needCustomerOnSellinsure:=getParametervalue('1043',SysInfo.LoginUserInfo.OrgID)='1';
  setDefaultCustomerOnSellinsure:=getParametervalue('1044',SysInfo.LoginUserInfo.OrgID)='1';
end;

function TFrmInsureSale.initInsureType: Boolean;
begin
  result:=false;
  if not Assigned(Fcdsinsuretype) then
  begin
    Fcdsinsuretype:=TjsonClientDataSet.Create(self);
    with Fcdsinsuretype do
    begin
      QueryAddress:='base/qryinsuretype';
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='insuretypemap';
//      Params.CreateParam(ftString,'userid',ptInput);
    end;
  end;
  with Fcdsinsuretype do
  begin
    active:=false;
//    Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
    Active:=True;
    result:=RecordCount>0;
  end;
end;

function TFrmInsureSale.initInsureTypeitem: Boolean;
begin
  result:=false;
  if not Assigned(Fcdsinsuretypeitem) then
  begin
    Fcdsinsuretypeitem:=TjsonClientDataSet.Create(self);
    with Fcdsinsuretypeitem do
    begin
      QueryAddress:='base/queryInsuretype';
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='insuretypemap';
//      Params.CreateParam(ftString,'userid',ptInput);
    end;
  end;
  with Fcdsinsuretypeitem do
  begin
    active:=false;
//    Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
    Active:=True;
    result:=RecordCount>0;
  end;
end;

procedure TFrmInsureSale.nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmInsureSale.nvedtticketnosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilter.Click;
  end;
  if (not (key in ['0'..'9','-',',',#8,#1,#3,#$16,#$18])) then
  begin
    key:=#0;
  end;
end;

procedure TFrmInsureSale.nvhelpscheduleKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmInsureSale.rbticketnoClick(Sender: TObject);
begin
  inherited;
  if Sender = rbticketno then
  begin
    pnlticketno.Enabled:=true;
    nvedtticketnos.SetFocus;
    pnlschedule.Enabled:=false;
  end
  else if Sender = rbschedule then
  begin
    pnlschedule.Enabled:=true;
    dtpdepartdate.SetFocus;
    pnlticketno.Enabled:=false;
  end;
end;

procedure TFrmInsureSale.refreshBill(silent:boolean);
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('Insure')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('Insure') then
  begin
    lblinsureno.Caption:=SysInfo.LoginUserInfo.curBillNo.Items['Insure'];
    lblleaveinsurenum.Caption:=IntToStr(SysInfo.LoginUserInfo.curBillNum.Items['Insure']);
    //提示用户
    tmrleaveinsurenum.Enabled:=(ticketnumhituser>SysInfo.LoginUserInfo.curBillNum.Items['Insure']);
  end
  else
  begin
    tmrleaveinsurenum.Enabled:=false;
    if not silent then
      SysDialogs.ShowError('保险单没有初始化，不允许售保险！');
    lblinsureno.Caption:='0';
    lblleaveinsurenum.Caption:='0';
  end;
end;

function TFrmInsureSale.setBillNoCondition(billnoEdit: TNovaEdit): boolean;
var ticketnobegin,ticketnoend:String;
    tmpStringList:TStringList;
    tmpString:string;
    tmpticketno:int64;
    ticketnos:TStringBuilder;
    hintstr:String;
    conditionstr:String;
    billcode:String;
begin
  inherited;
  result:=false;
  if billnoEdit=nvedtticketnos then
  begin
    hintstr:='票号';
    conditionstr:='tsl!ticketno';
    billcode:='Ticket';
  end
  else
  begin
    hintstr:='保单号';
    conditionstr:='isr!insuranceno';
    billcode:='Insure';
  end;
  with jcdsResult do
  begin
    if trim(billnoEdit.Text)='' then
    begin
      SysDialogs.ShowInfo('请输入要查询的'+hintstr);
      billnoEdit.SetFocus;
      exit;
    end;
    if (pos(',',billnoEdit.Text)>0) or (pos('-',billnoEdit.Text)>0) then
    begin
      tmpStringList:=TStringList.Create;
      tmpStringList.Delimiter:=',';
      tmpStringList.CommaText:=billnoEdit.Text;
      ticketnos:=TStringBuilder.Create;
      for tmpString in tmpStringList do
      begin
        if pos('-',tmpString)>0 then
        begin
          if posex('-',tmpString,pos('-',tmpString)+1)>0 then
          begin
            SysDialogs.ShowError(hintstr+'输入格式错误,多个票段查询需要用","隔开！');
            billnoEdit.SetFocus;
            exit;
          end;
          ticketnobegin:=copy(tmpString,1,pos('-',tmpString)-1);
          ticketnoend:=copy(tmpString,pos('-',tmpString)+1,length(tmpString)-pos('-',tmpString));

          if (length(ticketnoend)<>Length(ticketnobegin))
            or (Abs(strtoint64(ticketnoend)-strtoint64(ticketnobegin))>50) then
          begin
            SysDialogs.ShowError('您输入的票段数量超过'+inttostr(50)+'，请重新输入');
            billnoEdit.SetFocus;
            exit;
          end;
          tmpticketno:=StrToInt64(ticketnobegin);
          while tmpticketno<=StrToInt64(ticketnoend) do
          begin
            ticketnos.Append(',''').Append(pubfn.zerofill(inttostr(tmpticketno),SysInfo.curBillLength.Items[billcode])).Append('''');
            inc(tmpticketno);
          end;
        end
        else
        begin
          ticketnos.Append(',''').Append(pubfn.zerofill(tmpString,SysInfo.curBillLength.Items[billcode])).Append('''');
        end;
      end;
      params.CreateParam(ftString,'filter_INS_'+conditionstr,ptInput);
      ticketnos.Remove(0,1).Insert(0,'(').Append(')');
      tmpString:=ticketnos.ToString;
      params.ParamValues['filter_INS_'+conditionstr]:=ticketnos.ToString;
    end
    else
    begin
      params.CreateParam(ftString,'filter_EQS_'+conditionstr,ptInput);
      params.ParamValues['filter_EQS_'+conditionstr]:=pubfn.zerofill(billnoEdit.Text,SysInfo.curBillLength.Items[billcode]);
    end;
    params.CreateParam(ftString,'filter_GED_tsl!departdate',ptInput);
    params.ParamValues['filter_GED_tsl!departdate']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',trunc(now-7));
  end;
  result:=true;
end;

procedure TFrmInsureSale.tbtnFilterClick(Sender: TObject);
var ticketnobegin,ticketnoend:String;
    tmpStringList:TStringList;
    tmpString:string;
    tmpticketno:int64;
    ticketnos:TStringBuilder;
begin
  inherited;
  with jcdsResult do
  begin
    active:=false;
    Params.Clear;
    if rbticketno.Checked then
    begin
      if not setBillNoCondition(nvedtticketnos) then exit;
    end
    else
    begin
      if nvhelpschedule.Id<=0 then
      begin
        SysDialogs.ShowInfo('请输入要查询的班次');
        nvhelpschedule.SetFocus;
        exit;
      end;
      params.CreateParam(ftString,'filter_EQD_tsl!departdate',ptInput);
      params.CreateParam(ftString,'filter_EQL_sc!id',ptInput);
      params.ParamValues['filter_EQD_tsl!departdate']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',trunc(dtpdepartdate.Date));
      params.ParamValues['filter_EQL_sc!id']:=nvhelpschedule.Id;
      if StrToIntDef(nvedtseatno.Text,0)>0 then
      begin
        params.CreateParam(ftString,'filter_EQR_tsl!seatno',ptInput);
        params.ParamValues['filter_EQR_tsl!seatno']:=nvedtseatno.Text;
      end;
    end;
    active:=true;
  end;
end;

procedure TFrmInsureSale.tbtnInsertClick(Sender: TObject);
var totalprice:Currency;
    totalpremium:Currency;
    totalticketnum,totalinsurancenum:integer;
    sellby,distance,price:int64;
    cancelway:String;
    i,j:integer;
begin
  inherited;
  totalprice:=0;
  totalpremium:=0;
  totalticketnum:=0;
  totalinsurancenum:=0;
  cdsInsureBuffer.Active:=false;
  // 判断选中的记录数
  with jcdsResult do
  begin
    DisableControls;
    First;
    sellby:=0;
    while not eof do
    begin
      if fieldbyname('isselected').AsBoolean then
      begin
        if not cdsInsureBuffer.Active then
        begin
          cdsInsureBuffer.Active:=true;
        end;
        totalprice:=totalprice+FieldValues['price'];
        inc(totalticketnum);
        cdsInsureBuffer.Append;
        distance:= FieldValues['distance'];
        price   := FieldValues['price'];
        //保险服务器售保险
        if getParametervalue('2626',SysInfo.LoginUserInfo.OrgID) = '1'  then
        begin
            Fcdsinsuretypeitem.First;
            while not Fcdsinsuretypeitem.Eof do
            begin
             cdsInsureBuffer.FieldValues['insuretypeid'] := Fcdsinsuretypeitem.FieldValues['id'];
             Break;
              Fcdsinsuretypeitem.next;
            end;
        end
        else
        begin
            if getParametervalue('1060',SysInfo.LoginUserInfo.OrgID) = '0'  then
            begin
              Fcdsinsuretypeitem.First;
              while not Fcdsinsuretypeitem.Eof do
              begin
                 if (distance>=Fcdsinsuretypeitem.FieldValues['fromamount'])
                    and (distance<=Fcdsinsuretypeitem.FieldValues['endamount']) then
                 begin
                    cdsInsureBuffer.FieldValues['insuretypeid'] := Fcdsinsuretypeitem.FieldValues['id'];
                    Break;
                 end;
                 Fcdsinsuretypeitem.next;
              end;
            end
            else
            begin
              Fcdsinsuretypeitem.First;
              while not Fcdsinsuretypeitem.Eof do
              begin
                if (price>=Fcdsinsuretypeitem.FieldValues['fromamount'])
                   and (price<=Fcdsinsuretypeitem.FieldValues['endamount']) then
                begin
                   cdsInsureBuffer.FieldValues['insuretypeid'] := Fcdsinsuretypeitem.FieldValues['id'];
                   Break;
                end;
                Fcdsinsuretypeitem.next;
              end;
            end;
        end;


        cdsInsureBuffer.FieldByName('tickettype').AsString:=FieldByName('tickettype').AsString;
        cdsInsureBuffer.FieldValues['seatno']:=FieldValues['seatno'];
        cdsInsureBuffer.FieldValues['issell']:=true;
        cdsInsureBuffer.FieldValues['certificatetype']:='0';

        cdsInsureBuffer.FieldValues['premium']:=Fcdsinsuretype.FieldValues['premium'];
        cdsInsureBuffer.FieldValues['insureamount']:=Fcdsinsuretype.FieldValues['MAXINSUREAMOUNT'];
        cdsInsureBuffer.FieldValues['insurersid']:=Fcdsinsuretype.FieldValues['insurersid'];
        cdsInsureBuffer.FieldValues['isselfschedule']:=FieldValues['isselfschedule'];
        cdsInsureBuffer.FieldValues['ticketoutletsname']:=SysInfo.LoginUserInfo.ticketoutletsname;

        cdsInsureBuffer.FieldValues['scheduleplanid']:=FieldValues['scheduleplanid'];
        cdsInsureBuffer.FieldValues['departdate']:=FieldValues['departdate'];
        cdsInsureBuffer.FieldValues['schedulecode']:=FieldValues['schedulecode'];
        cdsInsureBuffer.FieldValues['islinework']:=FieldValues['islinework'];
        cdsInsureBuffer.FieldValues['departstationname']:=FieldValues['departstationname'];
        cdsInsureBuffer.FieldValues['reachstationname']:=FieldValues['reachstationname'];
        cdsInsureBuffer.FieldValues['reachstationsecondname']:=FieldValues['reachstationsecondname'];
        cdsInsureBuffer.FieldValues['departtime']:=FieldValues['departtime'];
        cdsInsureBuffer.FieldValues['distance']:=FieldValues['distance'];
        cdsInsureBuffer.FieldValues['sellid']:=FieldValues['id'];
        cdsInsureBuffer.FieldValues['ticketno']:=FieldValues['ticketno'];
        cdsInsureBuffer.FieldValues['carrychildnum']:=FieldValues['carrychildnum'];
        cdsInsureBuffer.post;
      end;
      next;
    end;
    EnableControls;
  end;
  if cdsInsureBuffer.Active and (cdsInsureBuffer.RecordCount>0) then
  begin
    FrmInsureSaleend:=TFrmInsureSaleend.Create(self);
    try
      with FrmInsureSaleend do
      begin
//        cdsInsureBuffer:=self.cdsInsureBuffer;
        Caption:='保险单信息录入';
        setDefaultCustomerOnSellinsure:=self.setDefaultCustomerOnSellinsure;
        defaultCustomerID:=UFrmInsureSale.defaultCustomerID;
        edittype:=TEditType.view;
        dsInsuranceBuffer.DataSet:=self.cdsInsureBuffer;
        cdsinsuretype:=self.Fcdsinsuretype;
        FinsurePrint:=self.FinsurePrint;
        if SysMainForm.showFormModal(FrmInsureSaleend,false)=mrok then
        begin
          refreshBill;
          tbtnFilterClick(nil);
           nvedtticketnos.SetFocus;
           //nvedtticketnos.SelectAll;
        end;
      end;
    finally
      freeandnil(FrmInsureSaleend);
    end;
  end;
end;

procedure TFrmInsureSale.tmrleaveinsurenumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveinsurenum.Font.Color:=RGB(Random(256),Random(256),Random(256));
end;

procedure TFrmInsureSale.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

function TFrmInsureSale.createCdsInsureBuffer(AOwner:TComponent): TjsonClientDataSet;
  function incEx(var i:integer):integer;
  begin
    inc(i);
    result:=i;
  end;
var field:TField;
    i:integer;
begin
  result:=TjsonClientDataSet.Create(AOwner);
  with result do
  begin
    RemoteServer:=DMPublic.jcon;
    QueryAddress:='insurancesell/findEmptyInsurance';
    SaveAddress:='insurancesell/sell';
    DataSourceName:='insurancePrintInfos';
    UpdateDataSet:='insurancePrintInfolist';
    refreshAfterApplyUpdates:=true;
    Params.CreateParam(ftString,'insuranceOrder.seller',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.orgid',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.startTicketNO',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.totalmoney',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.ip',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.ticketoutletsid',ptInput);
    Params.CreateParam(ftString,'insuranceOrder.sellway',ptInput);
    Params.CreateParam(ftInteger,'flag',ptOutput);
    Params.CreateParam(ftString,'msg',ptOutput);
    i:=-1;


    createField('sellid', '', ftLargeint,0, incEx(i), result) ;
    createField('scheduleplanid', '', ftLargeint,0, incEx(i), result) ;
    createField('distance', '', ftLargeint,0, incEx(i), result) ;
    createField('customerid', '', ftLargeint,0, incEx(i), result) ;
    createField('id', '', ftLargeint,0, incEx(i), result) ;
    createField('insurersid', '', ftLargeint,0, incEx(i), result) ;
    createField('insuretypeid', '', ftLargeint,0, incEx(i), result) ;

    createField('schedulecode', '', ftWideString,20, incEx(i), result) ;
    createField('departstationname', '', ftWideString,30, incEx(i), result) ;
    createField('reachstationname', '', ftWideString,30, incEx(i), result) ;
    createField('reachstationsecondname', '', ftWideString,30, incEx(i), result) ;
    createField('departtime', '', ftWideString,5, incEx(i), result) ;
    createField('ticketno', '', ftWideString,30, incEx(i), result) ;
    createField('tickettype', '', ftWideString,10, incEx(i), result) ;
    createField('certificateno', '', ftWideString,50, incEx(i), result) ;
    createField('certificatetype', '', ftWideString,10, incEx(i), result) ;
    createField('customername', '', ftWideString,30, incEx(i), result) ;
    createField('education', '', ftWideString,10, incEx(i), result) ;
    createField('familyaddress', '', ftWideString,100, incEx(i), result) ;
    createField('familyphone', '', ftWideString,20, incEx(i), result) ;
    createField('mobilephone', '', ftWideString,20, incEx(i), result) ;
    createField('customerremarks', '', ftWideString,100, incEx(i), result) ;
    createField('insuranceno', '', ftWideString,30, incEx(i), result) ;
    createField('ticketoutletsname', '', ftWideString,30, incEx(i), result) ;
    createField('paymethod', '', ftWideString,10, incEx(i), result) ;

    createField('seatno', '', ftInteger,0, incEx(i), result) ;
    createField('carrychildnum', '', ftInteger,0, incEx(i), result) ;


    createField('isselfschedule', '', ftBoolean,0, incEx(i), result) ;
    createField('issell', '', ftBoolean,0, incEx(i), result) ;
    createField('islinework', '', ftBoolean,0, incEx(i), result) ;

    createField('departdate', '', ftDate,0, incEx(i), result) ;
    createField('selltime', '', ftDateTime,0, incEx(i), result) ;
    createField('premium', '', ftFloat,0, incEx(i), result) ;
    createField('insureamount', '', ftFloat,0, incEx(i), result) ;
    createField('polnumber', '', ftWideString,30, incEx(i), result) ; //保险公司接口返回的保单号

    createField('emoney', '', ftFloat, 0, incEx(i), result); //意外伤害保险金额
    createField('emmoney', '', ftFloat, 0, incEx(i), result); //意外伤害医疗保险金额
    createField('reprintdatetime', '', ftWideString, 100, incEx(i), result); //保险票出票时间

    createLookupField('certificatetypename','','certificatetype','code','value',ftWideString,50,incEx(i),result,FcdsDDDCertificatetype);
    createLookupField('tickettypeprintname','','tickettype','code','printname',ftWideString,50,incEx(i),result,FcdsTicketType);
    createLookupField('paymethodname','','paymethod','code','value',ftWideString,50,incEx(i),result,FcdsDDDpaymethod);
    createLookupField('insuretypename','','insuretypeid','id','name',ftWideString,50,incEx(i),result,Fcdsinsuretype);
  end;
end;


end.
