unit UFrmCancelCheckticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, ImgList, NovaHelp, ComCtrls,UIDCardReader;

type
  TFrmCancelCheckticket = class(TSimpleEditForm,IIDCardfound)
    lbl1: TLabel;
    grp1: TGroupBox;
    LabcurFromStation: TLabel;
    lbl2: TLabel;
    LabcurTostation: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    LabcurSeatnum: TLabel;
    lbl3: TLabel;
    LabcurPrice: TLabel;
    bvl4: TBevel;
    shp1: TShape;
    lbl4: TLabel;
    LabcurDepartdate: TLabel;
    bvl5: TBevel;
    bvl6: TBevel;
    bvl7: TBevel;
    lbl5: TLabel;
    LabcurEntrance: TLabel;
    lbl6: TLabel;
    LabcurBuspark: TLabel;
    bvl8: TBevel;
    lbl8: TLabel;
    LabcurCode: TLabel;
    lbl9: TLabel;
    LabcurDeparttime: TLabel;
    bvl10: TBevel;
    LabcurTickettype: TLabel;
    lbllabremark: TLabel;
    LabcurRemark: TLabel;
    lbl10: TLabel;
    NovaEdtTicketNo: TNovaEdit;
    jscdcancelCheckticket: TjsonClientDataSet;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    dtpDepartdate: TDateTimePicker;
    NovaHelpSchedule: TNovaHelp;
    NovaEdtSeatno: TNovaEdit;
    jscdQryTicket: TjsonClientDataSet;
    bvl11: TBevel;
    LabcurTicketStatus: TLabel;
    Label16: TLabel;
    jscdQryIsMix: TjsonClientDataSet;
    jscdverifystation: TjsonClientDataSet;
    Label1: TLabel;
    edtcertificateno: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NovaEdtSeatnoExit(Sender: TObject);
    procedure dtpDepartdateChange(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure NovaEdtTicketNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ticketid: int64;
    curidcard: TIDCard;
    procedure clearTicket;
    function validateTicket: boolean;
    function verifydepartstation: boolean;    //校验票号是否属于发车站
    procedure qryTicket(scheduleplanid: int64; seatno: Integer;
      ticketno: String;certificateno:string);
    procedure cardfound(idcard: TIDCard);
  public
    { Public declarations }
    id: int64;
    sresult,inputdepartstationid: string;
    isrealnamemix:Boolean;
  end;

var
  FrmCancelCheckticket: TFrmCancelCheckticket;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmCancelCheckticket.bbtnCloseClick(Sender: TObject);
begin
  inherited;

  if id>0 then
  //SysDialogs.Warning('111111111');
    ModalResult := mrok;
end;

procedure TFrmCancelCheckticket.bbtnSaveClick(Sender: TObject);
var
  nresult,ismixcheck,iscancelold: Integer;
begin

  if trim(NovaEdtTicketNo.text) = '' then
  begin
    SysDialogs.Warning('请输入退检的车票！');
    NovaEdtTicketNo.SetFocus;
    exit;
  end;
  if isrealnamemix then
    begin
      if trim(edtcertificateno.text)='' then
      begin
        SysDialogs.Warning('请输入退检的证件号！');
        edtcertificateno.SetFocus;
        Exit;
      end;
    end;
 // if (length(trim(NovaEdtTicketNo.text)) >= 8)
 //  or (jscdQryTicket.FieldByName('tickettype').AsString = 'T')  then
  begin
    ismixcheck:=0;
    iscancelold:=0;

    //校验车票的发车站是否匹配
    if  verifydepartstation then
    begin
       SysDialogs.ShowMessage('发车站不匹配！请确认后再次检票！');
       Exit;
    end;

    with jscdQryIsMix do
    begin
      active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['ticketno'] := trim(NovaEdtTicketNo.text);
      execute;
      ismixcheck := Params.ParamValues['mixcheck'];
      if ismixcheck=1 then
      begin
        if SysDialogs.Ask('信息提示','该票为混检票，是否退检到原班次？') then
        begin
            iscancelold:=1;
        end
        else
        begin
           iscancelold:=0;
        end;
      end;
    end;


    with jscdcancelCheckticket do
    begin
      active := false;
      Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['ticketno'] := trim(NovaEdtTicketNo.text);
      Params.ParamValues['mixcheck'] := iscancelold;
      execute;
      nresult := Params.ParamValues['flag'];
      sresult := Params.ParamValues['msg'];
      if nresult = 1 then
      begin
        SysDialogs.ShowMessage(sresult);
        id := Params.ParamValues['scheduleplanid'];
        if NovaEdtSeatno.Text<>'' then
          NovaEdtSeatno.SetFocus
        else
          NovaEdtTicketNo.SetFocus;
        NovaEdtTicketNo.Clear;
        edtcertificateno.Clear;
        NovaEdtSeatno.Clear;
        clearTicket;

        //ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sresult);
        NovaEdtTicketNo.SetFocus;
        NovaEdtTicketNo.SelectAll;
      end;
    end;
  end ;
 { else
  begin
    SysDialogs.Warning('您输入的票号长度有误！');
    NovaEdtTicketNo.SetFocus;
  end; }
end;

procedure TFrmCancelCheckticket.clearTicket;
begin
  ticketid := 0;
  LabcurFromStation.Caption := '';
  LabcurTostation.Caption := '';
  LabcurSeatnum.Caption := '';
  LabcurPrice.Caption := '';
  LabcurDepartdate.Caption := '';
  LabcurEntrance.Caption := '';
  LabcurBuspark.Caption := '';
  //LabcurVehicletype.Caption := '';
  LabcurCode.Caption := '';
  LabcurDeparttime.Caption := '';
  LabcurRemark.Caption := '';
  LabcurTickettype.Caption := '';
  LabcurTicketStatus.Caption := '';
end;

procedure TFrmCancelCheckticket.dtpDepartdateChange(Sender: TObject);
begin
  inherited;
  with NovaHelpSchedule do
  begin
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpDepartdate.Date);
  end;
