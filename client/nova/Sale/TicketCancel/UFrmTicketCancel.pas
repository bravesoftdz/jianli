unit UFrmTicketCancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit,services,PubFn,StrUtils,UDMPublic,
  NovaPrint,FunctionItemIntf,UICcardRW, Buttons;

type
  TFrmTicketCancel = class(TSimpleCRUDForm,Ivipcardfound)
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
    jsoncdsticketcancel: TjsonClientDataSet;
    pnlinsurenos: TPanel;
    nvedtInsurenos: TNovaEdit;
    rbinsureno: TRadioButton;
    pnlvip: TPanel;
    lbl10: TLabel;
    lblviplastamount: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    lblvipamount: TLabel;
    lbl6: TLabel;
    lblviplastmoney: TLabel;
    lbl8: TLabel;
    lblvipnewamount: TLabel;
    lblvipnewmoney: TLabel;
    bvlvip: TBevel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lblvipname: TLabel;
    lblvipcardno: TLabel;
    lblvipcardtype: TLabel;
    lblviptel: TLabel;
    btnclearvipinfo: TBitBtn;
    jcdsvipinfo: TjsonClientDataSet;
    procedure rbticketnoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure nvedtticketnosKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure ToolButton51Click(Sender: TObject);
    procedure dbgrdhResultDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure nvhelpscheduleKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnclearvipinfoClick(Sender: TObject);
  private
    { Private declarations }
//    FcdsDDDschedulestatus:TjsonClientDataSet;    //班次状态
    FcdsDDDseattype:TjsonClientDataSet;      //票价座位类型
    FcdsDDDpaymethod:TjsonClientDataSet;  //支付方式
    FcdsDDDsellway:TjsonClientDataSet;  //售票方式
    FcdsDDDticketstatus:TjsonClientDataSet;  //车票状态
    FcdsTicketType:TjsonClientDataSet;  //票种
    onecardcansale:Boolean; //一卡通是否可以在窗口购票
    function initTicketType: Boolean;
    procedure initjcdsResult;
    function setBillNoCondition(billnoEdit:TNovaEdit):boolean;
    var isAuthority:Boolean;//是否可废隔日票
  public
    { Public declarations }
    curvipCard: TVipCard;
    procedure clearvipinfo;
    procedure vipcardfound(vipCard:TVipCard);
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmTicketCancel: TFrmTicketCancel;

implementation

uses UFrmcancelticketend;
const maxticketnum = 50;

{$R *.dfm}

procedure TFrmTicketCancel.FormShow(Sender: TObject);
var i:integer;
    Fcansellinsure:boolean;
begin
  inherited;
  dbgrdhResult.jsonConnection:=DMPublic.jcon;
  dbgrdhResult.GridUser:=SysInfo.LoginUserInfo.UserID;
  Fcansellinsure:=(getParametervalue('1022',SysInfo.LoginUserInfo.OrgID)='1')
               or (getParametervalue('1045',SysInfo.LoginUserInfo.OrgID)='1');
  if not Fcansellinsure then
  begin
    dbgrdhResult.FieldColumns['iscancelinsure'].Visible:=false;
    dbgrdhResult.FieldColumns['insuranceno'].Visible:=false;
    dbgrdhResult.FieldColumns['insurancepaymethodname'].Visible:=false;
    pnlinsurenos.Visible:=false;
    rbinsureno.Visible:=false;
    pnlQuery.Height:=pnlticketno.Height+pnlinsurenos.Height;
  end;
end;

procedure TFrmTicketCancel.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{DB607429-E5FD-42D5-801C-0D9010CA4050}' then //废票
  begin
    ToolButton51.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{CC84AEE4-47A4-446A-8E10-17590C7C63F8}' then //特权废票
  begin
    ToolButton52.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{D28A82BB-CDD2-444A-8789-D9ADBAEE8CD3}' then
  begin
    isAuthority :=aEnable;
  end;
end;

