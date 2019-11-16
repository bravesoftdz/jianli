unit UFrmMixCheckticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList, NovaHelp, ComCtrls, SeatPlan,
  Generics.Collections,UIDCardReader;

type
  TFrmMixCheckticket = class(TSimpleEditForm, IIDCardfound)
    GroupBox2: TGroupBox;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    NovaEdtTicketNo: TNovaEdit;
    Label2: TLabel;
    LabcurTostation: TLabel;
    LabcurSeatnum: TLabel;
    Label6: TLabel;
    LabcurPrice: TLabel;
    Shape1: TShape;
    Label11: TLabel;
    LabcurDepartdate: TLabel;
    Bevel7: TBevel;
    Bevel10: TBevel;
    Label21: TLabel;
    LabcurCode: TLabel;
    Label27: TLabel;
    LabcurDeparttime: TLabel;
    btnMixCheck: TBitBtn;
    BitBtn2: TBitBtn;
    jcsdQryTicket: TjsonClientDataSet;
    Label1: TLabel;
    jcsdMixCheckticket: TjsonClientDataSet;
    Label4: TLabel;
    dtpDepartdate: TDateTimePicker;
    NovaHelpSchedule: TNovaHelp;
    NovaEdtSeatno: TNovaEdit;
    Label5: TLabel;
    Label10: TLabel;
    pnl1: TPanel;
    LabmFromStation: TLabel;
    Label9: TLabel;
    LabmEndStation: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    LabSeatnum: TLabel;
    Label18: TLabel;
    LabSolds: TLabel;
    shp1: TShape;
    Label26: TLabel;
    LabOnDepartdate: TLabel;
    bvl5: TBevel;
    bvl6: TBevel;
    bvl7: TBevel;
    bvl8: TBevel;
    bvl9: TBevel;
    Label38: TLabel;
    LabCode: TLabel;
    Label15: TLabel;
    Label7: TLabel;
    LabVehicleNo: TLabel;
    Label8: TLabel;
    LabDepartTime: TLabel;
    bvl10: TBevel;
    pnlseatplan: TPanel;
    bvl3: TBevel;
    bvl4: TBevel;
    bvl11: TBevel;
    bvl12: TBevel;
    bvl13: TBevel;
    Label12: TLabel;
    Label13: TLabel;
    LabcurEntrance: TLabel;
    bvl14: TBevel;
    bvl15: TBevel;
    LabcurBuspark: TLabel;
    LabcurTicketStatus: TLabel;
    Label16: TLabel;
    LabcurFromStation: TLabel;
    Label19: TLabel;
    bvl16: TBevel;
    bvl17: TBevel;
    Label14: TLabel;
    LabCheckeds: TLabel;
    Label17: TLabel;
    LabNewSeatno: TLabel;
    Label20: TLabel;
    bvl18: TBevel;
    jscdQrySeatstatus: TjsonClientDataSet;
    jscdQryMixInfo: TjsonClientDataSet;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    LabSaler: TLabel;
    bvl19: TBevel;
    bvl20: TBevel;
    Label25: TLabel;
    LabSalertime: TLabel;
    LabInfo: TLabel;
    Label29: TLabel;
    jsCdqrycheckticketeds: TjsonClientDataSet;
    jcdsQryScheduleSeatstatus: TjsonClientDataSet;
    Label28: TLabel;
    edtcertificateno: TNovaEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnMixCheckClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dtpDepartdateChange(Sender: TObject);
    procedure NovaEdtSeatnoExit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure NovaEdtTicketNoKeyPress(Sender: TObject; var Key: Char);
    procedure NovaEdtTicketNoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    p3006:string;
    ischecked: boolean;
    isaddSeat: boolean;
    newseatno: Word;
    ticketid: int64;
    curselectedseatno: TList<Word>;
    selectSeatStatus: TList<string>;
    curSeatPlan: TSeatPlanChecked;
    checktickethelp: TSeatPicHelp;
    curidcard: TIDCard;
    procedure checkticket(ticketid: int64);
    procedure qryTicket(scheduleplanid: int64; seatno: Integer;
      ticketno: String;certificateno:string);
    procedure clearTicket;
    function validateTicket: boolean;
    function verifydepartstation: boolean;
    // procedure qryScheduleSeatstatus(scheduleplanid: int64);
    // 查询座位图的提示信息
    // function qryTicketsells(scheduleplanid: int64): string;
    // procedure clickseat(seatno: Word);
    procedure qrycheckedtickets();
    procedure clickseat(seatno: Word; ticketno: String; beforChecked: boolean;
      var afterChecked: boolean);
    procedure reflashseat(seats: Integer; brandModelid: int64);
    procedure cardfound(idcard: TIDCard);
  public
    { Public declarations }
    scheduleplanid, vehiclereportid, curbrandModelid: int64;
    isauthorlatetocur, ischeckbyseatnocur, newschisworkline,isrealnamemix: boolean;
    ticketentrance,inputdepartstationid:string;
  end;

