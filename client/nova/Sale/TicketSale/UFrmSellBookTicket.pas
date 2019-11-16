unit UFrmSellBookTicket;

{ TODO :
  订票不支持订联网票
  订票销售不支持售联网票
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmSellTicket, DBGridEhGrouping, Menus, ExtCtrls, DB, ComCtrls,
  Spin, StdCtrls, NovaEdit, NovaHelp, GridsEh, DBGridEh, NvDbgridEh, DBClient,
  jsonClientDataSet, UDMPublic, DBCtrls, Mask, NovaComboBox, SellTicket,
  DateUtils,
  Buttons;

type
  TFrmSellBookTicket = class(TFrmSellTicket)
    grpcustomer: TGroupBox;
    nvedtCERTIFICATENO: TNovaEdit;
    nvcbbCERTIFICATETYPE: TNovaComboBox;
    jsoncdsquerycustomer: TjsonClientDataSet;
    nvdbgrdhseatreserve: TNvDbgridEh;
    jcdsSeatreserve: TjsonClientDataSet;
    jcdsSeatreserveid: TLargeintField;
    jcdsSeatreserveorgname: TWideStringField;
    jcdsSeatreserveticketoutletname: TWideStringField;
    jcdsSeatreserveroutename: TWideStringField;
    jcdsSeatreserveschedulecode: TWideStringField;
    jcdsSeatreservereachstationname: TWideStringField;
    jcdsSeatreservedeparttime: TWideStringField;
    jcdsSeatreservesellstate: TWideStringField;
    jcdsSeatreservefullprice: TCurrencyField;
    jcdsSeatreserveserviceprice: TCurrencyField;
    jcdsSeatreservereservename: TWideStringField;
    jcdsSeatreservecustomername: TWideStringField;
    jcdsSeatreservecertificatetype: TWideStringField;
    jcdsSeatreservecertificateno: TWideStringField;
    jcdsSeatreservefamilyphone: TWideStringField;
    jcdsSeatreservemobilephone: TWideStringField;
    jcdsSeatreservecustomerid: TLargeintField;
    jcdsSeatreservescheduleplanid: TLargeintField;
    jcdsSeatreservesellstatename: TWideStringField;
    jcdsSeatreservecertiticatetypename: TWideStringField;
    jcdsSeatreservedepartdate: TDateTimeField;
    jcdsSeatreserveautocanceltime: TDateTimeField;
    jcdsSeatreservecanceltime: TDateTimeField;
    jcdsSeatreservecreatetime: TDateTimeField;
    jcdsSeatreserveupdatetime: TDateTimeField;
    jcdsSeatreservereservetime: TDateTimeField;
    jcdsSeatreserveisautocancel: TBooleanField;
    dsSeatreserve: TDataSource;
    jcdsResultstatus: TjsonClientDataSet;
    jcdsResultcustomtype: TjsonClientDataSet;
    jcdsSeatreserveisselect: TBooleanField;
    jcdsSeatreserveistakekid: TBooleanField;
    jcdsSeatreservecarrychildnum: TIntegerField;
    jcdsSeatreserveticketentrance: TWideStringField;
    jcdsSeatreservebuspark: TWideStringField;
    jcdsSeatreserveplanvehicletype: TWideStringField;
    jcdsSeatreserveplanvehiclegrade: TWideStringField;
    jcdsSeatreserveplanvehicletypecustomname: TWideStringField;
    jcdsSeatreserveplanvheicletypeid: TLargeintField;
    jcdsSeatreserveplanvehicleno: TWideStringField;
    jcdsSeatreserveplanvehicleid: TLargeintField;
    jcdsSeatreserveplanunitname: TWideStringField;
    jcdsSeatreserveplanunitid: TLargeintField;
    jcdsSeatreserveplanbrandmodel: TWideStringField;
    jcdsSeatreserveplanbrandmodelid: TLargeintField;
    jcdsSeatreservestationservicefee: TCurrencyField;
    jcdsSeatreservefueladditionfee: TCurrencyField;
    jcdsSeatreservetoplimitprice: TCurrencyField;
    jcdsSeatreservedistance: TIntegerField;
    jcdsSeatreserveseattype: TWideStringField;
    jcdsSeatreserveisovertime: TBooleanField;
    jcdsSeatreserveislinework: TBooleanField;
    jcdsSeatreserveworkways: TWideStringField;
    jcdsSeatreserveendstationname: TWideStringField;
    jcdsSeatreservestartstationname: TWideStringField;
    jcdsSeatreservereachstationsecondname: TWideStringField;
    jcdsSeatreservescheduleremarks: TWideStringField;
    jcdsSeatreservedepartstationid: TLargeintField;
    jcdsSeatreservereachstationid: TLargeintField;
    jcdsSeatreserveorgid: TLargeintField;
    jcdsSeatreservescheduleid: TLargeintField;
    jcdsSeatreservetickettype: TWideStringField;
    jcdsSeatreserveprice: TCurrencyField;
    jcdsSeatreserveseatno: TIntegerField;
    jcdsSeatreservehalfprice: TCurrencyField;
    jcdsSeatreservestudentprice: TCurrencyField;
    jcdsSeatreservedepartstationname: TWideStringField;
    jcdsSeatreserveisroundtrip: TBooleanField;
    jcdsSeatreservereturntripvaliddays: TIntegerField;
    jcdsSeatreserveticketentrancename: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure nvedtCERTIFICATENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nvcbbCERTIFICATETYPEChange(Sender: TObject);
    procedure pnlscheduleResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsSeatreserveDataChange(Sender: TObject; Field: TField);
    procedure nvdbgrdhseatreserveDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumnEh;
      State: TGridDrawState);
    procedure nvdbgrdhseatreserveGetCellParams(Sender: TObject;
      Column: TColumnEh; AFont: TFont; var Background: TColor;
      State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    customerid: Int64;
    function getcustomer: boolean;

    function queryseatreserve: Integer; // 查询留票记录
    function getPriceByTicketTypeCode(ticketTypeCode: string): Currency;
  protected
    procedure setInsuranceInfo(cdsInsuranceBuffer: TDataSet); override;
    // 保存当前要售的座位到缓存
    function savetobuffer: boolean; override;
    // 取当前售票数，不含缓存表中的售票数
    function getCurticketnum: Integer; override;
    // 取当前打印售票数，不含缓存表中的售票数，因为售一张往返车票，要打印两张车票。
    function getCurPrintTicketnum: Integer; override;
    function lockseat: String; override;
    function checkCanGoToReceive: boolean; override; // 检查是否满足显示收钱界面的条件
    function getCurTicketreceivablenum: Currency; override; // 取当前车票应收（不包括缓存表）
    function getCDSSchedule: TjsonClientDataSet; override;
    procedure setContextHint(winControl: TWinControl); override; // 设置上下文提示
    procedure showInsureForm; override;
  public
    { Public declarations }
    procedure initThroughControl(); override;
    procedure findSchedule(); override;
    procedure reset; override; // 重置界面
  end;

var
  FrmSellBookTicket: TFrmSellBookTicket;

implementation

uses Ufrmsellticketend, PubFn, Services, Generics.Collections, UFrmCustomerAdd;
{$R *.dfm}
{ TFrmSellBookTicket }

function TFrmSellBookTicket.checkCanGoToReceive: boolean;
var
  bm: Tbookmark;
begin
  result := false;
  with jcdsSeatreserve do
  begin
    if (Active) and (RecordCount > 0) then
    begin
      DisableControls;
      bm := GetBookmark;
      First;
      while not eof do
      begin
        if FieldByName('isselect').AsBoolean then
        begin
          result := True;
          Break;
        end;
        Next;
      end;
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

procedure TFrmSellBookTicket.dsSeatreserveDataChange(Sender: TObject;
  Field: TField);
var
  oldOnDataChange: TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then
    exit;
  // 非留位状态不允许选择
  if (Field.FieldName = 'isselect') or (Field.FieldName = 'istakekid') then
  begin
    if (Field.DataSet.FieldByName('sellstate').AsString <> 'R') then
    begin
      oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
      .OnDataChange := nil;
      Field.DataSet.FieldByName('isselect').Value := null;
      Field.DataSet.FieldByName('istakekid').Value := null;
(Sender as TDataSource)
      .OnDataChange := oldOnDataChange;
    end
    else
    begin
      if not Field.DataSet.FieldByName('isselect').AsBoolean then
      begin
        oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
        .OnDataChange := nil;
        Field.DataSet.FieldByName('istakekid').Value := false;
(Sender as TDataSource)
        .OnDataChange := oldOnDataChange;
      end;
    end;
  end;
end;

procedure TFrmSellBookTicket.findSchedule;
begin
  // inherited;
  if (SellTicket = nil) then
    exit;
  if ((nvhelpreachstation.Id = 0) and (nvhelpSchedule.Id = 0)) and
    ((nvcbbCERTIFICATETYPE.ItemIndex < 0) or (Trim(nvedtCERTIFICATENO.Text)
        = '')) then
  begin
    if (nvcbbCERTIFICATETYPE.ItemIndex < 0) then
    begin
      nvedtCERTIFICATENO.SetFocus;
    end
    else
    begin
      nvedtCERTIFICATENO.SetFocus;
    end;
    if dsSchedule.DataSet <> nil then
    begin
      dsSchedule.DataSet.Close;
    end;
  end
  else
  begin
    try
      queryseatreserve;
    Except
      on E: Exception do
      begin
        SysLog.WriteErr(E.Message);
      end;
    end;
    // condition:=ScheduleAskCondition.Create;
    // with condition do
    // begin
    // departDate:=dtpdepartdate.Date;
    // departStationId:=nvhelpdepartstation.Id;
    // reachStationId:=nvhelpreachstation.Id;
    // ScheduleId:=nvhelpSchedule.Id;
    // customerid:=self.customerid;
    // end;
    // sellTicket.findSchedule(condition);
    // if dsSchedule.DataSet=nil then
    // dsSchedule.DataSet:=sellTicket.cdsSchedule;
  end;
end;

procedure TFrmSellBookTicket.FormActivate(Sender: TObject);
begin
  // inherited;
  nvedtCERTIFICATENO.SetFocus;

end;

procedure TFrmSellBookTicket.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbCERTIFICATETYPE.Active := True;
  nvcbbCERTIFICATETYPE.SetItemIndexByCode('4');
  gbseatplan.Visible := false;
  nvdbgrdhschedule.Visible := false;
  gb7.Visible := false;
  gbamount.Visible := false;
  gbschedulecondition.Visible := false;
  gbTakeKid.Visible := false;
  pnlinput.Top := 0;
  // tickettype字段关联
  createLookupField('tickettypename', '', 'tickettype', 'code', 'name',
    ftWideString, 50, 0, jcdsSeatreserve, SellTicket.cdsTicketType);

  // with jcdsSeatreservetickettypename do
  // begin
  // FieldKind := fkLookup;
  // KeyFields := 'tickettype';
  // LookupKeyFields := 'code';
  // LookupResultField := 'NAME';
  // LookupDataset := SellTicket.cdsTicketType;
  // end;
end;

procedure TFrmSellBookTicket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = []) and ((Key = VK_F8) or (Key = VK_F9)) then // (key=VK_F4) or
    Key := 0
  else
    inherited;
