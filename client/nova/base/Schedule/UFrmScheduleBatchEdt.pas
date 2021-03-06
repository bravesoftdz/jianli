unit UFrmScheduleBatchEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaHComboBox, NovaComboBox,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, ComCtrls, NovaListView,
  Mask, Services, Menus;

type
  TFrmScheduleBatchEdt = class(TSimpleEditForm)
    Label2: TLabel;
    NHelpRoute: TNovaHelp;
    CobWORKTYPE: TNovaComboBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    CobWORKWAYS: TNovaComboBox;
    CobDISTRICTTYPE: TNovaComboBox;
    CobTYPE: TNovaComboBox;
    Label11: TLabel;
    NEdtPRINTINFO: TNovaEdit;
    Label14: TLabel;
    Label9: TLabel;
    NEdtRuntime: TNovaEdit;
    Label24: TLabel;
    Label25: TLabel;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    ChkISPROPRIETARY: TCheckBox;
    ChkISSELLRETURNTICKET: TCheckBox;
    ChkISORIGINATOR: TCheckBox;
    ChkISSALEAFTERREPORT: TCheckBox;
    ChkISCANMIXCHECK: TCheckBox;
    ChkPrintSeatno: TCheckBox;
    GroupBox1: TGroupBox;
    jsonSchedulestation: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    NovaListSchedule: TNovaListView;
    jcdsGenScheduleplan: TjsonClientDataSet;
    nvdbgrdh1: TNvDbgridEh;
    DsTicketprices: TDataSource;
    pmMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    jsonSaveSchedule: TjsonClientDataSet;
    Label8: TLabel;
    NEdtPLANSEATNUM: TNovaEdit;
    lblendstation: TLabel;
    lblstartstationprice: TLabel;
    NEdtEndStation: TNovaEdit;
    NEdtStartstationprice: TNovaEdit;
    procedure NHelpRouteIdChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    log: string;
    function checkSchedule(var msg: String): boolean;

  public
    { Public declarations }
    scheduleid, createby: Int64;
    ticketentrance, vehcilepark: string;
    createtime, code, synccode: string;
    worktype, workways, districttype, scheduletype: String;
  end;

var
  FrmScheduleBatchEdt: TFrmScheduleBatchEdt;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleBatchEdt.bbtnSaveClick(Sender: TObject);
var
  i: Integer;
  stationids, stationnames, scheduleids, schedulecodes, msg: string;

  nResult: Integer;
  sResult: string;
begin
  inherited;

  if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;
   scheduleids :='';
   schedulecodes :='';
   stationids :='';
   stationnames :='';
  // 判断是否有选择班次
  if NovaListSchedule.CheckedCount <= 0 then
    scheduleids := '(' + inttostr(scheduleid) + ')'
  else
  begin
    scheduleids := '(' + NovaListSchedule.GetSelected + ')';
    schedulecodes := NovaListSchedule.GetSearchString;
