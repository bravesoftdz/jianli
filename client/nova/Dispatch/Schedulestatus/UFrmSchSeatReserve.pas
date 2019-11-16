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
    autoCancelHours: double; // 自动取消留位小时数
    autoCancelHoursBeforeDepart_in: double; // 20111128 单位由小时改为分钟
    autoCancelHoursBeforeDepart_out: double; // 20111128 单位由小时改为分钟
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
    SysDialogs.ShowMessage('售票点不能为空！');  //校验售票点是否为空
    nvhlpTicketoutlets.SetFocus;
    Exit;
  end;
  if (Trim(edtroute.Text) = '') or (edtroute.Id <= 0) then
  begin
    SysDialogs.ShowMessage('运行线路不能为空！');  //校验运行线路是否为空
    edtroute.SetFocus;
    Exit;
  end;
  if (Trim(edtschedule.Text) = '') or (edtschedule.Id <= 0) then
  begin
    SysDialogs.ShowMessage('班次不能为空！');  //校验班次是否为空
    edtroute.SetFocus;
    Exit;
  end;

  if (SeatPlan.selectedSeats = nil) or (SeatPlan.selectedSeats.Count = 0) then
  begin
    SysDialogs.ShowMessage('请选择座位号！');
    Exit;
  end;

  departdatetime := FormatDateTime('yyyy-mm-dd', departdate)
    + ' ' + departtime + ':00';
  { if StringToDateTime(departdatetime) < now then
    begin
    SysDialogs.ShowMessage('该班次已过发车时间，不能留位');
    exit;
    end; }

  // 验证自动取消留位时间的合法性
  if chkAutoCancel.Checked then
  begin
    reservetime := FormatDateTime('yyyy-mm-dd', dtpautocanceldate.Date)
      + ' ' + FormatDateTime('hh:mm', dtpautocanceltime.Date) + ':00';
    if StringToDateTime(reservetime) > StringToDateTime(departdatetime) then
    begin
      SysDialogs.ShowMessage('自动取消留位时间不能大于发车时间!');
      Exit;
    end;
    if StringToDateTime(reservetime) < now then
    begin
      SysDialogs.ShowMessage('自动取消留位时间不能小于当前时间!');
      Exit;
    end;
  end;

  with jcdsResultReserve do
  begin
    Close;
    Params.ParamByName('seatreserve.serviceprice').Value := 0;
    Params.ParamByName('seatreserve.carrychildnum').Value := 0;
    Params.ParamByName('seatreserve.ticketoutletsid').Value :=
      nvhlpTicketoutlets.Id;  //售票点id修改为取自控件: 20160413 武穴需求：留位页面增加【售票点】
//      SysInfo.LoginUserInfo.ticketoutletsid;
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
        SysLog.WriteErr('留位/取消留位调整失败：' + E.Message);
      end;
    end;
  end;
end;

// 将字符串格式"yyyy-mm-dd hh:mm:ss" 转换为日期时间格式
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

procedure TFrmSchSeatReserve.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  //查询营运计划
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
        Params.ParamByName('filter_EQB_t!islinework').Value := '0';//非流水班
      end;
    end
    else
    begin
      with edtschedule do
      begin
        Params.ParamByName('filter_EQL_r!id').Value:= routeid;
        Params.ParamByName('filter_LIKES_t!code').Value:=edtschedule.Text;
        Params.ParamByName('filter_EQB_t!islinework').Value := '0';//非流水班
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
       FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime); //取发车日期，之前取自动取消留位的日期了
//         FormatDateTime('yyyy-mm-dd',dtpautocanceldate.DateTime);
       Active:=true;;
       scheduleplanid:=FieldByName('scheduleplanid').AsInteger;

       //20160413 武穴需求：留位页面增加【售票点】
       if scheduleplanid <= 0 then
       begin
          //没有查到班次计划，则清空座位图信息
          SeatPlan := TSeatPlanSelect.Create(self);
          selectSeatStatus.Clear;
          SeatPlan.selectSeatStatus := selectSeatStatus;
          SeatPlan.defaultcellwidth := 58;
          SeatPlan.defaultcellheight := 8;//此值设置过大，页面显示则面积会过大
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
          SysDialogs.ShowMessage('该班次当天没有生成营运计划！');
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
  scheduleCodeTemp : string; //班次code：当routeid改变时会清空班次信息，所以在页面显示时先临时保存班次信息，在routeid改变之后再赋给班次控件
begin
  inherited;
  //默认显示当前登录用户售票点
  nvhlpTicketoutlets.Text := SysInfo.LoginUserInfo.ticketoutletsname;
  nvhlpTicketoutlets.ID := SysInfo.LoginUserInfo.ticketoutletsid;

  //日期控件只能取当前之后的日期
  dtpstartdate.MinDate := Trunc(Now);
  scheduleCodeTemp := Trim(edtschedule.Text); //将班次code赋给临时变量
  edtroute.Id := routeid; //给线路控件赋id
  edtschedule.Id := scheduleid;  //给班次控件赋scheduleid
  edtschedule.Text := scheduleCodeTemp; //将schedulecode临时变量赋给班次控件


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
        GroupBox1.Caption:='车型座位图信息(点击鼠标选择座位)：'+sResult;
        GroupBox1.Refresh;
      end;

    except
      on E: Exception do
      begin
        SysLog.WriteErr('获取售票统计信息失败：' + E.Message);
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
  //解决无空位时取消留位，无法取消。
   // while SeatPlan.getSelectedSeats.Count > 0 do
    //begin
        SeatPlan.selectSeatNum := cds.FieldByName('seatnum')
      .AsInteger - cds.FieldByName('soldeatnum').AsInteger;
    //end;
  end;
  SeatPlan.Refresh;
end;

end.
