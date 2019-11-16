unit UFrmTicketQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uBaseForm, GridsEh, DBGridEh, NvDbgridEh, ExtCtrls,
  StdCtrls, NovaEdit, NovaHelp, ComCtrls, NovaComboBox, Buttons, Spin,
  generics.Defaults,generics.Collections,FunctionItemIntf,Math,Services,
  PubFn,UTicketQuery,SeatPlan,jsonClientDataSet, DB,StrUtils,DBClient,
  DateUtils, Menus, DBGridEhGrouping,UDMPublic,UICcardRW;

type
  TFrmTicketQuery = class(TBaseForm,Ivipcardfound)
    shpbackround: TShape;
    dsSchedule: TDataSource;
    splbufferticket: TSplitter;
    pnlmain: TPanel;
    gbContextHit: TGroupBox;
    lblContextHint: TLabel;
    gbseatplan: TGroupBox;
    pnlinput: TPanel;
    gbschedulecondition: TGroupBox;
    nvhelpreachstation: TNovaHelp;
    gb3: TGroupBox;
    dtpdepartdate: TDateTimePicker;
    gb7: TGroupBox;
    nvhelpdepartstation: TNovaHelp;
    pnlschedule: TPanel;
    nvdbgrdhschedule: TNvDbgridEh;
    nvhelpSchedule: TNovaHelp;
    scrlbxSeatPlan: TScrollBox;
    grpSellNet: TGroupBox;
    chkSellNet: TCheckBox;
    grpshowdeparted: TGroupBox;
    chkshowdeparted: TCheckBox;
    nvhlpdepartdistrict: TNovaHelp;
    pnlvip: TPanel;
    lbl10: TLabel;
    lblviplastamount: TLabel;
    lbl13: TLabel;
    lblviplastmoney: TLabel;
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
    Button1: TButton;
    tmrrefreshschedule: TTimer;
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure checkBoxClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure nvhelpreachstationEnter(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure nvhelpreachstationIdChange(Sender: TObject);
    procedure pnlscheduleResize(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvhelpreachstationChange(Sender: TObject);
    procedure nvdbgrdhscheduleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure nvdbgrdhscheduleGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure nvdbgrdhscheduleDblClick(Sender: TObject);
    procedure chkshowdepartedClick(Sender: TObject);
    procedure nvhelpdepartstationChange(Sender: TObject);
    procedure btnclearvipinfoClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmrrefreshscheduleTimer(Sender: TObject);
  private
    { Private declarations }
    EscapeOccurActiveChange:boolean;//VK_ESCAPE、VK_SUBTRACT引起焦点变化时 不记录上一次焦点所在控件
    EnterOccurActiveChange:boolean; //VK_ENTER、VK_ADD引起焦点变化时
    FTicketQuery:TTicketQuery;

    throughControls:TStack<TWinControl>;//记录焦点经过的控件顺序(只记录必需经过的控件)，用于ESC键时回退
    lastActiveControls:TQueue<TWinControl>;//记录焦点经过的控件顺序，用于取上一次焦点所在控件

    curlockedguid_str:String; //当前锁位guid字符串
    curlockedSeatnos:TList<Word>;//当前锁位座位号列表
    curlockedScheduleplanid:int64;//当前锁位班次计划id

    linescheduleseatno:integer;

    isselfschedule:boolean;
    AutoFocusKeyInterval:Cardinal;

    procedure refreshSeatPlan; //显示座位图或座位表
    procedure seatPlanSizeReSize();
    procedure setTicketQuery(const Value: TTicketQuery);
    procedure setDepartDateColor;
    //设置活动控件的边框
    procedure setActiveControlFrame(control:TWinControl);
    function GoToNextControl(curControl:TWinControl;goahead,skip:Boolean):TWinControl;
    function checkParent(control:TControl;parent:TWinControl):Boolean;
    function getPriceByTicketTypeCode(ticketTypeCode:string):Currency;
    //事件
    procedure ScheduleAfterScroll(Sender: TDataSet);
    procedure ScheduleAfterOpen(Sender: TDataSet);
    procedure ScheduleAfterClose(Sender: TDataSet);
    procedure StationKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //在客户端加条件过滤班次
    procedure ScheduleFilter;
    procedure reset;//重置界面
  protected
    defaultThroughControl:TList<TWinControl>;//必需经过的控件(Enter)
    fullThroughControl:TList<TWinControl>;//全部经过的控件(+)
    seatPlan:TSeatPlan;  //座位图
    SeatPlanDecorato:TVehicleSeatPlanDecorator;
    procedure clearvipinfo;
    procedure ActiveChanged; override;
    procedure initThroughControl();dynamic;
    procedure findSchedule();dynamic;
    procedure setContextHint(winControl:TWinControl);dynamic;//设置上下文提示
  public
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); overload;override;
    Constructor Create(AOwner: TComponent;TicketQuery:TTicketQuery;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil);overload;
    procedure vipcardfound(vipCard:TVipCard);
    property TicketQuery:TTicketQuery read FTicketQuery write setTicketQuery;
  end;

var
  FrmTicketQuery: TFrmTicketQuery;

implementation

uses UFrmTicketQueryDetail;

const defaultSeatPlanHeight=250;
      defaultSeatPlanHeight_buffer=200;
{$R *.dfm}

procedure TFrmTicketQuery.ActiveChanged;
var activeRect:Trect;
    winControl:TWinControl;
    idx,i:integer;
    throughEnum:TStack<Twincontrol>.TEnumerator;
begin      //←↑→↓
  inherited;
  winControl:=GetParentForm(self).ActiveControl;
  if winControl=nil then exit;

  //背景
  setActiveControlFrame(winControl);
  if (winControl=nil) or (GetParentForm(winControl,false)<>self) then exit;
  if lastActiveControls=nil then
  begin
    exit;
  end;
  //更新焦点上次所在控件
  lastActiveControls.Enqueue(winControl);
  while lastActiveControls.Count>2 do
  begin
    lastActiveControls.Dequeue;
  end;
  //更新焦点途经控件
  if winControl=defaultThroughControl.Items[0] then
  begin
    throughControls.Clear;
  end
  else if (lastActiveControls.Peek<>nil) and
     (not EscapeOccurActiveChange) and
     (defaultThroughControl.Contains(lastActiveControls.Peek)
     ) then
  begin
    idx:=-1;
    throughEnum:=throughControls.GetEnumerator;
    while throughEnum.MoveNext do
    begin
      Inc(idx);
      if throughEnum.Current=lastActiveControls.Peek then
      begin
        Break;
      end;
    end;
    if throughControls.Count=idx+1 then
    begin
      throughControls.Push(lastActiveControls.Peek);
    end
    else
    begin
      for I := throughControls.Count-1 downto idx+1 do
      begin
        throughControls.Pop;
      end;
    end;
  end;
  {$IFDEF CONSOLE}
    Writeln('new count:'+inttostr(throughControls.Count));
  {$ENDIF}

  //焦点变化时更新上下文提示
  setContextHint(winControl);
  // 隐藏收银框
  if EnterOccurActiveChange
    and (winControl=nvdbgrdhschedule)
    and (dsSchedule.DataSet<>nil)
    and dsSchedule.DataSet.Active
    and (dsSchedule.DataSet.RecordCount=0) then
  begin
    if (lastActiveControls.Peek<>nil) then
      lastActiveControls.Peek.SetFocus
    else
      defaultThroughControl.Items[0].SetFocus;
  end;
  EscapeOccurActiveChange:=false;
  EnterOccurActiveChange:=false;
end;

procedure TFrmTicketQuery.checkBoxClick(Sender: TObject);
begin
  inherited;
  if (Sender is TCheckBox) then
  begin
    if TCheckBox(Sender).Checked then
    begin
      TCheckBox(Sender).Font.Style:=TCheckBox(Sender).Font.Style+[fsBold];
    end
    else
    begin
      TCheckBox(Sender).Font.Style:=TCheckBox(Sender).Font.Style-[fsbold];
    end;
    if Sender=chkSellNet then
    begin
      if TCheckBox(Sender).Checked then
      begin
        nvhelpdepartstation.HelpOptions.HelpType:='NetStartStationHelp';
        nvhelpdepartstation.ignoreSearchFlag:='.';
        nvhelpreachstation.ignoreSearchFlag:='';
      end
      else
      begin
        nvhelpdepartstation.HelpOptions.HelpType:='StartStationHelp';
        nvhelpdepartstation.ignoreSearchFlag:='';
        nvhelpreachstation.ignoreSearchFlag:='.';
      end;
      reset;
    end
    else if (GetParentForm(self).ActiveControl=sender) then
    begin
      if (lastActiveControls.Count>0) and (lastActiveControls.Peek<>nil) then
      begin
        if lastActiveControls.Peek.CanFocus then
          lastActiveControls.Peek.SetFocus;
      end
      else
        GoToNextControl(TCheckBox(Sender),true,true);
    end;
  end;
end;

function TFrmTicketQuery.checkParent(control: TControl;
  parent: TWinControl): Boolean;
var _control:TWinControl;
begin
  Result:=false;
  _control:=control.Parent;
  while(_control<>nil) do
  begin
    if _control=parent then
    begin
      Result:=true;
      Break;
    end;
    _control:=_control.Parent;
  end;
end;

procedure TFrmTicketQuery.chkshowdepartedClick(Sender: TObject);
begin
  inherited;
  ScheduleFilter;
  checkBoxClick(chkshowdeparted);
end;

constructor TFrmTicketQuery.Create(AOwner: TComponent; TicketQuery: TTicketQuery;
  functionItem: IFunctionItem;parameter:TFunctionItemParameters);
var seatsStatus,seatstype:TDictionary<Word,String>;
    start:TDateTime;
begin
  Create(AOwner,functionItem);
  self.TicketQuery:=TicketQuery;
  dtpdepartdate.MaxDate:=Trunc(date)+strtointdef(getParametervalue('1017',SysInfo.LoginUserInfo.OrgID),7)-1;
//售票问讯不限制发车日期了20120622  dtpdepartdate.MinDate:=Trunc(now);
  grpSellNet.Visible:=True;
  dsSchedule.DataSet:=TicketQuery.cdsSchedule;
  //TicketQuery.AfterScheduleScroll:=ScheduleAfterScroll;
  //TicketQuery.cdsSchedule.AfterOpen:=ScheduleAfterOpen;
  //TicketQuery.cdsSchedule.AfterClose:=ScheduleAfterClose;
end;

constructor TFrmTicketQuery.Create(AOwner: TComponent;
  functionItem: IFunctionItem;parameter:TFunctionItemParameters;checkpermission:boolean);
begin
  inherited;
 { if not Assigned(SeatPlanDecorato) then
  begin
    seatPlan:=TSeatPlan.Create(gbseatplan);
    with seatPlan do
    begin
      ShowHint:=true;
    end;
    SeatPlanDecorato:=TVehicleSeatPlanDecorator.Create(gbseatplan,seatPlan);
    SeatPlanDecorato.setParent(scrlbxSeatPlan);
    SeatPlanDecorato.showspacename:=false;
  end; }

  initThroughControl();
  isselfschedule:=true;
  linescheduleseatno:=0;
  curlockedScheduleplanid:=0;
  EscapeOccurActiveChange:=false;
  EnterOccurActiveChange:=false;
  nvhelpreachstation.OnKeyDown:=StationKeyDown;
  nvhelpdepartstation.OnKeyDown:=StationKeyDown;

  dtpdepartdate.Date:=Date;
  setDepartDateColor;
  nvhelpdepartstation.Text:='';
  nvhelpdepartstation.Id:=0;
  nvhelpreachstation.Text:='';
  nvhelpreachstation.Id:=0;
 // if assigned(SeatPlanDecorato) then SeatPlanDecorato.Visible:=false;
 // gbseatplan.Height:=300;
  throughControls.Clear;
  lastActiveControls.Clear;
  lastActiveControls.Enqueue(nil);
  curlockedScheduleplanid:=0;
  AutoFocusKeyInterval:=StrToInt64Def(getParametervalue('0001',SysInfo.LoginUserInfo.OrgID),300);
  nvdbgrdhschedule.AutoFocusKeyInterval:=AutoFocusKeyInterval;
  setCardTypeNOLength(Tcardtypes.VIP,sysInfo.curBillLength.Items['Vip']);
  if getParametervalue('0013',SysInfo.LoginUserInfo.OrgID)='1' then
  begin
    TVipcardRW.GetInstance.addObserver(Self);
  end;
end;

procedure TFrmTicketQuery.dtpdepartdateChange(Sender: TObject);
begin
  inherited;
  setDepartDateColor;
  findSchedule;
end;

procedure TFrmTicketQuery.findSchedule;
var condition: ScheduleAskCondition;
begin
 if (TicketQuery=nil) then exit;
  if (nvhelpreachstation.Id=0) and (nvhelpSchedule.Id=0)  then
  begin
    if dsSchedule.DataSet<>nil then
    begin
      dsSchedule.DataSet.Close;
    end;
  end
  else
  begin
    condition:=ScheduleAskCondition.Create;
    with condition do
    begin
      isnet:=chkSellNet.Checked;
      departDate:=dtpdepartdate.Date;
      departStationId:=nvhelpdepartstation.Id;
      reachStationId:=nvhelpreachstation.Id;
      ScheduleId:=nvhelpSchedule.Id;
      if nvhlpdepartdistrict.Id>0 then
      begin
        districtcode:=nvhlpdepartdistrict.HelpFieldValue['Code'];
      end;
    end;
    TicketQuery.findSchedule(condition);
    if dsSchedule.DataSet=nil then
      dsSchedule.DataSet:=TicketQuery.cdsSchedule;
  end;
end;

procedure TFrmTicketQuery.FormActivate(Sender: TObject);
begin
  inherited;
  if (lastActiveControls<>nil) and (lastActiveControls.Peek<>nil) and (lastActiveControls.Peek.CanFocus) then
  begin
    lastActiveControls.Peek.SetFocus;
  end
  else if (defaultThroughControl<>nil) and (defaultThroughControl.Count>0) and (defaultThroughControl.Items[0].CanFocus) then
  begin
    defaultThroughControl.Items[0].SetFocus;
  end;
end;

procedure TFrmTicketQuery.FormDestroy(Sender: TObject);
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

procedure TFrmTicketQuery.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Screen.ActiveControl<>nil)
    and ((Key='+') or (Key='-'))
    and (GetParentForm(Screen.ActiveControl,False)=self)
    and ((Screen.ActiveControl is TcustomEdit)
         or (Screen.ActiveControl is TSpinEdit)
         or (Screen.ActiveControl is TDateTimePicker)
          ) then
    key:=#0;
