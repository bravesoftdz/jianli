unit UFrmTicketRetrunRe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit, services, PubFn, StrUtils, UDMPublic,
  NovaPrint, FunctionItemIntf, DateUtils, math, UICcardRW, Buttons;

type
  TFrmTicketRetrunRe = class(TSimpleCRUDForm)
    rbticketno: TRadioButton;
    rbschedule: TRadioButton;
    rbinsureno: TRadioButton;
    nvedtticketnos: TNovaEdit;
    dtpdepartdate: TDateTimePicker;
    nvhelpschedule: TNovaHelp;
    nvedtseatno: TNovaEdit;
    lblseatno: TLabel;
    lblschedule: TLabel;
    nvedtInsurenos: TNovaEdit;
    tmrleaveticketnum: TTimer;
    tmrRefreshBill: TTimer;
    gbreturnvoucher: TGroupBox;
    lblticketno: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblleaveticketnum: TLabel;
    jsoncdsticketreturn: TjsonClientDataSet;
    jcdsgetticketreturnrate: TjsonClientDataSet;
    pnllastmoney: TPanel;
    lbl1: TLabel;
    lbllastmoney: TLabel;
    lbl4: TLabel;
    lblreceipt: TLabel;
    lbl5: TLabel;
    lblchange: TLabel;
    jcdsfindticketfee: TjsonClientDataSet;
    qryjcdseticket: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure rbticketnoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure nvedtticketnosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    ReturnTicketPrinter: TNovaPrint;
    param1107: string; // ��Ʊ�����Ѽ���ǰ�Ƿ�۳���Ʊ�۷���ֵ

    canprint: boolean; // �ܷ��ӡ��Ʊƾ֤
    canreturnotherstationticket: boolean; // ����ʽ�����£���վ�ܷ�����վ����վƱ1106
    carryRule: string; // ��Ʊ�����ѽ�λ����
    istotalprint: boolean; // �����������Ƿ�ϴ�
    printreturnvoucher: boolean; // �Ƿ���Ҫ��ӡ��Ʊƾ֤
    ticketnumhituser: Integer;
    FcdsDDDseattype: TjsonClientDataSet; // Ʊ����λ����
    FcdsDDDpaymethod: TjsonClientDataSet; // ֧����ʽ
    FcdsDDDsellway: TjsonClientDataSet; // ��Ʊ��ʽ
    FcdsDDDticketstatus: TjsonClientDataSet; // ��Ʊ״̬
    FcdsTicketType: TjsonClientDataSet; // Ʊ��
    returnbilltypecode: string; // ��Ʊƾ֤ʹ��Ʊ�ݵı���
    function initReturnTicketNo: boolean;
    function initReturnTicketPrinter: boolean;
    function initTicketType: boolean;
    //procedure initjcdsResult;
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
    procedure refreshBill(silent: boolean = false);
    function setBillNoCondition(billnoEdit: TNovaEdit): boolean;
    function leftAddZero(text: string; len: Integer): string;
    function getticketreturnrate(departdatetime: TDateTime;islinework : boolean ): Currency;
    // ȡ��Ʊ��Ʊ�۷���ϼ�
    function getticketfee(isselfschedule: boolean;ticketsellid: Int64): Currency;
  public
    { Public declarations }
    function carry(fee: Double): Currency;
    var param1179: boolean; //�Ƿ����ö������ص���Ʊ�����ѹ�ʽ
  end;

var
  FrmTicketRetrunRe: TFrmTicketRetrunRe;

implementation

uses UFrmsignticket, UFrmreturnticketend;
{$R *.dfm}

function TFrmTicketRetrunRe.carry(fee: Double): Currency;
var
  s:string;
  ef:extended;
begin
  // ��Ʊ�����ѽ�λ����1�������롢2��ȥ��3�롢
  // 4С��5�ǽ���5�ǣ�����5�ǽ���1Ԫ��5����С����
  if carryRule = '1' then
  begin
    result := Round(fee);
  end
  else if carryRule = '2' then
  begin
    result := trunc(fee);
  end
  else if carryRule = '3' then
  begin
    if fee = trunc(fee) then
      result := trunc(fee)
    else
      result := trunc(fee) + 1;
  end
  else if carryRule = '4' then
  begin
    if fee - trunc(fee) <= 0 then
      result := trunc(fee)
    else if fee - trunc(fee) <= 0.5 then
      result := trunc(fee) + 0.5
    else
      result := trunc(fee) + 1;
  end
  else if carryRule = '5' then// 5
  begin
    result := fee;
  end
  else  //����һλС������������
  begin
      s:='#.'+ StringOfChar('0',1);
      ef:=StrToFloat(FloatToStr(fee));//��ֹ������������
      result:=StrToFloat(FormatFloat(s,ef));
  end;
end;

procedure TFrmTicketRetrunRe.dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //inherited;
  if key=13 then
  begin
    //tbtnFilterClick(sender);
   if( tbtnInsert.Visible and tbtnInsert.Enabled) then
   begin
     tbtnInsertClick(sender);
   end
   else
   begin
     key:=0;
   end;
  end;
end;

procedure TFrmTicketRetrunRe.FormActivate(Sender: TObject);
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
    rbticketno.Checked := true;
  end;
end;

procedure TFrmTicketRetrunRe.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
 // FrmTicketReturn := self;
  dtpdepartdate.Date := Date();
 // FcdsDDDseattype := createCdsDDD('handprice', 'seattype', self); // Ʊ����λ����
