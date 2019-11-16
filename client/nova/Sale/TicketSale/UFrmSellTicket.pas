unit UFrmSellTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, GridsEh, DBGridEh, NvDbgridEh, ExtCtrls,
  StdCtrls, NovaEdit, NovaHelp, ComCtrls, NovaComboBox, Buttons, Spin,
  generics.Defaults, generics.Collections, FunctionItemIntf, Math, Services,
  PubFn, SellTicket, SeatPlan, jsonClientDataSet, DB, StrUtils, DBClient,
  NovaPrint, DateUtils, Menus, DBGridEhGrouping, UDMPublic, UFrmCustomerAdd,
  SellWayEnd, UICcardRW, Sockets, UIDCardReader, UfrmTmpInsuranceNo, ShellAPI,
  UfrmreceiptSchedule;

type
  TFrmSellTicket = class(TBaseForm, Ivipcardfound, IIDCardfound)
    gbticketbuffer: TGroupBox;
    nvdbgrdhticketbuffer: TNvDbgridEh;
    pnlreceipt: TPanel;
    shpbackround: TShape;
    dsSchedule: TDataSource;
    dsTicketBuffer: TDataSource;
    tmrunlockseat: TTimer;
    pmbufferticket: TPopupMenu;
    NBufferTicketDelete: TMenuItem;
    splbufferticket: TSplitter;
    pnlmain: TPanel;
    gbContextHit: TGroupBox;
    lblContextHint: TLabel;
    gbseatplan: TGroupBox;
    pnlhint: TPanel;
    gb1: TGroupBox;
    cbautosellinsure: TCheckBox;
    gbTicketnos: TGroupBox;
    lblticketno: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblleaveticketnum: TLabel;
    gb4: TGroupBox;
    cbautoreceipt: TCheckBox;
    gbinsureno: TGroupBox;
    lblinsureno: TLabel;
    lbl7: TLabel;
    lblleaveinsurenum: TLabel;
    lbl12: TLabel;
    pnlinput: TPanel;
    gbamount: TGroupBox;
    gbschedulecondition: TGroupBox;
    nvhelpreachstation: TNovaHelp;
    gbTakeKid: TGroupBox;
    cbtakekid: TCheckBox;
    sekid: TSpinEdit;
    gb3: TGroupBox;
    dtpdepartdate: TDateTimePicker;
    gb7: TGroupBox;
    nvhelpdepartstation: TNovaHelp;
    pnlschedule: TPanel;
    nvdbgrdhschedule: TNvDbgridEh;
    spl1: TSplitter;
    dsInsureBuffer: TDataSource;
    nvdbgrdhInsureBuffer: TNvDbgridEh;
    pnlsellwayend: TPanel;
    pnlseatnos: TPanel;
    lblseatnos: TLabel;
    lbl9: TLabel;
    tmrleaveticketnum: TTimer;
    tmrleaveinsurenum: TTimer;
    tmrRefreshBill: TTimer;
    nvhelpSchedule: TNovaHelp;
    grpSellNet: TGroupBox;
    chkSellNet: TCheckBox;
    pnllastmoney: TPanel;
    lbl1: TLabel;
    lbllastmoney: TLabel;
    lbl4: TLabel;
    lblreceipt: TLabel;
    lbl5: TLabel;
    lblchange: TLabel;
    nvhlpdepartdistrict: TNovaHelp;
    jcdsCanSaleTicketType: TjsonClientDataSet;
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
    pnlseatplan: TPanel;
    scrlbxSeatPlan: TScrollBox;
    btnclearvipinfo: TBitBtn;
    jcdsvipinfo: TjsonClientDataSet;
    btnresetInsureNo: TButton;
    btnprintinsure: TButton;
    pnlJJInsureHint: TPanel;
    lblJJInsureMoney: TLabel;
    lbl19: TLabel;
    bvl1: TBevel;
    lbl20: TLabel;
    cbsellinsure: TCheckBox;
    jcdsParameters: TjsonClientDataSet;
    pnlreciptSchedule: TPanel;
    jcdsisrealnameticket: TjsonClientDataSet;
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure checkBoxClick(Sender: TObject);
    procedure nvhelpreachstationEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure nvhelpreachstationIdChange(Sender: TObject);
    procedure pnlscheduleResize(Sender: TObject);
    procedure tmrunlockseatTimer(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    procedure pnlreceiptMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure nvdbgrdhticketbufferKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NBufferTicketDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure tmrleaveticketnumTimer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure tmrleaveinsurenumTimer(Sender: TObject);
    procedure tmrRefreshBillTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure nvhelpreachstationChange(Sender: TObject);
    procedure nvdbgrdhscheduleDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure FormDeactivate(Sender: TObject);
    procedure nvdbgrdhscheduleGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure nvdbgrdhscheduleDblClick(Sender: TObject);
    procedure nvhelpdepartstationChange(Sender: TObject);
    procedure pnlvipResize(Sender: TObject);
    procedure pnlseatplanResize(Sender: TObject);
    procedure btnclearvipinfoClick(Sender: TObject);
    procedure btnresetInsureNoClick(Sender: TObject);
    procedure btnprintinsureClick(Sender: TObject);
    procedure nvdbgrdhscheduleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nvdbgrdhscheduleKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    EscapeOccurActiveChange: boolean; // VK_ESCAPE��VK_SUBTRACT���𽹵�仯ʱ ����¼��һ�ν������ڿؼ�
    EnterOccurActiveChange: boolean; // VK_ENTER��VK_ADD���𽹵�仯ʱ
    keydownControl: Tcontrol;

    FsellTicket: TSellTicket;
    FcurNeedSellNum: Word;

    throughControls: TStack<TWinControl>; // ��¼���㾭���Ŀؼ�˳��(ֻ��¼���辭���Ŀؼ�)������ESC��ʱ����

    seTicketNum_Z: TSpinEdit; // �Ż�Ʊ�����
    edDISCOUNT_PRICE: TNovaEdit; // �Ż�Ʊ�������
    seTicketNum_T: TSpinEdit; // ����Ʊ�����
    seTicketNum_H: TSpinEdit; // ����Ʊ�����

    lastSelectTicketpriceid: int64; // �ϴ�ѡ�еİ�μƻ�id

    linescheduleseatno: Integer;

    isVisibleEdit: Integer;
    isShowmoneyinsure:boolean;//�Ƿ�����Ǯ��������۱���
    isShoping: boolean;
    routeisrealnameticket :boolean;
    needCustomerOnRealSellticket_route: Boolean;
    isselfschedule: boolean;
    isshowselfmoney:boolean;
    ticketnumhituser: Integer;
    showlastmoney: boolean;
    insuretypeabout:string ;//�����������,0:���,1:Ʊ��
    isfullticketdefault: boolean; // ȫƱĬ������0:1
    ispassseat: boolean; // �Ƿ���Ҫ������λͼ
    autosellinsure: boolean; // �Զ��۱���
    autorecive: boolean; // �Զ�ʵ��
    isshowhint:Boolean;//�Ƿ���ʾ��λ��ʾ��Ϣ
    autofilldepartstation: boolean; // �Զ���ʼ��վ
    autoselectseat: boolean; // �Զ�ѡλ
    selectcontinuousseat: boolean; // ����ѡ��������λ
    hintseatnum: Integer; // ��Ʊ��ʾ����
    allowSelectByHand: boolean; // �Ƿ������ֶ�ѡ����λ
    isTakeChildOnlyFull: boolean; // �Ƿ�ֻ��ȫƱ���������ͯ

    onecardcansale: boolean; // һ��ͨ�Ƿ�����ڴ��ڹ�Ʊ

    needCustomerOnSellinsure: boolean; // �۱����Ƿ񵯳��˿���Ϣ¼��򣨲���ҪʱĬ�Ϲ˿�IDΪ0��
    needCustomerOnRealSellticket: Boolean; // ʵ������Ʊ�Ƿ񵯳��˿���Ϣ¼���
    setDefaultCustomerOnSellinsure: boolean; // �۱����Ƿ�Ĭ����д�˿���Ϣ��Ĭ�Ϲ˿�IDΪ0��
    setDefaultCustomerOnRealsellticket: boolean; // ʵ������Ʊ�Ƿ�Ĭ����д�˿���Ϣ
    privilegepatchticketcansellseatreserve: boolean;
    // �۱����Ƿ񵯳��˿���Ϣ¼��򣨲���ҪʱĬ�Ϲ˿�IDΪ0��
    // CarrychildRate:double;//����ͯ������

    pnlJJIdCardinfos: TIdCardInfos;
    function initTicketType(): boolean;

    procedure refreshBill(silent: boolean = false); // ˢ��Ʊ��
    procedure refreshInsureBill(silent: boolean = false); // ˢ�±��յ���
    procedure refreshSeatPlan; // ��ʾ��λͼ����λ��
    procedure refreshCanSaleTicketType; // ˢ�¿���Ʊ��
    procedure seatPlanSizeReSize();
    procedure setSellTicket(const Value: TSellTicket);
    // ���û�ؼ��ı߿�
    procedure setActiveControlFrame(control: TWinControl);
    function GoToNextControl(curControl: TWinControl;
      goahead, skip: boolean): TWinControl;
    function checkParent(control: Tcontrol; parent: TWinControl): boolean;
    function checkSelectSeat: boolean;
    // ��Ʊʧ��ʱ���ӻ����ɾ��
    procedure deletefrombuffer;
    function sell: boolean;
    function SaveOrSell(skip: boolean): boolean;

    /// ///////////////////////////////////////////////////////////
    // ������ع���
    procedure setinsureTarget;

    function getTotalTicketreceivablenum: Currency;
    function getTotalInsurereceivablenum: Currency;
    // ����Ʊ��
    function getTotalticketnum: Integer;
    // �ܴ�ӡ��Ʊ������Ϊ��һ��������Ʊ��Ҫ��ӡ���ų�Ʊ��
    function getTotalPrintTicketnum: Integer;
    function getTotalInsurenum: Integer;
    function getCurInsurereceivablenum: Currency;
    function getCurInsurenum: Integer;
    /// //////////////////////////////////////////////////////////////////
    // �¼�
    procedure ScheduleAfterScroll(Sender: TDataSet);
    procedure ScheduleAfterOpen(Sender: TDataSet);
    procedure ScheduleAfterClose(Sender: TDataSet);
    procedure ScheduleBeforeClose(Sender: TDataSet);
    procedure SeatSelectComplete(Sender: TObject);
    procedure StationKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure pnlreceiptReSize();
    procedure initSellWayEnd(); // ����sellway��ʼ������������

    procedure setCurNeedSellNum(AValue: Word);
    function getPriceByTicketTypeCode(ticketTypeCode: string): Currency;
    procedure clearvipinfo;
    procedure socketSellInsure(ticketBuffer: TDataSet); // ����SOCKETָ����ر��ճ���
    function initJJInsure: boolean; // ��ʼ���Ž��۱���ģʽ
    procedure calculateJJInsureMoney; // ����Ž�ģʽӦ�ձ���
  protected
    seTicketNum_Q: TSpinEdit; // ��һ�����������(ȫƱ)
    FrmCustomerAdd: TFrmCustomerAdd;
    lastActiveControls: TQueue<TWinControl>; // ��¼���㾭���Ŀؼ�˳������ȡ��һ�ν������ڿؼ�
    defaultThroughControl: TList<TWinControl>; // ���辭���Ŀؼ�(Enter)
    fullThroughControl: TList<TWinControl>; // ȫ�������Ŀؼ�(+)
    SellWayEnd: ISellWayEnd;
    SeatPlan: TSeatPlanSelect; // ��λͼ
    SeatPlanDecorato: TVehicleSeatPlanDecorator;
    curlockedguid_str: String; // ��ǰ��λguid�ַ���
    curlockedSeatnos: TList<Word>; // ��ǰ��λ��λ���б�
    curlockedScheduleplanid: int64; // ��ǰ��λ��μƻ�id
    curlockedJxsEticketids: TStringList; // ����ʡ������ ��ǰ�����ĵ���ƱID
    receiptSchedule: TfrmreceiptSchedule;
    procedure setDepartDateColor;
    function getTotalreceivablenum: Currency;
    procedure ActiveChanged; override;
    procedure initThroughControl(); dynamic;
    procedure findSchedule(); dynamic;
    function collectdataToTicketBuffer: boolean; dynamic;
    procedure ticketnumChange(Sender: TObject); dynamic;
    procedure setInsuranceInfo(cdsInsuranceBuffer: TDataSet); dynamic;
    function showReceiptBox: boolean; dynamic; // ��ʾ��Ǯ�Ի���
    procedure setContextHint(winControl: TWinControl); dynamic; // ������������ʾ
    procedure appendAllContextHint; // ���ù�ͬ����������ʾ
    // ���浱ǰҪ�۵���λ������
    function savetobuffer: boolean; dynamic;
    // ȡ��ǰ��Ʊ��������������е���Ʊ��
    function getCurticketnum: Integer; dynamic;
    // ȡ��ǰ��ӡ��Ʊ��������������е���Ʊ������Ϊ��һ��������Ʊ��Ҫ��ӡ���ų�Ʊ��
    function getCurPrintTicketnum: Integer; dynamic;
    procedure clearCurlockedScheduleplanid;
    function lockseat: String; dynamic;
    function checkCanGoToReceive: boolean; dynamic; // ����Ƿ�������ʾ��Ǯ���������
    function getCurTicketreceivablenum: Currency; dynamic; // ȡ��ǰ��ƱӦ�գ������������
    function getCDSSchedule: TjsonClientDataSet; dynamic;
    procedure showInsureForm; dynamic;   //ʵ������Ʊ���۱���ʱ��ʾ�˿���Ϣ¼���
    function saveInsuretobuffer: boolean;
    procedure notifyMiniScreenSchedule;
    property curNeedSellNum: Word read FcurNeedSellNum write setCurNeedSellNum;
    // ��ǰ��Ҫ�����Ʊ����������������е�Ʊ��
  public
    curvipCard: TVipCard;
    discountpricenum: Integer;
    openApinet: Integer;
    lastJJInsure: TDictionary<String, boolean>;
    procedure reset; dynamic; // ���ý���
    procedure resetall; dynamic; // ���ý���,�������泵Ʊ
    Constructor Create(AOwner: TComponent; functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: boolean = true); overload; override;
    Constructor Create(AOwner: TComponent; SellTicket: TSellTicket;
      functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil); overload;
    procedure vipcardfound(vipCard: TVipCard);
    procedure cardfound(idcard: TIDCard);
    property SellTicket: TSellTicket read FsellTicket write setSellTicket;

  end;

  TMiniScreenMSG = (LISTSCHEDULE, // ��ʾ���
    FINISH, // ��Ʊ�����ʾ�ȴ�����
    EXITSELL // �˳���Ʊʱ
    );

var
  // FrmSellTicket: TFrmSellTicket;
  tcpclient: TTcpClient;
  openSaleHintScreen: boolean; // �Ƿ�򿪸�������

procedure TcpClientError(Sender: TObject; SocketError: Integer);
procedure notifyMiniScreen(msg: TMiniScreenMSG; info: String);

implementation

uses Ufrmbookticketend, Ufrmsellticketend, Ufrmpatchsellticketend,
  Ufrmchangeticketend, UfrmsellBookticketend, Ufrmsellwayend,
  DateCn;

const
  defaultSeatPlanHeight = 160;
  defaultSeatPlanHeight_buffer = 120;
  defaultCustomerID = 1;
{$R *.dfm}

procedure TFrmSellTicket.ActiveChanged;
var
  activeRect: TRect;
  winControl: TWinControl;
  idx, i: Integer;
  throughEnum: TStack<TWinControl>.TEnumerator;
begin // ��������
  inherited;
  winControl := GetParentForm(self).ActiveControl;
  if winControl = nil then
    exit;

  // ����
  setActiveControlFrame(winControl);
  if (winControl = nil) or (GetParentForm(winControl, false) <> self) then
    exit;
  if lastActiveControls = nil then
  begin
    exit;
  end;
  // ���½����ϴ����ڿؼ�
  lastActiveControls.Enqueue(winControl);
  while lastActiveControls.Count > 2 do
  begin
    lastActiveControls.Dequeue;
  end;
  // ���½���;���ؼ�
  if winControl = defaultThroughControl.Items[0] then
  begin
    throughControls.Clear;
  end
  else if (lastActiveControls.Peek <> nil) and (not EscapeOccurActiveChange)
    and (defaultThroughControl.Contains(lastActiveControls.Peek) or
      ((lastActiveControls.Peek.parent = gbamount) and
        (lastActiveControls.Peek is TSpinEdit) and
        ((lastActiveControls.Peek as TSpinEdit).Value > 0))) then
  begin
    idx := -1;
    throughEnum := throughControls.GetEnumerator;
    while throughEnum.MoveNext do
    begin
      Inc(idx);
      if throughEnum.Current = lastActiveControls.Peek then
      begin
        Break;
      end;
    end;
    if throughControls.Count = idx + 1 then
    begin
      throughControls.Push(lastActiveControls.Peek);
    end
    else
    begin
      for i := throughControls.Count - 1 downto idx + 1 do
      begin
        throughControls.Pop;
      end;
    end;
  end;
{$IFDEF CONSOLE}
  Writeln('new count:' + inttostr(throughControls.Count));
{$ENDIF}
  // ����仯ʱ������������ʾ
  setContextHint(winControl);
  // ����������
  if (not checkParent(winControl, pnlreceipt)) // (winControl<>nvedtreceipt) and (winControl<>nvcbbpayment)
    and pnlreceipt.Visible and (not isShowmoneyinsure) then
  begin
    pnlreceipt.Visible := false;
    if Assigned(pnlJJIdCardinfos) then
      pnlJJIdCardinfos.Visible := false;
    // ������ǰ������λ
    if (curlockedguid_str <> '') and (curlockedScheduleplanid <> 0) then
    begin
      SellTicket.unlockSeat(StringToGUID(curlockedguid_str),
        curlockedScheduleplanid);
      clearCurlockedScheduleplanid;
      if not gbticketbuffer.Visible then
      begin
        curlockedguid_str := '';
        if Assigned(curlockedJxsEticketids) then
          curlockedJxsEticketids.Clear;
      end;
    end;
  end;
  if EnterOccurActiveChange and (winControl = nvdbgrdhschedule) and
    (dsSchedule.DataSet <> nil) and dsSchedule.DataSet.Active and
    (dsSchedule.DataSet.RecordCount = 0) then
  begin
    if (lastActiveControls.Peek <> nil) then
      lastActiveControls.Peek.SetFocus
    else
      defaultThroughControl.Items[0].SetFocus;
  end;
  EscapeOccurActiveChange := false;
  EnterOccurActiveChange := false;
end;

procedure TFrmSellTicket.pnlreceiptReSize;
var
  linespace: Integer;
  captionoldheight: Integer;
  i, j: Integer;
  sellwayendheight: Integer;
begin
  sellwayendheight := 0;
  for i := 0 to pnlsellwayend.ControlCount - 1 do
  begin
    if ((pnlsellwayend.Controls[i] is TCustomPanel) or
        (pnlsellwayend.Controls[i] is TCustomGroupBox) or
        (pnlsellwayend.Controls[i] is TCustomFrame)) and
      (pnlsellwayend.Controls[i] as TWinControl).Visible then
    begin
      if pnlsellwayend.Controls[i] is TCustomFrame then
      begin (pnlsellwayend.Controls[i] as TWinControl)
        .Height := 0;
        for j := 0 to (pnlsellwayend.Controls[i] as TWinControl)
          .ControlCount - 1 do
        begin
          if (((pnlsellwayend.Controls[i] as TWinControl)
                .Controls[j] is TCustomPanel) or
              ((pnlsellwayend.Controls[i] as TWinControl)
                .Controls[j] is TCustomGroupBox)) and
            ((pnlsellwayend.Controls[i] as TWinControl)
              .Controls[j] as TWinControl).Visible then
          begin (pnlsellwayend.Controls[i] as TWinControl)
            .Height := (pnlsellwayend.Controls[i] as TWinControl).Height +
              ((pnlsellwayend.Controls[i] as TWinControl)
                .Controls[j] as TWinControl).Height;
          end;
        end;
        pnlreceipt.Width := (pnlsellwayend.Controls[i] as TWinControl)
          .Width + pnlreceipt.BevelWidth * 4 + pnlreceipt.BorderWidth * 2 + 40;
        lblseatnos.Width := pnlseatnos.Width-80;
         // (pnlsellwayend.Controls[i] as TWinControl).Width - pnlseatnos.Width;
        //lblseatnos.Width := pnlseatnos.Width;
      end;
      sellwayendheight := sellwayendheight +
        (pnlsellwayend.Controls[i] as TWinControl).Height;
    end;
  end;
  linespace := 3;
  captionoldheight := lblseatnos.Height;
  lblseatnos.Canvas.Font.Assign(lblseatnos.Font);
  if (lblseatnos.Canvas.TextWidth(lblseatnos.Caption) mod lblseatnos.Width)
    <> 0 then
  begin
    lblseatnos.Height := (linespace + lblseatnos.Canvas.TextHeight('��')) *
      (1 + (lblseatnos.Canvas.TextWidth(lblseatnos.Caption)
          div lblseatnos.Width));
  end
  else
  begin
    lblseatnos.Height := (linespace + lblseatnos.Canvas.TextHeight('��')) *
      (lblseatnos.Canvas.TextWidth(lblseatnos.Caption) div lblseatnos.Width);
  end;
  pnlseatnos.Height := pnlseatnos.Height + lblseatnos.Height - captionoldheight;
  pnlreceipt.Height := pnlreciptSchedule.Height+ pnlseatnos.Height + sellwayendheight +
    pnlreceipt.BevelWidth * 4 + pnlreceipt.BorderWidth * 2;
   if (sellTicket.sellway[1]<>'8') then
   begin
      pnlreceipt.Top := max(0, min(pnlinput.Top - pnlreceipt.Height,
      (self.Height - pnlreceipt.Height) div 2))+100;
   end
   else
   begin
    pnlreceipt.Top := max(0, min(pnlinput.Top - pnlreceipt.Height,
      (self.Height - pnlreceipt.Height) div 2))+20;
   end;
  // pnlreceipt.Top:=min(pnlinput.Top-pnlreceipt.Height,(self.Height-pnlreceipt.Height) div 2);
  pnlreceipt.Left := (self.Width - pnlreceipt.Width) div 2;
  // չʾ�Ž�ģʽ�����շ���ʾ
  calculateJJInsureMoney;
end;

procedure TFrmSellTicket.appendAllContextHint;
begin
  //lblContextHint.Caption := lblContextHint.Caption + '��F1�鿴Ӧ�ɿF2����';
  if (dsSchedule <> nil) and (dsSchedule.DataSet <> nil) and
    (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount > 0)
    then
  begin
    //lblContextHint.Caption := lblContextHint.Caption + '��CTRL+S�鿴;��վ��';
    if (self.ClassName = 'TFrmSellTicket') then
    begin
      if not chkSellNet.checked then
      begin
        //lblContextHint.Caption := lblContextHint.Caption + '��CTRL+F4�鿴��������';
      end;
      //�������۹���
      {if (lastSelectTicketpriceid > 0) then
      begin
        lblContextHint.Caption := lblContextHint.Caption + '��F9����';
      end;}
    end;
  end;
  {if (nvdbgrdhticketbuffer.DataSource <> nil) and
    (nvdbgrdhticketbuffer.DataSource.DataSet <> nil) and
    (nvdbgrdhticketbuffer.DataSource.DataSet.Active) and
    (nvdbgrdhticketbuffer.DataSource.DataSet.RecordCount > 0) then
  begin
    lblContextHint.Caption := lblContextHint.Caption + '��F3ȫ�����á�F12��ӡȫ����Ʊ';
  end; }
end;

procedure TFrmSellTicket.btnclearvipinfoClick(Sender: TObject);
begin
  inherited;
  clearvipinfo;
  if (lastActiveControls.Count > 0) and (lastActiveControls.Peek <> nil) then
  begin
    if lastActiveControls.Peek.CanFocus then
      lastActiveControls.Peek.SetFocus;
  end
  else
    defaultThroughControl.Items[0].SetFocus;
end;

procedure TFrmSellTicket.btnprintinsureClick(Sender: TObject);
var
  tmpstring: string;
  invokeresult: string;
  _lastcontrol: TWinControl;
begin
  inherited;
  if (Sender <> nil) and (GetParentForm(self).ActiveControl = Sender) then
  begin
    if (lastActiveControls.Count > 0) and (lastActiveControls.Peek <> nil)
      and lastActiveControls.Peek.CanFocus then
    begin
      _lastcontrol := lastActiveControls.Peek;
    end;
  end;
  btnprintinsure.Visible := false;
  if (lastJJInsure = nil) or (lastJJInsure.Count = 0) then
  begin
    if _lastcontrol <> nil then
      _lastcontrol.SetFocus
    else
      GoToNextControl(TButton(Sender), true, true);
    exit;
  end;
  FrmTmpInsuranceNo.addInsurePrintToQueue(self, lastJJInsure);
  if _lastcontrol <> nil then
    _lastcontrol.SetFocus
  else
    GoToNextControl(TButton(Sender), true, true);
end;

procedure TFrmSellTicket.btnresetInsureNoClick(Sender: TObject);
var
  _lastcontrol: TWinControl;
begin
  inherited;
  if not Assigned(FrmTmpInsuranceNo) then
  begin
    FrmTmpInsuranceNo := TFrmTmpInsuranceNo.Create(self);
  end;
  if (Sender <> nil) and (GetParentForm(self).ActiveControl = Sender) then
  begin
    if (lastActiveControls.Count > 0) and (lastActiveControls.Peek <> nil)
      and lastActiveControls.Peek.CanFocus then
    begin
      _lastcontrol := lastActiveControls.Peek;
    end;
  end;
  SysMainForm.showFormModal(FrmTmpInsuranceNo, false);
  if _lastcontrol <> nil then
    _lastcontrol.SetFocus
  else
    GoToNextControl(TButton(Sender), true, true);
end;

procedure TFrmSellTicket.calculateJJInsureMoney;
var
  insureMoney: Currency;
  i: Integer;
  _cursellnum: Integer;
begin
  pnlJJInsureHint.Visible := false;
  insureMoney := 0;
  if not cansellJJinsure then
    exit;

  // ���㵱ǰ���������
  _cursellnum := 0;
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) and
      ((gbamount.Controls[i] as TSpinEdit).Value > 0) then
    begin
      _cursellnum := _cursellnum + (gbamount.Controls[i] as TSpinEdit).Value;
    end;
  end;
  insureMoney := insureMoney + _cursellnum *
    FrmTmpInsuranceNo.getInsureMoneyByDistance
    (dsSchedule.DataSet.FieldByName('distance').AsLargeInt);

  // ͳ�ƻ�����еı���
  if (dsTicketBuffer.DataSet <> nil) and dsTicketBuffer.DataSet.Active then
  begin
    with dsTicketBuffer.DataSet do
    begin
      //DisableControls;
      First;
      while not eof do
      begin
        insureMoney := insureMoney + FrmTmpInsuranceNo.getInsureMoneyByDistance
          (FieldByName('distance').AsLargeInt);
        next;
      end;
      //EnableControls;
    end;
  end;

  lblJJInsureMoney.Caption := CurrToStr(insureMoney) + 'Ԫ';
  pnlJJInsureHint.Visible := true;
  pnlreceipt.Height := pnlreceipt.Height + pnlJJInsureHint.Height;
  if Assigned(pnlJJIdCardinfos) then
  begin
    pnlJJIdCardinfos.Left := pnlreceipt.Left + pnlreceipt.Width;
    pnlJJIdCardinfos.Top := pnlreceipt.Top;
  end;