var
  FrmMixCheckticket: TFrmMixCheckticket;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmMixCheckticket.BitBtn2Click(Sender: TObject);
begin
  inherited;
  ModalResult := mrok;
end;

procedure TFrmMixCheckticket.btnMixCheckClick(Sender: TObject);
begin
  inherited;
  if self.NovaEdtTicketNo.Text='' then exit;
  if isrealnamemix and (trim(edtcertificateno.text)='') then
  begin
    SysDialogs.ShowMessage('请输入证件号！');
    exit;
  end;

  if validateTicket then
  begin
    if (self.NovaEdtTicketNo.Text <> '') then
      qryTicket(0, 0, trim(NovaEdtTicketNo.Text),trim(edtcertificateno.text))
    else
    begin
      //SysDialogs.Warning('您输入票号不存在！');
        LabInfo.Caption:='您输入票号不存在或者已过检票日期！';
      LabInfo.Refresh;
      exit;
    end;
    {if  verifydepartstation then
    begin
        //SysDialogs.ShowMessage('发车站不匹配！请确认后再次检票！');
        LabInfo.Caption:='发车站不匹配！请确认后再次检票！';
        LabInfo.Refresh;
       Exit;
    end; }
    if(ticketid>0)then
        checkticket(ticketid)
    else
    begin
        LabInfo.Caption:='您输入票号不存在或者已过检票日期！';
        LabInfo.Refresh;
        exit;
    end;
  end;
end;

procedure TFrmMixCheckticket.checkticket(ticketid: int64);
var
  nResult, i: Integer;
  sResult: string;
  seatsState: TDictionary<Word, String>;
  isemptyseat: boolean;