//  FcdsDDDpaymethod := createCdsDDD('ticketsell', 'paymethod', self); // ֧����ʽ
 // FcdsDDDsellway := createCdsDDD('ticketsell', 'sellway', self); // ��Ʊ��ʽ
 // FcdsDDDticketstatus := createCdsDDD('ticketsell', 'ticketstatus', self);
  // ��Ʊ״̬
  //initTicketType;
 // initjcdsResult;
  printreturnvoucher := StrToBoolDef(PubFn.getParametervalue('1101',
      SysInfo.LoginUserInfo.OrgID), true);
  istotalprint := StrToBoolDef(PubFn.getParametervalue('1108',
      SysInfo.LoginUserInfo.OrgID), true);
  // 1105��Ʊ�����ѽ�λ����1�������롢2��ȥ��3�롢4С��5�ǽ���5�ǣ�����5�ǽ���1Ԫ��5����С����
  carryRule := getParametervalue('1105', SysInfo.LoginUserInfo.OrgID);
  canreturnotherstationticket := (getParametervalue('1106',
      SysInfo.LoginUserInfo.OrgID) = '1');

  ticketnumhituser := StrToIntDef(getParametervalue('1013',
      SysInfo.LoginUserInfo.OrgID), 50);
  canprint := printreturnvoucher;
  if printreturnvoucher then
  begin
    canprint := initReturnTicketNo;
    refreshBill();
    canprint := canprint and initReturnTicketPrinter;
  end;
  gbreturnvoucher.Visible := printreturnvoucher;

 { setCardTypeNOLength(Tcardtypes.VIP, SysInfo.curBillLength.Items['Vip']);
  if getParametervalue('0013', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    TVipcardRW.GetInstance.addObserver(self);
  end;
  onecardcansale := getParametervalue('7003', SysInfo.LoginUserInfo.OrgID)
    = '1';  }
  param1107 := getParametervalue('1107', SysInfo.LoginUserInfo.OrgID);
  param1179 := getParametervalue('1179', SysInfo.LoginUserInfo.OrgID) = '1';

end;

procedure TFrmTicketRetrunRe.FormShow(Sender: TObject);
var
  Fcansellinsure: boolean;
begin
  inherited;
  Fcansellinsure := (getParametervalue('1022', SysInfo.LoginUserInfo.OrgID)
      = '1') or (getParametervalue('1045', SysInfo.LoginUserInfo.OrgID) = '1');
  if not Fcansellinsure then
  begin
    dbgrdhResult.FieldColumns['isreturninsure'].Visible := false;
    dbgrdhResult.FieldColumns['insuranceno'].Visible := false;
    dbgrdhResult.FieldColumns['insurancepaymethodname'].Visible := false;
    dbgrdhResult.FieldColumns['premium'].Visible := false;
    //pnlinsurenos.Visible := false;
   //  rbinsureno.Visible := false;
    //pnlQuery.Height := pnlticketno.Height + pnlinsurenos.Height;
  end;
end;

function TFrmTicketRetrunRe.getticketfee(isselfschedule: boolean;
  ticketsellid: Int64): Currency;
begin
   Result:=-1;
  with jcdsfindticketfee do
  begin
    close;
    Params.ParamValues['isselfschedule']:=jcdsResult.FieldByName('isselfschedule').AsString;
    Params.ParamValues['ticketsellid']:=jcdsResult.FieldValues['id'];
    try
      Execute;
      if Params.ParamValues['flag']=1 then
      begin
        Result:=Params.ParamValues['ticketfee'];
      end
      else
      begin
        if Params.ParamByName('msg').IsNull then
          SysDialogs.ShowError('ȡƱ�۷���ֵ����:δ֪����')
        else
          SysDialogs.Warning(Params.ParamValues['msg']);
      end;
    except on E: Exception do
      SysDialogs.ShowError('ȡƱ�۷���ֵ����:'+e.Message);
    end;
  end;
end;

function TFrmTicketRetrunRe.getticketreturnrate(
  departdatetime: TDateTime;islinework : boolean): Currency;
begin
  with jcdsgetticketreturnrate do
  begin
    Active := false;
    params.ParamValues['departdatetime'] := FormatDateTime
      ('yyyy-MM-dd HH:mm:ss', departdatetime);
    params.ParamValues['islinework'] :=  islinework;
    Execute;
    result := params.ParamByName('returnrate').AsCurrency;
  end;

end;



procedure TFrmTicketRetrunRe.HandleAuthority(const Key: TGUID;
  aEnable: boolean);
begin
  inherited;
  if GUIDToString(Key) = '{55C51B01-8E7A-4FCB-AECB-D10AF516F341}' then // ǩ����������
  begin
    tbtnSave.Visible := aEnable;
  end
  else if GUIDToString(Key) = '{B3E85905-EAB7-4BAD-AE6A-32C742DB58FA}' then
  // ��Ʊ
  begin
    tbtnInsert.Visible := aEnable;
  end
  else if GUIDToString(Key) = '{C0B09961-1913-4776-9C6C-1A9612EBA6F8}' then
  // ������Ʊ
  begin
    tbtnEdit.Visible := aEnable;
  end
  else if GUIDToString(Key) = '{4A900F4B-B714-475F-B70D-1D712BD9A3E2}' then
  // ��Ȩ��Ʊ
  begin
    tbtnDelete.Visible := aEnable;
  end;
end;

function TFrmTicketRetrunRe.initReturnTicketNo: boolean;
var
  functionParm: TFunctionItemParameters;
begin
  returnbilltypecode := PubFn.getParametervalue('1102',
    SysInfo.LoginUserInfo.UserID);
  result := SysInfo.LoginUserInfo.curBillNum.ContainsKey(returnbilltypecode)
    and (SysInfo.LoginUserInfo.curBillNum.Items[returnbilltypecode] > 0);
  if not result then
  begin
    functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := returnbilltypecode;
    SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
      functionParm);
    result := SysInfo.LoginUserInfo.curBillNum.ContainsKey(returnbilltypecode)
      and (SysInfo.LoginUserInfo.curBillNum.Items[returnbilltypecode] > 0);
  end;
end;

function TFrmTicketRetrunRe.initReturnTicketPrinter: boolean;
var
  temp: string;