end;

procedure TFrmSellTicket.cardfound(idcard: TIDCard);
var
  curidcard: TIDCard;
begin
  curidcard := idcard;
  if cansellJJinsure and Assigned(pnlJJIdCardinfos)
    and pnlJJIdCardinfos.Visible then
  begin
    pnlJJIdCardinfos.addnewIdCard(curidcard);
  end;
end;

procedure TFrmSellTicket.checkBoxClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  if (Sender is TCheckBox) then
  begin
    if TCheckBox(Sender).checked then
    begin
      TCheckBox(Sender).Font.Style := TCheckBox(Sender).Font.Style + [fsBold];
    end
    else
    begin
      TCheckBox(Sender).Font.Style := TCheckBox(Sender).Font.Style - [fsBold];
    end;
    if Sender = cbtakekid then
    begin
      if (Sender as TCheckBox).checked then
      begin
        sekid.Enabled := cbtakekid.checked;
        sekid.SetFocus;
        exit;
      end
      else
      begin
        if (lastActiveControls.Count > 0) and (lastActiveControls.Peek <> nil)
          then
        begin
          if lastActiveControls.Peek.CanFocus then
            lastActiveControls.Peek.SetFocus;
        end
        else
          GoToNextControl(TCheckBox(Sender), true, true);
        sekid.Enabled := cbtakekid.checked;
      end;
    end
    else if Sender = chkSellNet then
    begin
      if TCheckBox(Sender).checked then
      begin
        nvhelpdepartstation.HelpOptions.HelpType := 'NetStartStationHelp';
        nvhelpdepartstation.ignoreSearchFlag := '.';
        nvhelpreachstation.ignoreSearchFlag := '';
      end
      else
      begin
        nvhelpdepartstation.HelpOptions.HelpType := 'StartStationHelp';
        nvhelpdepartstation.ignoreSearchFlag := '';
        nvhelpreachstation.ignoreSearchFlag := '.';
        nvhelpreachstation.Params.ParamByName('cityid').Value:='';
      end;
      resetall;
      refreshCanSaleTicketType;
    end
    else if (GetParentForm(self).ActiveControl = Sender) then
    begin
      if (lastActiveControls.Count > 0) and (lastActiveControls.Peek <> nil)
        then
      begin
        if lastActiveControls.Peek.CanFocus then
          lastActiveControls.Peek.SetFocus;
      end
      else
        GoToNextControl(TCheckBox(Sender), true, true);
    end;

    if (Sender = cbsellinsure) or (Sender = cbautosellinsure) then
    begin
      if (Sender as TCheckBox).checked then
      begin
        lbl19.Visible := true;
        lblJJInsureMoney.Visible := true;
        lbl20.Visible := true;
      end
      else
      begin
        lbl20.Visible := false;
        lblJJInsureMoney.Visible := false;
        lbl19.Visible := false;
      end;
      if Assigned(pnlJJIdCardinfos) then
      begin
        pnlJJIdCardinfos.Visible := (Sender as TCheckBox)
          .checked and TIDCardReader.idcardreader_ready;
      end;
    end
  end;
end;

function TFrmSellTicket.checkCanGoToReceive: boolean;
var islinework:Boolean;             //�Ƿ�����ˮ���
begin
  islinework:=True;
  if (not SellTicket.cdsSchedule.FieldByName('islinework').AsBoolean) and (not
    (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp'))  then
  begin
     islinework:=SeatPlan.CanFocus;  //����ˮ��λ����̫�� ������λͼ��ʾ
  end;
  if nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp' then
  begin
      result := Assigned(dsSchedule.DataSet) and (dsSchedule.DataSet.Active) and
    (dsSchedule.DataSet.RecordCount > 0);
  end
  else
  begin
     result := Assigned(dsSchedule.DataSet) and (dsSchedule.DataSet.Active) and
    (dsSchedule.DataSet.RecordCount > 0) and islinework; //and(SeatPlan.CanFocus);
  end;

end;

function TFrmSellTicket.checkParent(control: Tcontrol;
  parent: TWinControl): boolean;
var
  _control: TWinControl;
begin
  result := false;
  _control := control.parent;
  while (_control <> nil) do
  begin
    if _control = parent then
    begin
      result := true;
      Break;
    end;
    _control := _control.parent;
  end;
end;

function TFrmSellTicket.checkSelectSeat: boolean;
var
  autoselect: boolean;
  _seatno: Word;
  i: Integer;
begin
  result := false;
  ticketnumChange(nil);

  if (curNeedSellNum = 0) then
  begin
    SysDialogs.ShowError('��������Ҫ�����Ʊ����');
    seTicketNum_Q.SetFocus;
    exit;
  end;
  if (curNeedSellNum > dsSchedule.DataSet.FieldByName('RESIDUESEATNUM')
      .AsInteger) then
  begin
    SysDialogs.ShowInfo('��ǰ���ʣ����λ��С����Ҫ�����Ʊ����');
    exit;
  end
  else if (not dsSchedule.DataSet.FieldByName('islinework').AsBoolean) and not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) and
    (curNeedSellNum > SeatPlan.getCanSelectSeatNum) then
  begin
    SysDialogs.ShowInfo('��ǰ��ο�ѡʣ����λ��С����Ҫ�����Ʊ����');
    exit;
  end;

  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) then
    begin

      if (rightstr(gbamount.Controls[i].Name, 1) = 'D') and
        ((gbamount.Controls[i] as TSpinEdit).Value > 0) then

        if dsSchedule.DataSet.FieldByName('discountpriceticket').AsInteger <
          (gbamount.Controls[i] as TSpinEdit).Value then
        begin
          SysDialogs.ShowInfo('��ǰ��ο����ۿ�Ʊ��С����Ҫ�����Ʊ����');
          exit;
        end;

    end;
  end;

  if (SellTicket.sellway[1] <> '8') and
    (getTotalPrintTicketnum > sysinfo.LoginUserInfo.curBillNum.Items['Ticket']
    ) then
  begin
    SysDialogs.ShowInfo('��ǰƱ��ʣ��Ʊ��Ϊ' + inttostr
        (sysinfo.LoginUserInfo.curBillNum.Items['Ticket']) + '��,С����Ҫ��ӡ��Ʊ����');
    exit;
  end;
  getTotalTicketreceivablenum; // ���Ʊ��Ʊ��
  // ����۶�ͯƱ��
  if cbtakekid.checked and (dsSchedule.DataSet.FieldByName
      ('residuecarrychildnum').AsInteger < sekid.Value) then
  begin
    SysDialogs.Warning('�ð�δ���ͯ������������������ͯ��������໹�������ͯ' + inttostr
        (dsSchedule.DataSet.FieldByName('residuecarrychildnum').AsInteger)
      // -dsSchedule.DataSet.FieldByName('carrychildnum').AsInteger
        + '��');
    exit;
  end;

  if dsSchedule.DataSet.FieldByName('islinework').AsBoolean or
     ((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
     (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) or
    (Assigned(SeatPlan.selectedSeats) and
      (SeatPlan.selectedSeats.Count = SeatPlan.selectSeatNum) and  (SeatPlan.selectedSeats.Count <> 0)) then
  begin
    result := true;
  end
  else
  begin
    if autoselectseat then // �Զ�ѡλ
    begin
      if selectcontinuousseat then // ����ѡ��������λ
        result := SeatPlan.autoSelectSeats(true)
      else
        result := SeatPlan.autoSelectSeats(false);
      if not result then
      begin
        SysDialogs.ShowInfo('�Զ�ѡλʧ��,ʣ����λ������');
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('ѡλδ���,����ѡλ');
    end;
  end;
  if result and (hintseatnum < getCurticketnum) then
  begin
    if not SysDialogs.Ask('����', '��ѡ�����λ��������������������Ҫ������Ʊ��') then
    begin
      result := false;
    end;
  end;
  // �������Ȩ��Ʊѡ�������λ����ʾ�û�
  if result and (SellTicket.sellway[1] <> '6') and
    (not dsSchedule.DataSet.FieldByName('islinework').AsBoolean) and not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) then
  begin
    for _seatno in SeatPlan.getSelectedSeats do
    begin
      if (SeatPlan.getSeatsStatus.Items[_seatno] = '4') or
        (SeatPlan.getSeatsStatus.Items[_seatno] = '5') then
      begin
        if not SysDialogs.Ask('����', '��ѡ�����λ��������λ!������Ҫ������Ʊ��') then
        begin
          result := false;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TFrmSellTicket.clearCurlockedScheduleplanid;
begin
  curlockedScheduleplanid := 0;
end;

procedure TFrmSellTicket.clearvipinfo;
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
  if (SellWayEnd is Tfrmsellticketend) then
  begin (SellWayEnd as Tfrmsellticketend)
    .nvcbbpayment.ItemIndex := 0; // �ֽ�
  end;
end;

function TFrmSellTicket.collectdataToTicketBuffer: boolean;
begin
  result := false; ;
  with TjsonClientDataSet(dsTicketBuffer.DataSet) do
  begin
    Params.ParamValues['order.seller'] := sysinfo.LoginUserInfo.UserID;
    Params.ParamValues['order.orgid'] := sysinfo.LoginUserInfo.OrgID;
    Params.ParamValues['order.startTicketNO'] :=
      sysinfo.LoginUserInfo.curBillNo.Items['Ticket'];
    Params.ParamValues['order.totalmoney'] := CurrToStr
      (getTotalTicketreceivablenum);
    Params.ParamValues['order.ip'] := sysinfo.LocalHostAddress;
    Params.ParamValues['order.ticketoutletsid'] :=
      sysinfo.LoginUserInfo.ticketoutletsid;
    Params.ParamValues['order.sellway'] := SellTicket.sellway;
  end;
  result := true;
end;

constructor TFrmSellTicket.Create(AOwner: TComponent; SellTicket: TSellTicket;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters);
var
  seatsStatus, seatstype: TDictionary<Word, String>;
  start: TDateTime;
begin
  self.SellTicket := SellTicket;
  Create(AOwner, functionItem);
  grpSellNet.Visible := SellTicket.sellway = '0';
  dtpdepartdate.MaxDate := Trunc(date) + strtointdef(getParametervalue('1017',
      sysinfo.LoginUserInfo.OrgID), 7);
  gb1.Visible := SellTicket.cansellinsure;
  gbinsureno.Visible := SellTicket.cansellinsure;
  nvdbgrdhInsureBuffer.Visible := SellTicket.cansellinsure;
  spl1.Visible := SellTicket.cansellinsure;
  // cbautosellinsure.Enabled:=sellTicket.cansellinsure;
  // if not cbautosellinsure.Enabled then
  // cbautosellinsure.Checked:=false;
  cansellJJinsure := false;
  isShoping := false;
  //sellTicket.cansellinsure:=false;
  {if not SellTicket.cansellinsure then
  begin
    initJJInsure;
  end;
   }
  dsSchedule.DataSet := SellTicket.cdsSchedule;
  dsTicketBuffer.DataSet := SellTicket.cdsTicketBuffer;
  SellTicket.AfterScheduleScroll := ScheduleAfterScroll;
  SellTicket.cdsSchedule.AfterOpen := ScheduleAfterOpen;
  SellTicket.cdsSchedule.AfterClose := ScheduleAfterClose;
  SellTicket.cdsSchedule.BeforeClose := ScheduleBeforeClose;
  // ��Ʊ����Ҫ���š�����Ҫ�տ����Ҫ�۱���
   gbTicketnos.Visible:=not (sellTicket.sellway[1]='8');
  // gbinsureno.Visible:=(not (sellTicket.sellway[1]='8'));
   pnlhint.Visible := (not(SellTicket.sellway[1] = '8'));
  tmrRefreshBill.Enabled := pnlhint.Visible;
  if SellTicket.sellway[1] <> '8' then
  begin
    refreshBill;
    refreshInsureBill;
  end;
  initTicketType();
  initThroughControl();
  if cansellJJinsure then
  begin
    TIDCardReader.GetInstance.addObserver(self);
    if TIDCardReader.idcardreader_ready then
    begin
      pnlJJIdCardinfos := TIdCardInfos.Create(self);
    end;
  end;
end;

constructor TFrmSellTicket.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;
  checkpermission: boolean);
begin
  inherited;
  isselfschedule := true;
  lastSelectTicketpriceid := 0;
  linescheduleseatno := 0;
  curNeedSellNum := 0;
  clearCurlockedScheduleplanid;
  EscapeOccurActiveChange := false;
  EnterOccurActiveChange := false;
  with jcdsParameters do
  begin
    Active := false;
    Params.ParamValues['code'] :=
      '''1027'',''1013'',''1014'',''1026'',''0001'',''1010'',''1011'',''1030'',''1006'',''1007'',''1016'',''1033'',''1041'',''7003'',''1043'',''1044'',''0144'',''1050'',''0013'',''1055'',''3014'',''1056'',''1057'',''1060'',''9494'',''9898''';
    if sysinfo.LoginUserInfo.OrgID <= 0 then
    begin
      Params.ParamValues['orgid'] := null;
    end
    else
    begin
      Params.ParamValues['orgid'] := sysinfo.LoginUserInfo.OrgID;
    end;
    Active := true;
    if RecordCount > 0 then
    begin
      First;
      while (not eof) do
      begin

        if StrToBoolDef(FieldByName('1027').AsString,
          false) then
        begin
          nvhelpreachstation.OnKeyDown := StationKeyDown;
          nvhelpdepartstation.OnKeyDown := StationKeyDown;
        end;
        ticketnumhituser := strtointdef(FieldByName('1013').AsString, 50);
        showlastmoney := FieldByName('1014').AsString = '1';
        isshowselfmoney:= FieldByName('1057').AsString = '1';
        nvdbgrdhschedule.AutoFocusKey := StrToBoolDef(FieldByName('1026').AsString, false);
        if nvdbgrdhschedule.AutoFocusKey then
        begin
          nvdbgrdhschedule.AutoFocusKeyInterval := StrToInt64Def(FieldByName('0001').AsString, 300);
        end;
        autosellinsure := FieldByName('1010').AsString = '1';
        if autosellinsure then
           cbautosellinsure.Checked:=True
        else
           cbautosellinsure.Checked:=false;
        isfullticketdefault:= FieldByName('1056').AsString = '1';
        ispassseat:= FieldByName('1055').AsString = '1';
        insuretypeabout:=FieldByName('1060').AsString;
        autorecive := FieldByName('1011').AsString = '1';
        isshowhint := FieldByName('3014').AsString = '1';
        autofilldepartstation := FieldByName('1030').AsString = '1';
        autoselectseat := FieldByName('1006').AsString = '1';
        selectcontinuousseat := FieldByName('1007').AsString = '1';
        hintseatnum := strtointdef(FieldByName('1016').AsString, 1);
        allowSelectByHand := FieldByName('1033').AsString = '1';
        isTakeChildOnlyFull := FieldByName('1041').AsString = '1';
        onecardcansale := FieldByName('7003').AsString = '1';
        needCustomerOnSellinsure := FieldByName('1043').AsString = '1';
        needCustomerOnRealSellticket := FieldByName('9494').AsString = '1';
        setDefaultCustomerOnSellinsure := FieldByName('1044').AsString = '1';
        setDefaultCustomerOnRealsellticket := FieldByName('9898').AsString = '1';
        openSaleHintScreen := FieldByName('0144').AsString = '1';
        setCardTypeNOLength(Tcardtypes.VIP, sysinfo.curBillLength.Items['Vip']);
        privilegepatchticketcansellseatreserve := FieldByName('1050').AsString = '1';
        if FieldByName('0013').AsString = '1' then
        begin
          TVipcardRW.GetInstance.addObserver(self);
        end;
        next;
      end;
    end;

  end;
  // if StrToBoolDef(getParametervalue('1027',SysInfo.LoginUserInfo.OrgID),false) then
  // begin
  // nvhelpreachstation.OnKeyDown:=StationKeyDown;
  // nvhelpdepartstation.OnKeyDown:=StationKeyDown;
  // end;
  // ticketnumhituser:=StrToIntDef(getParametervalue('1013',SysInfo.LoginUserInfo.OrgID),50);
  // showlastmoney:=getParametervalue('1014',SysInfo.LoginUserInfo.OrgID)='1';
  /// /  CarrychildRate:=StrToFloatDef(getParametervalue('1012',SysInfo.LoginUserInfo.OrgID),10)/100;
  // nvdbgrdhschedule.AutoFocusKey:=StrToBoolDef(getParametervalue('1026',SysInfo.LoginUserInfo.OrgID),false);
  // if nvdbgrdhschedule.AutoFocusKey then
  // begin
  // nvdbgrdhschedule.AutoFocusKeyInterval:=StrToInt64Def(getParametervalue('0001',SysInfo.LoginUserInfo.OrgID),300);
  // end;
  // autosellinsure:=getParametervalue('1010',SysInfo.LoginUserInfo.OrgID)='1';
  // autorecive:=getParametervalue('1011',SysInfo.LoginUserInfo.OrgID)='1';
  // autofilldepartstation:=getParametervalue('1030',SysInfo.LoginUserInfo.OrgID)='1';
  // autoselectseat:=getParametervalue('1006',SysInfo.LoginUserInfo.OrgID)='1';
  // selectcontinuousseat:=getParametervalue('1007',SysInfo.LoginUserInfo.OrgID)='1';
  // hintseatnum:=StrToIntDef(getParametervalue('1016',SysInfo.LoginUserInfo.OrgID),1);
  // allowSelectByHand:=getParametervalue('1033',SysInfo.LoginUserInfo.OrgID)='1';
  // isTakeChildOnlyFull:=getParametervalue('1041',SysInfo.LoginUserInfo.OrgID)='1';
  // onecardcansale:=getParametervalue('7003',SysInfo.LoginUserInfo.OrgID)='1';
  // needCustomerOnSellinsure:=getParametervalue('1043',SysInfo.LoginUserInfo.OrgID)='1';
  // setDefaultCustomerOnSellinsure:=getParametervalue('1044',SysInfo.LoginUserInfo.OrgID)='1';
  // openSaleHintScreen:= getParametervalue('0144',SysInfo.LoginUserInfo.OrgID)='1';
  // setCardTypeNOLength(Tcardtypes.VIP,sysInfo.curBillLength.Items['Vip']);
  // privilegepatchticketcansellseatreserve:= getParametervalue('1050',SysInfo.LoginUserInfo.OrgID)='1';
  // if getParametervalue('0013',SysInfo.LoginUserInfo.OrgID)='1' then
  // begin
  // TVipcardRW.GetInstance.addObserver(Self);
  // end;
end;

procedure TFrmSellTicket.deletefrombuffer;
var
  i, _curnum,_insurenum: Integer;
