 unit UFrmChangeTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmSellTicket, DBGridEhGrouping, Menus, ExtCtrls, DB, ComCtrls,
  Spin, StdCtrls, NovaEdit, NovaHelp, GridsEh, DBGridEh, NvDbgridEh,
  SellTicket, DBClient, jsonClientDataSet,UDMPublic,services,StrUtils, Buttons,
  FunctionItemIntf;

type
  TFrmChangeTicket = class(TFrmSellTicket)
    gbTicketToBeChange: TGroupBox;
    nvedtTicketToBeChange: TNovaEdit;
    jcdsfindTicket: TjsonClientDataSet;
    nvdbgrdhTicketSelect: TNvDbgridEh;
    dsticketselect: TDataSource;
    jcdslineworkIsdepart: TjsonClientDataSet;
    procedure nvhelpreachstationIdChange(Sender: TObject);
    procedure nvedtTicketToBeChangeExit(Sender: TObject);
    procedure pnlscheduleResize(Sender: TObject);
    procedure dsticketselectDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure jcdsfindTicketAfterOpen(DataSet: TDataSet);
    procedure nvedtTicketToBeChangeChange(Sender: TObject);
    procedure nvdbgrdhTicketSelectExit(Sender: TObject);
    procedure nvedtTicketToBeChangeKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Ftotalselectpremium:Currency;
    Ftotalselectprice:Currency;
    FSelectTicketIds:Tstringlist;  //选择要改签的车票ID列表
    FSelectInsuranceIds:Tstringlist;
    canchangeafterdeparted:Boolean;
    canchangeafterchanged:Boolean; //1507 是否是能改签一次
    selectcount_vipmoneypay:integer;//要改签的车票中是VIP余额支付的票张数
    function queryTicket:boolean;
    function checkTicketSelect:Boolean;
  protected
//    FcdsDDDsellway:TjsonClientDataSet;  //售票方式
    FcdsDDDticketstatus:TjsonClientDataSet;  //车票状态
    procedure initThroughControl();override;
    procedure findSchedule();override;
    procedure reset;override;//重置界面
    procedure ticketnumChange(Sender:TObject);override;
    function collectdataToTicketBuffer:boolean;override;
    function savetobuffer:boolean;override;
    procedure setInsuranceInfo(cdsInsuranceBuffer:TDataSet);override;
    function showReceiptBox:boolean;override;  //显示收钱对话框
    procedure setContextHint(winControl:TWinControl);override;//设置上下文提示
    procedure ActiveChanged; override;
    function setBillNoCondition(billnoEdit: TNovaEdit): boolean;
    procedure initjcdsfindTicket;
    procedure setNvdbgrdhTicketSelectVisible(visible:boolean);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); override;
  end;

var
  FrmChangeTicket: TFrmChangeTicket;

implementation
uses PubFn, Ufrmchangeticketend, SellWayEnd;

{$R *.dfm}

procedure TFrmChangeTicket.ActiveChanged;
begin
  inherited;
end;

function TFrmChangeTicket.queryTicket: boolean;
var ispermitlinework:String;
begin
  result:=false;
  nvedtTicketToBeChange.Id:=0;
  if trim(nvedtTicketToBeChange.Text)='' then
  begin
    SysDialogs.Warning('请输入要改签的车票票号!');
  end
  else
  begin
    with jcdsfindTicket do
    begin
      active:=false;
      Params.Clear;
      if not setBillNoCondition(nvedtTicketToBeChange) then exit;
//      Params.ParamValues['filter_EQS_t!ticketno']:=trim(nvedtTicketToBeChange.Text);
      active:=true;

      if RecordCount=0 then
      begin
        SysDialogs.Warning('您输入的车票票号不存在!');
      end
      else
       //控制流水线班次是否可以改签
        if (pubfn.getParametervalue('1518',sysinfo.LoginUserInfo.OrgID)='0') and (jcdsfindTicket.FieldValues['islinework']) then
        begin
