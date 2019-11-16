unit UFrmSchPlanManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaHComboBox, NovaComboBox, NovaEdit, NovaHelp, DBGridEhGrouping;

type
  TFrmSchPlanManage = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lblstation: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbl6: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlpendstation: TNovaHelp;
    nvhlpvehicletype: TNovaHelp;
    yes: TCheckBox;
    no: TCheckBox;
    nvhlpunit: TNovaHelp;
    NovaCobbScheduleStatus: TNovaComboBox;
    chkIssaleafterreport: TCheckBox;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsResultautocancelreserveseatnum: TIntegerField;
    jcdsResultunautocancelreserveseatnum: TIntegerField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultdepartdate: TDateField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultfixedreserveseatnum: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultissellable: TBooleanField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultisproprietary: TBooleanField;
    jcdsResultdepartname: TWideStringField;
    jcdsResultschedulename: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultstartroutename: TWideStringField;
    jcdsResultendroutename: TWideStringField;
    jcdsResultbegincheck: TBooleanField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultreportvehicleno: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultbuspark: TWideStringField;
    jcdsResultviastation: TWideStringField;
    jcdsResultvtname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultschedulestatusid: TLargeintField;
    jcdsResultvehicletypeid: TLargeintField;
    jcdsResultvehiclebrandmodelid: TLargeintField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultplanvehicleid: TLargeintField;
    jcdsResultschedulevehiclepeopleplanid: TLargeintField;
    jcdsResultislinework: TBooleanField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultreservenum: TIntegerField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultissaleafterreport: TBooleanField;
    jcdsResultruntime: TFloatField;
    jcdsResultorgname: TWideStringField;
    jcdsResultdepartstationid: TLargeintField;
    jcdsResultvcstatus: TWideStringField;
    jcdsResultreporttime: TDateTimeField;
    ChkIsDepart: TCheckBox;
    ChkIsNotDepart: TCheckBox;
    jcdsResultdistricttype: TWideStringField;
    jscdUpdateSale: TjsonClientDataSet;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jscdAllowTicketsell: TjsonClientDataSet;
    jscdStopTicketsell: TjsonClientDataSet;
    jcsdallowScheduleplan: TjsonClientDataSet;
    jcdsResultbrandmodelname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure nvhlprouteIdChange(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure ToolButton51Click(Sender: TObject);
  private
    { Private declarations }
    //停班恢复
    procedure allowScheduleplan(curid: int64);
    procedure stopTicketsell(curid: int64;departstationsid: int64);
    procedure allowTicketsell(curid: int64;departstationsid: int64);
  public
    { Public declarations }
        procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmSchPlanManage: TFrmSchPlanManage;

implementation

uses Services, PubFn, UDMPublic,UFrmSeatReserve,UFrmSchPlanModfiy,
UFrmStatiionPriceEdt,UFrmVehicletypestatusEdit, UFrmScheduleplanPlus,UFrmSchedulestatusStop;
{$R *.dfm}

procedure TFrmSchPlanManage.allowScheduleplan(curid: int64);
var
  nResult: integer;
  sResult: string;
begin

  try
    with jcsdallowScheduleplan do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
      Params.ParamValues['departstationid'] := sysInfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('恢复报停班次操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmSchPlanManage.allowTicketsell(curid, departstationsid: int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jscdAllowTicketsell do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := departstationsid;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('发售操作失败：' + E.Message);
    end;
  end;


end;

procedure TFrmSchPlanManage.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if (jcdsResult.FieldByName('issaleafterreport').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 报停
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    Background := clRed; // clYellow;
    // dbgrdhResult.Canvas.Font.Color := clRed; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 被并
  if (jcdsResult.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 脱班
  if (jcdsResult.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clYellow;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 停售
  if (jcdsResult.FieldByName('status').AsString = '5') and not
    (gdSelected in State) then
  begin
    Background := clFuchsia;
    // dbgrdhResult.Canvas.Font.Color := clFuchsia;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('reportvehicleno').AsString <> '') and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('isdeparted').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clMoneyGreen;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmSchPlanManage.dtpenddateChange(Sender: TObject);
begin
  inherited;
  if trunc(dtpstartdate.Date) > trunc(dtpenddate.Date) then
  begin
    dtpstartdate.Date := dtpenddate.Date;
  end;
end;

procedure TFrmSchPlanManage.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  if trunc(dtpstartdate.Date) > trunc(dtpenddate.Date) then
  begin
    dtpenddate.Date := dtpstartdate.Date;
  end;

end;

procedure TFrmSchPlanManage.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCobbScheduleStatus.Active := false;
  NovaCobbScheduleStatus.Active := True;
end;

procedure TFrmSchPlanManage.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := True;
  with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := SysInfo.LoginUserInfo.OrgIDs;
    Active := True;
    NovaHCbbOrg.SetItemIndexByField('id', SysInfo.LoginUserInfo.StationID);
  end;
  nvhlproute.SetFocus;
end;

procedure TFrmSchPlanManage.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{FB5B6A6A-E265-4034-9A92-1AF98F6BC770}' then //
  begin
    tbtnCancel.Visible:=aEnable;
  end
end;

procedure TFrmSchPlanManage.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if jcdsResult.FieldByName('status').AsString = '1' then // 报停
  begin
    tbtnSave.Caption := '恢复';
  end
  else
  begin
    tbtnSave.Caption := '停班';
  end;

  if jcdsResult.FieldByName('vcstatus').AsString ='正常' then // 正常
  begin
    ToolButton52.Caption := '停售';
  end
  else if jcdsResult.FieldByName('vcstatus').AsString ='停售' then
  begin
    ToolButton52.Caption := '发售';
  end ;
  if self.jcdsResult.FieldByName('issaleafterreport').AsBoolean then
    tbtnCancel.Caption:='正常售票'
  else
    tbtnCancel.Caption:='报到售票';
end;

procedure TFrmSchPlanManage.nvhlprouteIdChange(Sender: TObject);
begin
  tbtnFilterClick(Sender);
  self.nvhlproute.SelectAll;
end;

procedure TFrmSchPlanManage.stopTicketsell(curid, departstationsid: int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jscdStopTicketsell do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := departstationsid;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('停售操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmSchPlanManage.tbtnCancelClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  curid:Int64 ;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
   if not SysDialogs.Confirm('信息提示', '确认要'+tbtnCancel.caption+'？') then
      exit;

   curid:=jcdsResult.fieldbyname('id').AsLargeInt;
  try
    with jscdUpdateSale do
    begin
      Active := false;
      Params.ParamValues['scheduleplanid'] := curid;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);

        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('恢复正常售票操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnDeleteClick(Sender: TObject);
var
  curid : Int64;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  begin
    FrmStatiionPriceEdt := TFrmStatiionPriceEdt.Create(self);
    with FrmStatiionPriceEdt do
    begin
      dtpstartdate.Enabled:=false;
      dtpstartdate.DateTime:= jcdsResult.FieldByName('departdate').AsDateTime;
      dtpenddate.DateTime:= jcdsResult.FieldByName('departdate').AsDateTime;
      routeid:=jcdsResult.FieldByName('routeid').AsLargeInt;
      edtroute.Text:=jcdsResult.FieldByName('routename').AsString;
      edtschedule.Text:=jcdsResult.FieldByName('schedulename').AsString;
      scheduleplanid:=jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmStatiionPriceEdt,false) = mrOk then
      begin
       //tbtnFilterClick(sender);
       //jcdsResult.Locate('id',curid,[]);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnEditClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  begin
    FrmSchPlanModfiy := TFrmSchPlanModfiy.Create(self);
    with FrmSchPlanModfiy do
    begin
      dpstartdate.Enabled:=false;
      dpstartdate.DateTime:= jcdsResult.FieldByName('departdate').AsDateTime;
      edtroute.Text:=jcdsResult.FieldByName('routename').AsString;
      edtschedule.Text:=jcdsResult.FieldByName('schedulename').AsString;
      edtstarttime.DateTime:=jcdsResult.FieldByName('departtime').AsDateTime;
      routeid:=jcdsResult.FieldByName('routeid').AsLargeInt;
      departstationid:=jcdsResult.FieldByName('departstationid').AsLargeInt;
      scheduleplanid:= jcdsResult.FieldByName('id').AsLargeInt;
      curid:=scheduleplanid;
      edtschedule.Text := jcdsResult.FieldByName('schedulename').asstring;
      edtschedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
      dpstartdate.Mindate := Date;
      dpenddate.Mindate := Date;
      buspark:=jcdsResult.FieldByName('buspark').asstring;
      ticketentrance:=jcdsResult.FieldByName('ticketentrance').asstring;
      departtime:= jcdsResult.FieldByName('departtime').AsString;
      schedulestatusid:=jcdsResult.FieldByName('schedulestatusid').AsLargeInt;
      if SysMainForm.showFormModal(FrmSchPlanModfiy,false) = mrOk then
      begin
       tbtnFilterClick(sender);
       jcdsResult.Locate('id',curid,[]);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnFilterClick(Sender: TObject);
var
  planid: Int64;
begin
  inherited;
  if (trunc(dtpenddate.Date - dtpstartdate.Date) > 0) and
    ((self.nvhlproute.text = '') and (NovaCobbScheduleStatus.ItemIndex < 2)
    ) then
  begin
    SysDialogs.Warning('未输入营运线路或班次状态查询条件，只能查询一天的班次运行计划信息！');
    exit;
  end;

  if (StrToInt(getParametervalue('0007', SysInfo.LoginUserInfo.OrgID)) <= trunc
      (dtpenddate.Date - dtpstartdate.Date)) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  planid:=0;
  if (jcdsResult.Active) and (jcdsResult.recordcount > 0) then
    planid := jcdsResult.FieldByName('id').AsLargeInt;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['departstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_GED_sp!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_sp!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    if trim(nvhlpschedule.text) = '' then
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.id;
    end;
    if trim(nvhlproute.text) = '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.id;
    end;
    if trim(nvhlpendstation.text) = '' then
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := nvhlpendstation.id;
    end;
    if (ChkIsDepart.Checked) and (not ChkIsNotDepart.Checked) then
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := 1;
    end
    else if (not ChkIsDepart.Checked) and (ChkIsNotDepart.Checked) then
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := 0;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := null;
    end;

    if trim(nvhlpvehicletype.text) = '' then
    begin
      Params.ParamValues['filter_EQL_vt!id'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_vt!id'] := nvhlpvehicletype.id;
    end;
    if NovaCobbScheduleStatus.ItemIndex <= 0 then
    begin
      Params.ParamValues['filter_EQS_ss!status'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ss!status'] :=
        NovaCobbScheduleStatus.GetSelectCode;
    end;
    if ((yes.Checked) and (no.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := 'true';
    end
    else if ((yes.Checked = false) and (no.Checked)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := 'false';
    end
    else if ((yes.Checked) and (no.Checked)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := null;
    end
    else if ((yes.Checked = false) and (no.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := null;
    end;
    if (trim(nvhlpunit.text) = '') or (nvhlpunit.id = 0) then
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := nvhlpunit.id;
    end;
    if chkIssaleafterreport.Checked then
      Params.ParamValues['filter_EQB_sp!issaleafterreport'] := True
    else
      Params.ParamValues['filter_EQB_sp!issaleafterreport'] := null;
    Active := True;
    if planid > 0 then
    begin
      jcdsResult.Locate('id', planid, []);
    end;

  end;
end;

procedure TFrmSchPlanManage.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.recordcount < 1 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('该班次已经停班，不能留位！');
    exit;
  end;
  if jcdsResult.FieldByName('islinework').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('该班次是流水班，不能留位！');
    exit;
  end;

  with FrmSeatReserve do
  begin
    FrmSeatReserve := TFrmSeatReserve.Create(self);
    Caption := '留位/取消留位';
    edtroute.text := jcdsResult.FieldByName('routename').AsString;
    //edtstartdate.text := jcdsResult.FieldByName('departdate').AsString;
    edtschedule.text := jcdsResult.FieldByName('schedulename').AsString;
    //edtplanvehicle.text := jcdsResult.FieldByName('vehicleno').AsString;
   // OrgID := jcdsResult.FieldByName('orgid').AsLargeInt;
    departstationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    departdate := jcdsResult.FieldByName('departdate').AsDateTime;
    departtime := jcdsResult.FieldByName('departtime').AsString;
    brandModelid := jcdsResult.FieldByName('vehiclebrandmodelid').AsInteger;
    districttype := jcdsResult.FieldByName('districttype').AsInteger;
    NovaEdtDepartTime.Text:=jcdsResult.FieldByName('departtime').AsString;
    cds := jcdsResult;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', scheduleplanid, []);
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnSaveClick(Sender: TObject);
var
  scheduleplanid:Int64;
begin
  if (not jcdsResult.Active) and (not (jcdsResult.RecordCount > 0)) then
  begin
     Exit;
  end;
  scheduleplanid := jcdsResult.FieldByName('id').AsInteger;
  begin
    FrmSchedulestatusStop := TFrmSchedulestatusStop.Create(self);
    with FrmSchedulestatusStop do
    begin
      caption := '班次停班/复班处理';
      if jcdsResult.FieldByName('status').AsString = '1' then
         cbbOpertype.ItemIndex:=1
      else
        cbbOpertype.ItemIndex:=0;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').asstring;
      NovaHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('schedulename').asstring;
      NovaHelpSchedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
      DTPStartDay.Mindate := Date;
      DTPEndDay.Mindate := Date;
      if dtpstartdate.Date>=Now then
      begin
        DTPStartDay.Date := dtpstartdate.Date;
        DTPEndDay.Date := dtpstartdate.Date;
      end
      else
      begin
        DTPStartDay.Date := now;
        DTPEndDay.Date := now;
      end;

      if SysMainForm.showFormModal(FrmSchedulestatusStop,false) = mrOk then
      begin
       tbtnFilterClick(sender);
       jcdsResult.Locate('id',scheduleplanid,[]);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.ToolButton50Click(Sender: TObject);
var
  newid : Int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    SysDialogs.ShowMessage('流水班不需要加班！');
    Exit;
  end;

  begin
    FrmScheduleplanPlus := TFrmScheduleplanPlus.Create(self);
    with FrmScheduleplanPlus do
    begin
      Caption:='班次加班';
      scheduleplanid:= jcdsResult.FieldByName('id').AsLargeInt;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').asstring;
      NEdtHelpCode.Text := 'JB'+jcdsResult.FieldByName('schedulename').asstring;
      NovaVehicletype.SetItemIndexByField('id',jcdsResult.FieldByName('vehicletypeid').AsLargeInt);
      NovaVehicletypeChange(sender);
      NvHcbbVehiclebrandmodel.SetItemIndexByField('id',jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt);
      NvHcbbVehiclebrandmodelChange(sender);
      dtpStartdate_p.Mindate := Date;
      dtpEnddate_p.Mindate := Date;
      if dtpstartdate.Date>=trunc(Now) then
      begin
        dtpStartdate_p.Date := dtpstartdate.Date;
        dtpEnddate_p.Date := dtpstartdate.Date;
      end
      else
      begin
        dtpStartdate_p.Date := now;
        dtpEnddate_p.Date := now;
      end;

      if SysMainForm.showFormModal(FrmScheduleplanPlus,false) = mrOk then
      begin
       newid:=scheduleplanid;
       tbtnFilterClick(sender);
       jcdsResult.Locate('id',newid,[]);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.ToolButton51Click(Sender: TObject);
begin
  if jcdsResult.FieldByName('begincheck').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('该营运班次已经检票，不能进行调整！');
    Exit;
  end;
  with FrmVehicletypestatusEdit do
  begin
    FrmVehicletypestatusEdit := TFrmVehicletypestatusEdit.Create(Self);
    Caption := '调整车型';
    sign := false;
    id := jcdsResult.FieldByName('schedulevehiclepeopleplanid').AsLargeInt;
    edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    edtstartdate.Text := jcdsResult.FieldByName('departdate').AsString;
    edtdeparttime.Text := jcdsResult.FieldByName('departtime').AsString;
    edtstartstation.Text := jcdsResult.FieldByName('startroutename').AsString;
    edtendstation.Text := jcdsResult.FieldByName('endroutename').AsString;
    cbbplanvehicletype.SetItemIndexByField('id',
      jcdsResult.FieldByName('vehicletypeid').AsLargeInt);
    cbbVehiclebrandmodel.SetItemIndexByField('id',
      jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt);
    edtbrandmodel.Text:=cbbVehiclebrandmodel.Text;
    cbbplanvehicletype.Text := jcdsResult.FieldByName('vtname').AsString;
    cbbVehiclebrandmodel.Text := jcdsResult.FieldByName('brandmodelname').AsString;
    edtbrandmodel.Text := jcdsResult.FieldByName('brandmodelname').AsString;
    nvhlptypename.Text := jcdsResult.FieldByName('vtname').AsString;
    edtseatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    edtnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    planid := jcdsResult.FieldByName('id').AsLargeInt;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', planid,[] );
    end;
  end;
end;

procedure TFrmSchPlanManage.ToolButton52Click(Sender: TObject);
var
  curid,departstationsid: int64;
begin
  inherited;
  // 停售操作
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm(tbtnSave.Caption + '操作',
    '确认要' + ToolButton52.Caption + '该班次吗？') then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    departstationsid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    //
    if jcdsResult.FieldByName('status').AsString = '5' then
    begin
      allowTicketsell(curid,departstationsid) // 发售
    end
    else
      stopTicketsell(curid,departstationsid); // 停售
  end;
end;

end.