begin
  _curnum := getCurticketnum;
  _insurenum := getTotalInsurenum;
  // assert(assigned(dsTicketBuffer.DataSet) and dsTicketBuffer.DataSet.Active and (dsTicketBuffer.DataSet.RecordCount>=_curnum),'ϵͳ�쳣����Ʊ�������ݼ�û�д򿪻��¼��Ϊ0��');
  if Assigned(dsTicketBuffer.DataSet) and dsTicketBuffer.DataSet.Active and
    (dsTicketBuffer.DataSet.RecordCount >= _curnum) then
  begin
    _curnum:= dsTicketBuffer.DataSet.RecordCount;
    with dsTicketBuffer.DataSet do
    begin
      for i := _curnum downto 1 do
      begin
        Last;
        Delete;
      end;
    end;
  end;
  //������ջ���
  //�޸�bug����1��Ʊ����ʾƱ�Ų�һ�£�����Ʊ�ź󣬳�����1��Ʊ����2�ű��յ������2����ͬʱʹ��admin�˺ţ�
  if Assigned(dsInsureBuffer.DataSet) and dsInsureBuffer.DataSet.Active and
    (dsInsureBuffer.DataSet.RecordCount >= _insurenum) then
  begin
    _insurenum:= dsInsureBuffer.DataSet.RecordCount;
    with dsInsureBuffer.DataSet do
    begin
      for i := _insurenum downto 1 do
      begin
        Last;
        Delete;
      end;
    end;
  end;


end;

procedure TFrmSellTicket.dtpdepartdateChange(Sender: TObject);
begin
  inherited;
  gb3.Caption := DateCn.CnMonthOfDate(dtpdepartdate.DateTime) + '  ' + DateCn.CnDayOfDate(dtpdepartdate.DateTime);
  setDepartDateColor;
  findSchedule;
end;

procedure TFrmSellTicket.findSchedule;
var
  condition: ScheduleAskCondition;
begin
  if (SellTicket = nil) then
    exit;
  if (nvhelpreachstation.Id = 0) and (nvhelpSchedule.Id = 0) then
  begin
    if dsSchedule.DataSet <> nil then
    begin
      dsSchedule.DataSet.Close;
    end;
  end
  else
  begin
    condition := ScheduleAskCondition.Create;
    with condition do
    begin
      isnet := chkSellNet.Checked;
      departDate := Trunc(dtpdepartdate.date);
      departStationId := nvhelpdepartstation.Id;
      reachStationId := nvhelpreachstation.Id;
      ScheduleId := nvhelpSchedule.Id;
      if nvhlpdepartdistrict.Id > 0 then
      begin
        districtcode := nvhlpdepartdistrict.HelpFieldValue['Code'];
      end;
      if (chkSellNet.Checked) and (not (nvhelpdepartstation.Text='')) and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
      begin
          isnetway:=2;
          reachstationname:=nvhelpreachstation.Text;
      end
      else
      if chkSellNet.Checked then
      begin
          isnetway:=1;
          reachstationname:='';
      end;

    end;
    SellTicket.findSchedule(condition);
    condition.isnetway:=0;
    condition.reachstationname:='';
    if dsSchedule.DataSet = nil then
      dsSchedule.DataSet := SellTicket.cdsSchedule;
  end;
end;

procedure TFrmSellTicket.FormActivate(Sender: TObject);
begin
  inherited;
  if (lastActiveControls <> nil) and (lastActiveControls.Peek <> nil) and
    (lastActiveControls.Peek.CanFocus) then
  begin
    lastActiveControls.Peek.SetFocus;
  end
  else if (defaultThroughControl <> nil) and (defaultThroughControl.Count > 0)
    and (defaultThroughControl.Items[0].CanFocus) then
  begin
    defaultThroughControl.Items[0].SetFocus;
  end;
  if nvhelpreachstation.Visible then
     nvhelpreachstation.SetFocus;
end;

procedure TFrmSellTicket.FormDeactivate(Sender: TObject);
begin
  inherited;
//  OutputDebugString('dddddddddddddddddddddd');
end;

procedure TFrmSellTicket.FormDestroy(Sender: TObject);
begin
  notifyMiniScreen(EXITSELL, ' ');
  // ��������ȫ����λ
  if curlockedguid_str <> '' then
  begin
    SellTicket.unlockSeat(StringToGUID(curlockedguid_str));
    clearCurlockedScheduleplanid;
    curlockedguid_str := '';
    if Assigned(curlockedJxsEticketids) then
      curlockedJxsEticketids.Clear;
  end;
  try
    if getParametervalue('0013', sysinfo.LoginUserInfo.OrgID) = '1' then
    begin
      TVipcardRW.GetInstance.removeObserver(self);
    end;
  except
  end;
  if cansellJJinsure then
  begin
    try
      TIDCardReader.GetInstance.removeObserver(self);
    except
    end;
  end;
  inherited;
end;

procedure TFrmSellTicket.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  // keydownControl:=GetParentForm(self).ActiveControl;
end;

procedure TFrmSellTicket.FormKeyPress(Sender: TObject; var Key: Char);
var
    tickets,i:Integer;
