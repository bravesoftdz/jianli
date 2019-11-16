unit UFrmSchSeatReserve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, Spin,
  NovaEdit, ComCtrls, DB, DBClient, SeatPlan, Generics.Collections,
  jsonClientDataSet, NovaHelp;

type
  TFrmSchSeatReserve = class(TSimpleEditForm)
    rgreserve: TRadioGroup;
    lbldepartdate: TLabel;
    dtpstartdate: TDateTimePicker;
    chkAutoCancel: TCheckBox;
    dtpautocanceltime: TDateTimePicker;
    lblroute: TLabel;
    lblschedule: TLabel;
    Label1: TLabel;
    jcdsQrySeatstatus: TjsonClientDataSet;
    jcdsResultReserve: TjsonClientDataSet;
    GroupBox1: TGroupBox;
    qryOrgSell: TjsonClientDataSet;
    pnlpicture: TPanel;
    jscdGetAutoCanelSeatTime: TjsonClientDataSet;
    dtpautocanceldate: TDateTimePicker;
    NovaEdtDepartTime: TNovaEdit;
    Label2: TLabel;
    edtnum: TNovaEdit;
    lbl1: TLabel;
    edtRemark: TEdit;
    edtroute: TNovaHelp;
    edtschedule: TNovaHelp;
    jcdsResultQryScheduleplan: TjsonClientDataSet;
    lbl2: TLabel;
    nvhlpTicketoutlets: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure chkAutoCancelClick(Sender: TObject);
    procedure rgreserveClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtnumChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function StringToDateTime(ADateTimeStr: string): TDateTime;
    procedure edtscheduleIdChange(Sender: TObject);
    procedure edtscheduleChange(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure edtrouteIdChange(Sender: TObject);

  private
    { Private declarations }
    autoCancelHours: double; // �Զ�ȡ����λСʱ��
    autoCancelHoursBeforeDepart_in: double; // 20111128 ��λ��Сʱ��Ϊ����
    autoCancelHoursBeforeDepart_out: double; // 20111128 ��λ��Сʱ��Ϊ����
    SeatPlan: TSeatPlanSelect;
    // seatplanDecorator: TVehicleSeatPlanDecorator;
    // seatshint: TDictionary<Word, String>;
    // seatStation: TDictionary<Word, String>;
    selectSeatStatus: TList<string>;
    seatpichelp: TSeatPicHelp;
    // function getdeparttime: TDateTime;
    // function getLastautocanceldate: TDateTime;
    // function getAutoCancelTime(): TDateTime;
  public
    { Public declarations }
    districttype, id, OrgID, departstationid, scheduleid, scheduleplanid,
    routeid,brandModelid: int64;
    departtime: string;
    departdate: TDateTime;
    cds: TjsonClientDataSet;
  end;

var
  FrmSchSeatReserve: TFrmSchSeatReserve;

implementation

uses Services, PubFn, UDMPublic, DateUtils;
{$R *.dfm}

procedure TFrmSchSeatReserve.bbtnSaveClick(Sender: TObject);
var
  nResult, i: integer;
  sResult, seatnos: string;
  temp: double;
  reservetime, departdatetime: String;
begin
  if (Trim(nvhlpTicketoutlets.Text) = '') or (nvhlpTicketoutlets.ID <= 0) then
  begin
    SysDialogs.ShowMessage('��Ʊ�㲻��Ϊ�գ�');  //У����Ʊ���Ƿ�Ϊ��
    nvhlpTicketoutlets.SetFocus;
    Exit;
  end;
  if (Trim(edtroute.Text) = '') or (edtroute.Id <= 0) then
  begin
    SysDialogs.ShowMessage('������·����Ϊ�գ�');  //У��������·�Ƿ�Ϊ��
    edtroute.SetFocus;
    Exit;
  end;
  if (Trim(edtschedule.Text) = '') or (edtschedule.Id <= 0) then
  begin
    SysDialogs.ShowMessage('��β���Ϊ�գ�');  //У�����Ƿ�Ϊ��
    edtroute.SetFocus;
    Exit;
  end;

  if (SeatPlan.selectedSeats = nil) or (SeatPlan.selectedSeats.Count = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ����λ�ţ�');
    Exit;
  end;

  departdatetime := FormatDateTime('yyyy-mm-dd', departdate)
    + ' ' + departtime + ':00';
  { if StringToDateTime(departdatetime) < now then
    begin
    SysDialogs.ShowMessage('�ð���ѹ�����ʱ�䣬������λ');
    exit;
    end; }

  // ��֤�Զ�ȡ����λʱ��ĺϷ���
  if chkAutoCancel.Checked then
  begin
    reservetime := FormatDateTime('yyyy-mm-dd', dtpautocanceldate.Date)
      + ' ' + FormatDateTime('hh:mm', dtpautocanceltime.Date) + ':00';
    if StringToDateTime(reservetime) > StringToDateTime(departdatetime) then
    begin
      SysDialogs.ShowMessage('�Զ�ȡ����λʱ�䲻�ܴ��ڷ���ʱ��!');
      Exit;
    end;
    if StringToDateTime(reservetime) < now then
    begin
      SysDialogs.ShowMessage('�Զ�ȡ����λʱ�䲻��С�ڵ�ǰʱ��!');
      Exit;
    end;
  end;

  with jcdsResultReserve do
  begin
    Close;
    Params.ParamByName('seatreserve.serviceprice').Value := 0;
    Params.ParamByName('seatreserve.carrychildnum').Value := 0;
    Params.ParamByName('seatreserve.ticketoutletsid').Value :=
      nvhlpTicketoutlets.Id;  //��Ʊ��id�޸�Ϊȡ�Կؼ�: 20160413 ��Ѩ������λҳ�����ӡ���Ʊ�㡿
//      SysInfo.LoginUserInfo.ticketoutletsid;
    Params.ParamByName('seatreserve.password').Value := '';
    // �����˵�ǰ��Ʊ��վ���ж� update by lck 20120512
    Params.ParamByName('seatreserve.departstationid').Value := departstationid;
    if id > 0 then
      Params.ParamByName('seatreserve.id').Value := id;
    Params.ParamByName('seatreserve.scheduleplanid').Value := scheduleplanid;
    Params.ParamByName('seatreserve.scheduleid').Value := scheduleid;
    // Params.ParamByName('seatreserve.orgid').Value := OrgID;
    // Params.ParamByName('seatreserve.departdate').Value :=formatdatetime('yyyy-mm-dd',dtpstartdate.DateTime);
    Params.ParamByName('seatreserve.departtime').Value := departtime;
    if chkAutoCancel.Checked then
    begin
      Params.ParamByName('seatreserve.isautocancel').Value := 'true';
      Params.ParamByName('seatreserve.autocanceltime').Value := FormatDateTime
        ('yyyy-mm-dd', dtpautocanceldate.Date) + ' ' + FormatDateTime
        ('hh:mm:ss', dtpautocanceltime.Date);
    end
    else
    begin
      Params.ParamByName('seatreserve.isautocancel').Value := 'false';
      Params.ParamByName('seatreserve.autocanceltime').Value := null;
    end;
    if rgreserve.ItemIndex = 0 then
    begin
      Params.ParamByName('seatreserve.sellstate').Value := 'R';
      jcdsResultReserve.SaveAddress := 'dispatch/reserve';
    end
    else
    begin
      Params.ParamByName('seatreserve.sellstate').Value := 'C';
      jcdsResultReserve.SaveAddress := 'dispatch/cancel';
    end;
    Params.ParamByName('seatreserve.remarks').Value := edtRemark.Text;

    for i := 0 to SeatPlan.selectedSeats.Count - 1 do
    begin
      seatnos := seatnos + IntToStr(SeatPlan.selectedSeats.Items[i]) + ',';
    end;
    Params.ParamByName('seatnos').Value := seatnos;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        // cbbdriver1.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��λ/ȡ����λ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

// ���ַ�����ʽ"yyyy-mm-dd hh:mm:ss" ת��Ϊ����ʱ���ʽ
function TFrmSchSeatReserve.StringToDateTime(ADateTimeStr: string): TDateTime;
var
  AFormatSettings: TFormatSettings;
  ShortDateFormat, ShortTimeFormat: string;
  DateSeparator, TimeSeparator: char;
begin
  ShortDateFormat := 'yyyy-MM-dd';
  DateSeparator := '-';
  ShortTimeFormat := 'HH:mm:ss';
  TimeSeparator := ':';
  AFormatSettings.ShortDateFormat := ShortDateFormat;
  AFormatSettings.DateSeparator := DateSeparator;
  AFormatSettings.ShortTimeFormat := ShortTimeFormat;
  AFormatSettings.TimeSeparator := TimeSeparator;
  Result := StrToDateTime(ADateTimeStr, AFormatSettings);
end;

procedure TFrmSchSeatReserve.chkAutoCancelClick(Sender: TObject);
begin
  inherited;
  if chkAutoCancel.Checked then
  begin
    dtpautocanceldate.Enabled := true;
    dtpautocanceltime.Enabled := true;
    with jscdGetAutoCanelSeatTime do
    begin
      Active := false;
      Params.ParamByName('departstationid').Value := departstationid;
      Params.ParamByName('scheduleplanid').Value := scheduleplanid;
      try
        Execute;
        dtpautocanceldate.DateTime := Trunc(Params.ParamByName('maxcanceltime')
            .AsDateTime);
        dtpautocanceldate.MaxDate := Trunc(Params.ParamByName('maxcanceltime')
            .AsDateTime);
        dtpautocanceltime.DateTime := Params.ParamByName('maxcanceltime')
          .AsDateTime;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('��ȡ�Զ���λȡ��ʱ��ʧ�ܣ�' + E.Message);
        end;
      end;
    end;
  end
  else
  begin
    dtpautocanceldate.Enabled := false;
    dtpautocanceltime.Enabled := false;
  end;
end;

procedure TFrmSchSeatReserve.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  //��ѯӪ�˼ƻ�
  edtschedule.OnIdChange(Sender);
end;

procedure TFrmSchSeatReserve.edtnumChange(Sender: TObject);
begin
  inherited;
  if Trim(edtnum.text) = '' then
  begin
    // edtnum.text := '0';
    Exit;
  end;
  SeatPlan.setSelectSeatNum(strtoInt(edtnum.text));
  SeatPlan.autoSelectSeats(true);
  SeatPlan.Refresh;
end;


procedure TFrmSchSeatReserve.edtrouteIdChange(Sender: TObject);
begin
  inherited;
  edtschedule.Clear;
  NovaEdtDepartTime.Clear;
end;

procedure TFrmSchSeatReserve.edtscheduleChange(Sender: TObject);
begin
  inherited;
     if (edtroute.Id >0) then
    begin
      with edtschedule do
      begin
        Params.ParamByName('filter_EQL_r!id').Value:= edtroute.Id;
        Params.ParamByName('filter_LIKES_t!code').Value:=edtschedule.Text;
        Params.ParamByName('filter_EQB_t!islinework').Value := '0';//����ˮ��
      end;
    end
    else
    begin
      with edtschedule do
      begin
        Params.ParamByName('filter_EQL_r!id').Value:= routeid;
        Params.ParamByName('filter_LIKES_t!code').Value:=edtschedule.Text;
        Params.ParamByName('filter_EQB_t!islinework').Value := '0';//����ˮ��
      end;
    end;
end;

procedure TFrmSchSeatReserve.edtscheduleIdChange(Sender: TObject);
begin
  inherited;
    if edtschedule.id <= 0 then
    begin
      exit;
    end;

     with jcdsResultQryScheduleplan do
     begin
       Active:=false;
       Params.ParamByName('scheduleid').Value:= edtschedule.id;
       Params.ParamByName('departdate').Value:=
       FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime); //ȡ�������ڣ�֮ǰȡ�Զ�ȡ����λ��������
//         FormatDateTime('yyyy-mm-dd',dtpautocanceldate.DateTime);
       Active:=true;;
       scheduleplanid:=FieldByName('scheduleplanid').AsInteger;

       //20160413 ��Ѩ������λҳ�����ӡ���Ʊ�㡿
       if scheduleplanid <= 0 then
       begin
          //û�в鵽��μƻ����������λͼ��Ϣ
          SeatPlan := TSeatPlanSelect.Create(self);
          selectSeatStatus.Clear;
          SeatPlan.selectSeatStatus := selectSeatStatus;
          SeatPlan.defaultcellwidth := 58;
          SeatPlan.defaultcellheight := 8;//��ֵ���ù���ҳ����ʾ����������
          SeatPlan.defaultcolcount := 14;
          SeatPlan.brandModelid := brandModelid;
          SeatPlan.setShowspacename(false);

          if SeatPlan.Height < 200 then
            SeatPlan.Height := 200;
          SeatPlan.setParent(pnlpicture);
          SeatPlan.setParent(pnlpicture);
          rgreserveClick(Sender);
//          SeatPlan.Free;

          dtpstartdate.SetFocus;
          SysDialogs.ShowMessage('�ð�ε���û������Ӫ�˼ƻ���');
          Exit;
       end;

       departstationid:=FieldByName('departstationid').AsInteger;
       scheduleid:=edtschedule.id;
       NovaEdtDepartTime.Text:=FieldByName('departtime').AsString;
     end;

     SeatPlan := TSeatPlanSelect.Create(self);
     seatpichelp.qryScheduleSeatstatus(scheduleplanid);
     seatpichelp.qrySeatstatus(scheduleplanid, true);
     SeatPlan.seatsStatus := seatpichelp.seatsStatus;
     SeatPlan.ShowHint := true;
     SeatPlan.seatshint := seatpichelp.seatshint;
     SeatPlan.selectSeatStatus := selectSeatStatus;
     SeatPlan.defaultcellwidth := 58;
     SeatPlan.defaultcellheight := 50;
     SeatPlan.defaultcolcount := 14;
     SeatPlan.seatstype := seatpichelp.seatstype;
     SeatPlan.seatsTickettype := seatpichelp.seatsTickettype;
     SeatPlan.seatsreachstationname := seatpichelp.seatStation;
     SeatPlan.seatscolor := seatpichelp.seatscolor;
     SeatPlan.brandModelid := brandModelid;
     SeatPlan.setShowspacename(false);

     if SeatPlan.Height < 200 then
       SeatPlan.Height := 200;
     SeatPlan.setParent(pnlpicture);

     rgreserveClick(Sender);
     edtnum.SetFocus;
end;
procedure TFrmSchSeatReserve.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(selectSeatStatus) then
    selectSeatStatus.Free;
  if Assigned(seatpichelp) then
    seatpichelp.Free;
  inherited;
end;

procedure TFrmSchSeatReserve.FormCreate(Sender: TObject);
begin
  inherited;
  seatpichelp := TSeatPicHelp.Create;
  selectSeatStatus := TList<string>.Create;
  selectSeatStatus.Add('0');
end;

procedure TFrmSchSeatReserve.FormShow(Sender: TObject);
var
  nResult:integer;
  sResult:String;
  scheduleCodeTemp : string; //���code����routeid�ı�ʱ����հ����Ϣ��������ҳ����ʾʱ����ʱ��������Ϣ����routeid�ı�֮���ٸ�����οؼ�
begin
  inherited;
  //Ĭ����ʾ��ǰ��¼�û���Ʊ��
  nvhlpTicketoutlets.Text := SysInfo.LoginUserInfo.ticketoutletsname;
  nvhlpTicketoutlets.ID := SysInfo.LoginUserInfo.ticketoutletsid;

  //���ڿؼ�ֻ��ȡ��ǰ֮�������
  dtpstartdate.MinDate := Trunc(Now);
  scheduleCodeTemp := Trim(edtschedule.Text); //�����code������ʱ����
  edtroute.Id := routeid; //����·�ؼ���id
  edtschedule.Id := scheduleid;  //����οؼ���scheduleid
  edtschedule.Text := scheduleCodeTemp; //��schedulecode��ʱ����������οؼ�


  dtpautocanceldate.MinDate := Date;
  dtpautocanceldate.DateTime := Date;
  with qryOrgSell do
  begin
    try
      Active := false;
      Params.ParamByName('departdate').Value := FormatDateTime('yyyy-MM-dd',
        dtpstartdate.DateTime);
      Params.ParamByName('scheduleid').Value := scheduleid;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if(nResult>=0) then
      begin
        sResult := Params.ParamByName('msg').Value;
        GroupBox1.Caption:='������λͼ��Ϣ(������ѡ����λ)��'+sResult;
        GroupBox1.Refresh;
      end;

    except
      on E: Exception do
      begin
        SysLog.WriteErr('��ȡ��Ʊͳ����Ϣʧ�ܣ�' + E.Message);
      end;
    end;
  end;

  SeatPlan := TSeatPlanSelect.Create(self);
  seatpichelp.qryScheduleSeatstatus(scheduleplanid);
  seatpichelp.qrySeatstatus(scheduleplanid, true);
  SeatPlan.seatsStatus := seatpichelp.seatsStatus;
  SeatPlan.ShowHint := true;
  SeatPlan.seatshint := seatpichelp.seatshint;
  SeatPlan.selectSeatStatus := selectSeatStatus;
  SeatPlan.defaultcellwidth := 58;
  SeatPlan.defaultcellheight := 50;
  SeatPlan.defaultcolcount := 14;
  SeatPlan.seatstype := seatpichelp.seatstype;
  SeatPlan.seatsTickettype := seatpichelp.seatsTickettype;
  SeatPlan.seatsreachstationname := seatpichelp.seatStation;
  SeatPlan.seatscolor := seatpichelp.seatscolor;
  SeatPlan.brandModelid := brandModelid;
  SeatPlan.setShowspacename(false);

  if SeatPlan.Height < 200 then
    SeatPlan.Height := 200;
  SeatPlan.setParent(pnlpicture);

  rgreserveClick(Sender);
  edtnum.SetFocus;
end;

procedure TFrmSchSeatReserve.rgreserveClick(Sender: TObject);
begin
  inherited;
  if rgreserve.ItemIndex = 0 then
  begin
    selectSeatStatus.Clear;
    selectSeatStatus.Add('0');
    SeatPlan.selectSeatStatus := selectSeatStatus;
    SeatPlan.selectSeatNum := cds.FieldByName('seatnum')
      .AsInteger - cds.FieldByName('fixedreserveseatnum')
      .AsInteger - cds.FieldByName('soldeatnum').AsInteger - cds.FieldByName
      ('autocancelreserveseatnum').AsInteger - cds.FieldByName
      ('unautocancelreserveseatnum').AsInteger;
  end
  else
  begin
    selectSeatStatus.Clear;
    selectSeatStatus.Add('3');
    selectSeatStatus.Add('4');
    selectSeatStatus.Add('5');
    SeatPlan.selectSeatStatus := selectSeatStatus;
  //����޿�λʱȡ����λ���޷�ȡ����
   // while SeatPlan.getSelectedSeats.Count > 0 do
    //begin
        SeatPlan.selectSeatNum := cds.FieldByName('seatnum')
      .AsInteger - cds.FieldByName('soldeatnum').AsInteger;
    //end;
  end;
  SeatPlan.Refresh;
end;

end.
