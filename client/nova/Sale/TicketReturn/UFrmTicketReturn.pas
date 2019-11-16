unit UFrmTicketReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit, services, PubFn, StrUtils, UDMPublic,
  NovaPrint, FunctionItemIntf , DateUtils, math, UICcardRW, Buttons;

type
  TFrmTicketReturn = class(TSimpleCRUDForm, Ivipcardfound)
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
    jsoncdsticketreturn: TjsonClientDataSet;
    gbreturnvoucher: TGroupBox;
    lblticketno: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblleaveticketnum: TLabel;
    pnlinsurenos: TPanel;
    nvedtInsurenos: TNovaEdit;
    rbinsureno: TRadioButton;
    tmrRefreshBill: TTimer;
    tmrleaveticketnum: TTimer;
    pnllastmoney: TPanel;
    lbl1: TLabel;
    lbllastmoney: TLabel;
    lbl4: TLabel;
    lblreceipt: TLabel;
    lbl5: TLabel;
    lblchange: TLabel;
    jcdsreprint: TjsonClientDataSet;
    jcdsgetticketreturnrate: TjsonClientDataSet;
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
    jcdsfindticketfee: TjsonClientDataSet;
    jcdsResultisselected: TBooleanField;
    procedure rbticketnoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure nvedtticketnosKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure dsResultDataChange(Sender: TObject; Field: TField);
    procedure ToolButton51Click(Sender: TObject);
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure dbgrdhResultDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure nvhelpscheduleKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnclearvipinfoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    // FcdsDDDschedulestatus:TjsonClientDataSet;    //���״̬
    ticketnumhituser: Integer;
    FcdsDDDseattype: TjsonClientDataSet; // Ʊ����λ����
    FcdsDDDpaymethod: TjsonClientDataSet; // ֧����ʽ
    FcdsDDDsellway: TjsonClientDataSet; // ��Ʊ��ʽ
    FcdsDDDticketstatus: TjsonClientDataSet; // ��Ʊ״̬
    FcdsTicketType: TjsonClientDataSet; // Ʊ��
    printreturnvoucher: boolean; // �Ƿ���Ҫ��ӡ��Ʊƾ֤
    istotalprint: boolean; // �����������Ƿ�ϴ�
    returnbilltypecode: string; // ��Ʊƾ֤ʹ��Ʊ�ݵı���
    carryRule: string; // ��Ʊ�����ѽ�λ����
    ReturnTicketPrinter: TNovaPrint;

    canprint: boolean; // �ܷ��ӡ��Ʊƾ֤
    onecardcansale: boolean; // һ��ͨ�Ƿ�����ڴ��ڹ�Ʊ

    canreturnotherstationticket: boolean; // ����ʽ�����£���վ�ܷ�����վ����վƱ1106
    function initReturnTicketNo: boolean;
    function initReturnTicketPrinter: boolean;
    function initTicketType: boolean;
    procedure initjcdsResult;
    procedure refreshBill(silent: boolean = false);
    function setBillNoCondition(billnoEdit: TNovaEdit): boolean;
    function leftAddZero(text: string; len: Integer): string;
  public
    { Public declarations }
    param1107: boolean; // ��Ʊ�����Ѽ���ǰ�Ƿ�۳���Ʊ�۷���ֵ
    curvipCard: TVipCard;
    procedure clearvipinfo;
    procedure vipcardfound(vipCard: TVipCard);
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
    function carry(fee: Double): Currency;
    function getticketreturnrate(departdatetime: TDateTime): Currency;
    function getticketfee(isselfschedule: boolean;
      ticketsellid: Int64): Currency; // ȡ��Ʊ��Ʊ�۷���ϼ�
    procedure setTotalfee;
  end;

var
  FrmTicketReturn: TFrmTicketReturn;

implementation

uses UFrmsignticket, UFrmreturnticketend;

const
  maxticketnum = 50;
{$R *.dfm}

procedure TFrmTicketReturn.refreshBill(silent: boolean);
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

function TFrmTicketReturn.leftAddZero(text: string; len: Integer): string;
var
  temp: string;
begin
  while 0 < len - length(text) do
  begin
    text := '0' + text;
  end;
  result := text;
end;