end;

procedure TFrmCancelCheckticket.FormActivate(Sender: TObject);
begin
  inherited;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
    Sysinfo.CardManage.ReadCardNo(self.edtcertificateno);
    Sysinfo.CardManage.StartRead;
  end;
end;

procedure TFrmCancelCheckticket.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
ModalResult := mrok;
end;

procedure TFrmCancelCheckticket.FormCreate(Sender: TObject);
begin
  inherited;
  TIDCardReader.GetInstance.addObserver(self, false, true);
end;

procedure TFrmCancelCheckticket.FormDeactivate(Sender: TObject);
begin
  inherited;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
  end;
end;

procedure TFrmCancelCheckticket.FormDestroy(Sender: TObject);
begin
  inherited;
  TIDCardReader.GetInstance.removeObserver(self);
end;

procedure TFrmCancelCheckticket.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_escape) then
    Close;
end;

procedure TFrmCancelCheckticket.FormShow(Sender: TObject);
begin
  inherited;
  dtpDepartdate.Date := now;
  dtpDepartdateChange(Sender);
  clearTicket;
end;

procedure TFrmCancelCheckticket.NovaEdtSeatnoExit(Sender: TObject);
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
    if (jscdQryTicket.Active)
       and (jscdQryTicket.RecordCount=0) then
    begin
      SysDialogs.ShowMessage('你输入班次的座位号未售票！');
      exit;
    end;
  end;

end;

procedure TFrmCancelCheckticket.NovaEdtTicketNoKeyPress(Sender: TObject;
  var Key: Char);
  var templen,ticketlength :Integer;
begin
  //inherited;
//  改掉以下中的NovaEdtTicketNoChange 事件
//  if (NovaEdtTicketNo.Text<>'') and
//  (length(trim(NovaEdtTicketNo.Text))=Sysinfo.curBillLength.Items
//    ['Ticket']) then
//  begin
//    qryTicket(0, 0, trim(NovaEdtTicketNo.Text));
//  end;

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
    ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;
//    if length(trim(NovaEdtTicketNo.text)) > ticketlength then
//    begin
//      //如果获取的车票长度大于系统票据长度，则从后面截取到符合系统的票据长度
//      templen := length(trim(NovaEdtTicketNo.text)) - ticketlength;
//      NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen+1,
//        length(NovaEdtTicketNo.text));
//    end;
    qryTicket(0, 0, trim(NovaEdtTicketNo.Text),trim(edtcertificateno.text));
  end;
end;

procedure TFrmCancelCheckticket.qryTicket(scheduleplanid: int64; seatno: Integer;
  ticketno: String;certificateno:string);
begin
  with jscdQryTicket do
  begin
    active := False;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['seatno'] := seatno;
    Params.ParamValues['ticketno'] := ticketno;
    Params.ParamValues['certificateno'] := certificateno;
    active := true;
    if recordcount > 0 then
    begin
      ticketid := FieldByName('id').AsLargeInt;
      if ticketno = '' then
        NovaEdtTicketNo.Text := FieldByName('ticketno').AsString;
      LabcurFromStation.Caption := FieldByName('departstation').AsString;
      LabcurTostation.Caption := FieldByName('reachstation').AsString;
      if (FieldByName('islinework').AsBoolean) then
        LabcurSeatnum.Caption := ''
      else
        LabcurSeatnum.Caption := FieldByName('seatno').AsString;
      LabcurPrice.Caption := FieldByName('price').AsString;
      LabcurDepartdate.Caption := FieldByName('departdate').AsString;
      LabcurEntrance.Caption := FieldByName('ticketentrance').AsString;
      LabcurBuspark.Caption := FieldByName('buspark').AsString;
      LabcurCode.Caption := FieldByName('code').AsString;
      LabcurDeparttime.Caption := FieldByName('departtime').AsString;
      //LabcurVehicletype.Caption := FieldByName('vehicletype').AsString;
      LabcurRemark.Caption := FieldByName('remarks').AsString;
      if FieldByName('ticketstatus').AsString='0' then
       LabcurTicketStatus.Caption :='正常'
      else if FieldByName('ticketstatus').AsString='1' then
       LabcurTicketStatus.Caption :='已退票'
      else if FieldByName('ticketstatus').AsString='2' then
       LabcurTicketStatus.Caption := '已作废'
      else if FieldByName('ticketstatus').AsString='4' then
        LabcurTicketStatus.Caption := '已挂失'
      else
       LabcurTicketStatus.Caption := '未知状态';
    end
    else
    begin
      clearTicket;
      SysDialogs.Warning('您输入票号不存在！');
      exit;
    end;
  end;
end;

function TFrmCancelCheckticket.validateTicket: boolean;
begin
  result := true;
  if trim(NovaEdtTicketNo.text) = '' then
  begin
    NovaEdtTicketNo.SetFocus;
    SysDialogs.Warning('请输入票号！');
    result := false;
    exit;
  end;
 { if length(trim(NovaEdtTicketNo.text))<8 then
  // Sysinfo.curBillLength.Items['Ticket']
  begin
    NovaEdtTicketNo.SetFocus;
    SysDialogs.Warning('您输入票号位数不对！');
    result := false;
    exit;
  end;}
end;

function TFrmCancelCheckticket.verifydepartstation;
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
       if Strs[i]=jscdQryTicket.FieldByName('departstation').AsString then
       begin
          result := False;
       end;
    end;
end;
procedure TFrmCancelCheckticket.cardfound(idcard: TIDCard);
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