begin
  inherited;
  if (Screen.ActiveControl <> nil) and (GetParentForm(Screen.ActiveControl,
      false) = self) then
  begin
    if ((Key = '+') or (Key = '-')) and ((Screen.ActiveControl is TcustomEdit)
        or (Screen.ActiveControl is TSpinEdit) or
        (Screen.ActiveControl is TDateTimePicker)) then
    begin
       //ShowMessage('afdasf');
      Key := #0;
    end;
    if (Screen.ActiveControl is TSpinEdit) and (not(Key in ['0' .. '9', #8]))
      then
    begin
      tickets:=0;
      {for i := 0 to gbamount.ControlCount - 1 do
      begin
        if (gbamount.Controls[i] is TSpinEdit) then
        begin
          if ((gbamount.Controls[i] as TSpinEdit).Value > 0) then
          begin
            tickets:=tickets+(gbamount.Controls[i] as TSpinEdit).Value;
          end;
        end;
      end;
      if tickets=0 then
      begin
          if Assigned(SeatPlan) and SeatPlan.Visible and SeatPlan.CanFocus then
          SeatPlan.SetFocus;
      end
      else
      begin
          Key := #0;
      end;}
      Key := #0;
    end;
  end;
end;

procedure TFrmSellTicket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  continueDealKey: boolean;
  winControl: TWinControl;
  i: Integer;
  functionParm: TFunctionItemParameters;
  curSelectTicketpriceid: int64;
  condition: ScheduleAskCondition;
begin
  continueDealKey := false;
  winControl := GetParentForm(self).ActiveControl;

  if (Shift <> []) and (not(((Key = 187) or (Key = 189)) and (Shift = [ssShift])
      )) and (not((Key = 83) and (Shift = [ssCtrl]))) then
  begin
    continueDealKey := true;
  end
  else if Key = VK_F1 then
  begin
    if isshowselfmoney then
    begin
      functionParm := TFunctionItemParameters.Create;
      functionParm.CommaText := '3';
      SysFunctionMgr.exec(StringToGUID('{E7535C96-EF93-4836-BA70-1AAFC5DEAA94}'),
      functionParm);
    end
    else
    begin
       continueDealKey := true;
    end;
  end
  else if Key = VK_F2 then
  begin

    //reset;
    resetall;
    chkSellNet.checked := false;
  end
  {else if Key = VK_F3 then
  begin
    chkSellNet.checked := false;
    resetall;
  end}
  else if (Key = 83) and (Shift = [ssCtrl]) then
  begin
    if (getCDSSchedule <> nil) and (getCDSSchedule.Active) and
      (getCDSSchedule.RecordCount > 0) then
    begin
      functionParm := TFunctionItemParameters.Create;
      functionParm.CommaText := getCDSSchedule.FieldByName('scheduleplanid')
        .AsString + ',' + getCDSSchedule.FieldByName('departstationid')
        .AsString + ',' + booltostr(chkSellNet.checked)
        + ',' + getCDSSchedule.FieldByName('departdate')
        .AsString + ',' + getCDSSchedule.FieldByName('schedulesynccode')
        .AsString + ',' + getCDSSchedule.FieldByName('departstationcode')
        .AsString;
      SysFunctionMgr.exec
        (StringToGUID('{846C8762-1903-48B1-AFC7-B1629A5DE4A8}'), functionParm);
    end;
  end
  else if (Key = 83) and (Shift = [ssCtrl]) and (not chkSellNet.checked) and
    (self.ClassName = 'TFrmSellTicket') and (dsSchedule.DataSet <> nil) and
    (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount > 0) then
  begin
    curSelectTicketpriceid := dsSchedule.DataSet.FieldByName('id').AsLargeInt;
    condition := ScheduleAskCondition.Create;
    with condition do
    begin
      isnet := chkSellNet.checked;
      departDate := Trunc(now);
      dtpdepartdate.date := Trunc(now);
      departStationId := dsSchedule.DataSet.FieldByName('departstationid')
        .AsLargeInt;
      reachStationId := dsSchedule.DataSet.FieldByName('reachstationid')
        .AsLargeInt;
      ScheduleId := dsSchedule.DataSet.FieldByName('scheduleid').AsLargeInt;
    end;
    dsSchedule.DataSet.Close;
    SellTicket.findSchedule(condition);
    if dsSchedule.DataSet = nil then
      dsSchedule.DataSet := SellTicket.cdsSchedule;
    dsSchedule.DataSet.Active := true;
    dsSchedule.DataSet.Locate('id', lastSelectTicketpriceid, []);
    nvdbgrdhschedule.SetFocus;
  end
  else if (Key = VK_F5)
    and SellTicket.cansellinsure and cbautosellinsure.Enabled then
  begin
    cbautosellinsure.checked := not cbautosellinsure.checked;
    if (cbautosellinsure.checked) and (SellWayEnd<>nil)and (SellWayEnd as Tfrmsellticketend).Visible
      and  ( (SellWayEnd as Tfrmsellticketend).CanFocus) then
    begin
        SysLog.WriteErr('(SellWayEnd as Tfrmsellticketend).Visible..=true.');
        isShowmoneyinsure:=true;
        showInsureForm;
        //showReceiptBox;
        SellWayEnd.curTicketNum := getCurticketnum;
        SellWayEnd.cdsSchedule := getCDSSchedule;
        SellWayEnd.totalTicketReceivablenum := getTotalTicketreceivablenum;
        SellWayEnd.totalTicketNum := getTotalticketnum;

        SellWayEnd.totalInsureReceivableNum := getTotalInsurereceivablenum;
        SellWayEnd.totalInsureNum := getTotalInsurenum;
        SellWayEnd.show;
        pnlreceiptReSize();
        if getTotalInsurenum<>0 then //����հ�F5 ������Ǯ��������
        pnlreceipt.Visible := true;
        pnlreceipt.BringToFront;
        isShowmoneyinsure:=false;
        (SellWayEnd as Tfrmsellticketend).nvedtreceipt.SetFocus;
    end;
  end
  else if (Key = VK_F5)
    and cansellJJinsure and cbsellinsure.Visible and cbsellinsure.Enabled
    then
    begin
        OutputDebugString('(SellWayEnd as Tfrmsellticketend).Visible..========.');
        cbsellinsure.checked := not cbsellinsure.checked;
    end
  {else if (Key = VK_F6) and cbautoreceipt.Enabled then
  begin
    cbautoreceipt.checked := not cbautoreceipt.checked;
    continueDealKey := true;
  end}
  else if (Key = VK_F7) and chkSellNet.Enabled and grpSellNet.Visible then
  begin
    chkSellNet.checked := not chkSellNet.checked;
  end
  else if (Key = VK_F6) then
  begin
    if cbtakekid.Enabled then
      cbtakekid.checked := not cbtakekid.checked
    else
      cbtakekid.checked := false;
    ticketnumChange(nil);
  end
  //
  else if (Key = VK_F9) and (self.ClassName = 'TFrmSellTicket') and
    (dsSchedule.DataSet <> nil) and (not dsSchedule.DataSet.Active) and
    (lastSelectTicketpriceid > 0) and (not chkSellNet.checked) then
  begin
    dsSchedule.DataSet.Active := true;
    dsSchedule.DataSet.Locate('id', lastSelectTicketpriceid, []);
    GoToNextControl(seTicketNum_Q, true, true);
  end
  else if Key = VK_F10 then
  begin
    if gbticketbuffer.Visible then
      nvdbgrdhticketbuffer.SetFocus;
  end
//  else if (Key = VK_F9) then
//  begin
//    // if gbseatplan.Visible and Assigned(gbseatplan) then
//    // SeatPlanDecorato.SetFocus;
//    if Assigned(SeatPlan) and SeatPlan.Visible and SeatPlan.CanFocus then
//      SeatPlan.SetFocus;
//  end
 { else if Key = VK_F12 then // VK_F12
  begin
    // ��ӡ���ﳵ�еĳ�Ʊ  ��-->��Ϊ��λ�����ﳵ��س���Ǯ                                                 1
    if (not pnlreceipt.Visible) and (not(SellTicket.sellway[1] in ['4', '8']))
      and gbticketbuffer.Visible and Assigned(dsTicketBuffer.DataSet)
      and dsTicketBuffer.DataSet.Active and
      (dsTicketBuffer.DataSet.RecordCount > 0) then // 4��Ʊ��8��Ʊ��֧��������Ʊ
    begin
      // ������ǰδ���浽���ﳵ�еĳ�Ʊ
      reset;
      showReceiptBox;
      if Assigned(defaultThroughControl) and
        (defaultThroughControl.Last <> nil) and
        (defaultThroughControl.Last.CanFocus) then
      begin
        defaultThroughControl.Last.SetFocus;
      end;
      isShoping := true;
    end;
  end    }

  else if Key = VK_ESCAPE then
  begin
    EscapeOccurActiveChange := true;
    GoToNextControl(winControl, false, true);
  end

//  else if (Key = VK_ADD) or ((Key = 187) and (Shift = [ssShift])) then // +
  else if (Key = VK_ADD) or ((Key = 187) and (Shift = [ssShift])) or
   ((Key=39) and ((Screen.ActiveControl is TSpinEdit) or (Screen.ActiveControl=edDISCOUNT_PRICE) )) then // +
  begin
    if not((winControl = nvhelpreachstation) and (nvhelpreachstation.Id <= 0)
        and (nvhelpSchedule.Id <= 0) and ((dsSchedule.DataSet = nil) or
          (not dsSchedule.DataSet.Active))) then
    begin
      if (winControl = nvdbgrdhschedule) and (Assigned(dsSchedule.DataSet)) and
        (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount > 0)
        and (GetTickCount - SellTicket.FrefreshCurScheduleTime >
          refreshScheduleInterval * 1000) then
      begin
        SellTicket.refreshseatandprice();
        if chkSellNet.checked and SellTicket.delayrefresh then
        begin
          refreshSeatPlan;
          curNeedSellNum := curNeedSellNum;
        end;
        // dsSchedule.DataSet.AfterScroll(dsSchedule.DataSet);
      end;
      EnterOccurActiveChange := true;
      GoToNextControl(winControl, true, false);
    end;
  end
  else if Key = VK_RETURN then
  begin
    if not((winControl = nvhelpreachstation) and (nvhelpreachstation.Id <= 0)
        and (nvhelpSchedule.Id <= 0) and ((dsSchedule.DataSet = nil) or
          (not dsSchedule.DataSet.Active))) then
    begin
      if (winControl = nvdbgrdhschedule) and (Assigned(dsSchedule.DataSet)) and
        (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount > 0)
        and (GetTickCount - SellTicket.FrefreshCurScheduleTime >
          refreshScheduleInterval * 1000) then
      begin
        if not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) then
        begin //ʡ����������Ʊ�����˷���
           SellTicket.refreshseatandprice();
        end;

        if chkSellNet.checked and SellTicket.delayrefresh then
        begin
          refreshSeatPlan;
          curNeedSellNum := curNeedSellNum;
        end;
        // dsSchedule.DataSet.AfterScroll(dsSchedule.DataSet);
      end ;
      EnterOccurActiveChange := true;
      GoToNextControl(winControl, true, true);
    end;
  end
  //else if (Key = VK_SUBTRACT) or ((Key = 189) and (Shift = [ssShift])) then // -
  else if ((Key = VK_SUBTRACT) or ((Key = 189) and (Shift = [ssShift])) or
  ((Key = 37) and ((Screen.ActiveControl is TSpinEdit) or (Screen.ActiveControl=edDISCOUNT_PRICE) ))) then // -
  begin
    EscapeOccurActiveChange := true;
    GoToNextControl(winControl, false, false);
  end
  else
  begin
      OutputDebugString('continueDealKey := true;');
      continueDealKey := true;
  end;
  if not continueDealKey then
  begin
    Key := 0;
  end;
end;

procedure TFrmSellTicket.FormShow(Sender: TObject);
var
  filepath, salehintname: String;
  hWndClose: HWND;
begin
  inherited;
  if openSaleHintScreen then
  begin
    filepath := ExtractFilePath(ParamStr(0)) + 'SaleHintScreen.exe';
    // С��ʾ��Ļ����Ƿ��
    salehintname := 'SaleHintScreen'; // min_Screen ��С��ʾ��Ļ����򿪵�����
    // ��ʼ��������
    hWndClose := FindWindow(nil, PChar(salehintname)); // ���ݴ���������Ҫ���ھ��
    if hWndClose = 0 then // ���Ҳ��ɹ�,��ʾû�д�
    begin
      try
        ShellExecute(handle, 'open', PChar(filepath), nil, nil, SW_SHOWNORMAL);
        SetForegroundWindow(GetTopParentHandle);
      except
      end;
    end;
  end;

  nvhelpdepartstation.Text := sysinfo.LoginUserInfo.OrgName;
  nvhelpdepartstation.Id := sysinfo.LoginUserInfo.StationID;
  gb3.Caption := DateCn.CnMonthOfDate(dtpdepartdate.DateTime) + '  ' + DateCn.CnDayOfDate(dtpdepartdate.DateTime);
  checkBoxClick(chkSellNet);
  checkBoxClick(cbsellinsure);
  reset;
  nvdbgrdhschedule.jsonConnection := DMPublic.jcon;
  if nvdbgrdhschedule.AutoGridSave then
  begin
    nvdbgrdhschedule.GridUser := sysinfo.LoginUserInfo.UserID;
  end;
  notifyMiniScreen(FINISH, sysinfo.LoginUserInfo.UserCode);
end;

function TFrmSellTicket.getCDSSchedule: TjsonClientDataSet;
begin
  result := TjsonClientDataSet(dsSchedule.DataSet);
end;

function TFrmSellTicket.getCurInsurenum: Integer;
begin
  result := 0;
  if not cbautosellinsure.checked then
  begin
    exit;
  end;

  // ͳ�ƻ�û�д浽������Ʊ��
  if (Assigned(FrmCustomerAdd)) and
    (Assigned(FrmCustomerAdd.dsInsuranceBuffer.DataSet)) and
    (FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active) then
  begin
    with FrmCustomerAdd.dsInsuranceBuffer.DataSet do
    begin
      //DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('issell').AsBoolean then
        begin
          Inc(result);
        end;
        next;
      end;
      //EnableControls;
    end;
  end;
end;

function TFrmSellTicket.getCurInsurereceivablenum: Currency;
var
  i: Integer;
begin
  result := 0;
  if not  cbautosellinsure.checked then
  begin
     Exit;
  end;

  // ͳ�ƻ�û�д浽������Ʊ��
  if (Assigned(FrmCustomerAdd)) and
    (Assigned(FrmCustomerAdd.dsInsuranceBuffer.DataSet)) and
    (FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active) then
  begin
    with FrmCustomerAdd.dsInsuranceBuffer.DataSet do
    begin
      //DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('issell').AsBoolean then
        begin
          result := result + FieldByName('premium').AsCurrency;
        end;
        next;
      end;
      //EnableControls;
    end;
  end;
end;

function TFrmSellTicket.getCurPrintTicketnum: Integer;
var
  num: Word;
  i: Integer;
begin
  if not Assigned(seTicketNum_T) then
  begin
    if Assigned(dsSchedule.DataSet) and dsSchedule.DataSet.Active and
      (dsSchedule.DataSet.RecordCount > 0) and dsSchedule.DataSet.FieldByName
      ('isroundtrip').AsBoolean then
      result := curNeedSellNum * 2
    else
      result := curNeedSellNum;
  end
  else
  begin
    // �����������Ʊ�����Ʊ������㷽ʽ��һ��
    num := 0;
    for i := 0 to gbamount.ControlCount - 1 do
    begin
      if (gbamount.Controls[i] is TSpinEdit) then
      begin
        if (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
        begin
          if ((rightstr(gbamount.Controls[i].Name, 1) = 'T') or
              (rightstr(gbamount.Controls[i].Name, 1) = 'H')) and
            ((gbamount.Controls[i] as TSpinEdit).Value > 0) then
            num := num + 1
          else if Assigned(dsSchedule.DataSet)
            and dsSchedule.DataSet.Active and
            (dsSchedule.DataSet.RecordCount > 0)
            and dsSchedule.DataSet.FieldByName('isroundtrip').AsBoolean then
            num := num + (gbamount.Controls[i] as TSpinEdit).Value * 2
          else
            num := num + (gbamount.Controls[i] as TSpinEdit).Value;
        end;
      end;
    end;
    result := num;
  end;
end;

function TFrmSellTicket.getCurticketnum: Integer;
begin
  result := curNeedSellNum;
end;

function TFrmSellTicket.getCurTicketreceivablenum: Currency;
var
  i: Integer;
begin
  result := 0;
  // ����Ӧ��
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) and
      ((gbamount.Controls[i] as TSpinEdit).Value > 0) then
    begin
      result := result + (gbamount.Controls[i] as TSpinEdit)
        .Value * getPriceByTicketTypeCode(rightstr(gbamount.Controls[i].Name,
          1));
    end;
  end;
end;

function TFrmSellTicket.getPriceByTicketTypeCode(ticketTypeCode: string)
  : Currency;
begin
  result := 0;
  if (not Assigned(dsSchedule.DataSet)) or (not dsSchedule.DataSet.Active) then
    exit;
  if (ticketTypeCode = 'Q') then
    result := dsSchedule.DataSet.FieldByName('fullprice').AsCurrency
  else if (ticketTypeCode = 'B') then
    result := dsSchedule.DataSet.FieldByName('halfprice').AsCurrency
  else if (ticketTypeCode = 'X') then
    result := dsSchedule.DataSet.FieldByName('studentprice').AsCurrency
  else if (ticketTypeCode = 'D') then
    result := dsSchedule.DataSet.FieldByName('discountprice').AsCurrency
  else if (ticketTypeCode = 'Z') then
  begin
    if StrToCurrDef(edDISCOUNT_PRICE.Text, 0) < 0 then
    begin
      edDISCOUNT_PRICE.Text := CurrToStr
        (SellTicket.GetTickettypePrice(dsSchedule.DataSet.FieldByName
            ('scheduleid').AsLargeInt,
          dsSchedule.DataSet.FieldByName('departdate').AsDateTime,
          ticketTypeCode,
          dsSchedule.DataSet.FieldByName('fullprice').AsCurrency));
    end;
//    else if StrToCurrDef(edDISCOUNT_PRICE.Text, 0)
//      > dsSchedule.DataSet.FieldByName('fullprice').AsCurrency then
//    begin
//      edDISCOUNT_PRICE.Text := CurrToStr(dsSchedule.DataSet.FieldByName
//          ('fullprice').AsCurrency);
//    end;
    result := StrToCurr(edDISCOUNT_PRICE.Text);
  end
  else
  begin
    result := SellTicket.GetTickettypePrice
      (dsSchedule.DataSet.FieldByName('scheduleid').AsLargeInt,
      dsSchedule.DataSet.FieldByName('departdate').AsDateTime, ticketTypeCode,
      dsSchedule.DataSet.FieldByName('fullprice').AsCurrency);
  end;
end;

function TFrmSellTicket.getTotalTicketreceivablenum: Currency;
begin
  result := getCurTicketreceivablenum +
    SellTicket.getTotalTicketBufferReceivablenum;
end;

function TFrmSellTicket.getTotalInsurenum: Integer;
begin
  result := getCurInsurenum;
  // ͳ�ƻ�����е�Ʊ��
  if (dsInsureBuffer.DataSet <> nil) and dsInsureBuffer.DataSet.Active then
  begin
    with dsInsureBuffer.DataSet do
    begin
      //DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('issell').AsBoolean then
        begin
          Inc(result);
        end;
        next;
      end;
      //EnableControls;
    end;
  end;
end;

function TFrmSellTicket.getTotalInsurereceivablenum: Currency;
begin
  result := getCurInsurereceivablenum +
    SellTicket.getTotalInsureBufferReceivablenum;
end;

function TFrmSellTicket.getTotalPrintTicketnum: Integer;
var
  bookmark: TBookmark;
begin
  result := getCurPrintTicketnum;
  // ͳ�ƻ�����е�Ʊ��
  if (dsTicketBuffer.DataSet <> nil) and dsTicketBuffer.DataSet.Active then
  begin
    with dsTicketBuffer.DataSet do
    begin
      bookmark := GetBookmark;
      First;
      while not eof do
      begin
        if (FieldByName('tickettype').AsString = 'T') or
          (FieldByName('tickettype').AsString = 'H') then
        begin
          result := 1;
          Break;
        end
        else if FieldByName('isroundtrip').AsBoolean then
          result := result + 2
        else
          result := result + 1;
        next;
      end;
      GotoBookmark(bookmark);
    end;
  end;
end;

function TFrmSellTicket.getTotalreceivablenum: Currency;
begin
  result := getTotalTicketreceivablenum + getTotalInsurereceivablenum;
  if SellWayEnd <> nil then
  begin
    result := result + SellWayEnd.getSellWayreceivablenum
  end;
end;

function TFrmSellTicket.getTotalticketnum: Integer;
begin
  result := getCurticketnum;
  // ͳ�ƻ�����е�Ʊ��
  if (dsTicketBuffer.DataSet <> nil) and dsTicketBuffer.DataSet.Active then
  begin
    result := result + dsTicketBuffer.DataSet.RecordCount;
  end;
end;

function TFrmSellTicket.GoToNextControl(curControl: TWinControl;
  goahead, skip: boolean): TWinControl;
var
  i: Integer;
  _ThroughControl: TList<TWinControl>;
  nextcontrol: TWinControl;
  frmsellticketend : Tfrmsellticketend;
begin
  i := -1;
  _ThroughControl := nil;
  nextcontrol := nil;
  if goahead then // ��ǰ
  begin
    if skip then
      _ThroughControl := defaultThroughControl
    else
      _ThroughControl := fullThroughControl;
    if _ThroughControl.Contains(curControl) then
    begin
      i := _ThroughControl.IndexOf(curControl);
      if i = _ThroughControl.Count - 1 then
      begin
        SaveOrSell(skip);
        exit;
      end
      else
      begin
        nextcontrol := _ThroughControl.Items[i + 1];
        {if nextcontrol.Name='pnlseatplan' then
        begin
            nextcontrol:=seatplan;
        end;}
      end;
    end
    else
    begin
      if (skip and fullThroughControl.Contains(curControl)) then
      begin
        if fullThroughControl.IndexOf(curControl)
          = fullThroughControl.Count - 1 then
        begin
          SaveOrSell(skip);
          exit;
        end
        else
        begin
          for i := fullThroughControl.IndexOf(curControl)
            + 1 to fullThroughControl.Count - 1 do
          begin
            if defaultThroughControl.Contains(fullThroughControl.Items[i]) then
            begin
              nextcontrol := fullThroughControl.Items[i];
              Break;
            end;
          end;
          if nextcontrol = nil then
          begin
            nextcontrol := fullThroughControl.Items[fullThroughControl.IndexOf
              (curControl) + 1];
          end;
        end;
      end
      else
      begin
        if throughControls.Count > 0 then
        begin
          nextcontrol := throughControls.Pop;
        end
        else
        begin
          nextcontrol := defaultThroughControl.Items[0];
        end;
      end;
    end;
  end
  else // ���
  begin
    // ��һ��Ҫ�����Ŀؼ�
    if curControl = fullThroughControl.Items[0] then
    begin
      exit;
    end;
    if skip then
    begin
      // �����˻ؾ����Ŀؼ�(�ؾ�)
      if throughControls.Count > 0 then
      begin
        nextcontrol := throughControls.Pop;
      end
      else
      begin
        if fullThroughControl.Contains(curControl) then
        begin
          for i := fullThroughControl.IndexOf(curControl) - 1 downto 0 do
          begin
            if (i >= 0) and defaultThroughControl.Contains
              (fullThroughControl.Items[i]) then
            begin
              nextcontrol := fullThroughControl.Items[i];
              Break;
            end;
          end;
          if nextcontrol = nil then
          begin
            nextcontrol := FindNextControl(curControl, goahead, true, false);
          end;
        end
        else
        begin
          nextcontrol := defaultThroughControl.Items[0];
        end;
      end;
    end
    else
    begin
      if fullThroughControl.Contains(curControl) then
      begin
        nextcontrol := fullThroughControl.Items[fullThroughControl.IndexOf
          (curControl) - 1];
      end
      else
      begin
        if throughControls.Count > 0 then
        begin
          nextcontrol := throughControls.Pop;
        end
        else
        begin
          nextcontrol := defaultThroughControl.Items[0];
        end;
      end;
    end;
  end;
  if nextcontrol <> nil then
  begin
    if checkParent(nextcontrol, pnlreceipt) and not checkParent(curControl,
      pnlreceipt) then
    begin
      if checkCanGoToReceive and showReceiptBox then
      begin
        if SellWayEnd.isShowEdit>0 then
        begin
          nextcontrol := fullThroughControl.Items[fullThroughControl.IndexOf(nextcontrol)-1];
        end;
        if nextcontrol.CanFocus then
        begin

            //nextcontrol.SetFocus;
            //���ÿؼ�ѡ��״̬ ���־ 2015��6��12�� 10:31:25
            //��ȡ�����ж��Ƿ����ѡ��
            if (getParametervalue('1059', Sysinfo.LoginUserInfo.OrgID) <> '1') and (nextcontrol.Name = 'nvedtticketreceivablenum')then
              begin
                try
                    fullThroughControl.Items[fullThroughControl.IndexOf(nextcontrol)].Enabled := False;
                    fullThroughControl.Items[fullThroughControl.IndexOf(nextcontrol)+1].SetFocus ;
                Except
                  on E: Exception do
                  begin
                    SysLog.WriteErr(E.Message);
                  end;
                end;
              end
            else if (nextcontrol.Name = 'nvedtreceipt') then
            begin
               fullThroughControl.Items[fullThroughControl.IndexOf(nextcontrol)].SetFocus;
              // nvedtservicefee.
               // exit;
            end
            else
            begin
               nextcontrol.SetFocus;
            end;
            //SysLog.WriteErr('------------------------------------------------');
            //SysLog.WriteErr('nextcontrol.CanFocus=true  '+nextcontrol.Name);
        end
        else
        begin
          //SysLog.WriteErr('curControl='+curControl.Name);
          curControl := fullThroughControl.Items[fullThroughControl.IndexOf(nextcontrol)-1];
          GoToNextControl(curControl, goahead, skip);
          //SysLog.WriteErr('nextcontrol='+curControl.Name);
        end;
        // nextcontrol.SetFocus;
      end
      else
      begin
        exit;
      end;
    end
    else
    begin
      if nextcontrol.CanFocus then
      begin
        nextcontrol.SetFocus;
      end
      else
      begin
        GoToNextControl(nextcontrol, goahead, skip);
      end;
    end;
  end;
  notifyMiniScreenSchedule;
end;

function TFrmSellTicket.initJJInsure: boolean;
begin
  result := false;
  if not Assigned(FrmTmpInsuranceNo) then
  begin
    FrmTmpInsuranceNo := TFrmTmpInsuranceNo.Create(Application);
  end;
  if FrmTmpInsuranceNo.initJJInsure then
  begin
    result := true;
    gbinsureno.Visible := true;
    lbl12.Visible := false;
    lblleaveinsurenum.Visible := false;
    lbl7.Visible := false;
    btnresetInsureNo.Visible := true;
  end;
end;

procedure TFrmSellTicket.initSellWayEnd;
var
  frmbookticketend: Tfrmbookticketend;
  frmsellticketend: Tfrmsellticketend;
  frmpatchsellticketend: Tfrmpatchsellticketend;
  frmsellBookticketend: TfrmsellBookticketend;
  frmchangeticketend: Tfrmchangeticketend;
  j: Integer;
begin
  if not Assigned(self.SellTicket) or (trim(self.SellTicket.sellway) = '') then
  begin
    raise Exception.Create('δ������Ʊ��ʽ');
  end;
  // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
  // 0������Ʊ��1��Ʊ��2���϶�Ʊ
  case SellTicket.sellway[1] of
    '0':
      begin
        frmsellticketend := Tfrmsellticketend.Create(self);
        SellWayEnd := frmsellticketend;
      end;
    '1', '2':
      begin
        frmpatchsellticketend := Tfrmpatchsellticketend.Create(self);
        SellWayEnd := frmpatchsellticketend;
      end;
    '4':
      begin
        frmchangeticketend := Tfrmchangeticketend.Create(self);
        SellWayEnd := frmchangeticketend;
      end;
    '6':
      begin
        frmsellBookticketend := TfrmsellBookticketend.Create(self);
        SellWayEnd := frmsellBookticketend;
      end;
    '8':
      begin
        frmbookticketend := Tfrmbookticketend.Create(self);
        SellWayEnd := frmbookticketend;
      end;
  end;

(SellWayEnd as Tfrmsellwayend).defaultThroughControl := self.defaultThroughControl;
(SellWayEnd as Tfrmsellwayend).fullThroughControl := self.fullThroughControl;
(SellWayEnd as Tfrmsellwayend).parent := pnlsellwayend;
(SellWayEnd as Tfrmsellwayend).Left := 0;
(SellWayEnd as Tfrmsellwayend).Top := 0;
  receiptSchedule:=TfrmreceiptSchedule.Create(Self);
  receiptSchedule.parent := pnlreciptSchedule;
  receiptSchedule.Align:=alClient;
end;

procedure TFrmSellTicket.initThroughControl;
var
  i: Integer;
begin
  defaultThroughControl := TList<TWinControl>.Create;
  defaultThroughControl.Add(nvhelpreachstation);
  defaultThroughControl.Add(nvdbgrdhschedule);
  defaultThroughControl.Add(seTicketNum_Q);
  //defaultThroughControl.Add(pnlseatplan);   //pnlseatplan
  fullThroughControl := TList<TWinControl>.Create;
  fullThroughControl.Add(dtpdepartdate);
  fullThroughControl.Add(nvhelpdepartstation);
  fullThroughControl.Add(nvhelpreachstation);
  fullThroughControl.Add(nvdbgrdhschedule);
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) or (gbamount.Controls[i] is TEdit)
      then
      fullThroughControl.Add(TWinControl(gbamount.Controls[i]));
  end;

  fullThroughControl.Add(cbtakekid);
  fullThroughControl.Add(sekid);

  throughControls := TStack<TWinControl>.Create;
  lastActiveControls := TQueue<TWinControl>.Create;
  lastActiveControls.Enqueue(nil);

  initSellWayEnd();

  fullThroughControl.AddRange(SellWayEnd.getfullThroughControl);
  defaultThroughControl.AddRange(SellWayEnd.getdefaultThroughControl);
end;

function TFrmSellTicket.initTicketType: boolean;
var
  lb: TLabel;
  sed: TSpinEdit;
  i: Integer;
  _left: Integer;
  space: Integer;
begin
  result := false;
  if Assigned(SellTicket) then
  begin
    with SellTicket.cdsTicketType do
    begin
      First;
      i := 0;
      space := 5;
      _left := space;
      while not eof do
      begin
        lb := TLabel.Create(self);
        with lb do
        begin
          Caption := FieldByName('printname').AsString;
          parent := gbamount;
          ParentFont := true;
          Left := _left;
          Top := 25;
        end;
        sed := TSpinEdit.Create(self);
        with sed do
        begin
          Name := 'seTicketNum_' + FieldByName('code').AsString;
          parent := gbamount;
          Width := 40;
          Left := lb.Left + lb.Canvas.TextWidth(lb.Caption);
          Top := 20;
          Height := 29;
          Font.Assign(gbamount.Font);
          Font.Style := Font.Style + [fsBold];
          MinValue := 0;
          MaxValue := 99;
          MaxLength := 2;
          OnChange := ticketnumChange;
          if i = 0 then
          begin
            Value := 0;
            seTicketNum_Q := sed;
          end
          else
            Value := 0;
        end;
        _left := sed.Left + sed.Width + space;

        if FieldByName('code').AsString = 'T' then // ��¼����Ʊ�����
        begin
          seTicketNum_T := sed;
        end;
        if FieldByName('code').AsString = 'H' then // ��¼����Ʊ�����
        begin
          seTicketNum_H := sed;
        end;

        if FieldByName('code').AsString = 'Z' then //�Ż�Ʊ
        begin
          seTicketNum_Z := sed;
          edDISCOUNT_PRICE := TNovaEdit.Create(self);
          with edDISCOUNT_PRICE do
          begin
            parent := gbamount;
            Name := 'DISCOUNT_PRICE';
            Text := '0';
            Width := 40;
            parent := gbamount;
            ParentFont := true;
            Left := _left;
            Top := 22;
            // Font.Assign(gbamount.Font);
            // Font.Style:=Font.Style+[fsBold];
            // numbersonly:=true;
            valuetype := ssDouble;
            _left := _left + Width + space;
          end;
        end;

        gbamount.Width := _left;
        result := true;
        Inc(i);
        next;
      end;
    end;
  end;

end;

function TFrmSellTicket.lockseat: String;
var
  guid: TGUID;
  unlocktime: TDateTime;
  seatnos_S: string;
  tickettypes_S, pricess_S, outJxsEticketid_S: String;
  i, j: Integer;
  pricebyttcode : Currency;
begin
  result := '';
  if (not SellTicket.cansellroundtrip) and dsSchedule.DataSet.FieldByName
    ('isroundtrip').AsBoolean then
  begin
    SysDialogs.ShowError('��ʼ�����̳�Ʊ��ӡģ��ʧ�ܣ���������������Ʊ');
    exit;
  end;

  if not checkSelectSeat then
    exit;
  if dsSchedule.DataSet.FieldByName('islinework').AsBoolean then
  begin
    // ��ˮ�಻����λ
    result := '0';
    // result:=true;
  end
  else
  begin
    // result:=false;
    if not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) then
    begin
        if SeatPlan.selectedSeats.Count = 0 then
        begin
          exit;
        end;
    end;

    if curlockedguid_str = '' then
    begin
      if CreateGUID(guid) = S_OK then
      begin
      end
      else
      begin
        SysDialogs.ShowError('����guid����!');
        exit;
      end;
    end
    else
    begin
      guid := StringToGUID(curlockedguid_str);
    end;

    try
      seatnos_S := '';
      outJxsEticketid_S := '';
      tickettypes_S := '';
      pricess_S := '';
      // ����ʡ������Ʊ ȡƱ�ּ�Ʊ��
      for i := 0 to gbamount.ControlCount - 1 do
      begin
        if (gbamount.Controls[i] is TSpinEdit) then
        begin
          if (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
          begin
            if (gbamount.Controls[i] as TSpinEdit).Value > 0 then
            begin
               pricebyttcode := getPriceByTicketTypeCode(rightstr(gbamount.Controls[i].Name, 1));
            end;
            for j := 0 to (gbamount.Controls[i] as TSpinEdit).Value - 1 do
            begin
              if tickettypes_S = '' then
              begin
                tickettypes_S := rightstr(gbamount.Controls[i].Name, 1);
                pricess_S := CurrToStr(pricebyttcode);
              end
              else
              begin
                tickettypes_S := tickettypes_S + ',' + rightstr
                  (gbamount.Controls[i].Name, 1);
//                pricess_S := pricess_S + ',' + CurrToStr
//                  (getPriceByTicketTypeCode
//                    (rightstr(gbamount.Controls[i].Name, 1)));
                 pricess_S := pricess_S + ',' + CurrToStr(pricebyttcode);

              end;
            end;
          end;
        end;
      end;
     outputDebugString(PWideChar('----lockseat---����λ���ú�̨-----begin------'));
    if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
    begin
        unlocktime := SellTicket.lockseat(guid,
        dsSchedule.DataSet.FieldByName('scheduleplanid').AsLargeInt,
        dsSchedule.DataSet.FieldByName('seattype').AsString, seatnos_S, tickettypes_S, pricess_S,
        outJxsEticketid_S, IfThen(cbtakekid.checked, sekid.Value, 0));
    end
    else
    begin
        unlocktime := SellTicket.lockseat(guid,
        dsSchedule.DataSet.FieldByName('scheduleplanid').AsLargeInt,
        SeatPlan.selectedSeats, SeatPlan.selectSeatStatus,
        SeatPlan.selectSeattype, seatnos_S, tickettypes_S, pricess_S,
        outJxsEticketid_S, IfThen(cbtakekid.checked, sekid.Value, 0));
    end;
    outputDebugString(PWideChar('----lockseat---����λ���ú�̨-----end------'));
      // result:=true;
      result := seatnos_S;
      curlockedguid_str := GUIDToString(guid);
      curlockedScheduleplanid := dsSchedule.DataSet.FieldByName
        ('scheduleplanid').AsLargeInt;
      if not Assigned(curlockedSeatnos) then
        curlockedSeatnos := TList<Word>.Create
      else
        curlockedSeatnos.Clear;
      if not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2)) then
    begin
      curlockedSeatnos.AddRange(SeatPlan.selectedSeats);
    end;
      if not Assigned(curlockedJxsEticketids) then
        curlockedJxsEticketids := TStringList.Create
      else
        curlockedJxsEticketids.Clear;
      curlockedJxsEticketids.CommaText := outJxsEticketid_S;
      tmrunlockseat.Enabled := false;
      tmrunlockseat.Interval := Trunc
        (TimeStampToMSecs(DateTimeToTimeStamp(unlocktime)) - TimeStampToMSecs
          (DateTimeToTimeStamp(now)));
      tmrunlockseat.Enabled := true;
    except
      on E: Exception do
        SysDialogs.ShowError(E.Message);
    end;
  end;
end;

procedure TFrmSellTicket.NBufferTicketDeleteClick(Sender: TObject);
var
  seats: TList<Word>;
begin
  inherited;
  if (dsTicketBuffer.DataSet <> nil) and (dsTicketBuffer.DataSet.Active) and
    (dsTicketBuffer.DataSet.RecordCount > 0) then
  begin
    if SysDialogs.Confirm('ȷ��', 'ȷ��Ҫȡ�����ų�Ʊ��') then
    begin
      if not dsTicketBuffer.DataSet.FieldByName('islinework').AsBoolean then
      begin
        // �������ų�Ʊ
        if (curlockedguid_str <> '') then
        begin
          seats := TList<Word>.Create;
          seats.Add(dsTicketBuffer.DataSet.FieldByName('seatno').AsInteger);
          SellTicket.unlockSeat(StringToGUID(curlockedguid_str),
            dsTicketBuffer.DataSet.FieldByName('scheduleplanid').AsLargeInt,
            seats);
        end
        else
        begin
          SysDialogs.ShowError('��ǰ��������־δ֪��');
        end;
      end;
      dsTicketBuffer.DataSet.Delete;
      if Assigned(dsInsureBuffer.DataSet) and dsInsureBuffer.DataSet.Locate
        ('scheduleplanid;seatno',
        VarArrayOf([dsTicketBuffer.DataSet.FieldValues['scheduleplanid'],
          dsTicketBuffer.DataSet.FieldValues['seatno']]), []) then
      begin
        dsTicketBuffer.DataSet.Delete;
      end;
      if dsTicketBuffer.DataSet.RecordCount = 0 then
      begin
        curlockedguid_str := '';
        if Assigned(curlockedJxsEticketids) then
          curlockedJxsEticketids.Clear;
        gbticketbuffer.Visible := false;
        splbufferticket.Visible := false;
        if defaultThroughControl.Items[0].CanFocus then
        begin
          defaultThroughControl.Items[0].SetFocus;
        end;
      end;
    end;
  end;
end;

procedure TFrmSellTicket.notifyMiniScreenSchedule;
var
  info: String;
  i: Integer;
  curfullnum, curhalfnum: Integer;
begin
  if not openSaleHintScreen then exit;

  if (not Assigned(dsSchedule.DataSet)) or (not dsSchedule.DataSet.Active) or
    (dsSchedule.DataSet.RecordCount <= 0) then
    exit;
  if not(SellWayEnd is Tfrmsellticketend) then
    exit;
  info := dsSchedule.DataSet.FieldByName('reachstationname')
    .AsString + ',' + IfThen(dsSchedule.DataSet.FieldByName('isovertime')
      .AsBoolean, '�Ӱ೵', '���೵') + ',' + formatdatetime('dd',
    dsSchedule.DataSet.FieldByName('departdate').AsDateTime) + ',' + copy
    (dsSchedule.DataSet.FieldByName('departtime').AsString, 1, 2) + ',' + copy
    (dsSchedule.DataSet.FieldByName('departtime').AsString, 4, 5)
    + ',' + dsSchedule.DataSet.FieldByName('fullprice').AsString;
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) then
    begin
      if seTicketNum_Q = gbamount.Controls[i] then
        curfullnum := (gbamount.Controls[i] as TSpinEdit).Value
      else
        curhalfnum := curhalfnum + (gbamount.Controls[i] as TSpinEdit).Value;
    end;
  end;

  info := info + ',' + inttostr(curfullnum) + ',' + inttostr(curhalfnum)
    + ',' + CurrToStr(getCurTicketreceivablenum) + ',' + CurrToStr
    (getTotalTicketreceivablenum) + ',' + IfThen(pnlreceipt.Visible,
    (SellWayEnd as Tfrmsellticketend).nvedtreceipt.Text, '0') + ',' + IfThen
    (pnlreceipt.Visible, (SellWayEnd as Tfrmsellticketend).lblchange.Caption,
    '-' + CurrToStr(getCurTicketreceivablenum))
    + ',' + dsSchedule.DataSet.FieldByName('ticketentrance').AsString;
  notifyMiniScreen(TMiniScreenMSG.LISTSCHEDULE, info);
end;

procedure TFrmSellTicket.nvdbgrdhscheduleDblClick(Sender: TObject);
begin
  inherited;
  if (Assigned(dsSchedule.DataSet)) and (dsSchedule.DataSet.Active) and
    (dsSchedule.DataSet.RecordCount > 0) and
    (GetTickCount - SellTicket.FrefreshCurScheduleTime >
      refreshScheduleInterval * 1000) then
  begin
    SellTicket.refreshseatandprice();
    if chkSellNet.checked and SellTicket.delayrefresh then
    begin
      refreshSeatPlan;
    end;
  end;