end;

procedure TFrmSellBookTicket.FormShow(Sender: TObject);
begin
  inherited;
  nvdbgrdhseatreserve.jsonConnection := DMPublic.jcon;
  nvdbgrdhseatreserve.GridUser := SysInfo.LoginUserInfo.UserID;
end;

function TFrmSellBookTicket.getCDSSchedule: TjsonClientDataSet;
begin
  result := jcdsSeatreserve;
end;

function TFrmSellBookTicket.getCurPrintTicketnum: Integer;
var
  bm: Tbookmark;
begin
  result := 0;
  with jcdsSeatreserve do
  begin
    if (Active) and (RecordCount > 0) then
    begin
      DisableControls;
      bm := GetBookmark;
      First;
      while not eof do
      begin
        if FieldByName('isselect').AsBoolean then
        begin
          Inc(result);
          if FieldByName('isroundtrip').AsBoolean then
          begin
            Inc(result);
          end;
        end;
        Next;
      end;
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

function TFrmSellBookTicket.getCurticketnum: Integer;
var
  bm: Tbookmark;
begin
  result := 0;
  with jcdsSeatreserve do
  begin
    if (Active) and (RecordCount > 0) then
    begin
      DisableControls;
      bm := GetBookmark;
      First;
      while not eof do
      begin
        if FieldByName('isselect').AsBoolean then
        begin
          Inc(result);
        end;
        Next;
      end;
      GotoBookmark(bm);
      EnableControls;
    end;
  end;