end;

procedure TFrmTicketQuery.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var continueDealKey:Boolean;
    winControl:TWinControl;
    i:integer;
    functionParm: TFunctionItemParameters;
begin
  continueDealKey:=false;
  winControl:=GetParentForm(self).ActiveControl;
  if key=VK_F2 then
  begin
    reset;
  end
  else if (key=VK_F3) and chkshowdeparted.Enabled then
  begin
    chkshowdeparted.Checked:=not chkshowdeparted.Checked;
  end
  else if (Key = 83) and (Shift = [ssCtrl]) then
  begin
    if (Assigned(dsSchedule.DataSet))
        and (dsSchedule.DataSet.Active)
        and (dsSchedule.DataSet.RecordCount>0) then
    begin
      functionParm := TFunctionItemParameters.Create;
      functionParm.CommaText := dsSchedule.DataSet.FieldByName('scheduleplanid').AsString
                                +','+dsSchedule.DataSet.FieldByName('departstationid').AsString
                                +','+booltostr(chkSellNet.Checked)
                                +','+dsSchedule.DataSet.FieldByName('departdate').AsString
                                +','+dsSchedule.DataSet.FieldByName('schedulesynccode').AsString
                                +','+dsSchedule.DataSet.FieldByName('departstationcode').AsString
                                ;
      SysFunctionMgr.exec(StringToGUID('{846C8762-1903-48B1-AFC7-B1629A5DE4A8}'),functionParm);
    end;
  end
  else if (key=VK_F7) and chkSellNet.Enabled then
  begin
    chkSellNet.Checked:=not chkSellNet.Checked;
  end
  else if key=VK_F11 then
  begin