end;

procedure TFrmSellTicket.nvdbgrdhscheduleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  // if (Column.FieldName='fullprice') or (Column.FieldName='residueseatnum') then
  // begin
  // Exit;
  // end;
  // if (dsSchedule.DataSet.FieldByName('isreported').AsBoolean) and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clGreen;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
  // // ��ͣ
  // if (dsSchedule.DataSet.FieldByName('status').AsString = '1') and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clRed; // clYellow;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
  // // ����
  // if (dsSchedule.DataSet.FieldByName('status').AsString = '3') and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clLtGray; // clYellow;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
  // // �Ѱ�
  // if (dsSchedule.DataSet.FieldByName('status').AsString = '4') and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clOlive;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
  // // ͣ��
  // if (dsSchedule.DataSet.FieldByName('status').AsString = '5') and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clFuchsia;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
  // if (dsSchedule.DataSet.FieldByName('isdeparted').AsBoolean) and not
  // (gdSelected in State) then
  // begin
  // nvdbgrdhschedule.Canvas.Font.Color := clBlue;
  // nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  // end;
end;

procedure TFrmSellTicket.nvdbgrdhscheduleGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (dsSchedule.DataSet.FieldByName('isreported').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
  end;

  // ��ͣ
  if (dsSchedule.DataSet.FieldByName('status').AsString = '1') and not
    (gdSelected in State) then
  begin
    Background := clRed; // clYellow;
  end
  // ����
  else if (dsSchedule.DataSet.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
  end
  // �Ѱ�
  else if (dsSchedule.DataSet.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clYellow;
  end
  // ͣ��
  else if (dsSchedule.DataSet.FieldByName('status').AsString = '5') and not
    (gdSelected in State) then
  begin
    Background := clFuchsia;
  end;

  if (dsSchedule.DataSet.FieldByName('isdeparted').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clMoneyGreen;
  end;

  if (Column.FieldName = 'fullprice')
    or (Column.FieldName = 'halfprice') or (Column.FieldName = 'studentprice')
//    or (Column.FieldName = 'residueseatnum')
//    or (Column.FieldName = 'departdate') or (Column.FieldName = 'departtime')
    then
  begin
    AFont.Color := clRed;
    AFont.Size := nvdbgrdhschedule.Font.Size + 3;
    Background := clCream;
  end
  else
  begin
    AFont.Color := clBlack;
    AFont.Size := nvdbgrdhschedule.Font.Size + 3;
    Background := clCream;
  end;
end;

procedure TFrmSellTicket.nvdbgrdhscheduleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END] then
  begin
    OutputDebugString('nvdbgrdhschedule keydown');
    self.SellTicket.nvdbgrdhscheduleMoveByKey:=true;
  end;
end;

procedure TFrmSellTicket.nvdbgrdhscheduleKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i:Integer;
begin
  inherited;
  self.SellTicket.nvdbgrdhscheduleMoveByKey:=false;
  if Key in [VK_UP, VK_PRIOR, VK_DOWN, VK_NEXT, VK_HOME, VK_END] then
  begin
    OutputDebugString('nvdbgrdhschedule keyup');
    for I := 0 to 15 - 1 do
//    while self.SellTicket.nvdbgrdhscheduleMoveByKey= do
    begin
      Sleep(10);
      Application.ProcessMessages;
      if self.SellTicket.nvdbgrdhscheduleMoveByKey then
        exit ;
    end;
    self.SellTicket.ScheduleAfterScroll(nil);
  end;
end;

procedure TFrmSellTicket.nvdbgrdhticketbufferKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DELETE) then
     NBufferTicketDeleteClick(NBufferTicketDelete)
  else if Key=13 then
  begin
    // ��ӡ���ﳵ�еĳ�Ʊ                                                   1
    if (not pnlreceipt.Visible) and (not(SellTicket.sellway[1] in ['4', '8']))
      and gbticketbuffer.Visible and Assigned(dsTicketBuffer.DataSet)
      and dsTicketBuffer.DataSet.Active and
      (dsTicketBuffer.DataSet.RecordCount > 0) then // 4��Ʊ��8��Ʊ��֧��������Ʊ
    begin
      // ������ǰδ���浽���ﳵ�еĳ�Ʊ
      reset;
      showReceiptBox;
      if Assigned(defaultThroughControl) and
        (defaultThroughControl.Last <> nil) and
        (defaultThroughControl.Last.CanFocus) then
      begin
        defaultThroughControl.Last.SetFocus;
      end;
      isShoping := true;
      Key:=0;
    end;
  end;
end;

procedure TFrmSellTicket.nvhelpdepartstationChange(Sender: TObject);
begin
  inherited;
  if (nvhelpdepartstation.ignoreSearchFlag <> '') and
    (pos(nvhelpdepartstation.ignoreSearchFlag, nvhelpdepartstation.Text) = 1)
    and (length(nvhelpdepartstation.ignoreSearchFlag) < length
      (nvhelpdepartstation.Text)) then
  begin
    nvhlpdepartdistrict.init;
    nvhlpdepartdistrict.notFocusedShowHelp := true;
    nvhlpdepartdistrict.Text := copy(nvhelpdepartstation.Text,
      length(nvhelpdepartstation.ignoreSearchFlag) + 1);
  end
  else
  begin
    nvhlpdepartdistrict.notFocusedShowHelp := false;
    nvhlpdepartdistrict.Text := '';
  end;
end;

procedure TFrmSellTicket.nvhelpreachstationChange(Sender: TObject);
begin
  inherited;
  if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
  begin
      nvhelpreachstation.Params.ParamByName('cityid').Value:=nvhelpdepartstation.Id;
  end
  else
  begin
     nvhelpreachstation.Params.ParamByName('cityid').Value:='';
  end;
  if (nvhelpreachstation.ignoreSearchFlag <> '') and
    (pos(nvhelpreachstation.ignoreSearchFlag, nvhelpreachstation.Text) = 1)
    and (length(nvhelpreachstation.ignoreSearchFlag) < length
      (nvhelpreachstation.Text)) then
  begin
    nvhelpSchedule.init;
    nvhelpSchedule.notFocusedShowHelp := true;
    nvhelpSchedule.Text := copy(nvhelpreachstation.Text,
      length(nvhelpreachstation.ignoreSearchFlag) + 1);
  end
  else
  begin
    nvhelpSchedule.notFocusedShowHelp := false;
    nvhelpSchedule.Text := '';
  end;
end;

procedure TFrmSellTicket.nvhelpreachstationEnter(Sender: TObject);
begin
  inherited;
  throughControls.Clear;
  lastActiveControls.Clear;
  lastActiveControls.Enqueue(nil);
end;

procedure TFrmSellTicket.nvhelpreachstationIdChange(Sender: TObject);
var
  oldchangeEvent: TNotifyEvent;
begin
  inherited;
  if (Sender = nvhelpSchedule) then
  begin
    if (not chkSellNet.checked) and (nvhelpreachstation.ignoreSearchFlag <> '')
      and (pos(nvhelpreachstation.ignoreSearchFlag,
        nvhelpreachstation.Text) = 1) and
      (nvhelpreachstation.ignoreSearchFlag +
        nvhelpSchedule.Text <> nvhelpreachstation.Text) then
    begin
      oldchangeEvent := nvhelpreachstation.OnChange;
      nvhelpreachstation.Text := nvhelpreachstation.ignoreSearchFlag +
        nvhelpSchedule.Text;
      nvhelpreachstation.OnChange := oldchangeEvent;
    end;
    nvhelpreachstation.SetFocus;
  end;
  if (Sender = nvhlpdepartdistrict) then
  begin
    if (chkSellNet.checked) and (nvhelpdepartstation.ignoreSearchFlag <> '')
      and (pos(nvhelpdepartstation.ignoreSearchFlag,
        nvhelpdepartstation.Text) = 1) and
      (nvhelpdepartstation.ignoreSearchFlag + nvhlpdepartdistrict.Text <>
        nvhelpdepartstation.Text) then
    begin
      oldchangeEvent := nvhelpdepartstation.OnChange;
      nvhelpdepartstation.Text := nvhelpdepartstation.ignoreSearchFlag +
        nvhlpdepartdistrict.Text;
      nvhelpdepartstation.OnChange := oldchangeEvent;
    end;
    nvhelpdepartstation.SetFocus;
  end;
  findSchedule;
end;

procedure TFrmSellTicket.pnlreceiptMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  ReleaseCapture;
  SendMessage(pnlreceipt.handle, wm_SysCommand, $F012, 0);
end;

procedure TFrmSellTicket.pnlscheduleResize(Sender: TObject);
begin
  inherited;
  nvdbgrdhschedule.Left := nvdbgrdhschedule.Margins.Left;
  nvdbgrdhschedule.Top := nvdbgrdhschedule.Margins.Top;

  nvdbgrdhschedule.Width := pnlschedule.ClientWidth -
    nvdbgrdhschedule.Margins.Left - nvdbgrdhschedule.Margins.Right;
  nvdbgrdhschedule.Height := pnlschedule.ClientHeight -
    nvdbgrdhschedule.Margins.Top - nvdbgrdhschedule.Margins.Bottom;
end;

procedure TFrmSellTicket.pnlseatplanResize(Sender: TObject);
begin
  inherited;
  seatPlanSizeReSize;
end;

procedure TFrmSellTicket.pnlvipResize(Sender: TObject);
begin
  inherited;
  bvlvip.Left := 5;
  bvlvip.Width := max(0, (pnlvip.Width - bvlvip.Left * 2));
end;

procedure TFrmSellTicket.refreshBill(silent: boolean);
begin
  // ��Ʊ����Ҫ����
  if SellTicket.sellway[1] = '8' then
    exit;
  if sysinfo.LoginUserInfo.curBillNo.ContainsKey('Ticket')
    and sysinfo.LoginUserInfo.curBillNum.ContainsKey('Ticket') then
  begin
    lblticketno.Caption := sysinfo.LoginUserInfo.curBillNo.Items['Ticket'];
    lblleaveticketnum.Caption := inttostr
      (sysinfo.LoginUserInfo.curBillNum.Items['Ticket']);
    // ��ʾ�û�
    tmrleaveticketnum.Enabled :=
      (ticketnumhituser > sysinfo.LoginUserInfo.curBillNum.Items['Ticket']);
  end
  else
  begin
    tmrleaveticketnum.Enabled := false;
    if not silent then
      SysDialogs.ShowError('��Ʊû�г�ʼ������������Ʊ��');
    lblticketno.Caption := '0';
    lblleaveticketnum.Caption := '0';
  end;
end;

procedure TFrmSellTicket.refreshCanSaleTicketType;
var
  i: Integer;
  haspermission: boolean;
begin
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) and
      ((seTicketNum_Q <> gbamount.Controls[i]) and
        (rightstr(gbamount.Controls[i].Name, 1) <> 'Q') and
        (rightstr(gbamount.Controls[i].Name, 1) <> 'B') and
        (rightstr(gbamount.Controls[i].Name, 1) <> 'Z') and
        (rightstr(gbamount.Controls[i].Name, 1) <> 'T') and
        (rightstr(gbamount.Controls[i].Name, 1) <> 'X')) then
    begin // ����Ʊֻ������ȫ���롢ѧ
      gbamount.Controls[i].Enabled := not chkSellNet.checked;
    end;
  end;

//  if Assigned(edDISCOUNT_PRICE) then
//  begin
//    edDISCOUNT_PRICE.Enabled := (not chkSellNet.checked)
//      and seTicketNum_Z.Enabled;
//  end;

  // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
  if Assigned(seTicketNum_T) and (SellTicket.sellway[1] <> '0') and
    (SellTicket.sellway[1] <> '1') and (SellTicket.sellway[1] <> '2') then
  begin
    seTicketNum_T.Enabled := false; // ����Ʊ����Ʊ����Ȩ��Ʊ�⣬������Ʊ��ʽ��������������Ʊ
  end;
  if Assigned(seTicketNum_H) and (SellTicket.sellway[1] <> '0') and
    (SellTicket.sellway[1] <> '1') and (SellTicket.sellway[1] <> '2') then
  begin
    seTicketNum_H.Enabled := false; // ����Ʊ����Ʊ����Ȩ��Ʊ�⣬������Ʊ��ʽ���������۰���Ʊ
  end;

  if (dsSchedule.DataSet = nil) or (not dsSchedule.DataSet.Active) or
    (dsSchedule.DataSet.RecordCount = 0) then
  begin
    exit;
  end;
  // ��ο���Ʊ��Ȩ��
  with jcdsCanSaleTicketType do
  begin
    Close;
    Params.ParamValues['scheduleid'] := dsSchedule.DataSet.FieldByName
      ('scheduleid').AsString;
    try
      Open;
      if RecordCount > 0 then
      begin
        for i := 0 to gbamount.ControlCount - 1 do
        begin
          if (gbamount.Controls[i] is TSpinEdit) and
            ((seTicketNum_Q <> gbamount.Controls[i]) and
              (rightstr(gbamount.Controls[i].Name, 1) <> 'Q')
            // and (rightstr(gbamount.Controls[i].Name,1)<>'B')
            // and (rightstr(gbamount.Controls[i].Name,1)<>'X')
            ) then
          begin
            if chkSellNet.checked and (rightstr(gbamount.Controls[i].Name,
                1) <> 'Q') and (rightstr(gbamount.Controls[i].Name,
                1) <> 'B') and (rightstr(gbamount.Controls[i].Name,
                1) <> 'T') and(rightstr(gbamount.Controls[i].Name, 1) <> 'Z') and (rightstr(gbamount.Controls[i].Name, 1) <> 'X')
              then
            begin
              gbamount.Controls[i].Enabled := false;
            end
            else
            begin
              haspermission := false;
              First;
              while not eof do
              begin
                if rightstr(gbamount.Controls[i].Name, 1) = FieldByName
                  ('tickettypecode').AsString then
                begin
                  haspermission := true;
                  Break;
                end;
                next;
              end;
              gbamount.Controls[i].Enabled := haspermission;
            end;
          end;
        end;
      end;
    except
    end;
  end;
  // ����Ʊ�����ۻس�Ʊ
  if Assigned(seTicketNum_T) then
  begin
    seTicketNum_T.Enabled := seTicketNum_T.Enabled and
      (not dsSchedule.DataSet.FieldByName('isroundtrip').AsBoolean);
    if not seTicketNum_T.Enabled then
    begin
      seTicketNum_T.Value := 0;
    end;
  end;

  // ����Ʊ�����ۻس�Ʊ
  if Assigned(seTicketNum_H) then
  begin
    seTicketNum_H.Enabled := seTicketNum_H.Enabled and
      (not dsSchedule.DataSet.FieldByName('isroundtrip').AsBoolean);
    if not seTicketNum_H.Enabled then
    begin
      seTicketNum_H.Value := 0;
    end;
  end;

end;

procedure TFrmSellTicket.refreshInsureBill(silent: boolean);
begin
  // ��Ʊ����Ҫ����
  if SellTicket.sellway[1] = '8' then
    exit;
  if SellTicket.cansellinsure and sysinfo.LoginUserInfo.curBillNo.ContainsKey
    ('Insure') and sysinfo.LoginUserInfo.curBillNum.ContainsKey('Insure') then
  begin
    lblinsureno.Caption := sysinfo.LoginUserInfo.curBillNo.Items['Insure'];
    lblleaveinsurenum.Caption := inttostr
      (sysinfo.LoginUserInfo.curBillNum.Items['Insure']);
    // ��ʾ�û�
    tmrleaveinsurenum.Enabled :=
      (ticketnumhituser > sysinfo.LoginUserInfo.curBillNum.Items['Insure']);
  end
  else
  begin
    tmrleaveinsurenum.Enabled := false;
    // if sellTicket.cansellinsure then
    // begin
    // if not silent then
    // SysDialogs.Warning('���յ�û�г�ʼ�����������۱��գ�');
    // sellTicket.cansellinsure:=false;
    // cbautosellinsure.Enabled:=sellTicket.cansellinsure;
    // cbautosellinsure.Checked:=sellTicket.cansellinsure;
    // lblinsureno.Caption:='0';
    // lblleaveinsurenum.Caption:='0';
    // end;
  end;
  if cansellJJinsure then
  begin
    lblinsureno.Caption := curJJinsuranceno;
  end;
end;

procedure TFrmSellTicket.reset;
var
  i: Integer;
  oldIdChange: TNotifyEvent;
begin
  if (dsSchedule.DataSet <> nil) and (dsSchedule.DataSet.Active) then
  begin
    // ������ǰ������λ
    if (curlockedguid_str <> '') and (curlockedScheduleplanid <> 0) then
    begin
      SellTicket.unlockSeat(StringToGUID(curlockedguid_str),
        curlockedScheduleplanid);
      clearCurlockedScheduleplanid;
      if not gbticketbuffer.Visible then
      begin
        curlockedguid_str := '';
        if Assigned(curlockedJxsEticketids) then
          curlockedJxsEticketids.Clear;
      end;
    end;
    dsSchedule.DataSet.Active := false;
  end;
  // �Զ��۱���
  if SellTicket.cansellinsure and cbautosellinsure.Enabled then
  begin
    cbautosellinsure.checked := autosellinsure;
  end;
  if cansellJJinsure and cbsellinsure.Enabled then
  begin
    cbsellinsure.checked := autosellinsure;
  end;
  // �Զ�ʵ��
  cbautoreceipt.checked := autorecive;

  dtpdepartdate.DateTime := Trunc(date);
  gb3.Caption := DateCn.CnMonthOfDate(dtpdepartdate.DateTime) + '  ' + DateCn.CnDayOfDate(dtpdepartdate.DateTime);
  setDepartDateColor;
  oldIdChange := nvhelpdepartstation.OnIdChange;
  nvhelpdepartstation.OnIdChange := nil;
  if (not chkSellNet.checked) then
  begin
    if autofilldepartstation then
    begin
       nvhelpdepartstation.Text := sysinfo.LoginUserInfo.OrgName;
       nvhelpdepartstation.Id := sysinfo.LoginUserInfo.StationID;
    end
    else
    begin
       nvhelpdepartstation.Text := '';
       nvhelpdepartstation.Id := 0;
    end;
  end
  else
  begin
    nvhelpdepartstation.Text := '';
    nvhelpdepartstation.Id := 0;
  end;
  nvhlpdepartdistrict.Text := '';
  nvhlpdepartdistrict.Id := 0;
  nvhelpdepartstation.OnIdChange := oldIdChange;
  nvhelpreachstation.Text := '';
  nvhelpreachstation.Id := 0;
  nvhelpSchedule.Text := '';
  nvhelpSchedule.Id := 0;
  nvhlpdepartdistrict.SendToBack;
  nvhelpSchedule.SendToBack;
  sekid.Value := 0;

  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if gbamount.Controls[i] is TSpinEdit then
    begin
      if (gbamount.Controls[i] = seTicketNum_Q) and isfullticketdefault then // ȫƱ
      begin (gbamount.Controls[i] as TSpinEdit)
        .Value := 1;
      end
      else
      begin (gbamount.Controls[i] as TSpinEdit)
        .Value := 0;
      end;
    end;
  end;
  if Assigned(FrmCustomerAdd) then
  begin
    if FrmCustomerAdd.Showing then
      FrmCustomerAdd.ModalResult := mrCancel;
    freeandnil(FrmCustomerAdd);
  end;
  cbtakekid.checked := false;

  if Assigned(SeatPlanDecorato) then
    SeatPlanDecorato.Visible := false;
  if gbticketbuffer.Visible then
    gbseatplan.Height := defaultSeatPlanHeight_buffer
  else
    gbseatplan.Height := defaultSeatPlanHeight;
  lblseatnos.Caption := '';
  curNeedSellNum := 0;
  SellWayEnd.reset;
  throughControls.Clear;
  lastActiveControls.Clear;
  lastActiveControls.Enqueue(nil);
  pnlreceipt.Visible := false;
  if Assigned(pnlJJIdCardinfos) then
    pnlJJIdCardinfos.Visible := false;
  clearCurlockedScheduleplanid;
  if defaultThroughControl.Items[0].CanFocus then
  begin
    defaultThroughControl.Items[0].SetFocus;
  end;
  if (SellTicket.sellway[1] <> '2') and (SellTicket.sellway[1] <> '5') then
  begin
    dtpdepartdate.MinDate := Trunc(now);
  end;
  if (not Assigned(dsTicketBuffer.DataSet)) or
    (not dsTicketBuffer.DataSet.Active) or
    (dsTicketBuffer.DataSet.RecordCount <= 0) then
    notifyMiniScreen(FINISH, sysinfo.LoginUserInfo.UserCode);
end;

procedure TFrmSellTicket.resetall;
begin
  // ��������ȫ����λ
  clearvipinfo;
  if curlockedguid_str <> '' then
  begin
    if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and
    (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
    begin
       SellTicket.isOpenApiUnlock:=1;
    end
    else
    begin
      SellTicket.isOpenApiUnlock:=0;
    end;
    SellTicket.unlockSeat(StringToGUID(curlockedguid_str));
    SellTicket.isOpenApiUnlock:=0;
    clearCurlockedScheduleplanid;
    curlockedguid_str := '';
    if Assigned(curlockedJxsEticketids) then
      curlockedJxsEticketids.Clear;
  end;
  if Assigned(FrmCustomerAdd) then
  begin
    if FrmCustomerAdd.Showing then
      FrmCustomerAdd.ModalResult := mrCancel;
    freeandnil(FrmCustomerAdd);
  end;
  // ��ջ��泵Ʊ
  if Assigned(dsTicketBuffer.DataSet) then
    dsTicketBuffer.DataSet.Active := false;
  if Assigned(dsInsureBuffer.DataSet) then
    dsInsureBuffer.DataSet.Active := false;
  gbticketbuffer.Visible := false;
  splbufferticket.Visible := false;
  //chkSellNet.checked := false;
  reset;
  gbseatplan.Height := defaultSeatPlanHeight;
  if Assigned(pnlJJIdCardinfos) then
  begin
    pnlJJIdCardinfos.num := 0;
  end;
end;

function TFrmSellTicket.saveInsuretobuffer: boolean;
begin
  result := true;
  if (not Assigned(FrmCustomerAdd)) or
    (not Assigned(FrmCustomerAdd.dsInsuranceBuffer.DataSet)) or
    (not FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active) or (not cbautosellinsure.Checked) then
  begin
    exit;
  end;

  // ���汣����Ϣ����ʱ��
  if not Assigned(self.dsInsureBuffer.DataSet) then
  begin
    self.dsInsureBuffer.DataSet := SellTicket.cdsInsureBuffer;
  end;
  if not self.dsInsureBuffer.DataSet.Active then
  begin
    self.dsInsureBuffer.DataSet.Active := true;
  end;
  with FrmCustomerAdd.dsInsuranceBuffer.DataSet do
  begin
    First;
    while not eof do
    begin
      // if not FieldByName('issell').AsBoolean then Continue;
      self.dsInsureBuffer.DataSet.Append;
      self.dsInsureBuffer.DataSet.FieldValues['issell'] := FieldValues
        ['issell'];

      self.dsInsureBuffer.DataSet.FieldValues['scheduleplanid'] := FieldValues
        ['scheduleplanid'];
      self.dsInsureBuffer.DataSet.FieldValues['departdate'] := FieldValues
        ['departdate'];
      self.dsInsureBuffer.DataSet.FieldValues['schedulecode'] := FieldValues
        ['schedulecode'];
      self.dsInsureBuffer.DataSet.FieldValues['islinework'] := FieldValues
        ['islinework'];
      self.dsInsureBuffer.DataSet.FieldValues['departstationname'] :=
        FieldValues['departstationname'];
      self.dsInsureBuffer.DataSet.FieldValues['reachstationname'] := FieldValues
        ['reachstationname'];
      self.dsInsureBuffer.DataSet.FieldValues['reachstationsecondname'] :=
        FieldValues['reachstationsecondname'];
      self.dsInsureBuffer.DataSet.FieldValues['departtime'] := FieldValues
        ['departtime'];
      self.dsInsureBuffer.DataSet.FieldValues['distance'] := FieldValues
        ['distance'];
      self.dsInsureBuffer.DataSet.FieldValues['ticketno'] := FieldValues
        ['ticketno'];
      self.dsInsureBuffer.DataSet.FieldValues['seatno'] := FieldValues
        ['seatno'];
      self.dsInsureBuffer.DataSet.FieldValues['seatnostr'] := FieldValues
        ['seatnostr'];
      self.dsInsureBuffer.DataSet.FieldValues['tickettype'] := FieldValues
        ['tickettype'];
      self.dsInsureBuffer.DataSet.FieldValues['carrychildnum'] := FieldValues
        ['carrychildnum'];
      self.dsInsureBuffer.DataSet.FieldValues['customerid'] := FieldValues
        ['customerid'];
      self.dsInsureBuffer.DataSet.FieldValues['certificateno'] := FieldValues
        ['certificateno'];
      self.dsInsureBuffer.DataSet.FieldValues['certificatetype'] := FieldValues
        ['certificatetype'];
      self.dsInsureBuffer.DataSet.FieldValues['customername'] := FieldValues
        ['customername'];
      self.dsInsureBuffer.DataSet.FieldValues['education'] := FieldValues
        ['education'];
      self.dsInsureBuffer.DataSet.FieldValues['tickettypeprintname'] := FieldValues
        ['tickettypeprintname'];
      self.dsInsureBuffer.DataSet.FieldValues['familyaddress'] := FieldValues
        ['familyaddress'];
      self.dsInsureBuffer.DataSet.FieldValues['familyphone'] := FieldValues
        ['familyphone'];
      self.dsInsureBuffer.DataSet.FieldValues['mobilephone'] := FieldValues
        ['mobilephone'];
      self.dsInsureBuffer.DataSet.FieldValues['customerremarks'] := FieldValues
        ['customerremarks'];
      self.dsInsureBuffer.DataSet.FieldValues['insureamount'] := FieldValues
        ['insureamount'];
      self.dsInsureBuffer.DataSet.FieldValues['insurersid'] := FieldValues
        ['insurersid'];
      self.dsInsureBuffer.DataSet.FieldValues['insuretypeid'] := FieldValues
        ['insuretypeid'];
      self.dsInsureBuffer.DataSet.FieldValues['isselfschedule'] := FieldValues
        ['isselfschedule'];
      self.dsInsureBuffer.DataSet.FieldValues['premium'] := FieldValues
        ['premium'];
      self.dsInsureBuffer.DataSet.FieldValues['ticketoutletsname'] :=
        FieldValues['ticketoutletsname'];
      self.dsInsureBuffer.DataSet.post;
      next;
    end;
  end;
  freeandnil(FrmCustomerAdd);
end;

function TFrmSellTicket.SaveOrSell(skip: boolean): boolean;
// var lastmoney:Currency;
var
  lbllastmoneyCaption, lblreceiptCaption, lblchangeCaption: string;
begin
 { if not isShoping then
  begin
     assert(getCDSSchedule.Active and (getCDSSchedule.RecordCount > 0),
    'ϵͳ�쳣��������ݼ�û�д򿪻��¼��Ϊ0��');
  end; }
  if  (gbticketbuffer.Visible and Assigned(dsTicketBuffer.DataSet)
      and dsTicketBuffer.DataSet.Active )then
  begin
      isShoping := true;
  end;
  if openSaleHintScreen then
     notifyMiniScreenSchedule;
  result := false;
  if (not skip) then
  begin
    if Assigned(seTicketNum_T) and (seTicketNum_T.Value > 0) then
    begin
      SysDialogs.Warning('������Ʊʱ�������浽���ﳵ');
      exit;
    end;
    if Assigned(seTicketNum_H) and (seTicketNum_H.Value > 0) then
    begin
      SysDialogs.Warning('�۰���Ʊʱ�������浽���ﳵ');
      exit;
    end;

    if dsSchedule.DataSet.FieldByName('worktype').AsString = '3' then
    begin
      SysDialogs.Warning('�ۿ�����Ͱ��ʱ�������浽���ﳵ');
      exit;
    end;
  end;

  if (SellWayEnd is Tfrmsellticketend) and ((SellWayEnd as Tfrmsellticketend)
      .nvcbbpayment.GetSelectCode = '2') then
  begin
    if curvipCard = nil then
    begin
      SysDialogs.ShowInfo('��ǰû��VIP��������ʹ��VIP�����֧����');
      exit;
    end;
    if StrToCurr((SellWayEnd as Tfrmsellwayend).lblreceivablenum.Caption)
      > curvipCard.money then
    begin
      SysDialogs.ShowInfo('��ǰVIP������֧����');
      exit;
    end;
  end
  else if not cbautoreceipt.checked then
  begin
    if skip and (not(SellTicket.sellway[1] in ['8'])) and
      (not SellWayEnd.checkreceipt(getTotalreceivablenum)) then
    begin
      SysDialogs.ShowInfo('�����տ��');
      exit;
    end;
  end;
  
  outputDebugString(PWideChar('----��ǰ���۵���λ���浽����-----begin-----'));
  if (getCurticketnum > 0) and (not savetobuffer) then
  begin
      exit;
  end;
  outputDebugString(PWideChar('----��ǰ���۵���λ���浽����-----end-----'));

  // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
  // 0������Ʊ��1��Ʊ��2���϶�Ʊ
  if chkSellNet.checked or skip or (SellTicket.sellway[1] in ['4', '8']) then
  // 4��Ʊ��8��Ʊ��֧��������Ʊ
  begin
    // lastmoney:=sellTicket.getTotalTicketBufferReceivablenum+sellTicket.getTotalInsureBufferReceivablenum; //+SellWayEnd.getSellWayreceivablenum
    result := SellWayEnd.execute(TjsonClientDataSet(dsTicketBuffer.DataSet));
    if result then
    begin
      if (SellTicket.sellway[1] <> '8') then // 8��Ʊ����Ҫ����
      begin
        SellTicket.totalPrice := StrToCurr((SellWayEnd as Tfrmsellticketend)
            .lblreceivablenum.Caption);
        if showlastmoney and (not(SellTicket.sellway[1] in ['7', '8'])) and
          (SellWayEnd is Tfrmsellticketend) then
        begin
          lbllastmoneyCaption := (SellWayEnd as Tfrmsellticketend)
            .lblreceivablenum.Caption;
          lblreceiptCaption := (SellWayEnd as Tfrmsellticketend)
            .nvedtreceipt.Text;
          lblchangeCaption := (SellWayEnd as Tfrmsellticketend)
            .lblchange.Caption;
            if   ((SellWayEnd as Tfrmsellticketend).nvcbbpayment.ItemIndex=0)
             and (StrToCurr(lblchangeCaption)<0) then
            begin
               SysDialogs.Warning('ʵ�տ��С��Ӧ�տ�!');
               // ��ջ��泵Ʊ
               if Assigned(dsTicketBuffer.DataSet) then
                  dsTicketBuffer.DataSet.Active := false;
               if Assigned(dsInsureBuffer.DataSet) then
                  dsInsureBuffer.DataSet.Active := false;
               Exit;
            end;
        end;
        result := sell;
        if result then
        begin
          chkSellNet.checked := false;
        end;
      end
      else
      begin
        clearCurlockedScheduleplanid;
        resetall;
      end;
    end;
    // ��������ʧ��ʱ��ɾ���ղŴ���Ļ���
    if not result then
    begin
      deletefrombuffer;
    end
    else if showlastmoney and (not(SellTicket.sellway[1] in ['7', '8'])) and
      (SellWayEnd is Tfrmsellticketend) then
    begin
      pnllastmoney.Visible := true;
      lbllastmoney.Caption := lbllastmoneyCaption;
      lblreceipt.Caption := lblreceiptCaption;
      lblchange.Caption := lblchangeCaption;
      pnllastmoney.Width := lbllastmoney.Width + lblreceipt.Width +
        lblchange.Width + lbl1.Width + lbl4.Width + lbl5.Width + 20;

    end;
  end
  else
  begin
    gbticketbuffer.Visible := true;
    gbticketbuffer.Top := self.Height;
    splbufferticket.Top := gbticketbuffer.Top - splbufferticket.Height;
    splbufferticket.Visible := true;
    result := true;
    clearCurlockedScheduleplanid;
    reset;
  end;
end;

function TFrmSellTicket.savetobuffer: boolean;
var
  i, j: Integer;
  sn: Integer;
  _carrychildnum: Integer;
  priceByTicketTypeCode:Currency;
begin
  result := false;
  assert(Assigned(dsSchedule.DataSet) and dsSchedule.DataSet.Active and
      (dsSchedule.DataSet.RecordCount > 0), 'ϵͳ�쳣��������ݼ�û�д򿪻��¼��Ϊ0��');
  with dsTicketBuffer.DataSet do
  begin
    if not Active then
    begin
      try
        Active := true;
      except
        on E: Exception do
        begin
          SysLog.WriteErr(E.Message);
        end;
      end;
    end;
    sn := 0;
    _carrychildnum := 0;
    for i := 0 to gbamount.ControlCount - 1 do
    begin
      if (gbamount.Controls[i] is TSpinEdit) and
        (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
      begin
       if (gbamount.Controls[i] as TSpinEdit).Value >0 then
       begin
        priceByTicketTypeCode:=getPriceByTicketTypeCode(rightstr(gbamount.Controls[i].Name, 1));
       end;
        for j := 1 to (gbamount.Controls[i] as TSpinEdit).Value do
        begin
          Append;
          FieldByName('scheduleplanid').AsLargeInt :=
            dsSchedule.DataSet.FieldByName('scheduleplanid').AsLargeInt;
          FieldByName('departdate').AsDateTime := dsSchedule.DataSet.FieldByName
            ('departdate').AsDateTime;
          FieldByName('startstationname').AsString :=
            dsSchedule.DataSet.FieldByName('startstationname').AsString;
          FieldByName('endstationname').AsString :=
            dsSchedule.DataSet.FieldByName('endstationname').AsString;
          FieldByName('scheduleid').AsLargeInt := dsSchedule.DataSet.FieldByName
            ('scheduleid').AsLargeInt;
          FieldByName('schedulecode').AsString := dsSchedule.DataSet.FieldByName
            ('schedulecode').AsString;
          FieldByName('schedulesynccode').AsString :=
            dsSchedule.DataSet.FieldByName('schedulesynccode').AsString;
          FieldByName('workways').AsString := dsSchedule.DataSet.FieldByName
            ('workways').AsString;
          FieldByName('isovertime').AsBoolean := dsSchedule.DataSet.FieldByName
            ('isovertime').AsBoolean;
          FieldByName('islinework').AsBoolean := dsSchedule.DataSet.FieldByName
            ('islinework').AsBoolean;
          FieldByName('scheduleremarks').AsString :=
            dsSchedule.DataSet.FieldByName('scheduleremarks').AsString;
          FieldByName('seattype').AsString := dsSchedule.DataSet.FieldByName
            ('seattype').AsString;
           FieldByName('vcleseattype').AsString := dsSchedule.DataSet.FieldByName
            ('vcleseattype').AsString;
          FieldByName('orgid').AsLargeInt := dsSchedule.DataSet.FieldByName
            ('orgid').AsLargeInt;
          FieldByName('departstationid').AsLargeInt :=
            dsSchedule.DataSet.FieldByName('departstationid').AsLargeInt;
          FieldByName('reachstationid').AsLargeInt :=
            dsSchedule.DataSet.FieldByName('reachstationid').AsLargeInt;
          FieldByName('departstationcode').AsString :=
            dsSchedule.DataSet.FieldByName('departstationcode').AsString;
          FieldByName('reachstationcode').AsString :=
            dsSchedule.DataSet.FieldByName('reachstationcode').AsString;
          FieldByName('departstationname').AsString :=
            dsSchedule.DataSet.FieldByName('departstationname').AsString;
          FieldByName('reachstationname').AsString :=
            dsSchedule.DataSet.FieldByName('reachstationname').AsString;
          FieldByName('reachstationsecondname').AsString :=
            dsSchedule.DataSet.FieldByName('reachstationsecondname').AsString;
          FieldByName('departtime').AsString := dsSchedule.DataSet.FieldByName
            ('departtime').AsString;
          FieldByName('distance').AsLargeInt := dsSchedule.DataSet.FieldByName
            ('distance').AsLargeInt;
          FieldByName('tickettype').AsString := rightstr
            (gbamount.Controls[i].Name, 1);
          FieldByName('fullprice').AsFloat := dsSchedule.DataSet.FieldByName
            ('fullprice').AsFloat;
//          FieldByName('discountrate').AsFloat := roundEx
//            (getPriceByTicketTypeCode(rightstr(gbamount.Controls[i].Name, 1))
//              / dsSchedule.DataSet.FieldByName('fullprice').AsCurrency, 3);
//          FieldByName('price').AsFloat := getPriceByTicketTypeCode
//            (rightstr(gbamount.Controls[i].Name, 1));
          FieldByName('discountrate').AsFloat := roundEx
            (priceByTicketTypeCode / dsSchedule.DataSet.FieldByName('fullprice').AsCurrency, 3);
          FieldByName('price').AsFloat := priceByTicketTypeCode;
          FieldByName('moreprice').AsFloat := dsSchedule.DataSet.FieldByName
            ('moreprice').AsFloat; ;
          FieldByName('toplimitprice').AsFloat := dsSchedule.DataSet.FieldByName
            ('toplimitprice').AsFloat;
          FieldByName('fueladditionfee').AsFloat :=
            dsSchedule.DataSet.FieldByName('fueladditionfee').AsFloat;
          FieldByName('stationservicefee').AsFloat :=
            dsSchedule.DataSet.FieldByName('stationservicefee').AsFloat;
          if Assigned(curlockedJxsEticketids) and
            (curlockedJxsEticketids.Count > 0) then
          begin
            FieldByName('routename').AsString := dsSchedule.DataSet.FieldByName
              ('remarks').AsString; // ����ʡ������Ʊ �洢��·���뵽��·�����ֶ�
            FieldByName('ticketno').AsString := curlockedJxsEticketids.Strings
              [sn]; // ����ʡ������Ʊ ��Ʊ���ֶ����洢����Ʊ��
          end
          else
          begin
            FieldByName('routename').AsString := dsSchedule.DataSet.FieldByName
              ('routename').AsString;
            FieldByName('ticketno').AsString := '';
          end;
          if dsSchedule.DataSet.FieldByName('islinework').AsBoolean then
          begin
            Inc(linescheduleseatno);
            FieldByName('seatno').AsInteger := linescheduleseatno; // 0
            FieldByName('seatnostr').AsString := inttostr(linescheduleseatno);
          end
          else
          begin
           if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0)
           and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then //ʡ����������λ��
           begin
            FieldByName('seatno').AsInteger := 0;
            FieldByName('seatnostr').AsString := '';
           end
           else
           begin
               FieldByName('seatno').AsInteger := SeatPlan.selectedSeats.Items[sn];
               FieldByName('seatnostr').AsString := SeatPlan.getSeatNoStr
              (SeatPlan.selectedSeats.Items[sn]);
           end;
          end;
          if cbtakekid.checked and (curNeedSellNum > _carrychildnum) then
          // seatPlan.selectSeatNum
          begin
            if ((sekid.Value - _carrychildnum) mod (curNeedSellNum - sn))
              <> 0 then
            begin
              FieldByName('carrychildnum').AsInteger :=
                ((sekid.Value - _carrychildnum) div (curNeedSellNum - sn)) + 1;
            end
            else
            begin
              FieldByName('carrychildnum').AsInteger :=
                ((sekid.Value - _carrychildnum) div (curNeedSellNum - sn));
            end;
            _carrychildnum := _carrychildnum + FieldByName('carrychildnum')
              .AsInteger;
          end
          else
          begin
            FieldByName('carrychildnum').AsInteger := 0;
          end;
          FieldByName('ticketentrance').AsString :=
            dsSchedule.DataSet.FieldByName('ticketentrance').AsString;
          FieldByName('ticketentrancename').AsString :=
            dsSchedule.DataSet.FieldByName('ticketentrancename').AsString;
          FieldByName('buspark').AsString := dsSchedule.DataSet.FieldByName
            ('buspark').AsString;
          if (SellWayEnd is Tfrmsellticketend) then
          begin
            FieldByName('paymethod').AsString :=
              (SellWayEnd as Tfrmsellticketend).nvcbbpayment.GetSelectValue;
            // inttostr(nvcbbpayment.ItemIndex)
          end
          else
          begin
            FieldByName('paymethod').AsString := '0';
          end;

          FieldByName('handticketoutletsid').Value := null;
          FieldByName('planvehicletype').AsString :=
            dsSchedule.DataSet.FieldByName('planvehicletype').AsString;
          FieldByName('planvehiclegrade').AsString :=
            dsSchedule.DataSet.FieldByName('planvehiclegrade').AsString;
          FieldByName('planvehicletypecustomname').AsString :=
            dsSchedule.DataSet.FieldByName('planvehicletypecustomname')
            .AsString;
          FieldByName('planunitname').AsString := dsSchedule.DataSet.FieldByName
            ('planunitname').AsString;
          FieldByName('planbrandmodel').AsString :=
            dsSchedule.DataSet.FieldByName('planbrandmodel').AsString;
          FieldByName('planvehicleno').AsString :=
            dsSchedule.DataSet.FieldByName('planvehicleno').AsString;
          FieldByName('customerid').Value := null;
          FieldByName('returntripvaliddays').AsInteger :=
            dsSchedule.DataSet.FieldByName('returntripvaliddays').AsInteger;
          FieldByName('isroundtrip').AsBoolean := dsSchedule.DataSet.FieldByName
            ('isroundtrip').AsBoolean;

          if Assigned(FrmCustomerAdd) and Assigned
            (FrmCustomerAdd.dsInsuranceBuffer.DataSet)
            and FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active then
          begin
            FrmCustomerAdd.dsInsuranceBuffer.DataSet.DisableControls;
            FrmCustomerAdd.dsInsuranceBuffer.DataSet.First;
            while not FrmCustomerAdd.dsInsuranceBuffer.DataSet.eof do
            begin
              if FieldByName('islinework')
                .AsBoolean and FrmCustomerAdd.dsInsuranceBuffer.DataSet.
                FieldByName('islinework').AsBoolean and
                (FrmCustomerAdd.dsInsuranceBuffer.DataSet.RecNo = sn + 1) then
              begin
                FrmCustomerAdd.dsInsuranceBuffer.DataSet.Edit;
                FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['seatno']
                  := FieldValues['seatno'];
                FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['seatnostr'] := FieldValues['seatnostr'];
              end;
              if (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['customerid'] <> null) and
                (FrmCustomerAdd.dsInsuranceBuffer.DataSet.
                  FieldValues['customerid'] > 0) and
                (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['scheduleplanid'] = FieldValues['scheduleplanid']) and
                (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['seatno'] = FieldValues['seatno']) then
              begin
                FieldByName('customerid').Value :=
                  FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['customerid'];
                FieldByName('certificatetype').Value :=
                  FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['certificatetype'];
                FieldByName('certificateno').Value :=
                  FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                  ['certificateno'];
                Break;
              end;
              FrmCustomerAdd.dsInsuranceBuffer.DataSet.next;
            end;
            FrmCustomerAdd.dsInsuranceBuffer.DataSet.EnableControls;
          end;
          // ���·���ѣ���Ʊ����� ����Ʊ����ѡ���ǩ����ѣ�
          FieldByName('servicefee').AsFloat := SellWayEnd.getServicefee
            (TjsonClientDataSet(dsTicketBuffer.DataSet));
          post;
          Inc(sn);
        end;
      end;
    end;
    result := true;
    // clearCurlockedScheduleplanid;
  end;
  if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then //�Ƿ��۱���
  begin
    result := saveInsuretobuffer;
  end;
end;

procedure TFrmSellTicket.ScheduleAfterClose(Sender: TDataSet);
begin
  refreshSeatPlan;
  setContextHint(self.ActiveControl);
end;

procedure TFrmSellTicket.ScheduleAfterOpen(Sender: TDataSet);
begin
  // if (Sender<>nil) and Sender.active and (Sender.RecordCount>0) then
  // begin
  // nvdbgrdhschedule.SetFocus;
  // end;
  setContextHint(self.ActiveControl);
  with Sender do
  begin // �Զ���λ����һ������Ʊ�İ����
    First;
    while (not eof) and (Sender.FieldByName('RESIDUESEATNUM').AsInteger <= 0) do
    begin
      next;
    end;
  end;
end;

procedure TFrmSellTicket.ScheduleAfterScroll(Sender: TDataSet);
begin
  // ������ǰ������λ
  if (curlockedguid_str <> '') and (curlockedScheduleplanid <> 0) then
  begin
    if Self.SellTicket.delmsgAndCheckkeyup() then exit;
    SellTicket.unlockSeat(StringToGUID(curlockedguid_str),
      curlockedScheduleplanid);
    clearCurlockedScheduleplanid;
    if not gbticketbuffer.Visible then
    begin
      curlockedguid_str := '';
      if Assigned(curlockedJxsEticketids) then
        curlockedJxsEticketids.Clear;
    end;
  end;
  if chkSellNet.checked and SellTicket.delayrefresh then
  begin
    gbseatplan.Height := defaultSeatPlanHeight;
    if Assigned(SeatPlanDecorato) then
      SeatPlanDecorato.Visible := false;
  end
  else
  begin
    if Self.SellTicket.delmsgAndCheckkeyup() then exit;
    refreshSeatPlan;
  end;
  if Self.SellTicket.delmsgAndCheckkeyup() then exit;
  refreshCanSaleTicketType;
  if Assigned(edDISCOUNT_PRICE) then
  begin
    edDISCOUNT_PRICE.Text := CurrToStr
      (SellTicket.GetTickettypePrice(dsSchedule.DataSet.FieldByName
          ('scheduleid').AsLargeInt,
        dsSchedule.DataSet.FieldByName('departdate').AsDateTime,
        rightstr(seTicketNum_Z.Name, 1),
        dsSchedule.DataSet.FieldByName('fullprice').AsCurrency));
  end;
  ticketnumChange(nil);
  notifyMiniScreenSchedule;
end;

procedure TFrmSellTicket.ScheduleBeforeClose(Sender: TDataSet);
begin
  if (self.ClassName = 'TFrmSellTicket') and (Sender.RecordCount > 0) then
  begin
    lastSelectTicketpriceid := Sender.FieldByName('id').AsLargeInt;
  end;
end;

procedure TFrmSellTicket.seatPlanSizeReSize;
begin
  if Assigned(SeatPlanDecorato) then
  begin
    SeatPlanDecorato.Left := max(0,
      (pnlseatplan.Width - SeatPlanDecorato.Width) div 2);
    SeatPlanDecorato.Top := max(0,
      (pnlseatplan.Height - SeatPlanDecorato.Height) div 2);
  end;
end;

procedure TFrmSellTicket.SeatSelectComplete(Sender: TObject);
begin
end;

function TFrmSellTicket.sell: boolean;
var
  _paymethod: String;
  tempguid: TGUID;
  orderno: String;
  vipcardwriteresult: Integer;
  _curvipCard: TVipCard;
  i: Integer;
begin
  result := false;
  try
    pnlreceipt.Enabled := false;
    result := collectdataToTicketBuffer;
    if not result then
      exit;
    result := false;
    // һ�����ﳵֻ֧��һ�ֹ�Ʊ��ʽ
    if (SellWayEnd is Tfrmsellticketend) then
    begin
      _paymethod := (SellWayEnd as Tfrmsellticketend)
        .nvcbbpayment.GetSelectCode;
      // inttostr(nvcbbpayment.ItemIndex)
    end
    else
    begin
      _paymethod := '0';
    end;
    with dsTicketBuffer.DataSet do
    begin
      //DisableControls;
      try
        First;
        while not eof do
        begin
          Edit;
          FieldByName('paymethod').AsString := _paymethod;
          next;
        end;
      finally
        //EnableControls;
      end;
    end;
    if trim(curlockedguid_str) = '' then
    begin
      CreateGUID(tempguid);
      orderno := GUIDToString(tempguid);
      orderno := copy(orderno, 2, length(orderno) - 2);
    end
    else
    begin
      orderno := copy(curlockedguid_str, 2, length(curlockedguid_str) - 2);
    end;
    for i := 0 to gbamount.ControlCount - 1 do
    begin
      if (gbamount.Controls[i] is TSpinEdit) then
      begin
        if (rightstr(gbamount.Controls[i].Name, 1) = 'D') and
          ((gbamount.Controls[i] as TSpinEdit).Value > 0) then
        begin
          discountpricenum := (gbamount.Controls[i] as TSpinEdit).Value;
        end;

      end;
    end;
    if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
    begin
       openApinet:=1;
    end
    else
    begin
      openApinet:=0;
    end;
    if curvipCard = nil then
      result := SellTicket.SellTicket(orderno, nil, discountpricenum,openApinet)
    else
    begin
      _curvipCard := curvipCard;
      result := SellTicket.SellTicket(orderno, _curvipCard, discountpricenum,openApinet);
    end;
    discountpricenum := 0;
    openApinet:=0;
    SellTicket.isBuTicket := false;
      if(dsTicketBuffer.DataSet.Active) then
        SysLog.WriteErr('1\dsTicketBuffer.DataSet.RecordCount='+inttostr(dsTicketBuffer.DataSet.RecordCount))
      else
        SysLog.WriteErr('1\dsTicketBuffer.DataSet.Active=false');
    if result then
    begin
      notifyMiniScreen(FINISH, sysinfo.LoginUserInfo.UserCode);
      // д��
      if (_curvipCard <> nil) then
      begin
        if _paymethod = '2' then // VIP�������֧��
        begin
          _curvipCard.decrementmoney
            (StrToCurr((SellWayEnd as Tfrmsellwayend).lblreceivablenum.Caption)
            ); // getTotalreceivablenum
          _curvipCard.incrementamount
            (StrToCurr((SellWayEnd as Tfrmsellwayend).lblreceivablenum.Caption)
            );
          vipcardwriteresult := _curvipCard.writeCard;
          while (vipcardwriteresult <> 0) do
          begin
            // ע�⣺��ʾ���û�û��ȷ��ǰ�����δ����ִֹͣ�С�
            // ����Ϣѭ���������Ҳ����cardfound�ᱻ�ٴ�ִ�С�����curvipCard�ᱻ�ı�
            // if SysDialogs.Ask('����','д��ʧ�ܣ�'+_curvipCard.getErrorInfo(vipcardwriteresult)+'����ź�VIP������ȷ������д����') then
            // begin
            // vipcardwriteresult:=_curvipCard.writeCard;
            // end
            // else
            // begin
            // TODO : ��¼�쳣��־
            // Break;
            // end;
            SysDialogs.Warning('д��ʧ�ܣ�' + _curvipCard.getErrorInfo
                (vipcardwriteresult) + '����ź�VIP������ȷ������д����');
            vipcardwriteresult := _curvipCard.writeCard;
          end;
        end;
      end;
      if(dsTicketBuffer.DataSet.Active) then
        SysLog.WriteErr('2\dsTicketBuffer.DataSet.RecordCount='+inttostr(dsTicketBuffer.DataSet.RecordCount))
      else
        SysLog.WriteErr('2\dsTicketBuffer.DataSet.Active=false');
      clearvipinfo;
      clearCurlockedScheduleplanid;
      curlockedguid_str := '';
      tmrunlockseat.Enabled := false;
      refreshBill;
      if(dsTicketBuffer.DataSet.Active) then
        SysLog.WriteErr('3\dsTicketBuffer.DataSet.RecordCount='+inttostr(dsTicketBuffer.DataSet.RecordCount))
      else
        SysLog.WriteErr('3\dsTicketBuffer.DataSet.Active=false');
      socketSellInsure(dsTicketBuffer.DataSet); // ����SOCKETָ����ر��ճ���
      try
        if getTotalInsurenum > 0 then
        begin
          setinsureTarget;
          if SellTicket.sellinsure() then
          begin
            refreshInsureBill;
          end;
        end;
      finally
        resetall;
      end;
    end;
  finally
    pnlreceipt.Enabled := true;
  end;
end;

procedure TFrmSellTicket.setActiveControlFrame(control: TWinControl);
var
  frameWidth: Integer;
begin
  shpbackround.Visible := (control <> nil) and (control.parent <> nil) and
    (control <> self);
  if shpbackround.Visible then
  begin
    frameWidth := 2;
    if (control.Align = alClient) and (control.parent is TCustomPanel) then
    begin
      control.Align := alNone;
    end;
    shpbackround.parent := control.parent;
    shpbackround.Width := control.Width + frameWidth * 2;
    shpbackround.Height := control.Height + frameWidth * 2;
    shpbackround.Left := control.Left - frameWidth;
    shpbackround.Top := control.Top - frameWidth;
  end;
end;

procedure TFrmSellTicket.setContextHint(winControl: TWinControl);
var
  nextcontrol: TWinControl;
begin
 { if winControl = nil then
  begin
    lblContextHint.Caption := '';
  end
  else if winControl = nvdbgrdhschedule then
  begin
    lblContextHint.Caption := '������Ŷ�λ';
  end
  else if winControl = dtpdepartdate then
  begin
    lblContextHint.Caption := '���������ڡ�����С����';
  end
  else if winControl = nvhelpdepartstation then
  begin
    lblContextHint.Caption := '�����ƴ�����������վ�����������ڡ�����С����';
  end
  else if winControl = nvhelpreachstation then
  begin
    lblContextHint.Caption := '�����ƴ�������ҵ�վ�����������ڡ�����С����';
  end
  else if winControl = sekid then
  begin
    lblContextHint.Caption := '����������������С����';
  end
  else if winControl = nvdbgrdhticketbuffer then
  begin
    lblContextHint.Caption := '������Ŷ�λ��Deleteɾ����ѡ��Ʊ';
  end
  else if (winControl = SeatPlanDecorato) or (winControl = SeatPlan) then // ��λͼ
  begin
    lblContextHint.Caption := '�ո�ѡ���ȡ��ѡ�񡢷�����ƶ�';
  end
  else if winControl.parent = gbamount then // ���������
  begin
    lblContextHint.Caption := '����������������С����';
    nextcontrol := FindNextControl(winControl, true, true, false);
    if (nextcontrol <> nil) and (nextcontrol.parent = gbamount) then
    begin
      lblContextHint.Caption := lblContextHint.Caption + '��+������һ�������';
    end;
  end
  else
  begin
    lblContextHint.Caption := SellWayEnd.getContextHint(winControl);
  end;
  appendAllContextHint;  }
end;

procedure TFrmSellTicket.setCurNeedSellNum(AValue: Word);
begin
  FcurNeedSellNum := AValue;
  if (dsSchedule.DataSet <> nil) and dsSchedule.DataSet.Active and
    (dsSchedule.DataSet.RecordCount > 0) and
    (not dsSchedule.DataSet.FieldByName('islinework').AsBoolean) and
    (not((nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and
    (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2))) and
    Assigned(SeatPlan) and SeatPlanDecorato.Visible then
    begin
    SeatPlan.selectSeatNum := FcurNeedSellNum;
    end;

end;

procedure TFrmSellTicket.setDepartDateColor;
begin
  if Trunc(dtpdepartdate.date) = Trunc(now) then
  begin
    dtpdepartdate.Font.Style := dtpdepartdate.Font.Style - [fsBold, fsItalic];
  end
  else if Trunc(dtpdepartdate.date) < Trunc(now) then
  begin
    dtpdepartdate.Font.Style := dtpdepartdate.Font.Style + [fsBold, fsItalic];
  end
  else
  begin
    dtpdepartdate.Font.Style := dtpdepartdate.Font.Style + [fsBold] -
      [fsItalic];
  end;
end;

procedure TFrmSellTicket.setInsuranceInfo(cdsInsuranceBuffer: TDataSet);
begin ;
end;

procedure TFrmSellTicket.setinsureTarget;
var
  haslineschedule: boolean;
begin
  haslineschedule := false;
  SysLog.WriteErr('setinsureTarget---------------');
  if(dsTicketBuffer.DataSet.Active) then
    SysLog.WriteErr('dsTicketBuffer.DataSet.RecordCount='+inttostr(dsTicketBuffer.DataSet.RecordCount))
  else
    SysLog.WriteErr('dsTicketBuffer.DataSet.Active=false');

  with dsTicketBuffer.DataSet do
  begin
    DisableControls;
    dsInsureBuffer.DataSet.DisableControls;
    dsTicketBuffer.DataSet.First;
    while not dsTicketBuffer.DataSet.eof do
    begin
      dsInsureBuffer.DataSet.First;
      while not dsInsureBuffer.DataSet.eof do
      begin
        if dsTicketBuffer.DataSet.FieldByName('islinework').AsBoolean then
        begin
          haslineschedule := true;
        end;
        dsInsureBuffer.DataSet.Edit;
        dsInsureBuffer.DataSet.FieldByName('isselfschedule').AsBoolean :=
          isselfschedule;
        if (SellWayEnd is Tfrmsellticketend) then
        begin
          dsInsureBuffer.DataSet.FieldByName('paymethod').AsString :=
            (SellWayEnd as Tfrmsellticketend).nvcbbpayment.GetSelectCode;
          // inttostr(nvcbbpayment.ItemIndex)
        end
        else
        begin
          dsInsureBuffer.DataSet.FieldByName('paymethod').AsString := '0';
        end;
        SysLog.WriteErr('1 seatno'+inttostr(dsInsureBuffer.DataSet.FieldValues['seatno'])+','+inttostr(FieldValues['seatno']));
        // ��ˮ����λ�Żᷢ���仯 ���жϷ���������
        if (dsInsureBuffer.DataSet.FieldValues['scheduleplanid'] = FieldValues
            ['scheduleplanid']) and
          (dsInsureBuffer.DataSet.FieldValues['seatno'] = FieldValues['seatno']
          ) then
        begin
          dsInsureBuffer.DataSet.FieldValues['sellid'] := FieldValues['id'];
          SysLog.WriteErr('isfind dsInsureBuffer.DataSet.FieldValues[sellid]='+inttostr(dsInsureBuffer.DataSet.FieldValues['sellid']));
          dsInsureBuffer.DataSet.FieldValues['ticketno'] := FieldValues
            ['ticketno'];
          dsInsureBuffer.DataSet.FieldValues['carrychildnum'] := FieldValues
            ['carrychildnum'];
          dsInsureBuffer.DataSet.post;
          Break;
        end;
        dsInsureBuffer.DataSet.next;
      end;
      dsTicketBuffer.DataSet.next;
    end;
    EnableControls;
    dsInsureBuffer.DataSet.EnableControls;
  end;
  if haslineschedule then
  begin
    // ��ˮ�ఴ˳����������ƱID
    with dsTicketBuffer.DataSet do
    begin
      DisableControls;
      dsInsureBuffer.DataSet.DisableControls;
      First;
      dsInsureBuffer.DataSet.First;
      while not eof do
      begin
        dsInsureBuffer.DataSet.Edit;
        dsInsureBuffer.DataSet.FieldByName('isselfschedule').AsBoolean :=
          isselfschedule;
        if (SellWayEnd is Tfrmsellticketend) then
        begin
          dsInsureBuffer.DataSet.FieldByName('paymethod').AsString :=
            (SellWayEnd as Tfrmsellticketend).nvcbbpayment.GetSelectCode;
          // inttostr(nvcbbpayment.ItemIndex)
        end
        else
        begin
          dsInsureBuffer.DataSet.FieldByName('paymethod').AsString := '0';
        end;
        dsInsureBuffer.DataSet.FieldValues['sellid'] := FieldValues['id'];
        SysLog.WriteErr('FieldValues[id]='+inttostr(FieldValues['id']));
        dsInsureBuffer.DataSet.FieldValues['ticketno'] := FieldValues
          ['ticketno'];
        dsInsureBuffer.DataSet.FieldValues['carrychildnum'] := FieldValues
          ['carrychildnum'];
        dsInsureBuffer.DataSet.post;
        dsInsureBuffer.DataSet.next;
        next;
      end;
      EnableControls;
      dsInsureBuffer.DataSet.EnableControls;
    end;
  end;
end;

procedure TFrmSellTicket.setSellTicket(const Value: TSellTicket);
begin
  FsellTicket := Value;
end;

procedure TFrmSellTicket.showInsureForm;
var
  i, j: Integer;
  insuretypeid:String;
  FcdsInsureTypeByDiatance:TjsonClientDataSet;
  FcdsInsureTypeByPrice:TjsonClientDataSet;
 // sellinsurebyprice:boolean;
  isfindtype:Boolean;
  ticketnums:Integer;
begin
  //�Ƿ����Ʊ���۱���
 { sellinsurebyprice:=getParametervalue('1060',SysInfo.LoginUserInfo.OrgID)='1';
  if sellinsurebyprice then
  begin
    FcdsInsureTypeByPrice:=TjsonClientDataSet.Create(self);
    with FcdsInsureTypeByPrice do
    begin
      QueryAddress:='base/qryinsuretypebyprice';
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='insuretypemap';
      Params.CreateParam(ftLargeint,'fullprice',ptInput);
      Params.CreateParam(ftLargeint,'halfprice',ptInput);
    end;
    with FcdsInsureTypeByPrice do
    begin
      active:=false;
      Params.ParamValues['fullprice']:=dsSchedule.DataSet.FieldByName
                ('fullprice').AsLargeInt;
      Params.ParamValues['halfprice']:=dsSchedule.DataSet.FieldByName
                ('halfprice').AsLargeInt;
      active:=true;
      insuretypeid:=FieldByName('insuretypeid').AsString;
    end;
  end
  else
  begin
      //������̵õ���������
     FcdsInsureTypeByDiatance:=TjsonClientDataSet.Create(self);
     with FcdsInsureTypeByDiatance do
     begin
       QueryAddress:='base/qryinsuretypebydistance';
       RemoteServer:=DMPublic.jcon;
       DataSourceName:='insuretypemap';
       Params.CreateParam(ftLargeint,'distance',ptInput);
     end;
     with FcdsInsureTypeByDiatance do
     begin
       active:=false;
       Params.ParamValues['distance']:=dsSchedule.DataSet.FieldByName
              ('distance').AsLargeInt;
       active:=true;
       insuretypeid:=FieldByName('insuretypeid').AsString;
     end;
  end; }
  if not dsSchedule.DataSet.Active then exit;
  if dsSchedule.DataSet.recordcount=0 then exit;

  ticketnums:=0;
    for i := 0 to gbamount.ControlCount - 1 do
    begin
      if (gbamount.Controls[i] is TSpinEdit) and
        (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
      begin
        for j := 1 to (gbamount.Controls[i] as TSpinEdit).Value do
        begin
          ticketnums:=ticketnums+(gbamount.Controls[i] as TSpinEdit).Value;
        end;
      end;
    end;
  if ticketnums=0 then exit;


  if Assigned(FrmCustomerAdd) then
    freeandnil(FrmCustomerAdd);
  FrmCustomerAdd := TFrmCustomerAdd.Create(self);
  with FrmCustomerAdd do
  begin
    try

      if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then //�۱���
      begin
         setDefaultCustomerOnSellinsure := self.setDefaultCustomerOnSellinsure;
         cdsinsuretype := SellTicket.cdsinsuretype;
      end;
      if (SellTicket.canrealnamesellticket) or (routeisrealnameticket) then//ʵ������Ʊ
      begin
         setDefaultCustomerOnRealsellticket := self.setDefaultCustomerOnRealsellticket;
      end;
      canrealticketsell := SellTicket.canrealnamesellticket;
      canrealticketsell_route:= routeisrealnameticket;
      defaultCustomerID := UFrmSellTicket.defaultCustomerID;
      edittype := TEditType.view;
      //SellTicket.getInsureType(insuretypeid);
      dsInsuranceBuffer.DataSet := SellTicket.createCdsInsureBuffer
        (FrmCustomerAdd);
      nvdbgrdhCustomer.Columns[5].ReadOnly:=True;
//      nvdbgrdhCustomer.Columns[7].ReadOnly:=True;
      with dsInsuranceBuffer.DataSet do // jsoncdsInsurance
      begin
        Active := true;

        for i := 0 to gbamount.ControlCount - 1 do
        begin
          if (gbamount.Controls[i] is TSpinEdit) and
            (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
          begin
            for j := 1 to (gbamount.Controls[i] as TSpinEdit).Value do
            begin
              isfindtype:=False;
              Append;
              FieldByName('tickettype').AsString := rightstr
                (gbamount.Controls[i].Name, 1);
              if not dsSchedule.DataSet.FieldByName('islinework').AsBoolean then
              begin
                FieldValues['seatno'] := SeatPlan.selectedSeats.Items
                  [dsInsuranceBuffer.DataSet.RecordCount];
                FieldValues['seatnostr'] := SeatPlan.getSeatNoStr
                  (SeatPlan.selectedSeats.Items
                    [dsInsuranceBuffer.DataSet.RecordCount]);
              end;
              FieldValues['certificatetype'] := '0';
              FieldValues['issell'] := false;
              if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then //�۱���
              begin
              FieldValues['issell'] := true;
              {
              if not SellTicket.canrealnamesellticket then //����ʵ������Ʊ,֤���ֶο��Ա༭
              begin
                nvdbgrdhCustomer.Columns[7].ReadOnly:=False;
              end;}
              nvdbgrdhCustomer.Columns[7].ReadOnly:=False;
              nvdbgrdhCustomer.Columns[5].ReadOnly:=False;
               //������
              if insuretypeabout='0' then
              begin
                  cdsinsuretype.First;
                  while not cdsinsuretype.Eof do
                  begin
                     if (dsSchedule.DataSet.FieldByName
                        ('distance').AsLargeInt>=cdsinsuretype.FieldValues['fromamount'])
                        and (dsSchedule.DataSet.FieldByName
                        ('distance').AsLargeInt<=cdsinsuretype.FieldValues['endamount']) then
                     begin
                          FieldValues['insuretypeid'] := cdsinsuretype.FieldValues['id'];
                          FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
                          FieldValues['insureamount'] := cdsinsuretype.FieldValues
                            ['MAXINSUREAMOUNT'];
                          FieldValues['insurersid'] := cdsinsuretype.FieldValues
                            ['insurersid'];
                          FieldValues['emoney'] :=  cdsinsuretype.FieldValues['emoney'];
                          FieldValues['emmoney'] :=  cdsinsuretype.FieldValues['emmoney'];
                            isfindtype:=True;
                          Break;
                     end;
                     cdsinsuretype.next;
                  end;
              end
              else
              begin
                if (rightstr(gbamount.Controls[i].Name, 1)='B') then
                begin
                  cdsinsuretype.First;
                  while not cdsinsuretype.Eof do
                  begin
                     if (dsSchedule.DataSet.FieldByName
                        ('halfprice').AsLargeInt>=cdsinsuretype.FieldValues['fromamount'])
                        and (dsSchedule.DataSet.FieldByName
                        ('halfprice').AsLargeInt<=cdsinsuretype.FieldValues['endamount']) then
                     begin
                          FieldValues['insuretypeid'] := cdsinsuretype.FieldValues['id'];
                          FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
                          FieldValues['insureamount'] := cdsinsuretype.FieldValues
                            ['MAXINSUREAMOUNT'];
                          FieldValues['insurersid'] := cdsinsuretype.FieldValues
                            ['insurersid'];
                          FieldValues['emoney'] :=  cdsinsuretype.FieldValues['emoney'];
                          FieldValues['emmoney'] :=  cdsinsuretype.FieldValues['emmoney'];
                            isfindtype:=True;
                          Break;
                     end;
                     cdsinsuretype.next;
                  end;
                end
                else if (rightstr(gbamount.Controls[i].Name, 1)='S') then
                begin
                  cdsinsuretype.First;
                  while not cdsinsuretype.Eof do
                  begin
                     if (dsSchedule.DataSet.FieldByName
                        ('studentprice').AsLargeInt>=cdsinsuretype.FieldValues['fromamount'])
                        and (dsSchedule.DataSet.FieldByName
                        ('studentprice').AsLargeInt<=cdsinsuretype.FieldValues['endamount']) then
                     begin
                          FieldValues['insuretypeid'] := cdsinsuretype.FieldValues['id'];
                          FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
                          FieldValues['insureamount'] := cdsinsuretype.FieldValues
                            ['MAXINSUREAMOUNT'];
                          FieldValues['insurersid'] := cdsinsuretype.FieldValues
                            ['insurersid'];
                          FieldValues['emoney'] :=  cdsinsuretype.FieldValues['emoney'];
                          FieldValues['emmoney'] :=  cdsinsuretype.FieldValues['emmoney'];
                            isfindtype:=true;
                          Break;
                     end;
                     cdsinsuretype.next;
                  end;


                end
                else
                begin
                  cdsinsuretype.First;
                  while not cdsinsuretype.Eof do
                  begin
                     if (dsSchedule.DataSet.FieldByName
                        ('fullprice').AsLargeInt>=cdsinsuretype.FieldValues['fromamount'])
                        and (dsSchedule.DataSet.FieldByName
                        ('fullprice').AsLargeInt<=cdsinsuretype.FieldValues['endamount']) then
                     begin
                          FieldValues['insuretypeid'] := cdsinsuretype.FieldValues['id'];
                          FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
                          FieldValues['insureamount'] := cdsinsuretype.FieldValues
                            ['MAXINSUREAMOUNT'];
                          FieldValues['insurersid'] := cdsinsuretype.FieldValues
                            ['insurersid'];
                          FieldValues['emoney'] :=  cdsinsuretype.FieldValues['emoney'];
                          FieldValues['emmoney'] :=  cdsinsuretype.FieldValues['emmoney'];
                            isfindtype:=true;
                          Break;
                     end;
                     cdsinsuretype.next;
                  end;
                end;
              end;
              if not isfindtype then
              begin
                  FieldValues['insuretypeid'] := cdsinsuretype.FieldValues['id'];
                  FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
                  FieldValues['insureamount'] := cdsinsuretype.FieldValues
                    ['MAXINSUREAMOUNT'];
                  FieldValues['insurersid'] := cdsinsuretype.FieldValues
                    ['insurersid'];
                  FieldValues['emoney'] :=  cdsinsuretype.FieldValues['emoney'];
                  FieldValues['emmoney'] :=  cdsinsuretype.FieldValues['emmoney'];
              end;

              end;


              FieldValues['isselfschedule'] := false;
              FieldValues['ticketoutletsname'] :=
                sysinfo.LoginUserInfo.ticketoutletsname;

              FieldValues['scheduleplanid'] := dsSchedule.DataSet.FieldValues
                ['scheduleplanid'];
              FieldValues['departdate'] := dsSchedule.DataSet.FieldValues
                ['departdate'];
              FieldValues['schedulecode'] := dsSchedule.DataSet.FieldValues
                ['schedulecode'];
              FieldValues['islinework'] := dsSchedule.DataSet.FieldValues
                ['islinework'];
              FieldValues['departstationname'] := dsSchedule.DataSet.FieldValues
                ['departstationname'];
              FieldValues['reachstationname'] := dsSchedule.DataSet.FieldValues
                ['reachstationname'];
              FieldValues['reachstationsecondname'] :=
                dsSchedule.DataSet.FieldValues['reachstationsecondname'];
              FieldValues['departtime'] := dsSchedule.DataSet.FieldValues
                ['departtime'];
              FieldValues['distance'] := dsSchedule.DataSet.FieldValues
                ['distance'];
              post;
            end;
          end;
        end;
        setInsuranceInfo(dsInsuranceBuffer.DataSet);
        First;
      end;

      // �۱���ȡ1043������ʵ������Ʊȡ9494�����������Ƿ񵯳��˿���Ϣ¼���

      if ((SellTicket.cansellinsure) and (cbautosellinsure.checked) and needCustomerOnSellinsure)
        or ((SellTicket.canrealnamesellticket) and needCustomerOnRealSellticket)or (needCustomerOnRealSellticket and routeisrealnameticket) then
      begin
        if SysMainForm.showFormModal(FrmCustomerAdd, false) = mrOk then
        begin ;
        end
        else
        begin
          if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then
          begin
          with dsInsuranceBuffer.DataSet do
          begin
            First;
            while not eof do
            begin
              Edit;
              FieldValues['issell'] := false;
              post;
              next;
            end;
          end;
          end;
        end;
      end
      else
      begin
        with dsInsuranceBuffer.DataSet do
        begin
          First;
          while not eof do
          begin
            Edit;
            FieldValues['customerid'] := defaultCustomerID;
            post;
            next;
          end;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr(E.Message);
      end;
      // freeandnil(FrmCustomerAdd);
    end;
  end;
end;

function TFrmSellTicket.showReceiptBox: boolean;
var
  tmpseatno: Word;
  lockseats_S, old_lockseats_S: string;
  tmpstrlst: TStringList;
  i, j: Integer;
begin
  result := false;
  if checkCanGoToReceive then // ���Ҫ�۵�ǰ��Ʊ
  begin
    // ��λ
    outputDebugString(PWideChar('---showReceiptBox-----����λ----begin------'));
    lockseats_S := lockseat;
    outputDebugString(PWideChar('---showReceiptBox-----����λ----end--------'));
    if lockseats_S = '' then
      exit;
    routeisrealnameticket := false;
     if (not chkSellNet.Checked) and (SellTicket.canrealnamesellticket_route) then
     begin
       with  jcdsisrealnameticket  do
       begin
         active := false;
         Params.ParamValues['schedule.id']:=dsSchedule.DataSet.FieldByName('scheduleid').AsString;
         Execute;
         if Params.ParamValues['flag']=1 then
         begin
          if (Params.ParamValues['msg']= '1')then
             begin
               routeisrealnameticket:=true;
             end;
         end;
       end;
//           /or (routeisrealnameticket)
     end;


    pnlseatnos.Visible := true;
    lblseatnos.Caption := '';
    if dsSchedule.DataSet.FieldByName('islinework').AsBoolean then
    begin
      // ��ˮ�಻��ʾ��λ��
//      lblseatnos.Width:=438;
//      lblseatnos.Height:=49;
      lblseatnos.Caption := '��ˮ��û����λ��';
//      lblseatnos.Width := lblseatnos.Width+36;
    end
    else
    begin
      if Assigned(SeatPlan) and SeatPlan.Visible and SeatPlan.CanFocus then
      begin
        old_lockseats_S := '';
        for i := 0 to SeatPlan.getSelectedSeats.Count - 1 do
        begin
          if old_lockseats_S = '' then
            old_lockseats_S := inttostr(SeatPlan.getSelectedSeats.Items[i])
          else
            old_lockseats_S := old_lockseats_S + ',' + inttostr
              (SeatPlan.getSelectedSeats.Items[i])
        end;
        if old_lockseats_S <> lockseats_S then
        begin
          SeatPlan.getSelectedSeats.Clear;
          tmpstrlst := TStringList.Create;
          tmpstrlst.CommaText := lockseats_S;
          for i := 0 to tmpstrlst.Count - 1 do
            SeatPlan.getSelectedSeats.Add(StrToInt(tmpstrlst.Strings[i]));
        end;
      end;
      lblseatnos.Caption := StringReplace(lockseats_S, ',', '��',
        [rfReplaceAll, rfIgnoreCase]);
    end;
  end
  else
  begin
    // ֻ�ۻ�����еĳ�Ʊ
    pnlseatnos.Visible := false;
  end;

  // �Ƿ��۱��ջ�ʵ������Ʊ
  if (not chkSellNet.checked)
    and ((SellTicket.cansellinsure and cbautosellinsure.checked) or (SellTicket.canrealnamesellticket)or (routeisrealnameticket)) and
    (SellTicket.sellway <> '8') then
  begin
    showInsureForm;
  end;

  SellWayEnd.curTicketNum := getCurticketnum;
  SellWayEnd.cdsSchedule := getCDSSchedule;
  SellWayEnd.totalTicketReceivablenum := getTotalTicketreceivablenum;
  SellWayEnd.totalTicketNum := getTotalticketnum;

  SellWayEnd.totalInsureReceivableNum := getTotalInsurereceivablenum;
  SellWayEnd.totalInsureNum := getTotalInsurenum;


  isVisibleEdit := 0;
  for j := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[j] is TSpinEdit) then
    begin
      if ((rightstr(gbamount.Controls[j].Name, 1) = 'H') or (rightstr(gbamount.Controls[j].Name, 1) = 'T')) and
        ((gbamount.Controls[j] as TSpinEdit).Value > 0)
        and (not (SellWayEnd is Tfrmbookticketend))  then
      begin
        isVisibleEdit := 1;
        break;
      end;
    end;
  end;
  SellWayEnd.isShowEdit := isVisibleEdit;
  isVisibleEdit := 0;
  SellWayEnd.show;
  if nvdbgrdhticketbuffer.Visible and checkCanGoToReceive then
    receiptSchedule.setSchedule(getCDSSchedule,dsTicketBuffer.DataSet,gbamount,sellTicket.sellway[1])
  else if nvdbgrdhticketbuffer.Visible then
    receiptSchedule.setSchedule(nil,dsTicketBuffer.DataSet,gbamount,sellTicket.sellway[1])
  else if checkCanGoToReceive then
    receiptSchedule.setSchedule(getCDSSchedule,nil,gbamount,sellTicket.sellway[1]);
  pnlreceiptReSize();
  pnlreceipt.Visible := true;
  if cansellJJinsure and Assigned(pnlJJIdCardinfos)
    and TIDCardReader.idcardreader_ready then
  begin
    pnlJJIdCardinfos.num := getTotalticketnum;
    if cbsellinsure.checked then
      pnlJJIdCardinfos.Visible := true;
  end;
  pnlreceipt.BringToFront;
  lblvipamount.Caption := CurrToStr(self.getTotalreceivablenum);
  result := true;
end;

procedure TFrmSellTicket.socketSellInsure(ticketBuffer: TDataSet);
var
  bm: TBookmark;
  tmpstring: string;
  invokeresult: string;

  seatnoinput: string;

  departstationname: string;
  reachstationname: string;
  seatnostr: string;
  i: Integer;
  _idcard: TIDCard;
begin
  if not cansellJJinsure then
    exit;
  if ticketBuffer <> nil then
  begin
    // ���浱ǰ��Ʊ�ɹ�Ҫ���͵�ָ��Ա��ط�
    if lastJJInsure = nil then
    begin
      lastJJInsure := TDictionary<String, boolean>.Create;
    end
    else
    begin
      lastJJInsure.Clear;
    end;
    with ticketBuffer do
    begin
      bm := GetBookmark;
      try
        First;
        i := 0;
        while not eof do
        begin
          _idcard := nil;
          // SysDialogs.ShowMessage(IntToStr(pnlJJIdCardinfos.num));
          if Assigned(pnlJJIdCardinfos) then
            _idcard := pnlJJIdCardinfos.Items[i].idcard;
          if _idcard = nil then
            // ��֤��+��Ʊ���+����ʱ��+����+��λ+�г���Ϣ+��Ʒ����+Ͷ��������+����������+������֤������
            lastJJInsure.Add('|' + FieldByName('ticketno').AsString // ��Ʊ��
                + '|' + formatdatetime('yyyy-mm-dd',
                FieldByName('departdate').AsDateTime) + ' ' + FieldByName
                ('departtime').AsString // �������ڼ�ʱ��
                + '|' + FieldByName('schedulecode').AsString + '|' + FieldByName
                ('seatno').AsString + '|' + FieldByName('departstationname')
                .AsString + '-' + FieldByName('reachstationname')
                .AsString + '|' + FrmTmpInsuranceNo.getInsureTypeCodeByDistance
                (FieldByName('distance').AsLargeInt) + '|' // Ͷ��������
                + '|' // ����������
                + '|' // ������֤������
                + '|' // ������
                , false)
          else
            lastJJInsure.Add('|' + FieldByName('ticketno').AsString // ��Ʊ��
                + '|' + formatdatetime('yyyy-mm-dd',
                FieldByName('departdate').AsDateTime) + ' ' + FieldByName
                ('departtime').AsString // �������ڼ�ʱ��
                + '|' + FieldByName('schedulecode').AsString + '|' + FieldByName
                ('seatno').AsString + '|' + FieldByName('departstationname')
                .AsString + '-' + FieldByName('reachstationname')
                .AsString + '|' + FrmTmpInsuranceNo.getInsureTypeCodeByDistance
                (FieldByName('distance').AsLargeInt) + '|' + _idcard.Name
              // Ͷ��������
                + '|' + _idcard.Name // ����������
                + '|' + _idcard.Id // ������֤������
                + '|' // ������
                , false);
          next;
          Inc(i);
        end;
      finally
        GotoBookmark(bm);
      end;
    end;
  end;
  if cbsellinsure.checked then
  begin
    btnprintinsureClick(nil);
  end
  else
  begin
    btnprintinsure.Visible := true;
  end;
end;

procedure TFrmSellTicket.refreshSeatPlan;
var
  i: Integer;
begin
  if (dsSchedule.DataSet = nil) or (not dsSchedule.DataSet.Active) or
    (dsSchedule.DataSet.RecordCount = 0) or
    (dsSchedule.DataSet.FieldByName('ISLINEWORK').AsBoolean) then
  begin
    if gbticketbuffer.Visible then
      gbseatplan.Height := defaultSeatPlanHeight_buffer
    else
      gbseatplan.Height := defaultSeatPlanHeight;
    if Assigned(SeatPlanDecorato) then
      SeatPlanDecorato.Visible := false;
    exit;
  end;
  if (nvhelpdepartstation.HelpOptions.HelpType = 'NetStartStationHelp') and (nvhelpdepartstation.Id>0) and (nvhelpdepartstation.HelpFieldValue['isnet']=2) then
  begin
     if gbticketbuffer.Visible then
      gbseatplan.Height := defaultSeatPlanHeight_buffer
    else
      gbseatplan.Height := defaultSeatPlanHeight;
    if Assigned(SeatPlanDecorato) then
      SeatPlanDecorato.Visible := false;
    exit;
  end;
  if not Assigned(SeatPlanDecorato) then
  begin
    SeatPlan := TSeatPlanSelect.Create(gbseatplan);
    with SeatPlan do
    begin
      ShowHint := true;
      allowSelectByHand := self.allowSelectByHand;
      OnSelectComplete := SeatSelectComplete;
      if not Assigned(selectSeatStatus) then
        selectSeatStatus := TList<string>.Create;
      selectSeatStatus.Clear;
      // 0��Ʊ��1��Ʊ��2��Ȩ��Ʊ��3����Ʊ��4��Ʊ��5�ֹ�Ʊ��6��Ʊ���ۡ�7������Ʊ��8��Ʊ
      case SellTicket.sellway[1] of
        '6':
          begin
            selectSeatStatus.Add('4');
            selectSeatStatus.Add('5');
          end;
        '2', '5':
          begin
            selectSeatStatus.Add('0');
            selectSeatStatus.Add('4');
            selectSeatStatus.Add('5');
            if not privilegepatchticketcansellseatreserve then
            begin
              selectSeatStatus.Remove('4');
              selectSeatStatus.Remove('5');
            end;
          end;
      else
        selectSeatStatus.Add('0');
      end;
    end;
    //
    SeatPlanDecorato := TVehicleSeatPlanDecorator.Create(scrlbxSeatPlan,
      SeatPlan);
    SeatPlanDecorato.setParent(scrlbxSeatPlan); // gbseatplan
    SeatPlanDecorato.showspacename := false;
  end;
  SeatPlanDecorato.Visible := true;
  with SeatPlan do // seatPlan
  begin
    selectSeatNum := 0;
    seatsStatus := SellTicket.ScheduleSeatStatus;
    SeatsTickettype := SellTicket.ScheduleSeatTickettype;
    seatstype := SellTicket.ScheduleSeattype;
    selectSeattype := dsSchedule.DataSet.FieldByName('seattype').AsString;
    if isshowhint then
       seatshint := SellTicket.seatshint;

    if Assigned(selectedSeats) then
      selectedSeats.Clear;
  end;
  if dsSchedule.DataSet.FieldByName('planbrandmodelid').IsNull then
    SeatPlanDecorato.brandModelid := 0
  else
    SeatPlanDecorato.brandModelid := dsSchedule.DataSet.FieldByName
      ('planbrandmodelid').AsLargeInt;
  // SeatPlanDecorato.Repaint;
  // gbseatplan.Height:=seatPlanDecorato.actualheight;
  SeatPlan.Repaint;
  if ispassseat then
  begin
    if defaultThroughControl.IndexOf(seatplan)=-1 then
       defaultThroughControl.Insert(3,seatplan);
  end;
 // defaultThroughControl.Add(seatplan);
  seatPlanSizeReSize;
end;

procedure TFrmSellTicket.StationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Sender = nvhelpreachstation) and (not chkSellNet.checked) and
    (nvhelpreachstation.ignoreSearchFlag <> '') and
    (pos(nvhelpreachstation.ignoreSearchFlag, nvhelpreachstation.Text) = 1)
    then
  begin
    nvhelpSchedule.Perform(WM_KEYDOWN, Key, 0);
  end;
  if (Sender = nvhelpdepartstation) and (chkSellNet.checked) and
    (nvhelpdepartstation.ignoreSearchFlag <> '') and
    (pos(nvhelpdepartstation.ignoreSearchFlag, nvhelpdepartstation.Text) = 1)
    then
  begin
    nvhlpdepartdistrict.Perform(WM_KEYDOWN, Key, 0);
  end;
  if (Key = VK_UP) and (not nvhelpreachstation.isactive) and
    (not nvhelpSchedule.isactive) and
    (not nvhelpdepartstation.isactive) and (not nvhlpdepartdistrict.isactive)
    and ((dtpdepartdate.MaxDate = 0.0) or (Trunc(dtpdepartdate.date)
        + 1 <= dtpdepartdate.MaxDate)) then
  begin
    dtpdepartdate.DateTime := IncDay(Trunc(dtpdepartdate.date));
    gb3.Caption := DateCn.CnMonthOfDate(dtpdepartdate.DateTime) + '  ' + DateCn.CnDayOfDate(dtpdepartdate.DateTime);
    setDepartDateColor;
    findSchedule;
  end
  else if (Key = VK_DOWN) and (not nvhelpreachstation.isactive) and
    (not nvhelpSchedule.isactive) and (not nvhelpdepartstation.isactive) and
    (not nvhlpdepartdistrict.isactive) and
    ((dtpdepartdate.MinDate = 0.0) or (Trunc(dtpdepartdate.date)
        - 1 >= dtpdepartdate.MinDate)) then
  begin
    dtpdepartdate.DateTime := IncDay(Trunc(dtpdepartdate.date), -1);
    gb3.Caption := DateCn.CnMonthOfDate(dtpdepartdate.DateTime) + '  ' + DateCn.CnDayOfDate(dtpdepartdate.DateTime);
    setDepartDateColor;
    findSchedule;
  end;
end;

procedure TFrmSellTicket.ticketnumChange(Sender: TObject);
var
  num: Word;
  i: Integer;
  tuantipiaonum: Integer; // ����Ʊ����
  baochepiaonum: Integer; // ����Ʊ����
begin
  if (not Assigned(dsSchedule.DataSet)) or (not dsSchedule.DataSet.Active) or
    (dsSchedule.DataSet.RecordCount <= 0) then
    exit;
  if (Sender is TSpinEdit) and (trim((Sender as TSpinEdit).Text) = '') then
    exit;
  num := 0;
  tuantipiaonum := 0;
  baochepiaonum := 0;
  sekid.MaxValue := 0;
  for i := 0 to gbamount.ControlCount - 1 do
  begin
    if (gbamount.Controls[i] is TSpinEdit) then
    begin
      if (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
      begin
        num := num + (gbamount.Controls[i] as TSpinEdit).Value;
        if rightstr(gbamount.Controls[i].Name, 1) = 'T' then
        begin
          tuantipiaonum := (gbamount.Controls[i] as TSpinEdit).Value;
        end;
        if rightstr(gbamount.Controls[i].Name, 1) = 'H' then
        begin
          baochepiaonum := (gbamount.Controls[i] as TSpinEdit).Value;
        end;
      end;
      if isTakeChildOnlyFull and (rightstr(gbamount.Controls[i].Name, 1) = 'Q')
        then
      begin
        // ��Ʊ��λ���仯ʱ�޸�sekid.MaxValue
        if (trim((gbamount.Controls[i] as TSpinEdit).Text) <> '') then
          sekid.MaxValue := (gbamount.Controls[i] as TSpinEdit).Value
        else
          sekid.MaxValue := 0;
      end;
    end;
  end;
  if (tuantipiaonum > 0) and (tuantipiaonum <> num) then
  begin
    // ������Ʊʱ������������Ʊ��
    SysDialogs.Warning('������Ʊʱ������������Ʊ��'); (Sender as TSpinEdit)
    .Value := 0;
    exit;
  end;
  if (baochepiaonum > 0) and (baochepiaonum <> num) then
  begin
    // �۰���Ʊʱ������������Ʊ��
    SysDialogs.Warning('�۰���Ʊʱ������������Ʊ��'); (Sender as TSpinEdit)
    .Value := 0;
    exit;
  end;
  curNeedSellNum := num;
  // ��Ʊ��λ���仯ʱ�޸�sekid.MaxValue
  if not isTakeChildOnlyFull then
  begin
    sekid.MaxValue := num;
  end;
  if sekid.Value > sekid.MaxValue then
  begin
    sekid.Value := sekid.MaxValue;
  end;

  if sekid.MaxValue = 0 then
  begin
    sekid.Value := 0;

  end
  else
  begin
    // sekid.Value:=sekid.MaxValue;
    // if Sender=nil then
    // begin
    // sekid.Value:=1;
    // end;
  end;
  cbtakekid.Enabled := sekid.MaxValue <> 0;
  if cbtakekid.checked and (sekid.MaxValue = 0) then
    cbtakekid.checked := false;
  if cbtakekid.checked and (sekid.Value = 0) then
    sekid.Value := 1;
  sekid.Enabled := (sekid.MaxValue <> 0) and cbtakekid.checked;
  lblvipamount.Caption := CurrToStr(self.getTotalreceivablenum);
  notifyMiniScreenSchedule;
end;

procedure TFrmSellTicket.tmrleaveinsurenumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveinsurenum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmSellTicket.tmrleaveticketnumTimer(Sender: TObject);
begin
  inherited;
  Randomize;
  lblleaveticketnum.Font.Color := RGB(Random(256), Random(256), Random(256));
end;

procedure TFrmSellTicket.tmrRefreshBillTimer(Sender: TObject);
begin
  inherited;
  refreshBill(true);
  refreshInsureBill(true);
end;

procedure TFrmSellTicket.tmrunlockseatTimer(Sender: TObject);
begin
  inherited;
  tmrunlockseat.Enabled := false;
  chkSellNet.checked := false;
  resetall;
end;

procedure TFrmSellTicket.vipcardfound(vipCard: TVipCard);
begin
  curvipCard := vipCard;
  pnlvip.Visible := true;
  lblvipcardno.Caption := vipCard.cardNo;
  lblvipcardtype.Caption := getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption := CurrToStr(vipCard.money);
  lblvipnewmoney.Caption := '0';
  lblviplastamount.Caption := CurrToStr(vipCard.amount);
  lblvipamount.Caption := CurrToStr(self.getTotalreceivablenum);
  lblvipnewamount.Caption := '0';
  // ��ѯ���ݿ�
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno'] := vipCard.cardNo;
    Open;
    if RecordCount = 0 then
    begin
      SysDialogs.Warning('�򲻵�����Ϊ' + vipCard.cardNo + '����Ϣ�������Ǹÿ���״̬�쳣��');
      clearvipinfo;
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
      if (SellWayEnd is Tfrmsellticketend) then
      begin
        if (StrToCurr((SellWayEnd as Tfrmsellticketend)
              .lblreceivablenum.Caption) <= curvipCard.money) then
        begin (SellWayEnd as Tfrmsellticketend)
          .nvcbbpayment.ItemIndex := 2; // ��Ʊ
        end
        else
        begin (SellWayEnd as Tfrmsellticketend)
          .nvcbbpayment.ItemIndex := 0;
        end;
      end;
    end;
  end;
end;

procedure TcpClientError(Sender: TObject; SocketError: Integer);
begin
  tcpclient.Close;
end;

procedure notifyMiniScreen(msg: TMiniScreenMSG; info: String);
begin
  if not openSaleHintScreen then
    exit;
  if FindWindow(nil, 'MyForm') = 0 then
    exit;
  if tcpclient = nil then
  begin
    tcpclient := TTcpClient.Create(Application);
    tcpclient.RemoteHost := '127.0.0.1';
    tcpclient.RemotePort := '7687';
    @tcpclient.OnError := @TcpClientError;
  end;

  if not tcpclient.Connected then
  begin
    if not tcpclient.Connect then
    begin
      exit;
    end;
  end;
  tcpclient.Sendln(inttostr(ord(msg)) + ';' + info);
end;

end.