end;

function TFrmSellBookTicket.getCurTicketreceivablenum: Currency;
var
  bm: Tbookmark;
begin
  result := 0;
  if not jcdsSeatreserve.Active then
    exit;
  // 计算应收
  with jcdsSeatreserve do
  begin
    DisableControls;
    bm := GetBookmark;
    First;
    while not eof do
    begin
      if FieldByName('isselect').AsBoolean then
      begin
        result := result + FieldByName('price').AsCurrency;
      end;
      Next;
    end;
    GotoBookmark(bm);
    EnableControls;
  end;
end;

function TFrmSellBookTicket.getcustomer: boolean;
begin
  result := false;
  if (Trim(nvedtCERTIFICATENO.Text) = '') or
    (nvcbbCERTIFICATETYPE.ItemIndex < 0) then
  begin
    self.customerid := 0;
  end
  else
  begin
    with jsoncdsquerycustomer do
    begin
      Active := false;
      Params.ParamValues['filter_EQS_c!certificatetype'] :=
        nvcbbCERTIFICATETYPE.GetSelectCode;
      Params.ParamValues['filter_EQS_c!certificateno'] :=
        nvedtCERTIFICATENO.Text;
      Active := True;
      if RecordCount = 1 then
      begin
        self.customerid := FieldValues['id'];
        result := True;
      end
      else
      begin
        self.customerid := 0;
      end
    end;
  end;
  findSchedule;
end;

function TFrmSellBookTicket.getPriceByTicketTypeCode(ticketTypeCode: string)
  : Currency;
begin
  result := 0;
  if (not assigned(jcdsSeatreserve)) or (not jcdsSeatreserve.Active) then
    exit;
  if (ticketTypeCode = 'Q') then
    result := jcdsSeatreserve.FieldByName('fullprice').AsCurrency
  else if (ticketTypeCode = 'B') then
    result := jcdsSeatreserve.FieldByName('halfprice').AsCurrency
  else if (ticketTypeCode = 'X') then
    result := jcdsSeatreserve.FieldByName('studentprice').AsCurrency
  else
  begin
    result := SellTicket.GetTickettypePrice
      (jcdsSeatreserve.FieldByName('scheduleid').AsLargeInt,
      jcdsSeatreserve.FieldByName('departdate').AsDateTime, ticketTypeCode,
      jcdsSeatreserve.FieldByName('fullprice').AsCurrency);
  end;
end;

procedure TFrmSellBookTicket.initThroughControl;
var
  I: Integer;