//          showmessage(jcdsfindTicket.FieldValues['departdate']);
           with jcdslineworkIsdepart do
           begin
              Active:=false;
              Params.ParamValues['ticketno']:= nvedtTicketToBeChange.Text;
              Params.ParamValues['departdate']:= jcdsfindTicket.FieldValues['departdate'];
              Execute;
              ispermitlinework := Params.ParamValues['isexitlinework'] ;
              if StrToBool(ispermitlinework) then
                 SysDialogs.Warning('有发班记录流水线班次不允许改签!')
              else
              begin
                 Result:=true;
                 setNvdbgrdhTicketSelectVisible(True);
              end;
           end;

        end
       else
       begin
//        if not checkTicketSelect then
//        begin
//          SysDialogs.Warning('您输入的车票不允许改签，可能的原因有：已经检票、退票、废票、已经改签过一次、车票所在班次已发班不允许改签、团体票不允许改签');
//        end
//        else
//        begin
//          Result:=true;
//        end;
        Result:=true;
        // 显示列表供用户选择
        setNvdbgrdhTicketSelectVisible(True);
      end;
    end;
  end;
end;

function TFrmChangeTicket.checkTicketSelect: Boolean;
var oppositeorgid:Int64;
    selectcount:integer;
    tmpscheduleplanid:Int64;
    tmpreachstationid:Int64;
    bookmark:TBookmark;
begin
  Result:=false;
  if (not jcdsfindTicket.Active) or (jcdsfindTicket.RecordCount=0) then exit;
  oppositeorgid:=0;
  selectcount:=0;
  selectcount_vipmoneypay:=0;
  Ftotalselectpremium:=0;
  Ftotalselectprice:=0;
  tmpscheduleplanid:=0;
  tmpreachstationid:=0;
  FSelectTicketIds.Clear;
  FSelectInsuranceIds.Clear;

  // 判断选中的记录数
  with jcdsfindTicket do
  begin
    bookmark:=GetBookmark;
    DisableControls;
    First;
    while not eof do
    begin
      if fieldbyname('isselected').AsBoolean then
      begin
        //判断是否售的同一个车站的票
        if (fieldbyname('sellby').AsInteger=0) then
        begin
          if oppositeorgid=0 then
          begin
            oppositeorgid:=FieldValues['orgid'];
          end
          else if oppositeorgid<>FieldValues['orgid'] then
          begin
            SysDialogs.Warning('改签不能同时改不同车站购买的车票!');
            GotoBookmark(bookmark);
            EnableControls;
            FSelectTicketIds.Clear;
            FSelectInsuranceIds.Clear;
            exit;
          end;
        end;
        //判断是否同线路同到站
        if tmpscheduleplanid=0 then
        begin
          tmpscheduleplanid:=FieldValues['scheduleplanid'];
        end
        else if tmpscheduleplanid<>FieldValues['scheduleplanid'] then
        begin
          SysDialogs.Warning('改签不能同时改不同班次的车票!');
          GotoBookmark(bookmark);
          EnableControls;
          FSelectTicketIds.Clear;
          FSelectInsuranceIds.Clear;
          exit;
        end;
        if tmpreachstationid=0 then
        begin
          tmpreachstationid:=FieldValues['reachstationid'];
        end
        else if tmpreachstationid<>FieldValues['reachstationid'] then
        begin
          SysDialogs.Warning('改签不能同时改不同到站的车票!');
          GotoBookmark(bookmark);
          EnableControls;
          FSelectTicketIds.Clear;
          FSelectInsuranceIds.Clear;
          exit;
        end;
        if FieldByName('paymethod').AsString='2' then inc(selectcount_vipmoneypay);

        if (not FieldByName('insuranceid').IsNull)
          and (FieldByName('insuranceid').AsLargeInt>0) then
        begin
          Ftotalselectpremium:=Ftotalselectpremium+fieldbyname('premium').AsCurrency;
        end;
        Ftotalselectprice:=Ftotalselectprice+fieldbyname('price').AsCurrency;
        FSelectTicketIds.Add(FieldByName('id').AsString);
        FSelectInsuranceIds.Add(nvl(FieldByName('insuranceid').Value,'0'));
        Inc(selectcount);
      end;
      next;
    end;
    GotoBookmark(bookmark);
    EnableControls;
    //VIP余额支付的车票不能和其它方式支付的车票同时改签
    if (selectcount_vipmoneypay>0) and (selectcount_vipmoneypay<selectcount) then
    begin
      SysDialogs.Warning('VIP余额支付的车票不能和其它方式支付的车票同时改签!');
      FSelectTicketIds.Clear;
      FSelectInsuranceIds.Clear;
      exit;
    end;
  end;
  result:=selectcount>0;