procedure TFrmTicketCancel.initjcdsResult;
var i:integer;
begin
  with jcdsResult do
  begin
    i:=-1;
    createField('isselfschedule', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('isselected', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('iscancelinsure', '', ftBoolean,0, incEx(i), jcdsResult) ;
    createField('id', '', ftLargeint,0, incEx(i), jcdsResult) ;
//    createField('scheduleplanid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('orgid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('scheduleorgid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('sellby', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('insurancesellby', '', ftLargeint,0, incEx(i), jcdsResult) ;

    createField('departstationid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('reachstationid', '', ftLargeint,0, incEx(i), jcdsResult) ;
//    createField('scheduleid', '', ftLargeint,0, incEx(i), jcdsResult) ;
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

function TFrmTicketCancel.initTicketType: Boolean;
begin
  result:=false;
  if not Assigned(FcdsTicketType) then
  begin
    FcdsTicketType:=TjsonClientDataSet.Create(self);
    with FcdsTicketType do
    begin
      QueryAddress:='base/findTickettype';
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='tickettypemap';
//      Params.CreateParam(ftString,'userid',ptInput);
//      Params.CreateParam(ftString,'roleid',ptInput);
//      Params.CreateParam(ftString,'ticketoutletsid',ptInput);
    end;
  end;
  with FcdsTicketType do
  begin
    active:=false;
//    Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
//    Params.ParamValues['roleid']:=SysInfo.LoginUserInfo.RoleID;
//    Params.ParamValues['ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
    Active:=True;
    result:=RecordCount>0;
  end;
end;

procedure TFrmTicketCancel.dbgrdhResultDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (not jcdsResult.FieldByName('isselfschedule').AsBoolean) and not
    (gdSelected in State)then
  begin //售异站票
    dbgrdhResult.Canvas.Font.Color := clGreen;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (jcdsResult.FieldByName('sellby').AsInteger = 0) and not
    (gdSelected in State) then //异站售本站票
  begin
    dbgrdhResult.Canvas.Font.Color := clRed; // clYellow;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
//  else (jcdsResult.FieldByName('status').AsString = '3') and not
//    (gdSelected in State) then //本站售本站
//  begin
//    dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
//    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end
  ;
end;

procedure TFrmTicketCancel.dsResultDataChange(Sender: TObject; Field: TField);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then exit;
  //异站售本站票不能在本站废票
  if (jcdsResult.FieldByName('isselfschedule').AsBoolean)
  and (jcdsResult.FieldByName('sellby').AsInteger = 0) then
  begin
    oldOnDataChange:=(sender as TDataSource).OnDataChange;
    (sender as TDataSource).OnDataChange:=nil;
    field.DataSet.FieldByName('isselected').Value:=null;
    field.DataSet.FieldByName('iscancelinsure').Value:=null;
    (sender as TDataSource).OnDataChange:=oldOnDataChange;
    Exit;
  end;

  if (field.FieldName='isselected') then
  begin
    if  (field.DataSet.FieldByName('ticketstatus').AsString<>'0')
      or ((SysInfo.LoginUserInfo.OrgID<>field.DataSet.FieldByName('scheduleorgid').AsLargeInt)
          and (field.DataSet.FieldByName('orgid').AsLargeInt=field.DataSet.FieldByName('scheduleorgid').AsLargeInt)
          ) then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('isselected').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end
    else if field.DataSet.FieldByName('insuranceid').IsNull then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('iscancelinsure').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end
    else
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('iscancelinsure').AsBoolean:=field.DataSet.FieldByName('isselected').AsBoolean;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
  end
  else if (field.FieldName='iscancelinsure') then
  begin
    if (field.DataSet.FieldByName('insuranceid').IsNull)
        or ((SysInfo.LoginUserInfo.OrgID<>field.DataSet.FieldByName('scheduleorgid').AsLargeInt)
              and (field.DataSet.FieldByName('orgid').AsLargeInt=field.DataSet.FieldByName('scheduleorgid').AsLargeInt)
              ) then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('iscancelinsure').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
  end;
end;

procedure TFrmTicketCancel.FormActivate(Sender: TObject);
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
  else if rbinsureno.Checked then
  begin
    rbticketnoClick(rbinsureno);
  end
  else
  begin
    rbticketno.Checked:=true;
  end;
end;

procedure TFrmTicketCancel.FormCreate(Sender: TObject);
var i:integer;
begin
  inherited;
  FrmTicketCancel:=Self;
  dtpdepartdate.Date:=date();
  FcdsDDDseattype:=createCdsDDD('handprice','seattype',self);      //票价座位类型
  FcdsDDDpaymethod:=createCdsDDD('ticketsell','paymethod',self);      //支付方式
  FcdsDDDsellway:=createCdsDDD('ticketsell','sellway',self);  //售票方式
  FcdsDDDticketstatus:=createCdsDDD('ticketsell','ticketstatus',self);  //车票状态
  initTicketType;
  initjcdsResult;

  setCardTypeNOLength(Tcardtypes.VIP,sysInfo.curBillLength.Items['Vip']);
  if getParametervalue('0013',SysInfo.LoginUserInfo.OrgID)='1' then
  begin
    TVipcardRW.GetInstance.addObserver(Self);
  end;
  onecardcansale:=getParametervalue('7003',SysInfo.LoginUserInfo.OrgID)='1';
end;

procedure TFrmTicketCancel.FormDestroy(Sender: TObject);
begin
  inherited;
  if getParametervalue('0013',SysInfo.LoginUserInfo.OrgID)='1' then
  begin
    try
      TVipcardRW.GetInstance.removeObserver(Self);
    except
    end;
  end;
end;

procedure TFrmTicketCancel.nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmTicketCancel.nvedtticketnosKeyPress(Sender: TObject;
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

procedure TFrmTicketCancel.nvhelpscheduleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmTicketCancel.rbticketnoClick(Sender: TObject);
begin
  inherited;
  if Sender = rbticketno then
  begin
    pnlticketno.Enabled:=true;
    nvedtticketnos.SetFocus;
    pnlschedule.Enabled:=false;
    pnlinsurenos.Enabled:=false;
  end
  else if Sender = rbinsureno then
  begin
    pnlinsurenos.Enabled:=true;
    nvedtInsurenos.SetFocus;
    pnlticketno.Enabled:=false;
    pnlschedule.Enabled:=false;
  end
  else if Sender = rbschedule then
  begin
    pnlschedule.Enabled:=true;
    dtpdepartdate.SetFocus;
    pnlticketno.Enabled:=false;
    pnlinsurenos.Enabled:=false;
  end;
end;

function TFrmTicketCancel.setBillNoCondition(billnoEdit: TNovaEdit): boolean;
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
//            ticketnos.Append(',''').Append(pubfn.zerofill(inttostr(tmpticketno),SysInfo.curBillLength.Items[billcode])).Append('''');
            ticketnos.Append(',''').Append(pubfn.zerofill(inttostr(tmpticketno),Length(ticketnobegin))).Append('''');
            inc(tmpticketno);
          end;
        end
        else
        begin
//          ticketnos.Append(',''').Append(pubfn.zerofill(tmpString,SysInfo.curBillLength.Items[billcode])).Append('''');
          ticketnos.Append(',''').Append(tmpString).Append('''');
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
//      params.ParamValues['filter_EQS_'+conditionstr]:=pubfn.zerofill(billnoEdit.Text,SysInfo.curBillLength.Items[billcode]);
      params.ParamValues['filter_EQS_'+conditionstr]:=billnoEdit.Text;
    end;
    params.CreateParam(ftString,'filter_GED_tsl!departdate',ptInput);
    params.ParamValues['filter_GED_tsl!departdate']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',trunc(now-7));
  end;
  result:=true;
end;

procedure TFrmTicketCancel.tbtnFilterClick(Sender: TObject);
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
    if (curvipCard<>nil) and (Sender=nil) then
    begin
      //按VIP卡号查询
      params.CreateParam(ftString,'filter_GED_tsl!departdate',ptInput);
      params.ParamValues['filter_GED_tsl!departdate']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',trunc(now));
      params.CreateParam(ftString,'filter_EQS_v!vipcardno',ptInput);
      params.ParamValues['filter_EQS_v!vipcardno']:=curvipCard.cardNo;
    end
    else if rbticketno.Checked then
    begin
      if not setBillNoCondition(nvedtticketnos) then exit;
    end
    else if rbinsureno.Checked then
    begin
      if not setBillNoCondition(nvedtInsurenos) then exit;
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
    params.CreateParam(ftInteger,'flag',ptOutput);
    params.CreateParam(ftWideString,'msg',ptOutput);
    active:=true;
    if params.ParamValues['flag']<>1 then
    begin
      SysDialogs.Warning(params.ParamValues['msg']);
    end;
    dbgrdhResult.Refresh;
  end;
end;

procedure TFrmTicketCancel.ToolButton51Click(Sender: TObject);
var totalprice,totalservicefee:Currency;
    totalpremium:Currency;
    totalticketnum,totalinsurancenum:integer;
    sellby,insurancesellby,departorgid:int64;
    cancelway:String;

    paymethod:string;
    canceltovipcard:boolean;
    vipcardwriteresult:Integer;
    _curvipCard:TVipCard;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount=0) then exit;
  if (jcdsResult.FieldByName('ticketstatusname').AsString='已废') and (jcdsResult.FieldByName('isselected').AsBoolean) then
  begin
    SysDialogs.ShowMessage('该车票已废！');
    exit;
  end;
  if not SysDialogs.Confirm('提示','确定要废票吗？') then
    begin
      exit;
    end;
  if (Sender=ToolButton51) then
  begin
    cancelway:='0';
  end
  else if (Sender=ToolButton52) then
  begin
    cancelway:='1';
  end
  else
  begin
    SysDialogs.ShowMessage('未知的废票方式！');
    exit;
  end;
  totalprice:=0;
  totalservicefee:=0;
  totalpremium:=0;
  totalticketnum:=0;
  totalinsurancenum:=0;
  jsoncdsticketcancel.Active:=false;
  paymethod:='';
  canceltovipcard:=false;
  // 判断选中的记录数
  with jcdsResult do
  begin
    DisableControls;
    First;
    sellby:=0;
    insurancesellby:=0;
    departorgid:=0;
    while not eof do
    begin

      if fieldbyname('isselected').AsBoolean  or fieldbyname('iscancelinsure').AsBoolean then
      begin
      //允许废隔天票，true允许，false不允许
      if (not isAuthority)  and (fieldbyname('departdate').AsDateTime<Date()) and (Sender=ToolButton51) then
      begin
        SysDialogs.Warning('废票不允许废隔天票');
        Exit;
      end;

        //发车站不能废联网票
        if fieldbyname('isselected').AsBoolean
           and fieldbyname('isselfschedule').AsBoolean
           and (FieldByName('sellby').AsLargeInt=0) then
        begin
          SysDialogs.Warning('联网票不能在发车站废票!');
          EnableControls;
          exit;
        end;

        //判断是否是同一个售票员
        if fieldbyname('isselected').AsBoolean then
        begin
          if sellby=0 then
          begin
            sellby:=FieldValues['sellby'];
            if (Sender=ToolButton51) and (sellby<>Sysinfo.LoginUserInfo.UserID) then
            begin
              SysDialogs.Warning('废票只能废自己售出的车票!');
              EnableControls;
              exit;
            end;
          end
          else if sellby<>FieldValues['sellby'] then
          begin
            SysDialogs.Warning('废票不能同时废不同售票员售出的车票!');
            EnableControls;
            exit;
          end;
        end;
        if fieldbyname('iscancelinsure').AsBoolean then
        begin
          if insurancesellby=0 then
          begin
            insurancesellby:=FieldValues['insurancesellby'];
            if (Sender=ToolButton51) and (insurancesellby<>Sysinfo.LoginUserInfo.UserID) then
            begin
              SysDialogs.Warning('废保险票只能废自己售出的保险票!');
              EnableControls;
              exit;
            end;
          end
          else if insurancesellby<>FieldValues['insurancesellby'] then
          begin
            SysDialogs.Warning('废保险票不能同时废不同售票员售出的保险票!');
            EnableControls;
            exit;
          end;
        end;

        //判断是否售的同一个车站的票
        if fieldbyname('isselected').AsBoolean and (not fieldbyname('isselfschedule').AsBoolean) then
        begin
          if departorgid=0 then
          begin
            departorgid:=FieldValues['orgid'];
          end
          else if departorgid<>FieldValues['orgid'] then
          begin
            SysDialogs.Warning('废票不能同时废不同车站发车的车票!');
            EnableControls;
            exit;
          end;
        end;

        //判断是否都是VIP余额退票
        if fieldbyname('paymethod').AsString='2' then
        begin
          canceltovipcard:=true;
          if paymethod<>'' then
          begin
            SysDialogs.Warning('VIP余额购买的车票不能和其它支付方式购买的车票同时废票!请分开废票');
            EnableControls;
            exit;
          end;
        end
        else
        begin
          //保存非VIP余额购票方式
          paymethod:=fieldbyname('paymethod').AsString;
        end;

        if fieldbyname('isselected').AsBoolean  then
        begin
          totalprice:=totalprice+FieldValues['price'];
          if (fieldbyname('sellway').AsString='1')
            or (fieldbyname('sellway').AsString='2')
            or (fieldbyname('sellway').AsString='6') then
          totalservicefee:=totalservicefee+FieldValues['servicefee'];
          inc(totalticketnum);
        end;
        if not jsoncdsticketcancel.Active then
        begin
          jsoncdsticketcancel.Active:=true;
        end;
        jsoncdsticketcancel.Append;
        jsoncdsticketcancel.FieldValues['ticketprice']:=FieldValues['price'];
        jsoncdsticketcancel.FieldValues['isselfschedule']:=FieldValues['isselfschedule'];
        jsoncdsticketcancel.FieldValues['sellid']:=FieldValues['id'];
        jsoncdsticketcancel.FieldValues['sellby']:=FieldValues['sellby'];
        jsoncdsticketcancel.FieldValues['insurancesellby']:=FieldValues['insurancesellby'];
        jsoncdsticketcancel.FieldValues['iscancelticket']:=FieldValues['isselected'];
        jsoncdsticketcancel.FieldValues['iscancelinsure']:=FieldValues['iscancelinsure'];
        if FieldByName('iscancelinsure').AsBoolean then
        begin
          inc(totalinsurancenum);
          totalpremium:=totalpremium+FieldValues['premium'];
        end;
        jsoncdsticketcancel.FieldValues['cancelinsureid']:=FieldValues['insuranceid'];
        jsoncdsticketcancel.FieldValues['cancelway']:=cancelway;
        jsoncdsticketcancel.FieldValues['ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
        jsoncdsticketcancel.post;
      end;
      next;
    end;
    EnableControls;
  end;
  if jsoncdsticketcancel.Active and (jsoncdsticketcancel.RecordCount>0) then
  begin
    Frmcancelticketend:=TFrmcancelticketend.Create(self);
    try
      Frmcancelticketend.canceltovipcard:=canceltovipcard;
      Frmcancelticketend.lblticketnum.Caption:=inttostr(totalticketnum);
      Frmcancelticketend.lblinsurenum.Caption:=inttostr(totalinsurancenum);
      Frmcancelticketend.lblticketreceivablenum.Caption:=CurrToStr(totalprice);
      Frmcancelticketend.lblservicefee.Caption:=CurrToStr(totalservicefee);
      Frmcancelticketend.lblinsurereceivablenum.Caption:=CurrToStr(totalpremium);
      Frmcancelticketend.lblreceivablenum.Caption:=CurrToStr(totalprice+totalpremium+totalservicefee);

      if SysMainForm.showFormModal(Frmcancelticketend,false)=mrok then
      begin
        with jsoncdsticketcancel do
        begin
          if trim(Frmcancelticketend.mmoreason.Text)<>'' then
          begin
            first;
            while not eof do
            begin
              edit;
              jsoncdsticketcancel.FieldValues['remarks']:=Frmcancelticketend.mmoreason.Text;
              post;
              next;
            end;
          end;
          if canceltovipcard then //VIP卡内余额支付
          begin
            if (curvipCard<>nil) then
            begin
              _curvipCard:=curvipCard;
              jsoncdsticketcancel.Params.ParamValues['vipcardno']:=_curvipCard.cardNo;
              jsoncdsticketcancel.Params.ParamValues['vipgrade']:=IntToStr(Integer(_curvipCard.cardGrade));
              jsoncdsticketcancel.Params.ParamValues['vipmoney']:=_curvipCard.money;
              jsoncdsticketcancel.Params.ParamValues['vippoint']:=_curvipCard.amount;
            end
            else
            begin
              SysDialogs.ShowInfo('当前选中的车票废票时，余额要退到VIP卡中。请将VIP卡放到读卡器上');
              exit;
            end;
          end
          else
          begin
            jsoncdsticketcancel.Params.ParamValues['vipcardno']:=null;
            jsoncdsticketcancel.Params.ParamValues['vipgrade']:=null;
            jsoncdsticketcancel.Params.ParamValues['vipmoney']:=null;
            jsoncdsticketcancel.Params.ParamValues['vippoint']:=null;
          end;
          try
            if (ApplyUpdates(-1) <> 0) then
            begin
              SysDialogs.ShowError('废票失败:未知错误！');
            end;
            if Params.ParamValues['flag']=1 then
            begin
              //写卡
              if(_curvipCard<>nil) then
              begin
                if canceltovipcard then //VIP卡内余额支付
                begin
                  _curvipCard.incrementmoney(StrToCurr(Frmcancelticketend.lblreceivablenum.Caption));
                  _curvipCard.decrementamount(StrToCurr(Frmcancelticketend.lblreceivablenum.Caption));
                  vipcardwriteresult:=_curvipCard.writeCard;
                  while (vipcardwriteresult<>0) do
                  begin
//                    if SysDialogs.Ask('警告','写卡失败：'+_curvipCard.getErrorInfo(vipcardwriteresult)+'。请放好VIP卡，按确定重新写卡。') then
//                    begin
//                      vipcardwriteresult:=_curvipCard.writeCard;
//                    end
//                    else
//                    begin
//                      { TODO : 记录异常日志 }
//                      Break;
//                    end;
                    SysDialogs.Warning('写卡失败：'+_curvipCard.getErrorInfo(vipcardwriteresult)+'。请放好VIP卡，按确定重新写卡。');
                    vipcardwriteresult:=_curvipCard.writeCard;
                  end;
                end;
              end;
              if Params.ParamByName('msg').IsNull or (trim(Params.ParamByName('msg').AsString)='') then
                SysDialogs.ShowMessage('废票成功！')
              else
                SysDialogs.ShowMessage(Params.ParamValues['msg']);
              tbtnFilterClick(nil);
              clearvipinfo;
            end
            else
            begin
              if Params.ParamByName('msg').IsNull then
                SysDialogs.ShowError('废票失败:未知错误！')
              else
                SysDialogs.Warning(Params.ParamValues['msg']);
            end;
          except on E: Exception do
            SysDialogs.ShowError('废票失败:'+e.Message);
          end;
        end;
      end;
    finally
      freeandnil(Frmcancelticketend);
    end;
  end;
end;

procedure TFrmTicketCancel.btnclearvipinfoClick(Sender: TObject);
begin
  inherited;
  clearvipinfo;
  jcdsResult.Active:=False;
  FormActivate(nil);
end;

procedure TFrmTicketCancel.clearvipinfo;
begin
  curvipCard:=nil;
  pnlvip.Visible:=false;
  lblvipcardno.Caption:='';
  lblvipname.Caption:='';
  lblvipcardtype.Caption:='';
  lblviptel.Caption:='';
  lblviplastmoney.Caption:='0';
  lblvipnewmoney.Caption:='0';
  lblviplastamount.Caption:='0';
  lblvipamount.Caption:='0';
  lblvipnewamount.Caption:='0';
end;

procedure TFrmTicketCancel.vipcardfound(vipCard: TVipCard);
begin
  curvipCard:=vipCard;
  if not pnlvip.Visible then
  begin
    pnlvip.Visible:=true;
  end;
  lblvipcardno.Caption:=vipCard.cardNo;
  lblvipcardtype.Caption:=getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption:=currtostr(vipCard.money);
  lblvipnewmoney.Caption:='0';
  lblviplastamount.Caption:=currtostr(vipCard.amount);
  lblvipamount.Caption:='';
  lblvipnewamount.Caption:='0';
  //查询数据库
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno']:=vipCard.cardNo;
    open;
    if RecordCount=0 then
    begin
      clearvipinfo;
      SysDialogs.Warning('打不到卡号为'+vipCard.cardNo+'的信息，可能是该卡的状态异常。');
    end
    else
    begin
      lblvipname.Caption:=FieldByName('name').AsString;
      lblviptel.Caption:=FieldByName('mobilephone').AsString;
      if (not onecardcansale) and (vipCard.cardGrade=Tcardgrade.ONECARD) then
      begin
        SysDialogs.Warning('一卡通不支持在窗口售票！');
        clearvipinfo;
      end;
      tbtnFilterClick(nil);
    end;
  end;
end;

end.