function TFrmTicketReturn.setBillNoCondition(billnoEdit: TNovaEdit): boolean;
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
begin
  inherited;
  result := false;
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
            temp := leftAddZero(tmpString, 8);
          end
          else
          begin
            temp := temp + ',' + leftAddZero(tmpString, 8);
          end;
          ticketnos.Append(',''').Append(leftAddZero(tmpString, 8)).Append
            ('''');
        end;
      end;
      billnoEdit.text := temp;
      params.CreateParam(ftString, 'filter_INS_' + conditionstr, ptInput);
      ticketnos.Remove(0, 1).Insert(0, '(').Append(')');
      tmpString := ticketnos.ToString;
      params.ParamValues['filter_INS_' + conditionstr] := ticketnos.ToString;
    end
    else
    begin
      params.CreateParam(ftString, 'filter_EQS_' + conditionstr, ptInput);
      // params.ParamValues['filter_EQS_'+conditionstr]:=pubfn.zerofill(billnoEdit.Text,SysInfo.curBillLength.Items[billcode]);
      params.ParamValues['filter_EQS_' + conditionstr] := leftAddZero
        (billnoEdit.text, 8);
      billnoEdit.text := leftAddZero(billnoEdit.text, 8);
    end;
    params.CreateParam(ftString, 'filter_GED_tsl!departdate', ptInput);
    params.ParamValues['filter_GED_tsl!departdate'] := FormatDateTime
      ('yyyy-mm-dd hh:nn:ss', trunc(now - 120));
  end;
  result := true;
end;

procedure TFrmTicketReturn.FormShow(Sender: TObject);
var
  Fcansellinsure: boolean;
begin
  inherited;
  dbgrdhResult.jsonConnection := DMPublic.jcon;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  Fcansellinsure := (getParametervalue('1022', SysInfo.LoginUserInfo.OrgID)
      = '1') or (getParametervalue('1045', SysInfo.LoginUserInfo.OrgID) = '1');
  if not Fcansellinsure then
  begin
    dbgrdhResult.FieldColumns['isreturninsure'].Visible := false;
    dbgrdhResult.FieldColumns['insuranceno'].Visible := false;
    dbgrdhResult.FieldColumns['insurancepaymethodname'].Visible := false;
    dbgrdhResult.FieldColumns['premium'].Visible := false;
    pnlinsurenos.Visible := false;
    rbinsureno.Visible := false;
    pnlQuery.Height := pnlticketno.Height + pnlinsurenos.Height;
  end;
end;

function TFrmTicketReturn.getticketfee(isselfschedule: boolean;
  ticketsellid: Int64): Currency;
begin
  result := -1;
  with jcdsfindticketfee do
  begin
    close;
    params.ParamValues['isselfschedule'] := jcdsResult.FieldByName
      ('isselfschedule').AsString;
    params.ParamValues['ticketsellid'] := jcdsResult.FieldValues['id'];
    try
      Execute;
      if params.ParamValues['flag'] = 1 then
      begin
        result := params.ParamValues['ticketfee'];
      end
      else
      begin
        if params.ParamByName('msg').IsNull then
          SysDialogs.ShowError('ȡƱ�۷���ֵ����:δ֪����')
        else
          SysDialogs.Warning(params.ParamValues['msg']);
      end;
    except
      on E: Exception do
        SysDialogs.ShowError('ȡƱ�۷���ֵ����:' + E.Message);
    end;
  end;
end;

function TFrmTicketReturn.getticketreturnrate(departdatetime: TDateTime)
  : Currency;
// var _now : TDateTime;
begin
  // _now:=now;
  with jcdsgetticketreturnrate do
  begin
    Active := false;
    { if _now<departdatetime then
      Params.ParamValues['hoursbetweendeparttime']:=MinutesBetween(_now,departdatetime) div 60
      else
      Params.ParamValues['hoursbetweendeparttime']:=-1*(MinutesBetween(_now,departdatetime) div 60)-1; }
    params.ParamValues['departdatetime'] := FormatDateTime
      ('yyyy-MM-dd HH:mm:ss', departdatetime);
    Execute;
    result := params.ParamByName('returnrate').AsCurrency;
  end;
end;

procedure TFrmTicketReturn.HandleAuthority(const Key: TGUID; aEnable: boolean);
begin
  inherited;
  if GUIDToString(Key) = '{55C51B01-8E7A-4FCB-AECB-D10AF516F341}' then // ǩ����������
  begin
    ToolButton50.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{B3E85905-EAB7-4BAD-AE6A-32C742DB58FA}' then
  // ��Ʊ
  begin
    ToolButton51.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{C0B09961-1913-4776-9C6C-1A9612EBA6F8}' then
  // ������Ʊ
  begin
    ToolButton52.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{4A900F4B-B714-475F-B70D-1D712BD9A3E2}' then
  // ��Ȩ��Ʊ
  begin
    ToolButton53.Enabled := aEnable;
  end;
end;

procedure TFrmTicketReturn.initjcdsResult;
var
  i: Integer;
begin
  with jcdsResult do
  begin
    i := -1;
    createField('isselfschedule', '', ftBoolean, 0, incEx(i), jcdsResult);
    // createField('isselected', '', ftBoolean, 0, incEx(i), jcdsResult);
    createField('isreturninsure', '', ftBoolean, 0, incEx(i), jcdsResult);
    createField('id', '', ftLargeint, 0, incEx(i), jcdsResult);
    // createField('scheduleplanid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('orgid', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('scheduleorgid', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('sellby', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('departstationid', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('reachstationid', '', ftLargeint, 0, incEx(i), jcdsResult);
    // createField('scheduleid', '', ftLargeint,0, incEx(i), jcdsResult) ;
    createField('ticketsignid', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('signby', '', ftLargeint, 0, incEx(i), jcdsResult);
    createField('insuranceid', '', ftLargeint, 0, incEx(i), jcdsResult);

    createField('seatno', '', ftInteger, 0, incEx(i), jcdsResult);

    createField('ischecked', '', ftBoolean, 0, incEx(i), jcdsResult);
    createField('isdepartinvoices', '', ftBoolean, 0, incEx(i), jcdsResult);
    createField('islinework', '', ftBoolean, 0, incEx(i), jcdsResult);

    createField('signtime', '', ftDateTime, 0, incEx(i), jcdsResult);
    createField('selltime', '', ftDateTime, 0, incEx(i), jcdsResult);
    createField('departdate', '', ftDate, 0, incEx(i), jcdsResult);

    createField('premium', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('signcharges', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('fullprice', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('price', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('rate', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('charges', '', ftFloat, 0, incEx(i), jcdsResult);
    createField('servicefee', '', ftFloat, 0, incEx(i), jcdsResult);

    createField('departtime', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('paymethod', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('ticketno', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('sellway', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('ticketstatus', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('tickettype', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('seattype', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('signreason', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('insurancepaymethod', '', ftWideString, 10, incEx(i),
      jcdsResult);
    createField('insuranceno', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('signbyname', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('sellbyname', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('schedulecode', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('customername', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('departstationname', '', ftWideString, 10, incEx(i),
      jcdsResult);
    createField('reachstationname', '', ftWideString, 10, incEx(i), jcdsResult);
    createField('status', '', ftWideString, 10, incEx(i), jcdsResult);

    createLookupField('tickettypeprintname', '', 'tickettype', 'code',
      'printname', ftWideString, 50, incEx(i), jcdsResult, FcdsTicketType);
    createLookupField('paymethodname', '', 'paymethod', 'code', 'value',
      ftWideString, 50, incEx(i), jcdsResult, FcdsDDDpaymethod);
    createLookupField('insurancepaymethodname', '', 'insurancepaymethod',
      'code', 'value', ftWideString, 50, incEx(i), jcdsResult,
      FcdsDDDpaymethod);
    createLookupField('sellwayname', '', 'sellway', 'code', 'value',
      ftWideString, 50, incEx(i), jcdsResult, FcdsDDDsellway);
    createLookupField('ticketstatusname', '', 'ticketstatus', 'code', 'value',
      ftWideString, 50, incEx(i), jcdsResult, FcdsDDDticketstatus);

    // with DefaultFieldClasses[ftBoolean].Create(jcdsResult) do
    // begin
    // FieldName:='isselected';
    // DisplayLabel := 'ѡ��';
    // Index := 0;
    // FieldKind:=fkInternalCalc;
    // DataSet:=jcdsResult;
    // end;
    // with DefaultFieldClasses[ftBoolean].Create(jcdsResult) do
    // begin
    // FieldName:='isreturninsure';
    // DisplayLabel := '�˱���';
    // Index := 1;
    // FieldKind:=fkInternalCalc;
    // DataSet:=jcdsResult;
    // end;
  end;
end;

function TFrmTicketReturn.initTicketType: boolean;
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
      // Params.CreateParam(ftString,'userid',ptInput);
      // Params.CreateParam(ftString,'roleid',ptInput);
      // Params.CreateParam(ftString,'ticketoutletsid',ptInput);
    end;
  end;
  with FcdsTicketType do
  begin
    Active := false;
    // Params.ParamValues['userid']:= SysInfo.LoginUserInfo.UserID;
    // Params.ParamValues['roleid']:=SysInfo.LoginUserInfo.RoleID;
    // Params.ParamValues['ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
    Active := true;
    result := RecordCount > 0;
  end;
end;

procedure TFrmTicketReturn.btnclearvipinfoClick(Sender: TObject);
begin
  inherited;
  clearvipinfo;
  jcdsResult.Active := false;
  FormActivate(nil);
end;

function TFrmTicketReturn.carry(fee: Double): Currency;
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
  else // 5
  begin
    result := fee;
  end
end;

procedure TFrmTicketReturn.dbgrdhResultDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  if (not jcdsResult.FieldByName('isselfschedule').AsBoolean) and not
    (gdSelected in State) then
  begin // ����վƱ
    dbgrdhResult.Canvas.Font.Color := clGreen;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end
  else if (jcdsResult.FieldByName('sellby').AsInteger = 0) and not
    (gdSelected in State) then // ��վ�۱�վƱ
  begin
    dbgrdhResult.Canvas.Font.Color := clSkyBlue; // clYellow;
    dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // else (jcdsResult.FieldByName('status').AsString = '3') and not
  // (gdSelected in State) then //��վ�۱�վ
  // begin
  // dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
  // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end
end;

procedure TFrmTicketReturn.dbgrdhResultKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = 13) and (ToolButton51.Visible) and (ToolButton51.Enabled) then
  begin
    ToolButton51Click(Sender);
    Key := 0;
  end;

end;

procedure TFrmTicketReturn.dsResultDataChange(Sender: TObject; Field: TField);
var
  oldOnDataChange: TDataChangeEvent;
  isselected, ischecked: boolean;
begin
  inherited;
  if not Assigned(Field) then
    exit;

  if (Field.FieldName = 'isselected') then
  begin
    if (Field.DataSet.FieldByName('ticketstatus').AsString <> '0') or
      ((not canreturnotherstationticket) and
        (SysInfo.LoginUserInfo.OrgID <> Field.DataSet.FieldByName
          ('scheduleorgid').AsLargeInt) and (Field.DataSet.FieldByName('orgid')
          .AsLargeInt = Field.DataSet.FieldByName('scheduleorgid').AsLargeInt))
      then
    begin
      oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
      .OnDataChange := nil;
      Field.DataSet.FieldByName('isselected').Value := null;
(Sender as TDataSource)
      .OnDataChange := oldOnDataChange;
    end
    else if Field.DataSet.FieldByName('insuranceid').IsNull then
    begin
      oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
      .OnDataChange := nil;
      Field.DataSet.FieldByName('isreturninsure').Value := null;
(Sender as TDataSource)
      .OnDataChange := oldOnDataChange;
    end
    else
    begin
      oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
      .OnDataChange := nil;
      Field.DataSet.FieldByName('isreturninsure').AsBoolean :=
        Field.DataSet.FieldByName('isselected').AsBoolean;
(Sender as TDataSource)
      .OnDataChange := oldOnDataChange;
    end;
    // ===================
    isselected := jcdsResult.FieldByName('isselected').AsBoolean;
    ischecked := jcdsResult.FieldByName('ischecked').AsBoolean;    if isselected then
    begin
      if jcdsResult.FieldByName('isselected').IsNull then
      begin
        SysDialogs.Warning('�ó�Ʊ�Ѿ���������Ʊ����������Ʊ!');
        exit;
      end;      if isselected and ischecked then      begin
        SysDialogs.Warning('�ó�Ʊ�Ѿ���Ʊ����������Ʊ!');
        exit;
      end;    end;    setTotalfee;  end
  else if (Field.FieldName = 'isreturninsure') then
  begin
    if (Field.DataSet.FieldByName('insuranceid').IsNull) or
      ((not canreturnotherstationticket) and
        (SysInfo.LoginUserInfo.OrgID <> Field.DataSet.FieldByName
          ('scheduleorgid').AsLargeInt) and (Field.DataSet.FieldByName('orgid')
          .AsLargeInt = Field.DataSet.FieldByName('scheduleorgid').AsLargeInt))
      then
    begin
      oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
      .OnDataChange := nil;
      Field.DataSet.FieldByName('isreturninsure').Value := null;
(Sender as TDataSource)
      .OnDataChange := oldOnDataChange;
    end;
  end;
end;

procedure TFrmTicketReturn.FormActivate(Sender: TObject);
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

procedure TFrmTicketReturn.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  FrmTicketReturn := self;
  dtpdepartdate.Date := Date();
  FcdsDDDseattype := createCdsDDD('handprice', 'seattype', self); // Ʊ����λ����
  FcdsDDDpaymethod := createCdsDDD('ticketsell', 'paymethod', self); // ֧����ʽ
  FcdsDDDsellway := createCdsDDD('ticketsell', 'sellway', self); // ��Ʊ��ʽ
  FcdsDDDticketstatus := createCdsDDD('ticketsell', 'ticketstatus', self);
  // ��Ʊ״̬
  initTicketType;
  initjcdsResult;
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

  setCardTypeNOLength(Tcardtypes.VIP, SysInfo.curBillLength.Items['Vip']);
  if getParametervalue('0013', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    TVipcardRW.GetInstance.addObserver(self);
  end;
  onecardcansale := getParametervalue('7003', SysInfo.LoginUserInfo.OrgID)
    = '1';
  param1107 := getParametervalue('1107', SysInfo.LoginUserInfo.OrgID) = '1';
end;

procedure TFrmTicketReturn.FormDestroy(Sender: TObject);
begin
  inherited;
  if getParametervalue('0013', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    try
      TVipcardRW.GetInstance.removeObserver(self);
    except
    end;
  end;
end;

function TFrmTicketReturn.initReturnTicketNo: boolean;
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

function TFrmTicketReturn.initReturnTicketPrinter: boolean;
var
  temp: string;
begin
  inherited;
  result := false;
  try
    ReturnTicketPrinter := TNovaPrint.Create(self,
      TNovaPrint.GetTicketModelName('��Ʊƾ֤', '��Ʊƾ֤1'));
    if ReturnTicketPrinter <> nil then
      result := true
    else
      SysDialogs.ShowError('��ʼ����Ʊƾ֤��ӡģ��ʧ�ܣ�δ֪����');
  except
    on E: Exception do
      SysDialogs.ShowError('��ʼ����Ʊƾ֤��ӡģ��ʧ�ܣ�' + E.Message);
  end;
end;

procedure TFrmTicketReturn.nvedtseatnoKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmTicketReturn.nvedtticketnosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilter.Click;
  end;
  if (not(Key in ['0' .. '9', '-', ',', #8, #1, #3, #$16, #$18])) then
  begin
    Key := #0;
  end;
end;

procedure TFrmTicketReturn.nvhelpscheduleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnFilter.Click;
  end;
end;

procedure TFrmTicketReturn.rbticketnoClick(Sender: TObject);
begin
  inherited;
  if Sender = rbticketno then
  begin
    pnlticketno.Enabled := true;
    nvedtticketnos.SetFocus;
    pnlschedule.Enabled := false;
    pnlinsurenos.Enabled := false;
  end
  else if Sender = rbinsureno then
  begin
    pnlinsurenos.Enabled := true;
    nvedtInsurenos.SetFocus;
    pnlticketno.Enabled := false;
    pnlschedule.Enabled := false;
  end
  else if Sender = rbschedule then
  begin
    pnlschedule.Enabled := true;
    dtpdepartdate.SetFocus;
    pnlticketno.Enabled := false;
    pnlinsurenos.Enabled := false;
  end;
end;

procedure TFrmTicketReturn.tbtnFilterClick(Sender: TObject);
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
    params.Clear;
    if (curvipCard <> nil) and (Sender = nil) then
    begin
      // ��VIP���Ų�ѯ
      params.CreateParam(ftString, 'filter_GED_tsl!departdate', ptInput);
      params.ParamValues['filter_GED_tsl!departdate'] := FormatDateTime
        ('yyyy-mm-dd hh:nn:ss', trunc(now));
      params.CreateParam(ftString, 'filter_EQS_v!vipcardno', ptInput);
      params.ParamValues['filter_EQS_v!vipcardno'] := curvipCard.cardNo;
    end
    else if rbticketno.Checked then
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
      params.CreateParam(ftString, 'filter_EQD_tsl!departdate', ptInput);
      params.CreateParam(ftString, 'filter_EQL_sc!id', ptInput);
      params.ParamValues['filter_EQD_tsl!departdate'] := FormatDateTime
        ('yyyy-mm-dd hh:nn:ss', trunc(dtpdepartdate.Date));
      params.ParamValues['filter_EQL_sc!id'] := nvhelpschedule.Id;
      if StrToIntDef(nvedtseatno.text, 0) > 0 then
      begin
        params.CreateParam(ftString, 'filter_EQR_tsl!seatno', ptInput);
        params.ParamValues['filter_EQR_tsl!seatno'] := nvedtseatno.text;
      end;
    end;
    params.CreateParam(ftInteger, 'flag', ptOutput);
    params.CreateParam(ftWideString, 'msg', ptOutput);
    Active := true;
    if params.ParamValues['flag'] <> 1 then
    begin
      SysDialogs.Warning(params.ParamValues['msg']);
    end;
    // dbgrdhResult.FieldColumns['isreturninsure'].Footer.Value :='100%';
    dbgrdhResult.Refresh;
  end;
end;

procedure TFrmTicketReturn.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) or
    (jcdsResult.RecNo < 0) then
    exit;
  if printreturnvoucher and (not canprint) then
  begin
    SysDialogs.ShowError('����Ʊ�ݻ��ӡģ��û�г�ʼ�������ܻ�Ʊ�ش���Ʊƾ֤��');
    exit;
  end;
  // �ж�ѡ�еļ�¼��
  if jcdsResult.FieldByName('ticketstatus').AsString <> '1' then
  begin
    SysDialogs.Warning('�ó�Ʊ������Ʊ״̬����������Ʊ�ش���Ʊƾ֤!');
    exit;
  end;
  if not SysDialogs.Ask('��ʾ', 'ȷ��Ҫ����Ʊ�ش���Ʊƾ֤��') then
    exit;
  with jcdsreprint do
  begin
    Active := false;
    params.ParamValues['isselfschedule'] := jcdsResult.FieldByName
      ('isselfschedule').AsString;
    params.ParamValues['ticketsellid'] := jcdsResult.FieldValues['id'];
    params.ParamValues['curTicketNo'] := SysInfo.LoginUserInfo.curBillNo.Items
      [returnbilltypecode];
    try
      Active := true;
      if params.ParamValues['flag'] = 1 then
      begin
        ReturnTicketPrinter.SingleValue.Clear;
        ReturnTicketPrinter.SingleValue.AddOrSetValue('charges',
          FieldByName('charges').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('ticketprice',
          FieldByName('ticketprice').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('returnamount',
          FieldByName('returnamount').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('returnvoucherno',
          FieldByName('returnvoucherno').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('returntime',
          FieldByName('returntime').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('ticketoutletsname',
          SysInfo.LoginUserInfo.ticketoutletsname);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('sellbycode',
          SysInfo.LoginUserInfo.UserCode);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('sellbyname',
          SysInfo.LoginUserInfo.UserName);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('ticketno',
          jcdsResult.FieldByName('ticketno').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('schedulecode',
          jcdsResult.FieldByName('schedulecode').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('customername',
          jcdsResult.FieldByName('customername').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('departstationname',
          jcdsResult.FieldByName('departstationname').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('reachstationname',
          jcdsResult.FieldByName('reachstationname').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('departdate',
          jcdsResult.FieldByName('departdate').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('departtime',
          jcdsResult.FieldByName('departtime').AsString);
        ReturnTicketPrinter.SingleValue.AddOrSetValue('seatno',
          jcdsResult.FieldByName('seatno').AsString);
        if FieldByName('isreturninsure').AsBoolean then
        begin
          ReturnTicketPrinter.SingleValue.AddOrSetValue('insureno',
            jcdsResult.FieldByName('insuranceno').AsString);
          ReturnTicketPrinter.SingleValue.AddOrSetValue('premium',
            jcdsResult.FieldByName('premium').AsString);
        end;
        ReturnTicketPrinter.Print;
        with SysInfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue(returnbilltypecode,
            zerofill(IntToStr(StrToInt64(curBillNo.Items[returnbilltypecode])
                  + 1), length(curBillNo.Items[returnbilltypecode])));
          curBillNum.AddOrSetValue(returnbilltypecode,
            curBillNum.Items[returnbilltypecode] - 1);
        end;
        refreshBill;
        if params.ParamByName('msg').IsNull or
          (trim(params.ParamByName('msg').AsString) = '') then
          SysDialogs.ShowMessage('��Ʊ���ش���Ʊƾ֤�ɹ���')
        else
          SysDialogs.ShowMessage(params.ParamValues['msg']);
        if rbticketno.Checked then
        begin
          nvedtticketnos.Clear;
          nvedtticketnos.SetFocus;
        end;
      end
      else
      begin
        if params.ParamByName('msg').IsNull then
          SysDialogs.ShowError('��Ʊ���ش���Ʊƾ֤:δ֪����')
        else
          SysDialogs.Warning(params.ParamValues['msg']);
      end;
    except
      on E: Exception do
        SysDialogs.ShowError('��Ʊ���ش���Ʊƾ֤ʧ��:' + E.Message);
    end;
  end;
end;

procedure TFrmTicketReturn.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmTicketReturn.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
end;

procedure TFrmTicketReturn.ToolButton50Click(Sender: TObject);
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

procedure TFrmTicketReturn.ToolButton51Click(Sender: TObject);
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
  returntovipcard: boolean;
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
  returntovipcard := false;
  // �ж�ѡ�еļ�¼��
  with jcdsResult do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      if FieldByName('isselected').IsNull then
      begin
        SysDialogs.Warning('�ó�Ʊ�Ѿ���������Ʊ����������Ʊ!');
        EnableControls;
        exit;
      end;

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

        if Sender = ToolButton52 then // ����ȫ����Ʊ
        begin
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
            rate := getticketreturnrate(departdatetime);
            if (rate = 1) and (Sender = ToolButton51) then
            begin
              SysDialogs.Warning('��Ʊ��������Ϊ100%��Ʊ�����壡');
              exit;
            end;
            if param1107 then
            begin
              ticketfee := getticketfee(FieldByName('isselfschedule')
                  .AsBoolean, FieldByName('id').AsLargeInt);
              if ticketfee < 0 then
              begin
                SysDialogs.ShowError('ȡƱ�۷������');
                exit;
              end;
              charges := carry
                (ticketfee + (FieldByName('price').AsCurrency - ticketfee)
                  * rate);
            end
            else
            begin
              charges := carry(FieldByName('price').AsCurrency * rate);
            end;
            // if WithinPastMinutes(now,departdatetime,2*60) then //��Сʱ��
            // begin
            // rate:=StrToCurrDef(pubfn.getParametervalue('1104',sysinfo.LoginUserInfo.OrgID),0);
            // end
            // else
            // begin
            // rate:=StrToCurrDef(pubfn.getParametervalue('1103',sysinfo.LoginUserInfo.OrgID),0);
            // end;
            // charges:=round(FieldByName('price').AsCurrency*rate/100);
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
        if FieldByName('isreturninsure').AsBoolean then
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
        if Sender = ToolButton52 then // ����ȫ����Ʊ
        begin
          jsoncdsticketreturn.FieldValues['returnway'] := '1';
        end
        else if Sender = ToolButton53 then // ��Ȩ��Ʊ
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
        // jsoncdsticketreturn.FieldValues['id']:=FieldValues['id'];
        // jsoncdsticketreturn.FieldValues['createby']:=FieldValues['createby'];
        // jsoncdsticketreturn.FieldValues['createtime']:=FieldValues['createtime'];
        // jsoncdsticketreturn.FieldValues['returnby']:=FieldValues['returnby'];
        // jsoncdsticketreturn.FieldValues['returnip']:=FieldValues['returnip'];
        // jsoncdsticketreturn.FieldValues['returntime']:=FieldValues['returntime'];
        // jsoncdsticketreturn.FieldValues['updateby']:=FieldValues['updateby'];
        // jsoncdsticketreturn.FieldValues['updatetime']:=FieldValues['updatetime'];
        // jsoncdsticketreturn.FieldValues['turnoverdetailid']:=FieldValues['turnoverdetailid'];
        // private Billtype billtype
        jsoncdsticketreturn.post;
      end;
      next;
    end;
    EnableControls;
  end;
  if jsoncdsticketreturn.Active and (jsoncdsticketreturn.RecordCount > 0) then
  begin
    Frmreturnticketend := TFrmreturnticketend.Create(self);
    try
      // �˴���ֵ����������Ʊ���汣��ʱ�������ж�һ����Ʊ���Ƿ����ı�
      Frmreturnticketend._totalcharges := totalcharges;
      Frmreturnticketend._returnway := returnway;
      if Sender = ToolButton53 then // ��Ȩ��Ʊ
      begin
        Frmreturnticketend.rbrate.Checked := true;
        Frmreturnticketend.nvedtrate.text := CurrToStr(rate * 100);
        Frmreturnticketend.totalpremium := totalpremium;
        with jsoncdsticketreturn do
        begin
          First;
          while not eof do
          begin
            Frmreturnticketend.returnticketsprice.Add
              (FieldByName('ticketprice').AsCurrency);
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
          if Sender = ToolButton53 then // ��Ȩ��Ʊ
          begin
            First;
            while not eof do
            begin
              edit;
              if Frmreturnticketend.rbrate.Checked then
              begin
                jsoncdsticketreturn.FieldValues['charges'] :=
                  FrmTicketReturn.carry
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
          if returntovipcard then // VIP�������֧��
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
          end;
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
                      if Sender = ToolButton53 then //��Ȩ��Ʊ
                      begin
                         ReturnTicketPrinter.SingleValue.AddOrSetValue('charges',CurrToStr(FieldByName('charges').AsCurrency*totalticketnum));
                      end
                      else
                      begin
                          ReturnTicketPrinter.SingleValue.AddOrSetValue('charges',CurrToStr(totalcharges));
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
                    // if SysDialogs.Ask('����','д��ʧ�ܣ�'+_curvipCard.getErrorInfo(vipcardwriteresult)+'����ź�VIP������ȷ������д����') then
                    // begin
                    // vipcardwriteresult:=_curvipCard.writeCard;
                    // end
                    // else
                    // begin
                    // { TODO : ��¼�쳣��־ }
                    // Break;
                    // end;
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
              clearvipinfo;
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

procedure TFrmTicketReturn.clearvipinfo;
begin
  curvipCard := nil;
  pnlvip.Visible := false;
  lblvipcardno.Caption := '';
  lblvipname.Caption := '';
  lblvipcardtype.Caption := '';
  lblviptel.Caption := '';
  lblviplastmoney.Caption := '0';
  lblvipnewmoney.Caption := '0';
  lblviplastamount.Caption := '0';
  lblvipamount.Caption := '0';
  lblvipnewamount.Caption := '0';
end;

procedure TFrmTicketReturn.setTotalfee;
var
  totalcharges: Currency;
begin
  totalcharges := 0;
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
        totalcharges := totalcharges + FieldValues['charges'];
      end;
      next;
    end;
    EnableControls;
  end;
  // ������������ʾ
  dbgrdhResult.FieldColumns['ticketno'].footer.Value := CurrToStr(totalcharges);
end;

procedure TFrmTicketReturn.vipcardfound(vipCard: TVipCard);
begin
  curvipCard := vipCard;
  if not pnlvip.Visible then
  begin
    pnlvip.Visible := true;
  end;
  lblvipcardno.Caption := vipCard.cardNo;
  lblvipcardtype.Caption := getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption := CurrToStr(vipCard.money);
  lblvipnewmoney.Caption := '0';
  lblviplastamount.Caption := CurrToStr(vipCard.amount);
  lblvipamount.Caption := '';
  lblvipnewamount.Caption := '0';
  // ��ѯ���ݿ�
  with jcdsvipinfo do
  begin
    close;
    params.ParamValues['filter_EQS_v!vipcardno'] := vipCard.cardNo;
    open;
    if RecordCount = 0 then
    begin
      clearvipinfo;
      SysDialogs.Warning('�򲻵�����Ϊ' + vipCard.cardNo + '����Ϣ�������Ǹÿ���״̬�쳣��');
    end
    else
    begin
      lblvipname.Caption := FieldByName('name').AsString;
      lblviptel.Caption := FieldByName('mobilephone').AsString;
      if (not onecardcansale) and (vipCard.cardGrade = Tcardgrade.ONECARD) then
      begin
        SysDialogs.Warning('һ��ͨ��֧���ڴ�����Ʊ��');
        clearvipinfo;
      end;
      tbtnFilterClick(nil);
    end;
  end;
end;

end.
