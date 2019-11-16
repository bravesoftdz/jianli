unit UFrmSeatReserve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, Spin,
  NovaEdit, ComCtrls, DB, DBClient, SeatPlan, Generics.Collections,
  jsonClientDataSet;

type
  TFrmSeatReserve = class(TSimpleEditForm)
    rgreserve: TRadioGroup;
    lbldepartdate: TLabel;
    dtpstartdate: TDateTimePicker;
    chkAutoCancel: TCheckBox;
    dtpautocanceltime: TDateTimePicker;
    lblroute: TLabel;
    lblschedule: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    Label1: TLabel;
    edtnum: TSpinEdit;
    jcdsQrySeatstatus: TjsonClientDataSet;
    jcdsResultReserve: TjsonClientDataSet;
    GroupBox1: TGroupBox;
    jscdQrySeats: TjsonClientDataSet;
    pnlpicture: TPanel;
    jscdGetAutoCanelSeatTime: TjsonClientDataSet;
    dtpautocanceldate: TDateTimePicker;
    NovaEdtDepartTime: TNovaEdit;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure chkAutoCancelClick(Sender: TObject);
    procedure rgreserveClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtnumChange(Sender: TObject);
  private
    { Private declarations }
    autoCancelHours: double; // 自动取消留位小时数
    autoCancelHoursBeforeDepart_in: double; // 20111128 单位由小时改为分钟
    autoCancelHoursBeforeDepart_out: double; // 20111128 单位由小时改为分钟
    SeatPlan: TSeatPlanSelect;
    // seatplanDecorator: TVehicleSeatPlanDecorator;
    seatshint: TDictionary<Word, String>;
    seatStation: TDictionary<Word, String>;
    selectSeatStatus: TList<string>;
    // function getdeparttime: TDateTime;
    // function getLastautocanceldate: TDateTime;
    // function getAutoCancelTime(): TDateTime;
  public
    { Public declarations }
    districttype, id, OrgID, departstationid, scheduleid, scheduleplanid,
      brandModelid: int64;
    departtime: string;
    departdate: TDateTime;
    cds: TjsonClientDataSet;
  end;

var
  FrmSeatReserve: TFrmSeatReserve;

implementation

uses Services, PubFn, UDMPublic, DateUtils;
{$R *.dfm}

procedure TFrmSeatReserve.bbtnSaveClick(Sender: TObject);
var
  nResult, i: integer;
  sResult, seatnos: string;
  temp: double;
begin
  if (SeatPlan.selectedSeats = nil) or (SeatPlan.selectedSeats.Count = 0) then
  begin
    SysDialogs.ShowMessage('请选择座位号！');
    Exit;
  end;
  with jcdsResultReserve do
  begin
    Close;
    Params.ParamByName('seatreserve.serviceprice').Value := 0;
    Params.ParamByName('seatreserve.carrychildnum').Value := 0;
    Params.ParamByName('seatreserve.ticketoutletsid').Value :=
      SysInfo.LoginUserInfo.ticketoutletsid;
    Params.ParamByName('seatreserve.password').Value := '';
    // 增加了当前留票车站的判断 update by lck 20120512
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
        SysLog.WriteErr('留位/取消留位调整失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSeatReserve.chkAutoCancelClick(Sender: TObject);
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
          SysLog.WriteErr('获取自动留位取消时间失败：' + E.Message);
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

procedure TFrmSeatReserve.edtnumChange(Sender: TObject);
begin
  inherited;
  if Trim(edtnum.text) = '' then
  begin
    edtnum.text := '0';
    Exit;
  end;
  SeatPlan.setSelectSeatNum(strtoInt(edtnum.text));
  SeatPlan.autoSelectSeats(true);
  SeatPlan.Refresh;
end;

procedure TFrmSeatReserve.FormShow(Sender: TObject);
var
  seatstype, seatsStatus: TDictionary<Word, String>;
  seatno: Word;
begin
  inherited;
  dtpautocanceldate.MinDate := Date;
  dtpautocanceldate.DateTime := Date;
  SeatPlan := TSeatPlanSelect.Create(self);
  SeatPlan.ShowHint := true;
  if not Assigned(seatshint) then
    seatshint := TDictionary<Word, String>.Create()
  else
    seatshint.Clear;
  with jcdsQrySeatstatus do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        seatno := FieldByName('seatno').AsInteger;
        seatshint.AddOrSetValue(seatno, FieldByName('hint').AsString);
        next;
      end;
    end;
  end;
  SeatPlan.seatshint := seatshint;
  SeatPlan.brandModelid := brandModelid;
  SeatPlan.setShowspacename(false);

  seatsStatus := TDictionary<Word, String>.Create;
  seatstype := TDictionary<Word, String>.Create;
  with jscdQrySeats do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!scheduleplan.id'] := scheduleplanid;
    Active := true;
    first;
    while not eof do
    begin
      if FieldByName('status').AsString = '2' then
        seatsStatus.Add(FieldByName('seatno').AsInteger,
          FieldByName('tickettype').AsString)
      else
        seatsStatus.Add(FieldByName('seatno').AsInteger,
          FieldByName('status').AsString);
      seatstype.Add(FieldByName('seatno').AsInteger,
        FieldByName('seattype').AsString);
      next;
    end;
  end;

  SeatPlan.seatsStatus := seatsStatus;
  SeatPlan.seatstype := seatstype;
  // 增加到站信息
  if not Assigned(seatStation) then
    seatStation := TDictionary<Word, String>.Create()
  else
    seatStation.Clear;
  with jcdsQrySeatstatus do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        seatno := FieldByName('seatno').AsInteger;
        if FieldByName('ticketno').AsString <> '0' then
        begin
          seatStation.Add(seatno, FieldByName('seatinfo').AsString);
        end;
        next;
      end;
    end;
  end;

  if Assigned(seatStation) then
    SeatPlan.seatsreachstationname := seatStation;

  selectSeatStatus := TList<string>.Create;
  selectSeatStatus.Add('0');
  SeatPlan.selectSeatStatus := selectSeatStatus;
  // SeatPlan.selectSeattype := '';
  SeatPlan.setParent(pnlpicture);
  // seatplanDecorator := TVehicleSeatPlanDecorator.Create(self, SeatPlan);
  // seatplanDecorator.Parent := pnlpicture;
  // pnlpicture.Height := SeatPlan.actualheight + pnlpicture.GetTextLen;
  // dtpautocanceltime.DateTime := getLastautocanceldate();
  rgreserveClick(Sender);
end;

procedure TFrmSeatReserve.rgreserveClick(Sender: TObject);
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
    SeatPlan.selectSeatNum := cds.FieldByName('seatnum')
      .AsInteger - cds.FieldByName('soldeatnum').AsInteger;
  end;
  SeatPlan.Refresh;
end;

end.