begin
  { if (LabCode.Caption = LabcurCode.Caption) and
    ( LabOnDepartdate.Caption=LabcurDepartdate.Caption) then
    begin
    if LabcurSeatnum.Caption<>'' then
    curSeatPlan.locateBySeatNo(StrToInt(trim(LabcurSeatnum.Caption)));
    SysDialogs.Warning('同一班次不需要混检！');
    NovaEdtTicketNo.SetFocus;
    exit;
    end; }
  if ischecked then
  begin
    exit;
  end;
  if not isauthorlatetocur then
  begin
    if (LabcurDeparttime.Caption < LabDepartTime.Caption) then
    begin
      //SysDialogs.Warning('你没有权限把早班次混检到晚班次！');
      self.LabInfo.Caption:='你没有权限把早班次混检到晚班次！';
      NovaEdtTicketNo.SetFocus;
      exit;
    end;
  end;

  if (not newschisworkline) and (not isaddSeat) then
  begin
    isemptyseat := False;
    seatsState := curSeatPlan.getSeatsStatus;
    for i := 1 to seatsState.Count do
    begin
      if seatsState.Items[i] = '0' then
      begin
        isemptyseat := true;
        Break;
      end;
    end;

    if not isemptyseat then
    begin
      if (IntToStr(newseatno) = '')  or (LabNewSeatno.Caption = '') then
      begin
       // SysDialogs.Warning('请选择检入的座位号！');
        self.LabInfo.Caption:='请选择检入的座位号！';
        LabInfo.Refresh;
        exit;
      end;
    end;
  end;
  //20160325王远媛添加参数3006判断--0:非流水班次不能混检到流水班次 1:能
    if p3006='0' then
    begin
      if (newschisworkline) and (jcsdQryTicket.Fieldbyname('islinework').AsBoolean=False) then
      begin
        LabInfo.Caption:='非流水班次不能混检到流水班次！';
        LabInfo.Refresh;
        exit;
      end;
    end;
  try
    with jcsdMixCheckticket do
    begin
      active := False;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ticketid'] := ticketid;
      Params.ParamValues['newseatno'] := newseatno;
      Params.ParamValues['ticketentrance'] := ticketentrance;
      SysLog.WriteErr('ticketid333：' +inttostr(ticketid));
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin

        self.NovaEdtTicketNo.Clear;
        self.edtcertificateno.Clear;
        self.NovaEdtSeatno.Clear;
        LabInfo.Caption := sResult;
        if newschisworkline then
        begin
           qrycheckedtickets;
        end
        else
        begin
            checktickethelp.qryScheduleSeatstatus(scheduleplanid);
            checktickethelp.qrySeatstatus(scheduleplanid, False);
            curSeatPlan.seatsStatus := checktickethelp.seatsStatus;
            curSeatPlan.seatsTickettype := checktickethelp.seatsTickettype;
            curSeatPlan.seatsreachstationname := checktickethelp.seatStation;
            curSeatPlan.seatscolor := checktickethelp.seatscolor;
            if curSeatPlan.selectedSeats <> nil then
              curSeatPlan.selectedSeats.Clear;
            LabCheckeds.Caption := IntToStr(checktickethelp.checktickets);
            LabCheckeds.Refresh;
            curSeatPlan.Refresh;
        end;
        Application.ProcessMessages;
        NovaEdtTicketNo.SetFocus;
        newseatno:=0;
        // ModalResult := mrok;
      end
      else
      begin
//        SysDialogs.Warning(sResult);
        LabInfo.Caption:=sResult;
        LabInfo.Refresh;
        NovaEdtTicketNo.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('混检操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmMixCheckticket.clearTicket;
begin
  ticketid := 0;
  LabcurFromStation.Caption := '';
  LabcurTostation.Caption := '';
  LabcurSeatnum.Caption := '';
  LabcurPrice.Caption := '';
  LabcurDepartdate.Caption := '';
  LabcurEntrance.Caption := '';
  LabcurBuspark.Caption := '';
  LabcurTicketStatus.Caption := '';
  LabcurCode.Caption := '';
  LabcurDeparttime.Caption := '';
  LabNewSeatno.Caption := '';
  LabSaler.Caption := '';
  LabSalertime.Caption := '';
  self.Refresh;
  // LabcurRemark.Caption := '';
  // LabcurTickettype.Caption := '';
end;

procedure TFrmMixCheckticket.clickseat(seatno: Word; ticketno: String;
  beforChecked: boolean; var afterChecked: boolean);
begin
  if beforChecked then
  begin
    //
    //SysDialogs.ShowMessage('该车票已检！');
    LabInfo.Caption:='该车票已检！';
    LabInfo.Refresh;
    exit;
  end
  else
  begin
    curselectedseatno.Clear;
    curselectedseatno.Add(seatno);
    curSeatPlan.selectedSeats := curselectedseatno;
    curselectedseatno := curSeatPlan.getSelectedSeats;
    if curselectedseatno.Count > 0 then
    begin

      newseatno := curselectedseatno.Items[0];
      LabNewSeatno.Caption := IntToStr(newseatno);
    end
    else
    begin
      newseatno := 0;
      LabNewSeatno.Caption := '';
    end;
  end;
end;

procedure TFrmMixCheckticket.dtpDepartdateChange(Sender: TObject);
begin
  inherited;
  with NovaHelpSchedule do
  begin
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpDepartdate.Date);
  end;