begin
  inherited;
  result := false;
  try
    if ReturnTicketPrinter=nil then
    begin
      ReturnTicketPrinter := TNovaPrint.Create(self,
      TNovaPrint.GetTicketModelName('��Ʊƾ֤', '��Ʊƾ֤1'));
    end;
    if ReturnTicketPrinter <> nil then
      result := true
    else
      SysDialogs.ShowError('��ʼ����Ʊƾ֤��ӡģ��ʧ�ܣ�δ֪����');
  except
    on E: Exception do
      SysDialogs.ShowError('��ʼ����Ʊƾ֤��ӡģ��ʧ�ܣ�' + E.Message);
  end;

end;

function TFrmTicketRetrunRe.initTicketType: boolean;
begin
  result := false;
  if not Assigned(FcdsTicketType) then
  begin
    FcdsTicketType := TjsonClientDataSet.Create(self);
    with FcdsTicketType do
    begin
      QueryAddress := 'base/findTickettype';
      RemoteServer := DMPublic.jcon;
      DataSourceName := 'tickettypemap';
    end;
  end;
  with FcdsTicketType do
  begin
    Active := false;
    Active := true;
    result := RecordCount > 0;
  end;

end;

function TFrmTicketRetrunRe.leftAddZero(text: string; len: Integer): string;
var
  temp: string;
begin
  while 0 < len - length(text) do
  begin
    text := '0' + text;
  end;
  result := text;
end;

procedure TFrmTicketRetrunRe.nvedtticketnosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=13 then
  begin
    tbtnFilterClick(sender);
    key:=0;
  end;
end;

procedure TFrmTicketRetrunRe.rbticketnoClick(Sender: TObject);
begin
  inherited;
  if Sender = rbticketno then
  begin
    //pnlticketno.Enabled := true;
    nvedtticketnos.SetFocus;
    //pnlschedule.Enabled := false;
    //pnlinsurenos.Enabled := false;
  end
  else if Sender = rbinsureno then
  begin
    //pnlinsurenos.Enabled := true;
    nvedtInsurenos.SetFocus;
    //pnlticketno.Enabled := false;
    //pnlschedule.Enabled := false;
  end
  else if Sender = rbschedule then
  begin
   // pnlschedule.Enabled := true;
    dtpdepartdate.SetFocus;
    //pnlticketno.Enabled := false;
    //pnlinsurenos.Enabled := false;
  end;
end;

procedure TFrmTicketRetrunRe.refreshBill(silent: boolean);
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey(returnbilltypecode)
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey(returnbilltypecode)
    then
  begin
    lblticketno.Caption := SysInfo.LoginUserInfo.curBillNo.Items
      [returnbilltypecode];
    lblleaveticketnum.Caption := IntToStr
      (SysInfo.LoginUserInfo.curBillNum.Items[returnbilltypecode]);
    // ��ʾ�û�
    tmrleaveticketnum.Enabled :=
      (ticketnumhituser > SysInfo.LoginUserInfo.curBillNum.Items
        [returnbilltypecode]);
  end
  else
  begin
    tmrleaveticketnum.Enabled := false;
    if not silent then
      SysDialogs.Warning('��Ʊƾ֤û�г�ʼ��������������ȡ�����ѵĳ�Ʊ��');
    lblticketno.Caption := '0';
    lblleaveticketnum.Caption := '0';
  end;
end;

function TFrmTicketRetrunRe.setBillNoCondition(billnoEdit: TNovaEdit): boolean;
var
  ticketnobegin, ticketnoend: String;
  tmpStringList: TStringList;
  tmpString: string;
  tmpticketno: Int64;
  ticketnos: TStringBuilder;
  hintstr: String;
  conditionstr: String;
  billcode: String;
  ticketnotext, temp: String;
  ticketlength ,insurelength: integer;