//    if gbseatplan.Visible and Assigned(gbseatplan) then
//      gbseatplan.SetFocus;
    if Assigned(seatPlan) and seatPlan.Visible and seatPlan.CanFocus then
      seatPlan.SetFocus;
  end
  else if key=VK_ESCAPE then
  begin
    EscapeOccurActiveChange:=true;
    GoToNextControl(winControl,false,true);
  end
  else if key=VK_RETURN then
  begin
    if not ((winControl=nvhelpreachstation) and (nvhelpreachstation.Id<=0) and (nvhelpSchedule.Id<=0)) then
    begin
      if (winControl=nvdbgrdhschedule) and (Assigned(dsSchedule.DataSet))
        and (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount>0)
        and (GetTickCount-TicketQuery.FrefreshCurScheduleTime>refreshScheduleInterval*1000) then
      begin
        ticketQuery.refreshseatandprice();
        if chkSellNet.Checked and TicketQuery.delayrefresh then
        begin
          refreshSeatPlan;
        end;
//        dsSchedule.DataSet.AfterScroll(dsSchedule.DataSet);
      end;
      if winControl<>nvdbgrdhschedule then
      begin
        EnterOccurActiveChange:=true;
        GoToNextControl(winControl,True,true);
      end
      else
      begin
        tbtnInsertClick(Sender);
      end;
    end;

  end
  else if key=VK_ADD then //+
  begin
    if not ((winControl=nvhelpreachstation) and (nvhelpreachstation.Id<=0) and (nvhelpSchedule.Id<=0)) then
    begin
      if (winControl=nvdbgrdhschedule) and (Assigned(dsSchedule.DataSet))
        and (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount>0)
        and (GetTickCount-TicketQuery.FrefreshCurScheduleTime>refreshScheduleInterval*1000) then
      begin
        ticketQuery.refreshseatandprice();
        if chkSellNet.Checked and TicketQuery.delayrefresh then
        begin
          refreshSeatPlan;
        end;