end;

procedure TFrmMixCheckticket.FormActivate(Sender: TObject);
begin
  inherited;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
    Sysinfo.CardManage.ReadCardNo(self.edtcertificateno);
    Sysinfo.CardManage.StartRead;
  end;
end;

procedure TFrmMixCheckticket.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(selectSeatStatus) then
    selectSeatStatus.Free;
  checktickethelp.Free;
  curselectedseatno.Free;
  curSeatPlan.Free;
  inherited;
end;

procedure TFrmMixCheckticket.FormCreate(Sender: TObject);
begin
  inherited;
  LabmFromStation.Caption := '';
  LabmEndStation.Caption := '';
  LabSeatnum.Caption := '';
  LabOnDepartdate.Caption := '';
  // LabmEntrance.Caption := '';
  // LabmBusPark.Caption := '';
  // LabVehicletype.Caption := '';
  // LabVehicleNo.Caption := '';
  LabDepartTime.Caption := '';
  curSeatPlan := TSeatPlanChecked.Create(pnlseatplan);
  checktickethelp := TSeatPicHelp.Create;
  curselectedseatno := TList<Word>.Create;
  selectSeatStatus := TList<string>.Create;
  selectSeatStatus.Add('0');
  isrealnamemix := StrToBool(getParametervalue('3038',SysInfo.LoginUserInfo.OrgID)); //是否实名制检票
  if isrealnamemix then
  begin
     edtcertificateno.Visible:=True;
     Label28.Visible:=True;
     TIDCardReader.GetInstance.addObserver(self, false, true);
  end;

 { if getParametervalue('3010', Sysinfo.LoginUserInfo.OrgID)='0' then
  begin
    selectSeatStatus.Add('2');
  end; }
end;

procedure TFrmMixCheckticket.FormDeactivate(Sender: TObject);
begin
  inherited;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
  end;
end;

procedure TFrmMixCheckticket.FormDestroy(Sender: TObject);
begin
  inherited;
  TIDCardReader.GetInstance.removeObserver(self);
end;

procedure TFrmMixCheckticket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_escape) then
    Close;
end;

procedure TFrmMixCheckticket.FormShow(Sender: TObject);
var
  p3010:string;
begin
  inherited;
  clearTicket;
  p3010:=getParametervalue('3010', Sysinfo.LoginUserInfo.OrgID) ;
  if p3010= '1' then
    isaddSeat := true
  else
    isaddSeat := False;
  p3006:=getParametervalue('3006', sysInfo.LoginUserInfo.OrgID);
  dtpDepartdate.Date := now;
  dtpDepartdateChange(Sender);
  if not newschisworkline then
  begin
    checktickethelp.qryScheduleSeatstatus(scheduleplanid);
    checktickethelp.qrySeatstatus(scheduleplanid, False);
    curSeatPlan.seatsStatus := checktickethelp.seatsStatus;
    selectSeatStatus.Clear;
    selectSeatStatus.Add('0');
    if p3010='0' then
    begin
      selectSeatStatus.Add('2');
    end;
    curSeatPlan.selectSeatStatus := selectSeatStatus;
    curSeatPlan.seatsTickettype := checktickethelp.seatsTickettype;
    curSeatPlan.seatsreachstationname := checktickethelp.seatStation;
    curSeatPlan.seatscolor := checktickethelp.seatscolor;
    curSeatPlan.setSelectSeatNum(1);
    curSeatPlan.defaultcellwidth := 60;
    curSeatPlan.defaultcellheight := 58;
    curSeatPlan.defaultcolcount := 11;
    curSeatPlan.brandModelid := curbrandModelid;

    curSeatPlan.OnSelectSeat := clickseat;
    curSeatPlan.setParent(pnlseatplan);
    curSeatPlan.Align := alClient;
  end;
  if newschisworkline then
    qrycheckedtickets;