begin
  inherited;
  defaultThroughControl.Clear;
  fullThroughControl.Clear;

  defaultThroughControl.Add(nvedtCERTIFICATENO);
  defaultThroughControl.Add(nvdbgrdhseatreserve);

  // fullThroughControl.Add(dtpdepartdate);
  fullThroughControl.Add(nvcbbCERTIFICATETYPE);
  fullThroughControl.Add(nvedtCERTIFICATENO);
  fullThroughControl.Add(nvdbgrdhseatreserve);

  fullThroughControl.AddRange(SellWayEnd.getfullThroughControl);
  defaultThroughControl.AddRange(SellWayEnd.getdefaultThroughControl);
end;

function TFrmSellBookTicket.lockseat: String;
var
  guid: TGUID;
  unlocktime: TDateTime;
  seatnos_S: String;
  seats: TList<Word>; // 要锁定的座位号列表
  scheduleplanids_seats: TDictionary < Int64, TList < Word >> ;
  // 按不同的班次计划ID来存储要锁定的座位号列表
  keys: TDictionary < Int64, TList < Word >> .TKeyCollection;
  _scheduleplanid: Int64;
  selectseatstatus: TList<string>;
  bm: Tbookmark;
begin
  result := '';
  with jcdsSeatreserve do
  begin
    DisableControls;
    bm := GetBookmark;
    First;
    scheduleplanids_seats := TDictionary < Int64, TList < Word >> .Create;
    while not eof do
    begin
      if (not FieldByName('isselect').AsBoolean) then
      begin
        Next;
        Continue;
      end;
      if scheduleplanids_seats.ContainsKey
        (FieldByName('scheduleplanid').AsLargeInt) then
        seats := scheduleplanids_seats.Items[FieldByName('scheduleplanid')
          .AsLargeInt]
      else
        seats := TList<Word>.Create;
      seats.Add(FieldByName('seatno').AsInteger);
      scheduleplanids_seats.AddOrSetValue
        (FieldByName('scheduleplanid').AsLargeInt, seats);
      Next;
    end;
    GotoBookmark(bm);
    EnableControls;
  end;
  if assigned(scheduleplanids_seats) and (scheduleplanids_seats.Count > 0) then
  begin
    selectseatstatus := TList<string>.Create;
    selectseatstatus.Add('4');
    selectseatstatus.Add('5');
    keys := scheduleplanids_seats.keys;
    // 循环锁位
    for _scheduleplanid in keys do
    begin
      // 开始锁位
      if curlockedguid_str = '' then
      begin
        if CreateGUID(guid) = S_OK then
        begin
        end
        else
        begin
          SysDialogs.ShowError('生成guid出错!');
          exit;
        end;
      end
      else
      begin
        guid := StringToGUID(curlockedguid_str);
      end;
      try
        seatnos_S := '';
        unlocktime := SellTicket.lockseat(guid, _scheduleplanid,
          scheduleplanids_seats.Items[_scheduleplanid], selectseatstatus, '',
          seatnos_S);
        // result:=true;
        if Trim(result) = '' then
          result := seatnos_S
        else
          result := result + ',' + seatnos_S;
        curlockedguid_str := GUIDToString(guid);
        // curlockedScheduleplanid:=jcdsSeatreserve.FieldByName('scheduleplanid').AsLargeInt;
        curlockedScheduleplanid := -1;
        if not assigned(curlockedSeatnos) then
          curlockedSeatnos := TList<Word>.Create
        else
          curlockedSeatnos.Clear;
        curlockedSeatnos.AddRange(scheduleplanids_seats.Items[_scheduleplanid]);
        tmrunlockseat.Enabled := false;
        tmrunlockseat.Interval := trunc
          (TimeStampToMSecs(DateTimeToTimeStamp(unlocktime)) - TimeStampToMSecs
            (DateTimeToTimeStamp(now)));
        tmrunlockseat.Enabled := True;
      except
        on E: Exception do
          SysDialogs.ShowError(E.Message);
      end;
    end;
  end;
end;

procedure TFrmSellBookTicket.nvcbbCERTIFICATETYPEChange(Sender: TObject);
begin
  inherited;
  // getcustomer;
  findSchedule;
end;

procedure TFrmSellBookTicket.nvdbgrdhseatreserveDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  // if (Column.FieldName='price') or (Column.FieldName='sellstatename')
  // or (Column.FieldName='tickettypename') then
  // begin
  // Exit;
  // end;
  if jcdsSeatreserve.FieldByName('sellstate').AsString <> 'R' then
  begin
    nvdbgrdhseatreserve.Canvas.Font.Color := clSilver;
    nvdbgrdhseatreserve.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmSellBookTicket.nvdbgrdhseatreserveGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (Column.FieldName = 'price') or (Column.FieldName = 'sellstatename') or
    (Column.FieldName = 'tickettypename') or (Column.FieldName = 'departdate')
    or (Column.FieldName = 'departtime') then
  begin
    AFont.Color := clRed;
    AFont.Size := nvdbgrdhschedule.Font.Size + 3;
    Background := clCream;
  end;
end;