//        dsSchedule.DataSet.AfterScroll(dsSchedule.DataSet);
      end;
      EnterOccurActiveChange:=true;
      GoToNextControl(winControl,True,false);
    end;
  end
  else if (key=VK_SUBTRACT) or ((key=189) and (Shift=[ssShift])) then //-
  begin
    EscapeOccurActiveChange:=true;
    GoToNextControl(winControl,false,false);
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

procedure TFrmTicketQuery.FormResize(Sender: TObject);
begin
  inherited;
  seatPlanSizeReSize;
end;

procedure TFrmTicketQuery.FormShow(Sender: TObject);
begin
  inherited;
  nvdbgrdhschedule.jsonConnection:=DMPublic.jcon;
  nvdbgrdhschedule.GridUser:=SysInfo.LoginUserInfo.UserID;  checkBoxClick(chkSellNet);  checkBoxClick(chkshowdeparted);
  tmrrefreshschedule.interval :=strtoint(getParametervalue('1111',SysInfo.LoginUserInfo.OrgID))*1000;
  reset;
end;

function TFrmTicketQuery.getPriceByTicketTypeCode(
  ticketTypeCode: string): Currency;
begin
  result:=0;
  if (not assigned(dsSchedule.DataSet)) or (not dsSchedule.DataSet.active) then exit;
  if (ticketTypeCode='Q') then
    result:=dsSchedule.DataSet.FieldByName('fullprice').AsCurrency
  else if (ticketTypeCode='B') then
    result:=dsSchedule.DataSet.FieldByName('halfprice').AsCurrency
  else if (ticketTypeCode='X') then
    result:=dsSchedule.DataSet.FieldByName('studentprice').AsCurrency
  else
  begin
    result:=TicketQuery.GetTickettypePrice(dsSchedule.DataSet.FieldByName('departdate').AsDateTime,
                                          ticketTypeCode,
                                          dsSchedule.DataSet.FieldByName('fullprice').AsCurrency);
  end;
end;

function TFrmTicketQuery.GoToNextControl(curControl: TWinControl;goahead,skip:Boolean): TWinControl;
var i:Integer;
    _ThroughControl:TList<TWinControl>;
    nextcontrol:TWinControl;
begin
  i:=-1;
  _ThroughControl:=nil;
  nextcontrol:=nil;
  if goahead then  //向前
  begin
    if skip then
      _ThroughControl:=defaultThroughControl
    else
      _ThroughControl:=fullThroughControl;
    if _ThroughControl.Contains(curControl) then
    begin
      i:=_ThroughControl.IndexOf(curControl);
      if _ThroughControl.Count=i+1 then
      begin
        exit;
      end;
      nextcontrol:=_ThroughControl.Items[i+1];
    end
    else
    begin
      if (skip and fullThroughControl.Contains(curControl)) then
      begin

          for I := fullThroughControl.IndexOf(curControl)+1 to fullThroughControl.Count - 1 do
          begin
            if defaultThroughControl.Contains(fullThroughControl.Items[i]) then
            begin
              nextcontrol:=fullThroughControl.Items[i];
              Break;
            end;
          end;
          if nextcontrol=nil then
          begin
            nextcontrol:=fullThroughControl.Items[fullThroughControl.IndexOf(curControl)+1];
          end;
      end
      else
      begin
        if throughControls.Count>0 then
        begin
          nextcontrol:=throughControls.Pop;
        end
        else
        begin
          nextcontrol:=defaultThroughControl.Items[0];
        end;
      end;
    end;
  end
  else //向后
  begin
    //第一个要经过的控件
    if curControl=fullThroughControl.Items[0] then
    begin
      exit;
    end;
    if skip then
    begin
      //优先退回经过的控件(必经)
      if throughcontrols.Count>0 then
      begin
        nextcontrol:=throughControls.Pop;
      end
      else
      begin
        if fullThroughControl.Contains(curControl) then
        begin
          for I := fullThroughControl.IndexOf(curControl)-1 downto 0 do
          begin
            if (i>=0) and defaultThroughControl.Contains(fullThroughControl.Items[i])  then
            begin
              nextcontrol:=fullThroughControl.Items[i];
              Break;
            end;
          end;
          if nextcontrol=nil then
          begin
              nextcontrol:=FindNextControl(curControl,goahead,true,false);
          end;
        end
        else
        begin
          nextcontrol:=defaultThroughControl.Items[0];
        end;
      end;
    end
    else
    begin
      if fullThroughControl.Contains(curControl) then
      begin
        nextcontrol:=fullThroughControl.Items[fullThroughControl.IndexOf(curControl)-1];
      end
      else
      begin
        if throughControls.Count>0 then
        begin
          nextcontrol:=throughControls.Pop;
        end
        else
        begin
          nextcontrol:=defaultThroughControl.Items[0];
        end;
      end;
    end;
  end;
  if nextcontrol<>nil then
  begin
    if nextcontrol.CanFocus then
    begin
      nextcontrol.SetFocus;
    end
    else
    begin
      GoToNextControl(nextcontrol,goahead,skip);
    end;
  end;
end;

procedure TFrmTicketQuery.initThroughControl;
var i:integer;
begin
  defaultThroughControl:=TList<TWinControl>.Create;
  defaultThroughControl.Add(nvhelpreachstation);
  defaultThroughControl.Add(nvdbgrdhschedule);
  defaultThroughControl.Add(seatPlan);

  fullThroughControl:=TList<TWinControl>.Create;
  fullThroughControl.Add(dtpdepartdate);
  fullThroughControl.Add(nvhelpdepartstation);
  fullThroughControl.Add(nvhelpreachstation);
  fullThroughControl.Add(seatPlan);

  throughControls:=TStack<TWinControl>.Create;
  lastActiveControls:=TQueue<TWinControl>.Create;
  lastActiveControls.Enqueue(nil);

end;