end;

function TFrmChangeTicket.collectdataToTicketBuffer: boolean;
begin
  result:=inherited;
  if FSelectTicketIds.Count>0 then
  begin
    with TjsonClientDataSet(dsTicketBuffer.DataSet) do
    begin
      Params.ParamValues['ticketIdToBeChanges']:= FSelectTicketIds.CommaText;
//      Params.ParamValues['insuranceIdToBeChanges']:= FSelectInsuranceIds.CommaText;
      Params.ParamValues['order.totalmoney']:=CurrToStr(getTotalreceivablenum);
    end;
    result:=true;
  end
  else
  begin
    SysDialogs.ShowInfo('改签必需输入正确的票号!');
    result:=false;
  end;
end;

constructor TFrmChangeTicket.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;
  checkpermission: boolean);
begin
  inherited;
  initjcdsfindTicket;
end;

procedure TFrmChangeTicket.dsticketselectDataChange(Sender: TObject;
  Field: TField);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then exit;
  if (field.FieldName='isselected') then
  begin
    if (field.DataSet.FieldByName('ticketstatus').AsString<>'0')
      or (field.DataSet.fieldbyname('ischecked').AsBoolean)
      or (field.DataSet.fieldbyname('ischanged').AsBoolean and (not canchangeafterchanged))
      or ((not canchangeafterdeparted) and field.DataSet.fieldbyname('isdeparted').AsBoolean)
      or (field.DataSet.FieldByName('tickettype').AsString='T')
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

procedure TFrmChangeTicket.findSchedule;
var condition: ScheduleAskCondition;
begin
//  inherited;
  if (sellTicket=nil) then exit;
  if ((nvhelpreachstation.Id=0) and (nvhelpSchedule.Id=0)) then
  begin
    if dsSchedule.DataSet<>nil then
    begin
      dsSchedule.DataSet.Close;
    end;
  end
  else
  begin
    checkTicketSelect;
    if (FSelectTicketIds.Count<=0) then
    begin
      if nvdbgrdhTicketSelect.Visible then
      begin
        SysDialogs.ShowInfo('请先选择要改签的车票!');
        nvdbgrdhTicketSelect.SetFocus;
      end
      else
      begin
        SysDialogs.ShowInfo('请先输入要改签的正确票号!');
        nvedtTicketToBeChange.SetFocus;
      end;
      nvhelpreachstation.Text:='';
      nvhelpreachstation.Id:=0;
      exit;
    end;
    condition:=ScheduleAskCondition.Create;
    with condition do
    begin
      departDate:=dtpdepartdate.Date;
      departStationId:=nvhelpdepartstation.Id;
      reachStationId:=nvhelpreachstation.Id;
      ScheduleId:=nvhelpSchedule.Id;
      ticketIdToBeChange:=StrToInt64(FSelectTicketIds.Strings[0]);
    end;
    sellTicket.findSchedule(condition);
    if dsSchedule.DataSet=nil then
      dsSchedule.DataSet:=sellTicket.cdsSchedule;
  end;
end;