procedure TFrmSellBookTicket.nvedtCERTIFICATENOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_UP) then
  begin
    // dtpdepartdate.Date:=IncDay(dtpdepartdate.Date);
    // setDepartDateColor;
    // findSchedule;
  end
  else if (Key = VK_DOWN) then
  begin
    // dtpdepartdate.Date:=IncDay(dtpdepartdate.Date,-1);
    // setDepartDateColor;
    // findSchedule;
  end
  else if Key = VK_RETURN then
  begin
    // getcustomer;
    findSchedule;
  end;
end;

procedure TFrmSellBookTicket.pnlscheduleResize(Sender: TObject);
begin
  // inherited;
  nvdbgrdhseatreserve.Left := nvdbgrdhseatreserve.Margins.Left;
  nvdbgrdhseatreserve.Top := nvdbgrdhseatreserve.Margins.Top;

  nvdbgrdhseatreserve.Width := pnlschedule.ClientWidth -
    nvdbgrdhseatreserve.Margins.Left - nvdbgrdhseatreserve.Margins.Right;
  nvdbgrdhseatreserve.Height := pnlschedule.ClientHeight -
    nvdbgrdhseatreserve.Margins.Top - nvdbgrdhseatreserve.Margins.Bottom;
end;

function TFrmSellBookTicket.queryseatreserve: Integer;
var
  bm: Tbookmark;
  findR: boolean;
begin
  result := 0;
  findR := false;
  with jcdsSeatreserve do
  begin
    Active := false;
    Params.ParamValues['filter_EQS_c!certificatetype'] :=
      nvcbbCERTIFICATETYPE.GetSelectCode;
    Params.ParamValues['filter_EQS_c!certificateno'] := nvedtCERTIFICATENO.Text;
    Params.ParamValues['filter_GED_t!departdate'] := DateToStr(trunc(Date()));
    // Params.ParamValues['filter_EQS_t!sellstate']:='R';
    Active := True;
    result := RecordCount;
    if RecordCount > 0 then
    begin
      DisableControls;
      First;
      while not eof do
      begin
        if (not findR) and (FieldByName('sellstate').AsString = 'R') then
        begin
          bm := GetBookmark;
          findR := True;
        end;
        Edit;
        FieldByName('price').AsCurrency := getPriceByTicketTypeCode
          (FieldByName('tickettype').AsString);
        Post;
        Next;
      end;
      if findR then
        GotoBookmark(bm)
      else
        First;
      EnableControls;
    end;
  end;
end;

procedure TFrmSellBookTicket.reset;
begin
  inherited;
  nvcbbCERTIFICATETYPE.SetItemIndexByCode('4');
  nvedtCERTIFICATENO.Text := '';
  jcdsSeatreserve.Active := false;
end;

function TFrmSellBookTicket.savetobuffer: boolean;
var
  I, j: Integer;
  bm: Tbookmark;