procedure TFrmTicketQuery.nvdbgrdhscheduleDblClick(Sender: TObject);
begin
  inherited;
  if (Assigned(dsSchedule.DataSet))
    and (dsSchedule.DataSet.Active) and (dsSchedule.DataSet.RecordCount>0)
    and (GetTickCount-TicketQuery.FrefreshCurScheduleTime>refreshScheduleInterval*1000) then
  begin
    ticketQuery.refreshseatandprice();
    if chkSellNet.Checked and TicketQuery.delayrefresh then
    begin
      refreshSeatPlan;
    end;
  end;
  tbtnInsertClick(Sender);
end;

procedure TFrmTicketQuery.nvdbgrdhscheduleDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
//  if (Column.FieldName='fullprice') or (Column.FieldName='residueseatnum') then
//  begin
//    Exit;
//  end;
//  if (dsSchedule.DataSet.FieldByName('isreported').AsBoolean) and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clGreen;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
//  // 报停
//  if (dsSchedule.DataSet.FieldByName('status').AsString = '1') and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clRed; // clYellow;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
//  // 被并
//  if (dsSchedule.DataSet.FieldByName('status').AsString = '3') and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clLtGray; // clYellow;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
//  // 脱班
//  if (dsSchedule.DataSet.FieldByName('status').AsString = '4') and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clOlive;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
//  // 停售
//  if (dsSchedule.DataSet.FieldByName('status').AsString = '5') and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clFuchsia;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
//  if (dsSchedule.DataSet.FieldByName('isdeparted').AsBoolean) and not
//    (gdSelected in State) then
//  begin
//    nvdbgrdhschedule.Canvas.Font.Color := clBlue;
//    nvdbgrdhschedule.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//  end;
end;