end;

procedure TFrmMixCheckticket.NovaEdtSeatnoExit(Sender: TObject);
var
  scheduleplanid: int64;
  seatno: Integer;
begin
  inherited;
  if (NovaHelpSchedule.Id > 0) and (NovaEdtSeatno.Text <> '') then
  begin
    scheduleplanid := NovaHelpSchedule.Id;
    seatno := StrToInt(NovaEdtSeatno.Text);
    qryTicket(scheduleplanid, seatno, '','');
    if (jcsdQryTicket.active) and (jcsdQryTicket.RecordCount = 0) then
    begin
//      SysDialogs.ShowMessage('你输入班次的座位号未售票！');
      LabInfo.Caption:='你输入班次的座位号未售票！';
      LabInfo.Refresh;
      exit;
    end;
  end;

end;

procedure TFrmMixCheckticket.NovaEdtTicketNoChange(Sender: TObject);
var
  templen,ticketlength :Integer;
begin
    inherited;
   // ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;

end;

procedure TFrmMixCheckticket.NovaEdtTicketNoKeyPress(Sender: TObject;
  var Key: Char);
  var templen,ticketlength :Integer;
begin
  inherited;
   if Key = #13 then
  begin
    if isrealnamemix then
    begin
      if trim(NovaEdtTicketNo.text)='' then
      begin
        NovaEdtTicketNo.SetFocus;
        Exit;
      end;
      if trim(edtcertificateno.text)='' then
      begin
        edtcertificateno.SetFocus;
        Exit;
      end;
    end;
    if length(trim(NovaEdtTicketNo.text)) >=8 then
    begin
      //如果获取的车票长度大于系统票据长度，则从后面截取到符合系统的票据长度
      //ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;
      {if length(trim(NovaEdtTicketNo.text))>Sysinfo.curBillLength.Items['Ticket']   then
      begin
        templen := length(trim(NovaEdtTicketNo.text)) - ticketlength;
        NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen+1,
        length(NovaEdtTicketNo.text));
      end;  }
      qryTicket(0, 0, trim(NovaEdtTicketNo.Text),trim(edtcertificateno.text));
      {if  verifydepartstation then
      begin
         SysDialogs.ShowMessage('发车站不匹配！请确认后再次检票！');
         Exit;
      end;}
      if ticketid>0 then
      begin
        NovaEdtTicketNo.Clear;
        edtcertificateno.Clear;
        checkticket(ticketid);
      end
      else
      begin
        NovaEdtTicketNo.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmMixCheckticket.qrycheckedtickets();
var
  checktickets:integer;
begin
  with jsCdqrycheckticketeds do
  begin
    active := False;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['vehiclereportid'] := vehiclereportid;
    execute;
    checktickets:= Params.ParamValues['checktickets'];
    LabSolds.Caption:='';
    LabCheckeds.Caption := IntToStr(checktickets);
    LabCheckeds.Refresh;
  end;
end;

procedure TFrmMixCheckticket.qryTicket(scheduleplanid: int64; seatno: Integer;
  ticketno: String;certificateno:string);