begin
  result := false;
  assert(assigned(jcdsSeatreserve) and jcdsSeatreserve.Active and
      (jcdsSeatreserve.RecordCount > 0), '系统逻辑异常，留位数据集没有打开或记录数为0！');
  with dsTicketBuffer.DataSet do
  begin
    if not Active then
    begin
      Active := True;
    end;
    jcdsSeatreserve.DisableControls;
    bm := jcdsSeatreserve.GetBookmark;
    jcdsSeatreserve.First;
    while not jcdsSeatreserve.eof do
    begin
      if jcdsSeatreserve.FieldByName('isselect').AsBoolean then
      begin
        Append;
        FieldByName('scheduleplanid').AsLargeInt := jcdsSeatreserve.FieldByName
          ('scheduleplanid').AsLargeInt;
        FieldByName('departdate').AsDateTime := jcdsSeatreserve.FieldByName
          ('departdate').AsDateTime;
        FieldByName('routename').AsString := jcdsSeatreserve.FieldByName
          ('routename').AsString;
        FieldByName('startstationname').AsString := jcdsSeatreserve.FieldByName
          ('startstationname').AsString;
        FieldByName('endstationname').AsString := jcdsSeatreserve.FieldByName
          ('endstationname').AsString;
        FieldByName('scheduleid').AsLargeInt := jcdsSeatreserve.FieldByName
          ('scheduleid').AsLargeInt;
        FieldByName('schedulecode').AsString := jcdsSeatreserve.FieldByName
          ('schedulecode').AsString;
        FieldByName('workways').AsString := jcdsSeatreserve.FieldByName
          ('workways').AsString;
        FieldByName('isovertime').AsBoolean := jcdsSeatreserve.FieldByName
          ('isovertime').AsBoolean;
        FieldByName('islinework').AsBoolean := jcdsSeatreserve.FieldByName
          ('islinework').AsBoolean;
        FieldByName('scheduleremarks').AsString := jcdsSeatreserve.FieldByName
          ('scheduleremarks').AsString;
        FieldByName('seattype').AsString := jcdsSeatreserve.FieldByName
          ('seattype').AsString;
        FieldByName('orgid').AsLargeInt := jcdsSeatreserve.FieldByName('orgid')
          .AsLargeInt;
        FieldByName('departstationid').AsLargeInt := jcdsSeatreserve.FieldByName
          ('departstationid').AsLargeInt;
        FieldByName('reachstationid').AsLargeInt := jcdsSeatreserve.FieldByName
          ('reachstationid').AsLargeInt;
        FieldByName('departstationname').AsString := jcdsSeatreserve.FieldByName
          ('departstationname').AsString;
        FieldByName('reachstationname').AsString := jcdsSeatreserve.FieldByName
          ('reachstationname').AsString;
        FieldByName('reachstationsecondname').AsString :=
          jcdsSeatreserve.FieldByName('reachstationsecondname').AsString;
        FieldByName('departtime').AsString := jcdsSeatreserve.FieldByName
          ('departtime').AsString;
        FieldByName('distance').AsLargeInt := jcdsSeatreserve.FieldByName
          ('distance').AsLargeInt;
        FieldByName('tickettype').AsString := jcdsSeatreserve.FieldByName
          ('tickettype').AsString;
        FieldByName('fullprice').AsFloat := jcdsSeatreserve.FieldByName
          ('fullprice').AsFloat;
        FieldByName('price').AsFloat := getPriceByTicketTypeCode
          (jcdsSeatreserve.FieldByName('tickettype').AsString);
        FieldByName('discountrate').AsFloat := roundEx
          (FieldByName('price').AsFloat / jcdsSeatreserve.FieldByName
            ('fullprice').AsCurrency, 3);
        FieldByName('toplimitprice').AsFloat := jcdsSeatreserve.FieldByName
          ('toplimitprice').AsFloat;
        FieldByName('fueladditionfee').AsFloat := jcdsSeatreserve.FieldByName
          ('fueladditionfee').AsFloat;
        FieldByName('stationservicefee').AsFloat := jcdsSeatreserve.FieldByName
          ('stationservicefee').AsFloat;
        FieldByName('ticketno').AsString := '';
        if jcdsSeatreserve.FieldByName('islinework').AsBoolean then
        begin
          raise Exception.Create('流水班不应该有订票记录!');
        end
        else
        begin
          FieldByName('seatno').AsInteger := jcdsSeatreserve.FieldByName
            ('seatno').AsInteger;
          FieldByName('seatnostr').AsString := jcdsSeatreserve.FieldByName
            ('seatno').AsString; // seatPlan.getSeatNoStr(seatPlan.selectedSeats.Items[sn]);
        end;
        if jcdsSeatreserve.FieldByName('istakekid').AsBoolean then
        begin
          FieldByName('carrychildnum').AsInteger := jcdsSeatreserve.FieldByName
            ('carrychildnum').AsInteger;
        end
        else
        begin
          FieldByName('carrychildnum').AsInteger := 0;
        end;
        FieldByName('ticketentrance').AsString := jcdsSeatreserve.FieldByName
          ('ticketentrance').AsString;
        FieldByName('ticketentrancename').AsString :=
          jcdsSeatreserve.FieldByName('ticketentrancename').AsString;
        FieldByName('buspark').AsString := jcdsSeatreserve.FieldByName
          ('buspark').AsString;
        if (SellWayEnd is Tfrmsellticketend) then
        begin
          FieldByName('paymethod').AsString := (SellWayEnd as Tfrmsellticketend)
            .nvcbbpayment.GetSelectCode;
        end
        else
        begin
          FieldByName('paymethod').AsString := '0';
        end;

        FieldByName('handticketoutletsid').Value := null;
        FieldByName('planvehicletype').AsString := jcdsSeatreserve.FieldByName
          ('planvehicletype').AsString;
        FieldByName('planvehiclegrade').AsString := jcdsSeatreserve.FieldByName
          ('planvehiclegrade').AsString;
        FieldByName('planvehicletypecustomname').AsString :=
          jcdsSeatreserve.FieldByName('planvehicletypecustomname').AsString;
        FieldByName('planunitname').AsString := jcdsSeatreserve.FieldByName
          ('planunitname').AsString;
        FieldByName('planbrandmodel').AsString := jcdsSeatreserve.FieldByName
          ('planbrandmodel').AsString;
        FieldByName('planvehicleno').AsString := jcdsSeatreserve.FieldByName
          ('planvehicleno').AsString;
        FieldByName('customerid').Value := null;

        if assigned(FrmCustomerAdd) and assigned
          (FrmCustomerAdd.dsInsuranceBuffer.DataSet)
          and FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active then
        begin
          FrmCustomerAdd.dsInsuranceBuffer.DataSet.DisableControls;
          FrmCustomerAdd.dsInsuranceBuffer.DataSet.First;
          while not FrmCustomerAdd.dsInsuranceBuffer.DataSet.eof do
          begin
            if (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                ['customerid'] <> null) and
              (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                ['customerid'] > 0) and
              (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues
                ['scheduleplanid'] = FieldValues['scheduleplanid']) and
              (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['seatno']
                = FieldValues['seatno']) then
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
            FrmCustomerAdd.dsInsuranceBuffer.DataSet.Next;
          end;
          FrmCustomerAdd.dsInsuranceBuffer.DataSet.EnableControls;
        end;

        FieldByName('returntripvaliddays').AsInteger :=
          jcdsSeatreserve.FieldByName('returntripvaliddays').AsInteger;
        FieldByName('isroundtrip').AsBoolean := jcdsSeatreserve.FieldByName
          ('isroundtrip').AsBoolean;
        // if assigned(FrmCustomerAdd) and assigned(FrmCustomerAdd.dsInsuranceBuffer.DataSet) and FrmCustomerAdd.dsInsuranceBuffer.DataSet.Active then
        // begin
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.DisableControls;
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.First;
        // while not FrmCustomerAdd.dsInsuranceBuffer.DataSet.Eof do
        // begin
        // if FieldByName('islinework').AsBoolean and FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldByName('islinework').AsBoolean and (FrmCustomerAdd.dsInsuranceBuffer.DataSet.RecNo=sn+1) then
        // begin
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.Edit;
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['seatno']:=FieldValues['seatno'];
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['seatnostr']:=FieldValues['seatnostr'];
        // end;
        // if (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['customerid']<>null)
        // and (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['customerid']>0)
        // and (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['scheduleplanid']=FieldValues['scheduleplanid'])
        // and (FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['seatno']=FieldValues['seatno'])
        // then
        // begin
        // FieldByName('customerid').Value:=FrmCustomerAdd.dsInsuranceBuffer.DataSet.FieldValues['customerid'];
        // break;
        // end;
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.next;
        // end;
        // FrmCustomerAdd.dsInsuranceBuffer.DataSet.EnableControls;
        // end;
        // 更新服务费（补票服务费 、订票服务费、改签服务费）
        FieldByName('servicefee').AsFloat := SellWayEnd.getServicefee
          (TjsonClientDataSet(dsTicketBuffer.DataSet));
        Post;
      end;
      jcdsSeatreserve.Next;
    end;
    jcdsSeatreserve.GotoBookmark(bm);
    jcdsSeatreserve.EnableControls;
    result := True;
    // clearCurlockedScheduleplanid;
  end;
  if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then // 是否售保险
  begin
    result := saveInsuretobuffer;
  end;