procedure TFrmTicketQuery.nvdbgrdhscheduleGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (dsSchedule.DataSet.FieldByName('isreported').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
  end;

  // 报停
  if (dsSchedule.DataSet.FieldByName('status').AsString = '1') and not
    (gdSelected in State) then
  begin
     Background := clRed; // clYellow;
  end
  // 被并
  else if (dsSchedule.DataSet.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
  end
  // 脱班
  else if (dsSchedule.DataSet.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clYellow;
  end
  // 停售
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

  if (Column.FieldName='fullprice') or (Column.FieldName='residueseatnum') then
  begin
    AFont.Color:=clRed;
    AFont.Size:=nvdbgrdhschedule.Font.Size+3;
    Background := clCream;
  end;
end;

procedure TFrmTicketQuery.nvhelpdepartstationChange(Sender: TObject);
begin
  inherited;
  if (nvhelpdepartstation.ignoreSearchFlag<>'')
    and (pos(nvhelpdepartstation.ignoreSearchFlag,nvhelpdepartstation.Text)=1)
    and (length(nvhelpdepartstation.ignoreSearchFlag)<length(nvhelpdepartstation.Text)) then
  begin
    nvhlpdepartdistrict.init;
    nvhlpdepartdistrict.notFocusedShowHelp:=true;
    nvhlpdepartdistrict.Text:=copy(nvhelpdepartstation.Text,length(nvhelpdepartstation.ignoreSearchFlag)+1);
  end
  else
  begin
    nvhlpdepartdistrict.notFocusedShowHelp:=false;
    nvhlpdepartdistrict.Text:='';
  end;
end;

procedure TFrmTicketQuery.nvhelpreachstationChange(Sender: TObject);
begin
  inherited;
  if (nvhelpreachstation.ignoreSearchFlag<>'')
    and (pos(nvhelpreachstation.ignoreSearchFlag,nvhelpreachstation.Text)=1)
    and (length(nvhelpreachstation.ignoreSearchFlag)<length(nvhelpreachstation.Text)) then
  begin
    nvhelpSchedule.init;
    nvhelpSchedule.notFocusedShowHelp:=true;
    nvhelpSchedule.Text:=copy(nvhelpreachstation.Text,length(nvhelpreachstation.ignoreSearchFlag)+1);
  end
  else
  begin
    nvhelpSchedule.notFocusedShowHelp:=false;
    nvhelpSchedule.Text:='';
  end;
end;
procedure TFrmTicketQuery.nvhelpreachstationEnter(Sender: TObject);
begin
  inherited;
  throughControls.Clear;
  lastActiveControls.Clear;
  lastActiveControls.Enqueue(nil);
end;

procedure TFrmTicketQuery.nvhelpreachstationIdChange(Sender: TObject);
var oldchangeEvent:TNotifyEvent;
begin
  inherited;
  if (Sender=nvhelpSchedule) then
  begin
    if (not chkSellNet.Checked)
    and (nvhelpreachstation.ignoreSearchFlag<>'')
    and (pos(nvhelpreachstation.ignoreSearchFlag,nvhelpreachstation.Text)=1)
    and (nvhelpreachstation.ignoreSearchFlag+nvhelpSchedule.Text<>nvhelpreachstation.Text) then
    begin
      oldchangeEvent:=nvhelpreachstation.OnChange;
      nvhelpreachstation.Text:=nvhelpreachstation.ignoreSearchFlag+nvhelpSchedule.Text;
      nvhelpreachstation.OnChange:=oldchangeEvent;
    end;
    nvhelpreachstation.SetFocus;
  end;
  if (Sender=nvhlpdepartdistrict) then
  begin
    if (chkSellNet.Checked)
    and (nvhelpdepartstation.ignoreSearchFlag<>'')
    and (pos(nvhelpdepartstation.ignoreSearchFlag,nvhelpdepartstation.Text)=1)
    and (nvhelpdepartstation.ignoreSearchFlag+nvhlpdepartdistrict.Text<>nvhelpdepartstation.Text) then
    begin
      oldchangeEvent:=nvhelpdepartstation.OnChange;
      nvhelpdepartstation.Text:=nvhelpdepartstation.ignoreSearchFlag+nvhlpdepartdistrict.Text;
      nvhelpdepartstation.OnChange:=oldchangeEvent;
    end;
    nvhelpdepartstation.SetFocus;
  end;
  findSchedule;
end;

procedure TFrmTicketQuery.pnlscheduleResize(Sender: TObject);
begin
  inherited;
  nvdbgrdhschedule.Left:=nvdbgrdhschedule.Margins.Left;
  nvdbgrdhschedule.Top:=nvdbgrdhschedule.Margins.Top;

  nvdbgrdhschedule.Width:=pnlschedule.ClientWidth-nvdbgrdhschedule.Margins.Left-nvdbgrdhschedule.Margins.Right;
  nvdbgrdhschedule.Height:=pnlschedule.ClientHeight-nvdbgrdhschedule.Margins.Top-nvdbgrdhschedule.Margins.Bottom;
end;

procedure TFrmTicketQuery.ScheduleAfterClose(Sender: TDataSet);
begin
  //refreshSeatPlan;
end;

procedure TFrmTicketQuery.ScheduleAfterOpen(Sender: TDataSet);
begin
  ScheduleFilter;
//  if (Sender<>nil) and Sender.active and (Sender.RecordCount>0) then
//  begin
//    nvdbgrdhschedule.SetFocus;
//  end;
end;

procedure TFrmTicketQuery.ScheduleAfterScroll(Sender: TDataSet);
begin
  //不显示座位图信息了
  {if chkSellNet.Checked and TicketQuery.delayrefresh then
  begin
    gbseatplan.Height:=defaultSeatPlanHeight;
    if assigned(SeatPlanDecorato) then SeatPlanDecorato.Visible:=false;
  end
  else
  begin
    refreshSeatPlan;
  end; }
end;

procedure TFrmTicketQuery.ScheduleFilter;
begin
  if (dsSchedule.dataset<>nil)
    and dsSchedule.dataset.active then
  begin
    if not chkshowdeparted.checked then
    begin
      dsSchedule.dataset.Filter:=' isdeparted=0 and residueseatnum>0';
    end
    else
    begin
      dsSchedule.dataset.Filter:='';
    end;
    dsSchedule.dataset.Filtered:=true;
  end;
end;

procedure TFrmTicketQuery.seatPlanSizeReSize;
begin
  if Assigned(seatPlanDecorato) then
  begin
    seatPlanDecorato.Left:=Max(0,(gbseatplan.Width-seatPlanDecorato.Width) div 2);
    seatPlanDecorato.Top:=Max(0,(gbseatplan.Height-seatPlanDecorato.Height) div 2);
  end;
end;

procedure TFrmTicketQuery.setActiveControlFrame(control: TWinControl);
var frameWidth:integer;
begin
  shpbackround.Visible:=(control<>nil) and (control.Parent<>nil) and (control<>self);
  if shpbackround.Visible then
  begin
    frameWidth:=2;
    if (control.Align=alClient) and (control.Parent is TCustomPanel) then
    begin
      control.Align:=alNone;
    end;
    shpbackround.Parent:=control.Parent;
    shpbackround.Width:=control.Width+frameWidth*2;
    shpbackround.Height:=control.Height+frameWidth*2;
    shpbackround.Left:=control.Left-framewidth;
    shpbackround.Top:=control.Top-framewidth;
  end;
end;

procedure TFrmTicketQuery.setContextHint(winControl: TWinControl);
var nextControl:TWinControl;
begin
  if winControl=nvdbgrdhschedule then
  begin
    lblContextHint.Caption:='↑↓序号定位';
  end
  else if winControl=dtpdepartdate then
  begin
    lblContextHint.Caption:='↑增加日期、↓减小日期';
  end
  else if winControl=nvhelpdepartstation then
  begin
    lblContextHint.Caption:='输入简拼或编码查找起点站、↑增加日期、↓减小日期';
  end
  else if winControl=nvhelpreachstation then
  begin
    lblContextHint.Caption:='输入简拼或编码查找到站';
  end
  else if (winControl=SeatPlanDecorato) or (winControl=seatPlan) then //座位图
  begin
    lblContextHint.Caption:='空格键选择或取消选择、方向键移动';
  end;
end;

procedure TFrmTicketQuery.setDepartDateColor;
begin
  if trunc(dtpdepartdate.Date)=trunc(now) then
  begin
    dtpdepartdate.Font.Style:=dtpdepartdate.Font.Style-[fsBold,fsItalic];
  end
  else if trunc(dtpdepartdate.Date)<trunc(now) then
  begin
    dtpdepartdate.Font.Style:=dtpdepartdate.Font.Style+[fsBold,fsItalic];
  end
  else
  begin
    dtpdepartdate.Font.Style:=dtpdepartdate.Font.Style+[fsBold]-[fsItalic];
  end;
end;

procedure TFrmTicketQuery.setTicketQuery(const Value: TTicketQuery);
begin
  FTicketQuery := Value;
end;

procedure TFrmTicketQuery.refreshSeatPlan;
var i:integer;
begin
  {if (dsSchedule.DataSet=nil) or (not dsSchedule.DataSet.Active)
    or (dsSchedule.DataSet.RecordCount=0) or (dsSchedule.DataSet.FieldByName('ISLINEWORK').AsBoolean) then
  begin
    gbseatplan.Height:=defaultSeatPlanHeight;
    if assigned(SeatPlanDecorato) then SeatPlanDecorato.Visible:=false;
    exit;
  end;
  SeatPlanDecorato.Visible:=true;
  with seatPlan  do  //seatPlan
  begin
    seatsStatus:=TicketQuery.ScheduleSeatStatus;
    seatsTickettype:=TicketQuery.ScheduleSeatTickettype;
    seatshint := TicketQuery.seatshint;
  end;
  if dsSchedule.DataSet.FieldByName('planbrandmodelid').IsNull then
    SeatPlanDecorato.brandModelid:=0
  else
    SeatPlanDecorato.brandModelid:=dsSchedule.DataSet.FieldByName('planbrandmodelid').AsLargeInt;
//  SeatPlanDecorato.Repaint;
//  gbseatplan.Height:=seatPlanDecorato.actualheight;
  seatPlan.Repaint;
  seatPlanSizeReSize;   }
end;

procedure TFrmTicketQuery.reset;
var i:Integer;
    oldIdChange:TNotifyEvent;
begin
  dtpdepartdate.DateTime:=Trunc(Date);
  setDepartDateColor;
  oldIdChange:=nvhelpdepartstation.OnIdChange;
  nvhelpdepartstation.OnIdChange:=nil;
  if (not chkSellNet.Checked) and (getParametervalue('1030',SysInfo.LoginUserInfo.OrgID)='1') then
  begin
    nvhelpdepartstation.Text:=SysInfo.LoginUserInfo.OrgName;
    nvhelpdepartstation.Id:=SysInfo.LoginUserInfo.StationID;
  end
  else
  begin
    nvhelpdepartstation.Text:='';
    nvhelpdepartstation.Id:=0;
  end;
  nvhlpdepartdistrict.Text:='';
  nvhlpdepartdistrict.id:=0;
  nvhelpdepartstation.OnIdChange:=oldIdChange;
  nvhelpreachstation.Text:='';
  nvhelpreachstation.Id:=0;
  nvhelpSchedule.Text:='';
  nvhelpSchedule.Id:=0;
  nvhlpdepartdistrict.SendToBack;
  nvhelpSchedule.SendToBack;
  if assigned(SeatPlanDecorato) then SeatPlanDecorato.Visible:=false;
  throughControls.Clear;
  lastActiveControls.Clear;
  lastActiveControls.Enqueue(nil);
  if defaultThroughControl.Items[0].CanFocus then
  begin
    defaultThroughControl.Items[0].SetFocus;
  end;
  clearvipinfo;
end;

procedure TFrmTicketQuery.StationKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Sender=nvhelpreachstation)
    and (not chkSellNet.Checked)
    and (nvhelpreachstation.ignoreSearchFlag<>'')
    and (pos(nvhelpreachstation.ignoreSearchFlag,nvhelpreachstation.Text)=1) then
  begin
    nvhelpSchedule.Perform(WM_KEYDOWN,KEY,0);
  end;
  if (Sender=nvhelpdepartstation)
    and (chkSellNet.Checked)
    and (nvhelpdepartstation.ignoreSearchFlag<>'')
    and (pos(nvhelpdepartstation.ignoreSearchFlag,nvhelpdepartstation.Text)=1) then
  begin
    nvhlpdepartdistrict.Perform(WM_KEYDOWN,KEY,0);
  end;
  if (key=VK_UP)
    and (not nvhelpreachstation.isactive)
    and (not nvhelpSchedule.isactive)
    and (not nvhelpdepartstation.isactive)
    and (not nvhlpdepartdistrict.isactive)
    and ((dtpdepartdate.MaxDate = 0.0) or (Trunc(dtpdepartdate.Date)+1 <= dtpdepartdate.MaxDate)) then
  begin
    dtpdepartdate.DateTime:=IncDay(trunc(dtpdepartdate.Date));
    setDepartDateColor;
    findSchedule;
  end
  else if (key=VK_DOWN)
    and (not nvhelpreachstation.isactive)
    and (not nvhelpSchedule.isactive)
    and (not nvhelpdepartstation.isactive)
    and (not nvhlpdepartdistrict.isactive)
    and ((dtpdepartdate.MinDate = 0.0) or (Trunc(dtpdepartdate.Date)-1 >= dtpdepartdate.MinDate)) then
  begin
    dtpdepartdate.DateTime:=IncDay(trunc(dtpdepartdate.Date),-1);
    setDepartDateColor;
    findSchedule;
  end;
end;

procedure TFrmTicketQuery.btnclearvipinfoClick(Sender: TObject);
begin
  inherited;
  clearvipinfo;
  if (lastActiveControls.Count>0) and (lastActiveControls.Peek<>nil) then
  begin
    if lastActiveControls.Peek.CanFocus then
      lastActiveControls.Peek.SetFocus;
  end
  else
    defaultThroughControl.Items[0].SetFocus;
end;

procedure TFrmTicketQuery.Button1Click(Sender: TObject);
var
  winControl:TWinControl;
  id:int64;
begin
  inherited;
  winControl:=GetParentForm(self).ActiveControl;
  if winControl<>nvdbgrdhschedule then
      begin
//        EnterOccurActiveChange:=true;
        GoToNextControl(winControl,false,false);
      end;
  id:=dsSchedule.DataSet.FieldByName('id').AsLargeInt;
  findSchedule;
  dsSchedule.DataSet.Locate('id',id,[]);
end;

procedure TFrmTicketQuery.clearvipinfo;
begin
  pnlvip.Visible:=false;
  lblvipcardno.Caption:='';
  lblvipname.Caption:='';
  lblvipcardtype.Caption:='';
  lblviptel.Caption:='';
  lblviplastmoney.Caption:='0';
  lblviplastamount.Caption:='0';
end;

procedure TFrmTicketQuery.vipcardfound(vipCard: TVipCard);
begin
  pnlvip.Visible:=true;
  lblvipcardno.Caption:=vipCard.cardNo;
  lblvipcardtype.Caption:=getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption:=currtostr(vipCard.money);
  lblviplastamount.Caption:=currtostr(vipCard.amount);
  //查询数据库
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno']:=vipCard.cardNo;
    open;
    if RecordCount=0 then
    begin
      SysDialogs.Warning('打不到卡号为'+vipCard.cardNo+'的信息，可能是该卡的状态异常。');
      clearvipinfo;
    end
    else
    begin
      lblvipname.Caption:=FieldByName('name').AsString;
      lblviptel.Caption:=FieldByName('mobilephone').AsString;
    end;
  end;
end;


procedure TFrmTicketQuery.tbtnInsertClick(Sender: TObject);
var schcode,sccode,depdate,deptime:string;
    schid,scplanid,isnet,departStationId,reachStationId:Int64;
    totalseatnum,soldseatnum,residuesseatnum,districtcode,worktypeflag:string;
    netseatnum,autoreserveseatnum,unautoreserveseatnum,fixreserveseatnum:Int64;
    netsoldnum,netreserved,netresidueseatnum:Int64;
    islinework:Boolean;
begin
  inherited;
  if not dsSchedule.DataSet.Active then
    Exit;
  if dsSchedule.DataSet.RecordCount = 0 then
    Exit;
    sccode := dsSchedule.DataSet.FieldByName('schedulesynccode').AsString;
    schcode := dsSchedule.DataSet.FieldByName('schedulecode').AsString;
    depdate := dsSchedule.DataSet.FieldByName('departdate').AsString;
    deptime := dsSchedule.DataSet.FieldByName('departtime').AsString;
    scplanid := dsSchedule.DataSet.FieldByName('scheduleplanid').AsLargeInt;
    schid := dsSchedule.DataSet.FieldByName('scheduleid').AsLargeInt;
    worktypeflag :=  dsSchedule.DataSet.FieldByName('worktype').AsString;
    islinework := dsSchedule.DataSet.FieldByName('islinework').Asboolean;
    departStationId := nvhelpdepartstation.Id;
    reachStationId := nvhelpreachstation.Id;
    if nvhlpdepartdistrict.Id > 0 then
    begin
      districtcode := nvhlpdepartdistrict.HelpFieldValue['Code'];
    end;
  FrmTicketQueryDetail := TFrmTicketQueryDetail.Create(self);
  with FrmTicketQueryDetail do
  begin
      with jcdsAskScheduleDetail do
      begin
        Active := False;
          if chkSellNet.Checked then
          begin
              Params.ParamValues['isnet']:=1 ; //1本集团联网
          end
          else
          begin
             Params.ParamValues['isnet']:=0 ; //0不联网
          end;
          Params.ParamValues['scheduleDetail.scheduleplanid'] := scplanid;
          Params.ParamValues['scheduleDetail.scheduleid'] := schid;
          Params.ParamValues['scheduleDetail.schedulesynccode'] := sccode;
          Params.ParamValues['scheduleDetail.departtime'] :=  deptime;
          Params.ParamValues['scheduleDetail.departDate'] :=  depdate;
          Params.ParamValues['scheduleDetail.departStationId'] := departStationId;
          Params.ParamValues['scheduleDetail.reachStationId'] := reachStationId;
          Params.ParamValues['scheduleDetail.districtcode'] := districtcode;
          Params.ParamValues['scheduleDetail.worktype'] := worktypeflag;
          Params.ParamValues['scheduleDetail.islinework'] := islinework;
          Params.ParamValues['scheduleDetail.flag'] := 1;
        Active := true;
        netseatnum := Params.ParamByName('seatnum').AsLargeInt;
        netsoldnum := Params.ParamByName('soldnum').AsLargeInt;
        netreserved :=  Params.ParamByName('reserved').AsLargeInt;
        netresidueseatnum :=  Params.ParamByName('residueseatnum').AsLargeInt;
      end;
  end;
    //刷新更新后的售票数
    Button1Click(sender);
    //联网查询时如果有配载班次，更新票数
    if netseatnum=0 then
    begin
       totalseatnum := dsSchedule.DataSet.FieldByName('seatnum').AsString;
    end
    else
    begin
       totalseatnum := inttostr(netseatnum);
    end;
    if netsoldnum=0 then
    begin
       soldseatnum := dsSchedule.DataSet.FieldByName('soldeatnum').AsString;
    end
    else
    begin
       soldseatnum := inttostr(netsoldnum);
    end;
     if netresidueseatnum=0 then
    begin
       residuesseatnum:=dsSchedule.DataSet.FieldByName('residueseatnum').AsString;
    end
    else
    begin
       residuesseatnum:=inttostr(netresidueseatnum);
    end;

    autoreserveseatnum := dsSchedule.DataSet.FieldByName('autocancelreserveseatnum').AsLargeInt;
    unautoreserveseatnum:=dsSchedule.DataSet.FieldByName('unautocancelreserveseatnum').AsLargeInt;
    fixreserveseatnum:= dsSchedule.DataSet.FieldByName('fixedreserveseatnum').AsLargeInt;

    if netreserved=0 then
    begin
      FrmTicketQueryDetail.lbl14.Caption := inttostr(autoreserveseatnum+unautoreserveseatnum+fixreserveseatnum);
    end
    else
    begin
       FrmTicketQueryDetail.lbl14.Caption := inttostr(netreserved);
    end;

    FrmTicketQueryDetail.lbl101.Caption := schcode;
    FrmTicketQueryDetail.lbl12.Caption := totalseatnum;
    FrmTicketQueryDetail.lbl13.Caption := soldseatnum;
    FrmTicketQueryDetail.lbl15.Caption := residuesseatnum;
 
  with FrmTicketQueryDetail do
  begin
      with jcdsAskDetail do
      begin
        Active := False;
          if chkSellNet.Checked then
          begin
              Params.ParamValues['isnet']:=1 ; //1本集团联网
          end
          else
          begin
             Params.ParamValues['isnet']:=0 ; //0不联网
          end;
          Params.ParamValues['scheduleDetail.scheduleplanid'] := scplanid;
          Params.ParamValues['scheduleDetail.scheduleid'] := schid;
          Params.ParamValues['scheduleDetail.schedulesynccode'] := sccode;
          Params.ParamValues['scheduleDetail.departtime'] :=  deptime;
          Params.ParamValues['scheduleDetail.departDate'] :=  depdate;
          Params.ParamValues['scheduleDetail.departStationId'] := departStationId;
          Params.ParamValues['scheduleDetail.reachStationId'] := reachStationId;
          Params.ParamValues['scheduleDetail.districtcode'] := districtcode;
          Params.ParamValues['scheduleDetail.worktype'] := worktypeflag;
          Params.ParamValues['scheduleDetail.islinework'] := islinework;
          Params.ParamValues['scheduleDetail.flag'] := 2;
        Active := true;
      end;

      ShowModal;

  end;

end;

procedure TFrmTicketQuery.tmrrefreshscheduleTimer(Sender: TObject);
var
  id:Int64;
begin
  inherited;
  id:=dsSchedule.DataSet.FieldByName('id').AsLargeInt;
  findSchedule;
  dsSchedule.DataSet.Locate('id',id,[]);
end;

end.