procedure TFrmChangeTicket.FormActivate(Sender: TObject);
begin
  //inherited;
  if  not pnlreceipt.Visible then
  begin
    nvedtTicketToBeChange.SetFocus;
  end;
end;

procedure TFrmChangeTicket.FormCreate(Sender: TObject);
begin
  inherited;
  selectcount_vipmoneypay:=0;
//  FcdsDDDsellway:=createCdsDDD('ticketsell','sellway',self);  //售票方式
  FcdsDDDticketstatus:=createCdsDDD('ticketsell','ticketstatus',self);  //车票状态
  canchangeafterdeparted:=pubfn.getParametervalue('1503',sysinfo.LoginUserInfo.OrgID)='1';
  FSelectTicketIds:=Tstringlist.Create;
  FSelectInsuranceIds:=TStringList.Create;
  canchangeafterchanged:=pubfn.getParametervalue('1507',sysinfo.LoginUserInfo.OrgID)='0';
end;

procedure TFrmChangeTicket.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Screen.ActiveControl=nvedtTicketToBeChange) and (Key='-') then
  begin
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmChangeTicket.initThroughControl;
begin
  inherited;
  defaultThroughControl.Insert(0,nvedtTicketToBeChange);
  fullThroughControl.Insert(0,nvedtTicketToBeChange);
  defaultThroughControl.Insert(1,nvdbgrdhTicketSelect);
  fullThroughControl.Insert(1,nvdbgrdhTicketSelect);
end;

procedure TFrmChangeTicket.jcdsfindTicketAfterOpen(DataSet: TDataSet);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  with DataSet do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      if FieldByName('isselected').Value=0 then
      begin
        edit;
        oldOnDataChange:=dsticketselect.OnDataChange;
        dsticketselect.OnDataChange:=nil;
        if (not canchangeafterdeparted) and fieldbyname('isdeparted').AsBoolean then
        begin
          FieldByName('isselected').Value:=null;
        end
        else
        begin
          FieldByName('isselected').Value:=1;
        end;
        dsticketselect.OnDataChange:=oldOnDataChange;
        post;
      end;
      Next;
    end;
    First;
    EnableControls;
  end;
end;

procedure TFrmChangeTicket.nvdbgrdhTicketSelectExit(Sender: TObject);
begin
  inherited;
//  if (screen.ActiveControl<>nil) and (GetParentForm(screen.ActiveControl,false)=self) and (not checkTicketSelect) then
//  begin
//    SysDialogs.ShowInfo('请先选择要改签的车票!');
//    nvdbgrdhTicketSelect.SetFocus;
//  end;
end;

procedure TFrmChangeTicket.nvedtTicketToBeChangeChange(Sender: TObject);
begin
  inherited;
  setNvdbgrdhTicketSelectVisible(false);
end;

procedure TFrmChangeTicket.nvedtTicketToBeChangeExit(Sender: TObject);
begin
  inherited;
  if pnlreceipt.Visible then exit;
  if (screen.ActiveControl<>nil) and (GetParentForm(screen.ActiveControl,false)=self) and (not queryTicket) then
  begin
    nvedtTicketToBeChange.SetFocus;
  end;
end;