begin
  with jcsdQryTicket do
  begin
    active := False;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['seatno'] := seatno;
    Params.ParamValues['ticketno'] := ticketno;
    Params.ParamValues['certificateno'] := certificateno;
    active := true;
    if RecordCount > 0 then
    begin
      ticketid := Fieldbyname('id').AsLargeInt;
      SysLog.WriteErr('ticketid：' +inttostr(ticketid));
      if ticketno = '' then
        NovaEdtTicketNo.Text := Fieldbyname('ticketno').AsString;
      LabcurFromStation.Caption := Fieldbyname('departstation').AsString;
      LabcurTostation.Caption := Fieldbyname('reachstation').AsString;
      if (Fieldbyname('islinework').AsBoolean) then
        LabcurSeatnum.Caption := ''
      else
        LabcurSeatnum.Caption := Fieldbyname('seatno').AsString;
      LabcurPrice.Caption := Fieldbyname('price').AsString;
      LabcurDepartdate.Caption := Fieldbyname('departdate').AsString;
      LabcurEntrance.Caption := Fieldbyname('ticketentrance').AsString;
      LabcurBuspark.Caption := Fieldbyname('buspark').AsString;
      LabcurCode.Caption := Fieldbyname('code').AsString;
      LabcurDeparttime.Caption := Fieldbyname('departtime').AsString;
      LabSaler.Caption := Fieldbyname('sellbyname').AsString;
      LabSalertime.Caption := Fieldbyname('selltime').AsString;

      if Fieldbyname('ticketstatus').AsString = '0' then
        LabcurTicketStatus.Caption := '正常'
      else if Fieldbyname('ticketstatus').AsString = '1' then
        LabcurTicketStatus.Caption := '已退票'
      else if Fieldbyname('ticketstatus').AsString = '2' then
        LabcurTicketStatus.Caption := '已作废'
      else
        LabcurTicketStatus.Caption := '未知状态';
      //判断选择的发车站和票上发车站是否一致

      // LabcurRemark.Caption := FieldByName('remarks').AsString;
      if Fieldbyname('ischecked').AsBoolean then
      begin
        ischecked := true;
        with jscdQryMixInfo do
        begin
          active := False;
          SysLog.WriteErr('ticketid22：' +inttostr(ticketid));
          Params.ParamValues['ticketid'] := ticketid;
          execute;
//          SysDialogs.ShowMessage(Params.ParamValues['msg']);
          LabInfo.Caption:=Params.ParamValues['msg'];
          LabInfo.Refresh;
          NovaEdtTicketNo.Clear;
          edtcertificateno.Clear;
          // NovaEdtSeatno.SetFocus;
        end;
      end
      else
      begin
        ischecked := False;
        //btnMixCheck.SetFocus;
      end;
    end
    else
    begin
      NovaEdtTicketNo.Clear;
      edtcertificateno.Clear;
      clearTicket;
      SysDialogs.Warning('您输入票号不存在！');
      exit;
    end;
  end;
end;

procedure TFrmMixCheckticket.reflashseat(seats: Integer; brandModelid: int64);
begin

end;

function TFrmMixCheckticket.validateTicket;
begin
  result := true;
  if trim(NovaEdtTicketNo.Text) = '' then
  begin
    NovaEdtTicketNo.SetFocus;
    SysDialogs.Warning('请输入票号！');
    result := False;
    exit;
  end;
  if length(trim(NovaEdtTicketNo.Text))<8 then
  begin
    NovaEdtTicketNo.SetFocus;
    SysDialogs.Warning('您输入票号位数不对！');
    result := False;
    exit;
  end;
end;

function TFrmMixCheckticket.verifydepartstation;
var
    strs :TStrings;
    i :Integer;
begin
    result := true;
    strs := TStringList.Create;
    strs.Delimiter := ';';
    strs.DelimitedText := inputdepartstationid;
    for i := 0 to Strs.Count-1 do
    begin
       if Strs[i]=jcsdQryTicket.FieldByName('departstation').AsString then
       begin
          result := False;
       end;
    end;
end;

procedure TFrmMixCheckticket.cardfound(idcard: TIDCard);
begin
  curidcard := idcard;
  if curidcard <> nil then
  begin
    if isrealnamemix then
    begin
      edtcertificateno.text:= curidcard.id;
      exit;
    end;
  end;
end;

end.