//    SysDialogs.ShowMessage(schedulecodes);
  end;

  // 判断站点是否售票
  stationids := '';
  with jsonSchedulestation do
  begin
    // if (isupdate = 'true') and (ChangeCount = 0) then
    // begin
    // SysDialogs.ShowMessage('数据未做任何修改！');
    // exit;
    // end;
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        if FieldByName('issellable').AsBoolean then
        begin
          if stationids = '' then
          begin
            stationids := FieldByName('stationid').AsString;
            stationnames := FieldByName('stationname').AsString;
          end
          else
          begin
            stationids := stationids + ',' + FieldByName('stationid').AsString;
            stationnames := stationnames + ',' + FieldByName('stationname')
              .AsString;
          end;
        end;
        Next;
      end;
      EnableControls;
    end;
  end;

  { if (edittype = Tedittype.add) and (NHelpRoute.isactive) and
    (NHelpRoute.HelpFieldValue['orgid'] <> SysInfo.LoginUserInfo.OrgID) then
    begin
    if not SysDialogs.Ask('提示信息', '该线路所属机构与当前登录机构不是同一机构，是否保存！') then
    exit;
    end; }
  with jsonSchedulestation do
  begin
    // Params.ParamByName('schedule.orgid').Value := NovaCbbOrg.HelpFieldValue
    // ['id'];
    Params.ParamByName('schedule.id').Value := scheduleid;
    // Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.route.id').Value := NHelpRoute.Id;
    Params.ParamByName('schedule.worktype').Value := CobWORKTYPE.GetSelectCode;
    Params.ParamByName('schedule.workways').Value := CobWORKWAYS.GetSelectCode;
    Params.ParamByName('schedule.districttype').Value :=
      CobDISTRICTTYPE.GetSelectCode;
    Params.ParamByName('schedule.type').Value := CobTYPE.GetSelectCode;
    // Params.ParamByName('schedule.starttime').Value := medtStartTime.Text;
    // FormatDateTime('hh:mm',dtStartTime.Time);
    Params.ParamByName('schedule.runtime').Value := trim(NEdtRuntime.Text);
    // Params.ParamByName('schedule.planseatnum').Value := trim
    // (NEdtPLANSEATNUM.Text);
    // if ChkISLINEWORK.Checked then
    // Params.ParamByName('schedule.islinework').Value := True
    // else
    Params.ParamByName('schedule.islinework').Value := False;
    if ChkISPROPRIETARY.Checked then
      Params.ParamByName('schedule.isproprietary').Value := True
    else
      Params.ParamByName('schedule.isproprietary').Value := False;

    if ChkISSELLRETURNTICKET.Checked then
      Params.ParamByName('schedule.issellreturnticket').Value := True
    else
      Params.ParamByName('schedule.issellreturnticket').Value := False;

    if ChkISCANMIXCHECK.Checked then
      Params.ParamByName('schedule.iscanmixcheck').Value := True
    else
      Params.ParamByName('schedule.iscanmixcheck').Value := False;

    // if ChkISOVERTIME.Checked then
    // Params.ParamByName('schedule.isovertime').Value := True
    // else
    // Params.ParamByName('schedule.isovertime').Value := False;

    if ChkISSALEAFTERREPORT.Checked then
      Params.ParamByName('schedule.issaleafterreport').Value := True
    else
      Params.ParamByName('schedule.issaleafterreport').Value := False;
    if ChkISORIGINATOR.Checked then
      Params.ParamByName('schedule.isoriginator').Value := True
    else
      Params.ParamByName('schedule.isoriginator').Value := False;
    // if chkEditAll.Checked then
    // Params.ParamByName('schedule.isEditOtherSchedule').Value := True
    // else
    // Params.ParamByName('schedule.isEditOtherSchedule').Value := False;

    Params.ParamByName('schedule.planseatnum').Value := NEdtPLANSEATNUM.Text;

    Params.ParamByName('schedule.endstation').Value := NEdtEndStation.Text;
    if NEdtStartstationprice.Text='' then
       NEdtStartstationprice.Text:='0';
    Params.ParamByName('schedule.startstationprice').Value := NEdtStartstationprice.Text;

    // else
    // Params.ParamByName('schedule.isfixseat').Value := False;
    Params.ParamByName('schedule.isaudited').Value := ChkPrintSeatno.Checked;
    Params.ParamByName('schedule.isauditpass').Value := False;
    Params.ParamByName('schedule.isactive').Value := True;
    Params.ParamByName('schedule.printinfo').Value := trim(NEdtPRINTINFO.Text);
    // Params.ParamByName('schedule.viastation').Value := trim
    // (NEdtVIASTATION.Text);
    // Params.ParamByName('schedule.remarks').Value := trim(MeREMARKS.Text);
    Params.ParamByName('schedule.createby').Value := createby;
    if createtime <> '' then
      Params.ParamByName('schedule.createtime').Value := createtime;

    Params.ParamByName('schedule.ticketentranceid').Value :=
      NHccbTicketEntrance.HelpFieldValue['id'];
    Params.ParamByName('schedule.vehcileparkid').Value :=
      NHccbVehiclepark.HelpFieldValue['id'];
    // if ChkISLINEWORK.Checked then
    // begin
    // Params.ParamByName('schedule.spacinginterval').Value := trim
    // (NovaEdtSpacinginterval.Text);
    // Params.ParamByName('schedule.endtime').Value := FormatDateTime('hh:mm',
    // DpEndTime.Time);
    // end
    // else
    // begin
    // Params.ParamByName('schedule.spacinginterval').Value := 0;
    // Params.ParamByName('schedule.endtime').Value := null;
    // end;
    Params.ParamByName('scheduleids').Value := scheduleids;
    Params.ParamByName('stationids').Value := stationids;
    if (self.edittype = Tedittype.update) then
      Params.ParamByName('schedule.synccode').Value := synccode;
    try
//       Execute;
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        // if Id > 0 then
        // begin
        log := '批量修改班次信息:修改机构=' + SysInfo.LoginUserInfo.OrgName + ',运营线路=' +
          NHelpRoute.Text + ',班次号=' + schedulecodes + ',运营类别=' +
          CobWORKTYPE.Text + ',营运方式' + CobWORKWAYS.Text + ',运行区域=' +
          CobDISTRICTTYPE.Text + ',班次类型' + CobTYPE.Text + ',运行时间=' +
          NEdtRuntime.Text + ',检票口' + NHccbTicketEntrance.Text +
          ',乘车库=' + NHccbVehiclepark.Text + ',可售站点=' + stationnames;
        if ChkISORIGINATOR.Checked then
          log := log + ',过路班次=是'
        else
          log := log + ',过路班次=否';
        if ChkISSALEAFTERREPORT.Checked then
          log := log + ',报到售票=是'
        else
          log := log + ',报到售票=否';
        if ChkISSELLRETURNTICKET.Checked then
          log := log + ',双程班次=是'
        else
          log := log + ',双程班次=否';

        SysLog.WriteLog('批量修改班次信息', '修改', log);
      end;
      // Id := Params.ParamByName('scheduleid').Value;
      ModalResult := mrok;
      // end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('批量修改班次信息失败：' + E.Message);
      end;
    end;
  end;