end;

procedure TFrmSellBookTicket.setContextHint(winControl: TWinControl);
begin
  if (winControl = nvcbbCERTIFICATETYPE) or (winControl = nvedtCERTIFICATENO)
    then
  begin
    lblContextHint.Caption := '输入订票人信息';
    appendAllContextHint;
  end
  else if (winControl = nvdbgrdhseatreserve) then
  begin
    lblContextHint.Caption := '空格键选择';
    appendAllContextHint;
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmSellBookTicket.setInsuranceInfo(cdsInsuranceBuffer: TDataSet);
var
  selectedSeats: TStringBuilder;
  seatno: Word;
begin
  inherited;
  // selectedSeats:=TStringBuilder.Create;
  // for seatno in seatPlan.selectedSeats do
  // begin
  // selectedSeats.Append(',').Append(seatno);
  // end;
  // selectedSeats.Remove(0,1).Insert(0,'(').Append(')');
  // with jcdsqryBookTicket do
  // begin
  // active:=false;
  // Params.ParamValues['filter_INS_t!seatno']:=selectedSeats.ToString;
  // Params.ParamValues['filter_EQL_t!scheduleplanid']:=dsSchedule.DataSet.FieldByName('scheduleplanid').AsString;
  // active:=true;
  // end;
  // with cdsInsuranceBuffer do
  // begin
  // first;
  // while not eof do
  // begin
  // jcdsqryBookTicket.First;
  // while not jcdsqryBookTicket.Eof do
  // begin
  // if FieldValues['seatno']=jcdsqryBookTicket.FieldValues['seatno'] then
  // begin
  // edit;
  // FieldValues['customerid']:=jcdsqryBookTicket.FieldValues['customerid'];
  // FieldValues['customername']:=jcdsqryBookTicket.FieldValues['customername'];
  // FieldValues['certificatetype']:=jcdsqryBookTicket.FieldValues['certificatetype'];
  // FieldValues['certificateno']:=jcdsqryBookTicket.FieldValues['certificateno'];
  // if State=dsEdit then
  // begin
  // post;
  // end;
  // break;
  // end;
  // jcdsqryBookTicket.next;
  // end;
  // next;
  // end;
  // end;
end;

procedure TFrmSellBookTicket.showInsureForm;
var
  I, j: Integer;
  bm: Tbookmark;