begin
  inherited;
  result := false;
  ticketlength := SysInfo.curBillLength.Items['Ticket'];
  insurelength := SysInfo.curBillLength.Items['Insure'];
  if billnoEdit = nvedtticketnos then
  begin
    hintstr := 'Ʊ��';
    conditionstr := 'tsl!ticketno';
    billcode := 'Ticket';
  end
  else
  begin
    hintstr := '������';
    conditionstr := 'isr!insuranceno';
    billcode := 'Insure';
  end;
  with jcdsResult do
  begin
    if trim(billnoEdit.text) = '' then
    begin
      SysDialogs.ShowInfo('������Ҫ��ѯ��' + hintstr);
      billnoEdit.SetFocus;
      exit;
    end;
    if (pos(',', billnoEdit.text) > 0) or (pos('-', billnoEdit.text) > 0) then
    begin
      tmpStringList := TStringList.Create;
      tmpStringList.Delimiter := ',';
      tmpStringList.CommaText := billnoEdit.text;
      ticketnos := TStringBuilder.Create;
      temp := '';
      for tmpString in tmpStringList do
      begin

        if pos('-', tmpString) > 0 then
        begin
          if posex('-', tmpString, pos('-', tmpString) + 1) > 0 then
          begin
            SysDialogs.ShowError(hintstr + '�����ʽ����,���Ʊ�β�ѯ��Ҫ��","������');
            billnoEdit.SetFocus;
            exit;
          end;
          ticketnobegin := copy(tmpString, 1, pos('-', tmpString) - 1);
          ticketnoend := copy(tmpString, pos('-', tmpString) + 1,
            length(tmpString) - pos('-', tmpString));

          ticketnobegin := leftAddZero(ticketnobegin, 8);
          ticketnoend := leftAddZero(ticketnoend, 8);
          if temp = '' then
          begin
            temp := ticketnobegin + '-' + ticketnoend;
          end
          else
          begin
            temp := temp + ',' + ticketnobegin + '-' + ticketnoend;
          end;

          if (length(ticketnoend) <> length(ticketnobegin)) or
            (Abs(StrToInt64(ticketnoend) - StrToInt64(ticketnobegin)) > 50)
            then
          begin
            SysDialogs.ShowError('�������Ʊ����������' + IntToStr(50) + '������������');
            billnoEdit.SetFocus;
            exit;
          end;

          tmpticketno := StrToInt64(ticketnobegin);
          while tmpticketno <= StrToInt64(ticketnoend) do
          begin
            // ticketnos.Append(',''').Append(pubfn.zerofill(inttostr(tmpticketno),SysInfo.curBillLength.Items[billcode])).Append('''');
            ticketnos.Append(',''').Append
              (PubFn.zerofill(IntToStr(tmpticketno), length(ticketnobegin)))
              .Append('''');
            inc(tmpticketno);
          end;
        end
        else
        begin
          // ticketnos.Append(',''').Append(pubfn.zerofill(tmpString,SysInfo.curBillLength.Items[billcode])).Append('''');
          if temp = '' then
          begin
            if billcode='Insure' then
            temp := leftAddZero(tmpString, insurelength)
            else
            temp := leftAddZero(tmpString, ticketlength);
          end
          else
          begin
            if billcode='Insure' then
            temp := temp + ',' + leftAddZero(tmpString, insurelength)
            else
            temp := temp + ',' + leftAddZero(tmpString, ticketlength);
          end;
          if billcode='Insure' then
          ticketnos.Append(',''').Append(leftAddZero(tmpString, insurelength)).Append
            ('''')
            else
          ticketnos.Append(',''').Append(leftAddZero(tmpString, ticketlength)).Append
            ('''');
        end;
      end;
      billnoEdit.text := temp;
      // params.CreateParam(ftString, 'filter_INS_' + conditionstr, ptInput);
      ticketnos.Remove(0, 1).Insert(0, '(').Append(')');
      tmpString := ticketnos.ToString;
      params.ParamValues['filter_INS_' + conditionstr] := ticketnos.ToString;
    end
    else
    begin
      // params.CreateParam(ftString, 'filter_EQS_' + conditionstr, ptInput);
      // params.ParamValues['filter_EQS_'+conditionstr]:=pubfn.zerofill(billnoEdit.Text,SysInfo.curBillLength.Items[billcode]);
      if billcode='Insure' then
      begin
        params.ParamValues['filter_EQS_' + conditionstr] := leftAddZero
        (billnoEdit.text, insurelength);
        billnoEdit.text := leftAddZero(billnoEdit.text, insurelength)
      end
      else
      begin
      params.ParamValues['filter_EQS_' + conditionstr] := leftAddZero
        (billnoEdit.text, ticketlength);
      billnoEdit.text := leftAddZero(billnoEdit.text, ticketlength);
      end;
    end;
    // params.CreateParam(ftString, 'filter_GED_tsl!departdate', ptInput);
    params.ParamValues['filter_GED_tsl!departdate'] := FormatDateTime
      ('yyyy-mm-dd hh:nn:ss', trunc(now - 30));
  end;
  result := true;

end;

procedure TFrmTicketRetrunRe.tbtnFilterClick(Sender: TObject);
var
  ticketnobegin, ticketnoend: String;
  tmpStringList: TStringList;
  tmpString: string;
  tmpticketno: Int64;
  ticketnos: TStringBuilder;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    params.ParamValues['filter_EQD_tsl!departdate'] := null;
    params.ParamValues['filter_EQL_sc!id'] := null;
    params.ParamValues['filter_EQR_tsl!seatno'] := null;
    params.ParamValues['filter_GED_tsl!departdate'] := null;
    params.ParamValues['filter_INS_tsl!ticketno'] := null;
    params.ParamValues['filter_EQS_tsl!ticketno'] := null;
    params.ParamValues['filter_INS_isr!insuranceno'] := null;

    if rbticketno.Checked then
    begin
      if not setBillNoCondition(nvedtticketnos) then
        exit;
    end
    else if rbinsureno.Checked then
    begin
      if not setBillNoCondition(nvedtInsurenos) then
        exit;
    end
    else
    begin
      if nvhelpschedule.Id <= 0 then
      begin
        SysDialogs.ShowInfo('������Ҫ��ѯ�İ��');
        nvhelpschedule.SetFocus;
        exit;
      end;
      // params.CreateParam(ftString, 'filter_EQD_tsl!departdate', ptInput);
      // params.CreateParam(ftString, 'filter_EQL_sc!id', ptInput);
      // params.ParamValues['filter_EQD_tsl!departdate'] := FormatDateTime
      // ('yyyy-mm-dd hh:nn:ss', trunc(dtpdepartdate.Date));
      // params.ParamValues['filter_EQL_sc!id'] := nvhelpschedule.Id;
      if StrToIntDef(nvedtseatno.text, 0) > 0 then
      begin
        // params.CreateParam(ftString, 'filter_EQR_tsl!seatno', ptInput);
        params.ParamValues['filter_EQR_tsl!seatno'] := nvedtseatno.text;
      end;
      //�����ڲ�ѯ
      params.ParamValues['filter_EQD_tsl!departdate'] := FormatDateTime
        ('yyyy-mm-dd hh:nn:ss',trunc(dtpdepartdate.Date));
      params.ParamValues['filter_EQL_sc!id']:= nvhelpschedule.Id;
    end;
    // params.CreateParam(ftInteger, 'flag', ptOutput);
    // params.CreateParam(ftWideString, 'msg', ptOutput);
    Active := true;
    if params.ParamValues['flag'] <> 1 then
    begin
      SysDialogs.Warning(params.ParamValues['msg']);
    end;
    if FieldByName('isreturninsure').AsBoolean then
    begin

    end
    else
    begin
      FieldByName('isreturninsure').ReadOnly:=True;
    end;

    // dbgrdhResult.Refresh;
  end;

end;

procedure TFrmTicketRetrunRe.tbtnInsertClick(Sender: TObject);
var
  charges: Currency;
  totalprice: Currency;
  totalpremium: Currency;
  totalcharges: Currency;
  totalticketnum, totalinsurancenum: Integer;
  printnum: Integer;
  departdatetime: TDateTime;
  rate: Currency;
  oppositeorgid: Int64;
  paymethod: string;
  returntovipcard,islinework: boolean;
  vipcardwriteresult: Integer;
  _curvipCard: TVipCard;
  ticketfee: Currency;
  returnway: string;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
  begin
    exit;
  end;
  totalprice := 0;
  totalpremium := 0;
  totalcharges := 0;
  totalticketnum := 0;
  totalinsurancenum := 0;
  printnum := 0;
  oppositeorgid := 0;
  paymethod := '';
  jsoncdsticketreturn.Active := false;
 // returntovipcard := false;
  // �ж�ѡ�еļ�¼��
  with jcdsResult do
  begin
    //20160323��Զ�������ʾ--����Ʊ�����Ʊ��ʾ���ó�Ʊ���ˡ�
    if (rbticketno.Checked) and (jcdsResult.FieldByName('ticketstatus').AsString='1') then
    begin
     SysDialogs.ShowMessage('�ó�Ʊ����!');
     Exit;
    end;

    DisableControls;
    First;
    while not eof do
    begin
     { if FieldByName('isselected').IsNull then
      begin
        SysDialogs.Warning('�ó�Ʊ�Ѿ���������Ʊ����������Ʊ!');
        EnableControls;
        exit;
      end;  }

      if FieldByName('isselected').AsBoolean or FieldByName('isreturninsure')
        .AsBoolean then
      begin
        if FieldByName('ischecked').AsBoolean then
        begin
          SysDialogs.Warning('�ó�Ʊ�Ѿ���Ʊ����������Ʊ!');
          EnableControls;
          exit;
        end;

        // �ж��Ƿ��۵�ͬһ����վ��Ʊ           //and (not fieldbyname('isselfschedule').AsBoolean)
        if FieldByName('isselected').AsBoolean and
          ((FieldByName('isselfschedule').AsBoolean and (FieldByName('sellby')
                .AsInteger = 0)) or (not FieldByName('isselfschedule')
              .AsBoolean)) then
        begin
          if oppositeorgid = 0 then
          begin
            oppositeorgid := FieldValues['orgid'];
          end
          else if oppositeorgid <> FieldValues['orgid'] then
          begin
            SysDialogs.Warning('��Ʊ����ͬʱ�˲�ͬ�Է���վ��������ĳ�Ʊ!');
            EnableControls;
            exit;
          end;
        end;

        try
        //�ж��Ƿ񳬹�����ʱ��
        if CompareDateTime(EncodeDateTime
              (YearOf(FieldByName('departdate').AsDateTime),
              MonthOfTheYear(FieldByName('departdate').AsDateTime),
              DayOfTheMonth(FieldByName('departdate').AsDateTime),
              StrToInt(copy(FieldByName('departtime').AsString, 1, pos(':',
                    FieldByName('departtime').AsString) - 1)),
              StrToInt(copy(FieldByName('departtime').AsString, pos(':',
                    FieldByName('departtime').AsString) + 1)), 0, 0),Now)
           = -1  then
        begin
          if not SysDialogs.Confirm('ȷ����Ʊ','�˳�Ʊ�ѹ�����ʱ�䣬�Ƿ������Ʊ��') then
          begin
              EnableControls;
                   Exit;
          end;

        end;
        except
          on E: Exception do
          begin
            SysLog.WriteErr('��Ʊ�ж��Ƿ񳬹�����ʱ������쳣��' + E.Message);
          end;
        end;

          // �ж��Ƿ��쳣����
         if (FieldByName('isselected').AsBoolean) and
          (FieldByName('sellway').AsInteger = 7)
         then
        begin
          with qryjcdseticket do
          begin
            begin
              qryjcdseticket.active := false;
              qryjcdseticket.params.ParamValues['filter_EQS_ts!id'] :=
                jcdsResult.FieldByName('id').AsString;
              qryjcdseticket.active := True;
            end;
            if qryjcdseticket.RecordCount > 0 then
            begin
              SysDialogs.Warning('���ⶩ����������Ʊ!');
              EnableControls;
              exit;
            end;
          end;
        end;

        // �ж��Ƿ���VIP�����Ʊ
        if FieldByName('paymethod').AsString = '2' then
        begin
          returntovipcard := true;
          if paymethod <> '' then
          begin
            SysDialogs.Warning('VIP����ĳ�Ʊ���ܺ�����֧����ʽ����ĳ�Ʊͬʱ��Ʊ!��ֿ���Ʊ');
            EnableControls;
            exit;
          end;
        end
        else
        begin
          // �����VIP�����Ʊ��ʽ
          paymethod := FieldByName('paymethod').AsString;
        end;

        if Sender = tbtnEdit then // ����ȫ����Ʊ
        begin
          if param1107='3' then
            charges := 4
          else
            charges := 0;
        end
        else
        begin
          if FieldValues['signcharges'] <> null then
          begin
            charges := FieldValues['signcharges'];
          end
          else if FieldByName('status').AsString = '1' then // ��ͣ
          begin
            charges := 0;
          end
          else
          begin
            departdatetime := EncodeDateTime
              (YearOf(FieldByName('departdate').AsDateTime),
              MonthOfTheYear(FieldByName('departdate').AsDateTime),
              DayOfTheMonth(FieldByName('departdate').AsDateTime),
              StrToInt(copy(FieldByName('departtime').AsString, 1, pos(':',
                    FieldByName('departtime').AsString) - 1)),
              StrToInt(copy(FieldByName('departtime').AsString, pos(':',
                    FieldByName('departtime').AsString) + 1)), 0, 0);
            islinework := FieldByName('islinework').AsBoolean;
            if FieldByName('openapiorgname').AsString='' then //��������openApi��Ʊ
            begin
               rate := getticketreturnrate(departdatetime,islinework);
            end
            else
            begin
               rate := FieldByName('rate').AsCurrency; //openApi��Ʊ����Ʊ��������ȡ���ýӿڻ�ȡ��
            end;
//            rate := getticketreturnrate(departdatetime,islinework);
            if (rate = 1) and (Sender = tbtnInsert) then
            begin
              SysDialogs.Warning('��Ʊ��������Ϊ100%��Ʊ�����壡');
              exit;
            end;


            if FieldByName('openapiorgname').AsString='' then //��������openApi��Ʊ
            begin
              if ((param1107 ='1') or (param1107 ='2')) then
              begin
                ticketfee := getticketfee(FieldByName('isselfschedule')
                    .AsBoolean, FieldByName('id').AsLargeInt);
                if ticketfee < 0 then
                begin
                  SysDialogs.ShowError('ȡƱ�۷������');
                  exit;
                end;
                if param1107 ='1' then
                begin
                charges := carry
                  (ticketfee + (FieldByName('price').AsCurrency - ticketfee)
                    * rate);
                end
                else  if param1107 ='2' then
                begin
                charges := carry    //charges+
                  ( FieldByName('price').AsCurrency
                    * rate + ticketfee);
                end;
              end
              else  if param1107 ='0' then
              begin
                charges := carry(FieldByName('price').AsCurrency * rate);
              end
              else
              begin
                charges  := carry(4 + (FieldByName('price').AsCurrency - 4)* rate);
              end;
            end
            else
            begin
              //openApi��Ʊ����Ʊ������ȡ���ýӿڻ�ȡ��
              charges := FieldByName('charges').AsCurrency;
            end;


          end;
        end;
        if FieldByName('isselected').AsBoolean then
        begin
          if (charges > 0) and printreturnvoucher and (not canprint) then
          begin
            SysDialogs.ShowError('����Ʊ�ݻ��ӡģ��û�г�ʼ����ϵͳҪ���ӡ�����ѣ�');
            EnableControls;
            exit;
          end;
          totalprice := totalprice + FieldValues['price'];
          totalcharges := totalcharges + charges;
          inc(totalticketnum);
        end;
        if not jsoncdsticketreturn.Active then
        begin
          jsoncdsticketreturn.Active := true;
        end;
        jsoncdsticketreturn.Append;
        jsoncdsticketreturn.FieldValues['charges'] := charges;
        // jsoncdsticketreturn.FieldValues['totalcharges'] := totalcharges;
        jsoncdsticketreturn.FieldValues['ticketprice'] := FieldValues['price'];
        jsoncdsticketreturn.FieldValues['returnamount'] :=
          jsoncdsticketreturn.FieldValues['ticketprice']
          - jsoncdsticketreturn.FieldValues['charges'];

        jsoncdsticketreturn.FieldValues['isselfschedule'] := FieldValues
          ['isselfschedule'];
        jsoncdsticketreturn.FieldValues['sellid'] := FieldValues['id'];

        jsoncdsticketreturn.FieldValues['isreturnticket'] := FieldValues
          ['isselected'];
        jsoncdsticketreturn.FieldValues['isreturninsure'] := FieldValues
          ['isreturninsure'];
        if (FieldByName('isreturninsure').AsBoolean) then
        begin
            inc(totalinsurancenum);
            totalpremium := totalpremium + FieldValues['premium'];
        end;
        jsoncdsticketreturn.FieldValues['returninsureid'] := FieldValues
          ['insuranceid'];
        if printreturnvoucher and SysInfo.LoginUserInfo.curBillNo.ContainsKey
          (returnbilltypecode) then
        begin
          jsoncdsticketreturn.FieldValues['returnvoucherno'] :=
            SysInfo.LoginUserInfo.curBillNo.Items[returnbilltypecode];
        end
        else
        begin
          jsoncdsticketreturn.FieldValues['returnvoucherno'] := null;
        end;
        if Sender = tbtnEdit then // ����ȫ����Ʊ
        begin
          jsoncdsticketreturn.FieldValues['returnway'] := '1';
        end
        else if Sender = tbtnDelete then // ��Ȩ��Ʊ
        begin
          jsoncdsticketreturn.FieldValues['returnway'] := '2';
        end
        else
        begin
          jsoncdsticketreturn.FieldValues['returnway'] := '0';
          returnway := '0';
        end;
        jsoncdsticketreturn.FieldValues['ticketoutletsid'] :=
          SysInfo.LoginUserInfo.ticketoutletsid;

        jsoncdsticketreturn.post;
      end;
      next;
    end;
    EnableControls;
  end;
  if jsoncdsticketreturn.Active and (jsoncdsticketreturn.RecordCount > 0) then
  begin
    Frmreturnticketend := TFrmreturnticketend.Create(self);
    //��Ȩ��Ʊ ��  ������Ʊ����ӡ�����ѷ�Ʊ
    if (Sender = tbtnEdit)  then
    begin
      Frmreturnticketend.ChkIsPrint.Enabled:=True;
      Frmreturnticketend.ChkIsPrint.Checked:=False;
      Frmreturnticketend.ChkIsPrint.Caption:='����ӡ�����ѷ�Ʊ';
      Frmreturnticketend.ChkIsPrint.Enabled:=False;
    end;
    try
      // �˴���ֵ����������Ʊ���汣��ʱ�������ж�һ����Ʊ���Ƿ����ı�
      Frmreturnticketend._totalcharges := totalcharges;
      Frmreturnticketend._returnway := returnway;
      if Sender = tbtnDelete then // ��Ȩ��Ʊ
      begin
        Frmreturnticketend.rbrate.Checked := true;
        Frmreturnticketend.nvedtrate.text := CurrToStr(rate * 100);
        Frmreturnticketend.totalpremium := totalpremium;
        with jsoncdsticketreturn do
        begin
          First;
          while not eof do
          begin
            Frmreturnticketend.returnticketsprice.Add(FieldByName('ticketprice').AsCurrency);
            next;
          end;
        end;
        if not Frmreturnticketend.pnlsetcharge.Visible then
        begin
          Frmreturnticketend.pnlsetcharge.Visible := true;
          Frmreturnticketend.Height := Frmreturnticketend.Height +
            Frmreturnticketend.pnlsetcharge.Height;
        end;
      end
      else
      begin
        if Frmreturnticketend.pnlsetcharge.Visible then
        begin
          Frmreturnticketend.pnlsetcharge.Visible := false;
          Frmreturnticketend.Height := Frmreturnticketend.Height -
            Frmreturnticketend.pnlsetcharge.Height;
        end;
      end;
      Frmreturnticketend.returntovipcard := returntovipcard;
      Frmreturnticketend.stationfee := ticketfee ;
      Frmreturnticketend.param1107 :=param1107;
      Frmreturnticketend.lblticketnum.Caption := IntToStr(totalticketnum);
      Frmreturnticketend.lblinsurenum.Caption := IntToStr(totalinsurancenum);
      Frmreturnticketend.lblticketreceivablenum.Caption := CurrToStr
        (totalprice - totalcharges);
      Frmreturnticketend.lblinsurereceivablenum.Caption := CurrToStr
        (totalpremium);
      Frmreturnticketend.lbltickettotalnum.Caption := CurrToStr(totalprice);
      Frmreturnticketend.lblticketcharge.Caption := CurrToStr(totalcharges);
      Frmreturnticketend.lblinsuretotalnum.Caption := CurrToStr(totalpremium);
      Frmreturnticketend.lblreceivablenum.Caption := CurrToStr
        (totalprice - totalcharges + totalpremium);
      if SysMainForm.showFormModal(Frmreturnticketend, false) = mrok then
      begin
        with jsoncdsticketreturn do
        begin
          if trim(Frmreturnticketend.mmoreason.text) <> '' then
          begin
            First;
            while not eof do
            begin
              edit;
              jsoncdsticketreturn.FieldValues['remarks'] :=
                Frmreturnticketend.mmoreason.text;
              post;
              next;
            end;
          end;
          if Sender = tbtnDelete then // ��Ȩ��Ʊ
          begin
            First;
            while not eof do
            begin
              edit;
              if Frmreturnticketend.rbrate.Checked then
              begin
                jsoncdsticketreturn.FieldValues['charges'] :=
                  FrmTicketRetrunRe.carry
                  (FieldByName('ticketprice').AsCurrency * StrToCurrDef
                    (Frmreturnticketend.nvedtrate.text, 0) / 100);
              end
              else
              begin
                jsoncdsticketreturn.FieldValues['charges'] := min
                  (StrToCurrDef(Frmreturnticketend.nvedtfix.text, 0),
                  FieldByName('ticketprice').AsCurrency);
              end;
              jsoncdsticketreturn.FieldValues['returnamount'] :=
                jsoncdsticketreturn.FieldValues['ticketprice']
                - jsoncdsticketreturn.FieldValues['charges'];
              post;
              next;
            end;
          end;
          {if returntovipcard then // VIP�������֧��
          begin
            if (curvipCard <> nil) then
            begin
              _curvipCard := curvipCard;
              jsoncdsticketreturn.params.ParamValues['vipcardno'] :=
                _curvipCard.cardNo;
              jsoncdsticketreturn.params.ParamValues['vipgrade'] := IntToStr
                (Integer(_curvipCard.cardGrade));
              jsoncdsticketreturn.params.ParamValues['vipmoney'] :=
                _curvipCard.money;
              jsoncdsticketreturn.params.ParamValues['vippoint'] :=
                _curvipCard.amount;
            end
            else
            begin
              SysDialogs.ShowInfo('��ǰѡ�еĳ�Ʊ��Ʊʱ�����Ҫ�˵�VIP���С��뽫VIP���ŵ���������');
              exit;
            end;
          end
          else
          begin
            jsoncdsticketreturn.params.ParamValues['vipcardno'] := null;
          end; }
          jsoncdsticketreturn.params.ParamValues['canprint'] :=
            Frmreturnticketend.ChkIsPrint.Checked;
          try
            if (ApplyUpdates(-1) <> 0) then
            begin
              SysDialogs.Warning('��Ʊʧ��:δ֪����');
            end;
            if params.ParamValues['flag'] = 1 then
            begin
              // if printreturnvoucher and canprint then
              // �Ƿ��ӡ��Ϊ���û��Լ�ѡ��
              if printreturnvoucher and canprint and Frmreturnticketend.
                ChkIsPrint.Checked then
              begin
                First;
                while not eof do
                begin
                  if FieldByName('charges').AsCurrency <= 0 then
                  begin
                    next;
                    Continue;
                  end;
                  if FieldByName('isreturnticket').AsBoolean and
                    (not FieldByName('returnvoucherno').IsNull) and
                    (trim(FieldByName('returnvoucherno').AsString) <> '') then
                  begin
                    inc(printnum);
                    ReturnTicketPrinter.SingleValue.Clear;
                    // ReturnTicketPrinter.SingleValue.AddOrSetValue('charges',
                    // FieldByName('charges').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue
                      ('ticketprice', FieldByName('ticketprice').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue
                      ('returnamount',
                      FieldByName('returnamount').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue
                      ('returnvoucherno',
                      FieldByName('returnvoucherno').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue('returntime',
                      FieldByName('returntime').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue
                      ('ticketoutletsname',
                      SysInfo.LoginUserInfo.ticketoutletsname);
                    jcdsResult.DisableControls;
                    jcdsResult.First;
                    while not jcdsResult.eof do
                    begin
                      if jcdsResult.FieldValues['id'] = FieldValues['sellid']
                        then
                      begin
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('sellbycode', SysInfo.LoginUserInfo.UserCode);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('sellbyname', SysInfo.LoginUserInfo.UserName);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('ticketno',
                          jcdsResult.FieldByName('ticketno').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('schedulecode',
                          jcdsResult.FieldByName('schedulecode').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('customername',
                          jcdsResult.FieldByName('customername').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('departstationname',
                          jcdsResult.FieldByName('departstationname')
                            .AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('reachstationname',
                          jcdsResult.FieldByName('reachstationname').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('departdate',
                          jcdsResult.FieldByName('departdate').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('departtime',
                          jcdsResult.FieldByName('departtime').AsString);
                        ReturnTicketPrinter.SingleValue.AddOrSetValue('seatno',
                          jcdsResult.FieldByName('seatno').AsString);
                        if FieldByName('isreturninsure').AsBoolean then
                        begin
                          ReturnTicketPrinter.SingleValue.AddOrSetValue
                            ('insureno',
                            jcdsResult.FieldByName('insuranceno').AsString);
                          ReturnTicketPrinter.SingleValue.AddOrSetValue
                            ('premium',
                            jcdsResult.FieldByName('premium').AsString);
                        end;
                        break;
                      end;
                      jcdsResult.next;
                    end;
                    jcdsResult.EnableControls;
                    if istotalprint then
                    begin
                      if Sender = tbtnDelete then // ��Ȩ��Ʊ
                      begin
                      //������
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('charges',
                          floattostr(strtofloat(Frmreturnticketend.lblticketcharge.Caption)
                          + strtofloat(Frmreturnticketend.Label8.Caption)));
                          //CurrToStr(FieldByName('charges').AsCurrency * totalticketnum));
                      end
                      else
                      begin
                        //������
                        ReturnTicketPrinter.SingleValue.AddOrSetValue
                          ('charges', CurrToStr(totalcharges));
                      end;
                      ReturnTicketPrinter.SingleValue.AddOrSetValue
                        ('returnnum', IntToStr(totalticketnum));
                      // ��Ʊ����
                      ReturnTicketPrinter.Print;
                      break;
                    end;
                    ReturnTicketPrinter.SingleValue.AddOrSetValue('charges',
                      FieldByName('charges').AsString);
                    ReturnTicketPrinter.SingleValue.AddOrSetValue('returnnum',
                      '1'); // ��Ʊ����
                    ReturnTicketPrinter.Print;
                  end;
                  next;
                end;
              end;
              if printreturnvoucher and SysInfo.LoginUserInfo.curBillNo.
                ContainsKey(returnbilltypecode) then
              begin
                with SysInfo.LoginUserInfo do
                begin
                  curBillNo.AddOrSetValue(returnbilltypecode,
                    zerofill(IntToStr(StrToInt64
                          (curBillNo.Items[returnbilltypecode]) + printnum),
                      length(curBillNo.Items[returnbilltypecode])));
                  curBillNum.AddOrSetValue(returnbilltypecode,
                    curBillNum.Items[returnbilltypecode] - printnum);
                end;
                refreshBill;
              end;
              pnllastmoney.Visible := true;
              lbllastmoney.Caption :=
                Frmreturnticketend.lbltickettotalnum.Caption;
              lblreceipt.Caption := Frmreturnticketend.lblticketcharge.Caption;
              lblchange.Caption := Frmreturnticketend.lblreceivablenum.Caption;
              pnllastmoney.Width := lbllastmoney.Width + lblreceipt.Width +
                lblchange.Width + lbl1.Width + lbl4.Width + lbl5.Width + 20;
              // д��
              if (_curvipCard <> nil) then
              begin
                if returntovipcard then // VIP�������֧��
                begin
                  _curvipCard.incrementmoney
                    (StrToCurr(Frmreturnticketend.lblreceivablenum.Caption));
                  _curvipCard.decrementamount
                    (StrToCurr(Frmreturnticketend.lblreceivablenum.Caption));
                  vipcardwriteresult := _curvipCard.writeCard;
                  while (vipcardwriteresult <> 0) do
                  begin
                    SysDialogs.Warning('д��ʧ�ܣ�' + _curvipCard.getErrorInfo
                        (vipcardwriteresult) + '����ź�VIP������ȷ������д����');
                    vipcardwriteresult := _curvipCard.writeCard;
                  end;
                end;
              end;
              if params.ParamByName('msg').IsNull or
                (trim(params.ParamByName('msg').AsString) = '') then
                SysDialogs.ShowMessage('��Ʊ�ɹ���')
              else
                SysDialogs.ShowMessage(params.ParamValues['msg']);
              tbtnFilterClick(nil);
              //clearvipinfo;
              if rbticketno.Checked then
              begin
                nvedtticketnos.Clear;
                nvedtticketnos.SetFocus;
              end;
            end
            else
            begin
              if params.ParamByName('msg').IsNull then
                SysDialogs.ShowError('��Ʊʧ��:δ֪����')
              else
                SysDialogs.Warning(params.ParamValues['msg']);
            end;
          except
            on E: Exception do
              SysDialogs.ShowError('��Ʊʧ��:' + E.Message);
          end;
        end;
      end;
    finally
      freeandnil(Frmreturnticketend);
    end;
  end;
end;

procedure TFrmTicketRetrunRe.tbtnSaveClick(Sender: TObject);
var
  Frmsignticket: TFrmsignticket;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
    exit;
  // �ж�ѡ�еļ�¼��
  with jcdsResult do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      if FieldByName('isselected').AsBoolean then
      begin
        if not Assigned(Frmsignticket) then
        begin
          Frmsignticket := TFrmsignticket.Create(self);
          Frmsignticket.jsoncdsticketsign.Active := true;
        end;
        Frmsignticket.jsoncdsticketsign.Append;
        Frmsignticket.jsoncdsticketsign.FieldValues['isselfschedule'] :=
          FieldValues['isselfschedule'];
        Frmsignticket.jsoncdsticketsign.FieldValues['sellid'] := FieldValues
          ['id'];
        Frmsignticket.jsoncdsticketsign.FieldValues['ticketprice'] :=
          FieldValues['price'];
      end;
      next;
    end;
    EnableControls;
  end;
  if Assigned(Frmsignticket) then
  begin
    try
      if SysMainForm.showFormModal(Frmsignticket, false) = mrok then
      begin
        // ����ѡ�еļ�¼
        tbtnFilterClick(nil);
      end;
    finally
      freeandnil(Frmsignticket);
    end;
  end;
end;

procedure TFrmTicketRetrunRe.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmTicketRetrunRe.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

end.