end;

function TFrmScheduleBatchEdt.checkSchedule(var msg: String): boolean;
var
  hh, ss: WideString;
begin
  result := False;

  if ((trim(NHelpRoute.Text) = '') or (NHelpRoute.Id = 0)) then
  begin
    msg := '请选择线路！';
    NHelpRoute.SetFocus;
    exit;
  end;

  if (scheduleid <= 0) or (NovaListSchedule.CheckedCount <= 0) then
  begin
    msg := '请选择班次！';
    NovaListSchedule.SetFocus;
    exit;
  end;

  //
  // if trim(NEdtHelpCode.Text) = '' then
  // begin
  // msg := '班次号不能为空！';
  // NEdtHelpCode.SetFocus;
  // exit;
  // end;
  if CobWORKTYPE.ItemIndex < 0 then
  begin
    msg := '请选择运营类别！';
    CobWORKTYPE.SetFocus;
    exit;
  end;
  if CobWORKWAYS.ItemIndex < 0 then
  begin
    msg := '请选择营运方式！';
    CobWORKWAYS.SetFocus;
    exit;
  end;

  if CobDISTRICTTYPE.ItemIndex < 0 then
  begin
    msg := '请选择运行区域！';
    CobDISTRICTTYPE.SetFocus;
    exit;
  end;
  if CobTYPE.ItemIndex < 0 then
  begin
    msg := '请选择班次类型！';
    CobTYPE.SetFocus;
    exit;
  end;

  if NHccbTicketEntrance.ItemIndex < 0 then
  begin
    msg := '请选择检票口！';
    NHccbTicketEntrance.SetFocus;
    exit;
  end;
  //
  // if NHccbVehiclepark.ItemIndex < 0 then
  // begin
  // msg := '请选择上车卡位！';
  // NHccbVehiclepark.SetFocus;
  // exit;
  // end;
  { try
    hh := Copy(medtStartTime.Text, 1, 2);
    if (hh = '') or (StrToInt(hh) >= 24) then
    begin
    msg := '你输入的时间格式有误！';
    medtStartTime.SetFocus;
    exit;
    end;
    if Copy(hh, 1, 1) = ' ' then
    begin
    hh := '0' + trim(hh);
    end;
    ss := Copy(medtStartTime.Text, 4, 2);
    if (ss = '') or (StrToInt(ss) >= 60) then
    begin
    msg := '你输入的时间格式有误！';
    medtStartTime.SetFocus;
    exit;
    end;
    if Copy(ss, 1, 1) = ' ' then
    begin
    ss := '0' + trim(ss);
    end;
    medtStartTime.Text := hh + ':' + ss;
    except
    msg := '你输入的时间格式有误！';
    medtStartTime.SetFocus;
    exit;
    end; }
  { if FormatDateTime('hh:mm',dtStartTime.Time) = '00:00' then
    begin
    msg := '请输入发车时间！';
    dtStartTime.SetFocus;
    exit;
    end; }

  if trim(NEdtRuntime.Text) = '' then
  begin
    msg := '请输入运行小时！';
    NEdtRuntime.SetFocus;
    exit;
  end;

  { if trim(NEdtPLANSEATNUM.Text) = '' then
    begin
    msg := '请输入定员！';
    NEdtPLANSEATNUM.SetFocus;
    exit;
    end; }
  { if ChkISLINEWORK.Checked then
    begin
    if( FormatDateTime('hh:mm',dtStartTime.Time)>FormatDateTime('hh:mm',DpEndTime.Time)) then
    begin
    msg := '始发时间不能大于末班时间！';
    dtStartTime.SetFocus;
    exit;
    end;
    end; }
  result := True;
end;

procedure TFrmScheduleBatchEdt.NHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  with NovaListSchedule do
  begin
    Active := False;
    Params.ParamValues['routeid'] := NHelpRoute.Id;
    Active := True;
  end;
end;

procedure TFrmScheduleBatchEdt.FormCreate(Sender: TObject);
begin
  inherited;
  CobWORKTYPE.Active := False;
  CobWORKTYPE.Active := True;
  CobWORKWAYS.Active := False;
  CobWORKWAYS.Active := True;
  CobDISTRICTTYPE.Active := False;
  CobDISTRICTTYPE.Active := True;
  CobTYPE.Active := False;
  CobTYPE.Active := True;
  with NHccbTicketEntrance do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!orgid'] := SysInfo.LoginUserInfo.OrgID;
    Active := True;
  end;
  with NHccbVehiclepark do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!orgid'] := SysInfo.LoginUserInfo.OrgID;
    Active := True;
  end;
end;

procedure TFrmScheduleBatchEdt.FormShow(Sender: TObject);
begin
  inherited;
  if scheduleid > 0 then
  begin
    with jsonSchedulestation do
    begin
      Active := False;
      Params.ParamValues['schedule.id'] := scheduleid;
      Active := True;
    end;
  end;
end;

end.