procedure TFrmChangeTicket.nvedtTicketToBeChangeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
//  if Key=#13 then
//  begin
//  end;
  if (not (key in ['0'..'9','-',',',#8,#1,#3,#$16,#$18])) then
  begin
    key:=#0;
  end;
end;

procedure TFrmChangeTicket.nvhelpreachstationIdChange(Sender: TObject);
begin
  inherited;
//  findSchedule;
end;

procedure TFrmChangeTicket.pnlscheduleResize(Sender: TObject);
begin
  inherited;
  if nvdbgrdhTicketSelect.Visible then
  begin
    nvdbgrdhTicketSelect.Height:=100;
    nvdbgrdhschedule.Height:=nvdbgrdhschedule.Height-nvdbgrdhTicketSelect.Height;
    nvdbgrdhTicketSelect.Left:=nvdbgrdhschedule.Left;
    nvdbgrdhTicketSelect.Top:=nvdbgrdhschedule.Top+nvdbgrdhschedule.Height;
    nvdbgrdhTicketSelect.Width:=nvdbgrdhschedule.Width;
  end;
end;

procedure TFrmChangeTicket.reset;
begin
  inherited;
  nvedtTicketToBeChange.Text:='';
  Ftotalselectpremium:=0;
  Ftotalselectprice:=0;
  FSelectTicketIds.Clear;
  FSelectInsuranceIds.Clear;
end;

procedure TFrmChangeTicket.setContextHint(winControl: TWinControl);
begin
  if winControl=nvedtTicketToBeChange then
  begin
    //lblContextHint.Caption:='输入或扫描,输入多张票号请用,或-分隔符';
    appendAllContextHint;
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmChangeTicket.setInsuranceInfo(cdsInsuranceBuffer:TDataSet);
var
  tickettype:String;
begin
  inherited;
  if FSelectTicketIds.Count>0 then
  begin
    with cdsInsuranceBuffer do
    begin
      first;
      while not eof do
      begin
        edit;

        //如果需要改签的票没有出售保险，则按票价拉出对应的保险类型
        tickettype:= jcdsfindTicket.FieldByName('tickettype').AsString;
        if jcdsfindTicket.FieldByName('insuranceno').AsString='' then
        begin
          if getParametervalue('1060',SysInfo.LoginUserInfo.OrgID) = '0'  then
          begin
            SellTicket.cdsinsuretype.First;
            while not SellTicket.cdsinsuretype.Eof do
            begin
               if (dsSchedule.DataSet.FieldByName
                        ('distance').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                  and (dsSchedule.DataSet.FieldByName
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
             if tickettype='B' then
             begin
                SellTicket.cdsinsuretype.First;
                while not SellTicket.cdsinsuretype.Eof do
                begin
                  if (dsSchedule.DataSet.FieldByName
                        ('halfprice').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                     and (dsSchedule.DataSet.FieldByName
                        ('halfprice').AsLargeInt<=SellTicket.cdsinsuretype.FieldValues['endamount']) then
                  begin
                     FieldValues['insuretypeid'] := SellTicket.cdsinsuretype.FieldValues['id'];
                     Break;
                  end;
                  SellTicket.cdsinsuretype.next;
                end;
             end
             else if tickettype='S' then
             begin
                SellTicket.cdsinsuretype.First;
                while not SellTicket.cdsinsuretype.Eof do
                begin
                  if (dsSchedule.DataSet.FieldByName
                        ('studentprice').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                     and (dsSchedule.DataSet.FieldByName
                        ('studentprice').AsLargeInt<=SellTicket.cdsinsuretype.FieldValues['endamount']) then
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
                  if (dsSchedule.DataSet.FieldByName
                        ('fullprice').AsLargeInt>=SellTicket.cdsinsuretype.FieldValues['fromamount'])
                     and (dsSchedule.DataSet.FieldByName
                        ('fullprice').AsLargeInt<=SellTicket.cdsinsuretype.FieldValues['endamount']) then
                  begin
                     FieldValues['insuretypeid'] := SellTicket.cdsinsuretype.FieldValues['id'];
                     Break;
                  end;
                  SellTicket.cdsinsuretype.next;
                end;
             end

          end;
        end
        else
        begin
          FieldValues['insuretypeid']:=jcdsfindTicket.FieldValues['insuretypeid'];
        end;

        FieldValues['customerid']:=jcdsfindTicket.FieldValues['customerid'];
        FieldValues['customername']:=jcdsfindTicket.FieldValues['customername'];
        if jcdsfindTicket.FieldValues['certificatetype']=null then
          FieldValues['certificatetype']:='0'
        else
          FieldValues['certificatetype']:=jcdsfindTicket.FieldValues['certificatetype'];
        FieldValues['certificateno']:=jcdsfindTicket.FieldValues['certificateno'];
        if State=dsEdit then
        begin
          post;
        end;
        next;
      end;
    end;
  end;
end;

procedure TFrmChangeTicket.setNvdbgrdhTicketSelectVisible(visible: boolean);
begin
  nvdbgrdhTicketSelect.Visible:=visible;
  pnlscheduleResize(pnlschedule);
  if nvdbgrdhTicketSelect.Visible then
  begin
    if not defaultThroughControl.Contains(nvdbgrdhTicketSelect) then
    begin
      defaultThroughControl.Insert(1,nvdbgrdhTicketSelect);
    end;
    if not fullThroughControl.Contains(nvdbgrdhTicketSelect) then
    begin
      fullThroughControl.Insert(1,nvdbgrdhTicketSelect);
    end;
    nvdbgrdhTicketSelect.SetFocus;
  end
  else
  begin
    if defaultThroughControl.Contains(nvdbgrdhTicketSelect) then
    begin
      defaultThroughControl.Remove(nvdbgrdhTicketSelect);
    end;
    if fullThroughControl.Contains(nvdbgrdhTicketSelect) then
    begin
      fullThroughControl.Remove(nvdbgrdhTicketSelect);
    end;
  end;
end;

function TFrmChangeTicket.showReceiptBox:boolean;
begin
  result:=false;
  if FSelectTicketIds.Count=0 then
  begin
    if nvdbgrdhTicketSelect.Visible then
    begin
      SysDialogs.ShowInfo('请先选择要改签的车票!');
      nvdbgrdhTicketSelect.SetFocus;
    end
    else
    begin
      SysDialogs.ShowInfo('请先输入要改签的正确票号!');
      nvedtTicketToBeChange.SetFocus;
    end;
    Exit;
  end;
  if FSelectTicketIds.Count<>curNeedSellNum then
  begin
    SysDialogs.ShowInfo('改签的票数不等于售出的票数!');
    seTicketNum_Q.SetFocus;
    Exit;
  end;

  if not checkTicketSelect then
  begin
    SysDialogs.Warning('您选择的车票不允许改签，可能的原因有：已经检票、退票、废票、已经改签过一次、车票所在班次已发班不允许改签、团体票不允许改签');
    exit;
  end;

  result:=inherited;
  if not result then exit;
  with  (SellWayEnd as Tfrmchangeticketend) do
  begin
    lblTicketreturn.caption:=CurrToStr(Ftotalselectprice);
//    lblinsurereturn.caption:=CurrToStr(Ftotalselectpremium); //原保险应退
    lblreceivablenum.Caption:=CurrToStr(getTotalreceivablenum);
    nvedtreceiptChange(nil);
  end;
  SellWayEnd.show;
  pnlreceipt.BringToFront;
end;

procedure TFrmChangeTicket.ticketnumChange(Sender: TObject);
begin
  inherited;
  if curNeedSellNum>FSelectTicketIds.Count then
  begin
    curNeedSellNum:=curNeedSellNum-(Sender as Tspinedit).Value;
    (Sender as Tspinedit).Value:=0;
    (Sender as Tspinedit).SelectAll;
//    (Sender as Tspinedit).SetFocus;
  end
  else if (Sender=nil) and (curNeedSellNum<FSelectTicketIds.Count) and (seTicketNum_Q<>nil) then
  begin
    seTicketNum_Q.Value:=seTicketNum_Q.Value+(FSelectTicketIds.Count-curNeedSellNum);
  end;
end;

function TFrmChangeTicket.savetobuffer: boolean;
begin
  Result:=checkTicketSelect;
  if not Result then
  begin
    SysDialogs.ShowInfo('请先选择要改签的车票!');
    exit;
  end;
  if (selectcount_vipmoneypay>0)
    and ((self.SellWayEnd as Tfrmchangeticketend).nvcbbpayment.ItemIndex<>2) then
  begin
    Result:=false;
    SysDialogs.ShowMessage('要改签的车票是VIP余额支付，售票方式必需是VIP余额支付');
    exit;
  end;
  if (selectcount_vipmoneypay=0)
    and ((self.SellWayEnd as Tfrmchangeticketend).nvcbbpayment.ItemIndex=2) then
  begin
    Result:=false;
    SysDialogs.ShowMessage('要改签的车票非VIP余额支付，售票方式不能是VIP余额支付');
    Exit;
  end;
  Result := inherited;
end;

function TFrmChangeTicket.setBillNoCondition(billnoEdit: TNovaEdit): boolean;
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
  conditionstr:='t!ticketno';
  billcode:='Ticket';
  with jcdsfindTicket do
  begin
    if trim(billnoEdit.Text)='' then
    begin
      SysDialogs.ShowInfo('请输入要改签的票号');
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
    params.CreateParam(ftString,'filter_GED_t!departdate',ptInput);
    params.ParamValues['filter_GED_t!departdate']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',trunc(now-7));
  end;
  result:=true;
end;

procedure TFrmChangeTicket.initjcdsfindTicket;
var i:integer;
begin
  with jcdsfindTicket do
  begin
    i:=-1;
    createField('isselected', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;
    createField('id', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('scheduleplanid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('sellby', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('departstationid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('reachstationid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('scheduleid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('insuranceid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;

    createField('seatno', '', ftInteger,0, incEx(i), jcdsfindTicket) ;

    createField('ischecked', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;
    createField('islinework', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;

    createField('selltime', '', ftDateTime,0, incEx(i), jcdsfindTicket) ;
    createField('departdate', '', ftDate,0, incEx(i), jcdsfindTicket) ;

    createField('premium', '', ftFloat,0, incEx(i), jcdsfindTicket) ;
    createField('price', '', ftFloat,0, incEx(i), jcdsfindTicket) ;
//    createField('servicefee', '', ftFloat,0, incEx(i), jcdsfindTicket) ;

    createField('departtime', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('paymethod', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('ticketno', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
//    createField('sellway', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('ticketstatus', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('tickettype', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('insurancepaymethod', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('insuranceno', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
//    createField('sellbyname', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
//    createField('schedulecode', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('customername', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('departstationname', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('reachstationname', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('status', '', ftWideString,10, incEx(i), jcdsfindTicket) ;

    createField('orgid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('carrychildnum', '', ftInteger,0, incEx(i), jcdsfindTicket) ;
    createField('ticketoutletsid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('customerid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('insuretypeid', '', ftLargeint,0, incEx(i), jcdsfindTicket) ;
    createField('isdeparted', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;
    createField('ischanged', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;
    createField('isroundtrip', '', ftBoolean,0, incEx(i), jcdsfindTicket) ;
    createField('certificateno', '', ftWideString,40, incEx(i), jcdsfindTicket) ;
    createField('certificatetype', '', ftWideString,10, incEx(i), jcdsfindTicket) ;
    createField('returntripvaliddays', '', ftInteger,0, incEx(i), jcdsfindTicket) ;
    createLookupField('tickettypeprintname','','tickettype','code','printname',ftWideString,50,incEx(i),jcdsfindTicket,sellTicket.cdsTicketType);
    createLookupField('paymethodname','','paymethod','code','value',ftWideString,50,incEx(i),jcdsfindTicket,sellTicket.cdsDDDpaymethod);
    createLookupField('insurancepaymethodname','','insurancepaymethod','code','value',ftWideString,50,incEx(i),jcdsfindTicket,sellTicket.cdsDDDpaymethod);
//    createLookupField('sellwayname','','sellway','code','value',ftWideString,50,incEx(i),jcdsfindTicket,FcdsDDDsellway);
    createLookupField('ticketstatusname','','ticketstatus','code','value',ftWideString,50,incEx(i),jcdsfindTicket,FcdsDDDticketstatus);
  end;
end;


end.