begin
  if assigned(FrmCustomerAdd) then
    freeandnil(FrmCustomerAdd);
  FrmCustomerAdd := TFrmCustomerAdd.Create(self);
  with FrmCustomerAdd do
  begin
    try
      // Caption:='保险单信息录入';
      edittype := TEditType.view;
      dsInsuranceBuffer.DataSet := SellTicket.createCdsInsureBuffer
        (FrmCustomerAdd);
      nvdbgrdhCustomer.Columns[5].ReadOnly:=True;
      nvdbgrdhCustomer.Columns[7].ReadOnly:=True;
      if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then // 售保险
      begin
        cdsinsuretype := SellTicket.cdsinsuretype;
      end;
      with dsInsuranceBuffer.DataSet do // jsoncdsInsurance
      begin
        try
          Active := True;
        Except
          on E: Exception do
          begin
            SysLog.WriteErr(E.Message);
          end;
        end;
        jcdsSeatreserve.DisableControls;
        bm := jcdsSeatreserve.GetBookmark;
        if not jcdsSeatreserve.Active then
        begin
           Exit;
        end;
        if jcdsSeatreserve.RecordCount<1 then
        begin
           Exit;
        end;
        jcdsSeatreserve.First;

        while not jcdsSeatreserve.eof do
        begin
          if jcdsSeatreserve.FieldByName('isselect').AsBoolean then
          begin
            Append;
            FieldByName('tickettype').AsString := jcdsSeatreserve.FieldByName
              ('tickettype').AsString;
            FieldValues['seatno'] := jcdsSeatreserve.FieldByName('seatno')
              .AsInteger;
            FieldValues['seatnostr'] := jcdsSeatreserve.FieldByName('seatno')
              .AsString;
            FieldValues['issell'] := false;
            if (SellTicket.cansellinsure) and (cbautosellinsure.checked) then
            // 售保险
            begin
              FieldValues['issell'] := True;
              //增加保险类型的判断
              if getParametervalue('1060',SysInfo.LoginUserInfo.OrgID) = '0'  then
              begin
                SellTicket.cdsinsuretype.First;
                while not SellTicket.cdsinsuretype.Eof do
                begin
                   if (jcdsSeatreserve.FieldByName
                            ('distance').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                      and (jcdsSeatreserve.FieldByName
                            ('distance').AsLargeInt<=SellTicket.cdsinsuretype.FieldValues['endamount']) then
                   begin
                      FieldValues['insuretypeid'] := SellTicket.cdsinsuretype.FieldValues['id'];
                      Break;
                   end;
                   SellTicket.cdsinsuretype.next;
                end;
              end
              else
              begin
                SellTicket.cdsinsuretype.First;
                while not SellTicket.cdsinsuretype.Eof do
                begin
                  if (jcdsSeatreserve.FieldByName
                            ('price').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                     and (jcdsSeatreserve.FieldByName
                            ('price').AsLargeInt<=SellTicket.cdsinsuretype.FieldValues['endamount']) then
                  begin
                     FieldValues['insuretypeid'] := SellTicket.cdsinsuretype.FieldValues['id'];
                     Break;
                  end;
                  SellTicket.cdsinsuretype.next;
                end;
              end;
              nvdbgrdhCustomer.Columns[5].ReadOnly:=False;
              if not SellTicket.canrealnamesellticket then  //不是实名制售票,证件字段可以编辑
              begin
                nvdbgrdhCustomer.Columns[7].ReadOnly:=False;
              end;
            end;

            if SellTicket.canrealnamesellticket then //实名制售票
            begin
                 if jcdsSeatreserve.FieldByName('certificatetype').AsString='0' then
                 begin
                     FieldValues['certificatetype'] := jcdsSeatreserve.FieldByName('certificatetype').AsString;
                     FieldValues['certificateno'] := jcdsSeatreserve.FieldValues['certificateno'];
                 end
                 else
                 begin
                    FieldValues['certificatetype'] := '0';
                 end;
            end
            else
            begin
               FieldValues['certificatetype'] := jcdsSeatreserve.FieldByName('certificatetype').AsString;
               FieldValues['certificateno'] := jcdsSeatreserve.FieldValues['certificateno'];
            end;

            FieldValues['isselfschedule'] := false;
            FieldValues['ticketoutletsname'] :=
              SysInfo.LoginUserInfo.ticketoutletsname;

            FieldValues['scheduleplanid'] := jcdsSeatreserve.FieldValues
              ['scheduleplanid'];
            FieldValues['departdate'] := jcdsSeatreserve.FieldValues
              ['departdate'];
            FieldValues['schedulecode'] := jcdsSeatreserve.FieldValues
              ['schedulecode'];
            FieldValues['islinework'] := jcdsSeatreserve.FieldValues
              ['islinework'];
            FieldValues['departstationname'] := jcdsSeatreserve.FieldValues
              ['departstationname'];
            FieldValues['reachstationname'] := jcdsSeatreserve.FieldValues
              ['reachstationname'];
            FieldValues['reachstationsecondname'] := jcdsSeatreserve.FieldValues
              ['reachstationsecondname'];
            FieldValues['departtime'] := jcdsSeatreserve.FieldValues
              ['departtime'];
            FieldValues['distance'] := jcdsSeatreserve.FieldValues['distance'];
            FieldValues['customerid'] := jcdsSeatreserve.FieldValues
              ['customerid'];
            FieldValues['customername'] := jcdsSeatreserve.FieldValues
              ['customername'];

            Post;
          end;
          jcdsSeatreserve.Next;
        end;
        jcdsSeatreserve.GotoBookmark(bm);
        jcdsSeatreserve.EnableControls;
        setInsuranceInfo(dsInsuranceBuffer.DataSet);
      end;

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
              Post;
              Next;
            end;
          end;
        end;
      end;
    finally
      // freeandnil(FrmCustomerAdd);
    end;
  end;
end;

end.
