unit UFrmScheduleEdit;

{ ------------------------------------
  功能说明：添加班次信息
  创建日期：2011.01.28
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, Mask, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet, Services, NovaComboBox, ComCtrls,
  NovaHComboBox, ImgList;

type
  TFrmSchdeuleEdit = class(TSimpleEditForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    NHelpRoute: TNovaHelp;
    NEdtHelpCode: TNovaEdit;
    Label1: TLabel;
    Label9: TLabel;
    ChkISPROPRIETARY: TCheckBox;
    ChkISOVERTIME: TCheckBox;
    ChkISSELLRETURNTICKET: TCheckBox;
    ChkISLINEWORK: TCheckBox;
    ChkISORIGINATOR: TCheckBox;
    ChkISSALEAFTERREPORT: TCheckBox;
    ChkISCANMIXCHECK: TCheckBox;
    NEdtRuntime: TNovaEdit;
    Label10: TLabel;
    NEdtPRINTINFO: TNovaEdit;
    Label11: TLabel;
    NEdtVIASTATION: TNovaEdit;
    Label12: TLabel;
    MeREMARKS: TMemo;
    jsonCDSSaveSchedule: TjsonClientDataSet;
    Label5: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    NEdtPLANSEATNUM: TNovaEdit;
    CobWORKTYPE: TNovaComboBox;
    CobWORKWAYS: TNovaComboBox;
    CobDISTRICTTYPE: TNovaComboBox;
    CobTYPE: TNovaComboBox;
    Label24: TLabel;
    Label25: TLabel;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    Label26: TLabel;
    DpEndTime: TDateTimePicker;
    NovaEdtSpacinginterval: TNovaEdit;
    Label29: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    lbl4: TLabel;
    medtStartTime: TMaskEdit;
    chkEditAll: TCheckBox;
    Chkisfixseat: TCheckBox;
    ChkPrintSeatno: TCheckBox;
    Cbxisneed: TCheckBox;
    Label23: TLabel;
    NvedtDrivernum: TNovaEdit;
    NEdtEndStation: TNovaEdit;
    NEdtStartstationprice: TNovaEdit;
    lblendstation: TLabel;
    lblstartstationprice: TLabel;
    ChbPrintDepartTiime: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure ChkISLINEWORKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaCbbOrgChange(Sender: TObject);
    procedure CbxisneedClick(Sender: TObject);
  private
    { Private declarations }
    log: string;
    function checkSchedule(var msg: String): boolean;
  public
    { Public declarations }
    id, createby,routeid: Int64;
    ticketentrance, vehcilepark: string;
    createtime, code, synccode,routename: string;
    worktype, workways, districttype, scheduletype: String;
  end;

var
  FrmSchdeuleEdit: TFrmSchdeuleEdit;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSchdeuleEdit.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult: string;
begin
  inherited;

  if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  if (edittype = Tedittype.add) and (NHelpRoute.isactive) and
    (NHelpRoute.HelpFieldValue['orgid'] <> SysInfo.LoginUserInfo.OrgID) then
  begin
    if not SysDialogs.Ask('提示信息', '该线路所属机构与当前登录机构不是同一机构，是否保存！') then
      exit;
  end;
  if (edittype = Tedittype.update)
  and (NHelpRoute.Id<>routeid) then
    if not SysDialogs.Confirm('修改操作', '班次所属线路已经改变，确认要修改吗？') then
    begin
      exit;
    end;

  with jsonCDSSaveSchedule do
  begin
    close;
    Params.ParamByName('schedule.orgid').Value := NovaCbbOrg.HelpFieldValue
      ['id'];
    Params.ParamByName('schedule.id').Value := id;
    Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.route.id').Value := NHelpRoute.id;
    Params.ParamByName('schedule.worktype').Value := CobWORKTYPE.GetSelectCode;
    Params.ParamByName('schedule.workways').Value := CobWORKWAYS.GetSelectCode;
    Params.ParamByName('schedule.districttype').Value :=
      CobDISTRICTTYPE.GetSelectCode;
    Params.ParamByName('schedule.type').Value := CobTYPE.GetSelectCode;
    Params.ParamByName('schedule.starttime').Value := medtStartTime.Text;
    // FormatDateTime('hh:mm',dtStartTime.Time); 
    Params.ParamByName('schedule.runtime').Value := trim(NEdtRuntime.Text);
    Params.ParamByName('schedule.planseatnum').Value := trim
      (NEdtPLANSEATNUM.Text);
    if ChkISLINEWORK.Checked then
      Params.ParamByName('schedule.islinework').Value := True
    else
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

    if ChkISOVERTIME.Checked then
      Params.ParamByName('schedule.isovertime').Value := True
    else
      Params.ParamByName('schedule.isovertime').Value := False;

    if ChkISSALEAFTERREPORT.Checked then
      Params.ParamByName('schedule.issaleafterreport').Value := True
    else
      Params.ParamByName('schedule.issaleafterreport').Value := False;
    if ChkISORIGINATOR.Checked then
      Params.ParamByName('schedule.isoriginator').Value := True
    else
      Params.ParamByName('schedule.isoriginator').Value := False;
    if chkEditAll.Checked then
      Params.ParamByName('schedule.isEditOtherSchedule').Value := True
    else
      Params.ParamByName('schedule.isEditOtherSchedule').Value := False;
    if Chkisfixseat.Checked then
      Params.ParamByName('schedule.isfixseat').Value := True
    else
      Params.ParamByName('schedule.isfixseat').Value := False;

    if Cbxisneed.Checked then
    begin
      Params.ParamByName('schedule.isneedfinger').Value := True;
      Params.ParamByName('schedule.driverfingernum').Value
                        := NvedtDrivernum.Text ;
    end
    else
    begin
      Params.ParamByName('schedule.isneedfinger').Value := False;
      Params.ParamByName('schedule.driverfingernum').Value := '0';
    end;
    Params.ParamByName('schedule.isaudited').Value := ChkPrintSeatno.Checked;
    Params.ParamByName('schedule.isauditpass').Value := ChbPrintDepartTiime.Checked;
    Params.ParamByName('schedule.isactive').Value := True;
    Params.ParamByName('schedule.printinfo').Value := trim(NEdtPRINTINFO.Text);
    Params.ParamByName('schedule.viastation').Value := trim
      (NEdtVIASTATION.Text);
    Params.ParamByName('schedule.remarks').Value := trim(MeREMARKS.Text);
    Params.ParamByName('schedule.createby').Value := createby;
    if createtime <> '' then

      Params.ParamByName('schedule.createtime').Value := createtime;

    Params.ParamByName('schedule.ticketentranceid').Value :=
      NHccbTicketEntrance.HelpFieldValue['id'];
    Params.ParamByName('schedule.vehcileparkid').Value :=
      NHccbVehiclepark.HelpFieldValue['id'];
    if ChkISLINEWORK.Checked then
    begin
      Params.ParamByName('schedule.spacinginterval').Value := trim
        (NovaEdtSpacinginterval.Text);
      Params.ParamByName('schedule.endtime').Value := FormatDateTime('hh:mm',
        DpEndTime.Time);
    end
    else
    begin
      Params.ParamByName('schedule.spacinginterval').Value := 0;
      Params.ParamByName('schedule.endtime').Value := null;
    end;

    Params.ParamByName('schedule.endstation').Value := trim(NEdtEndStation.Text);
    Params.ParamByName('schedule.startstationprice').Value := trim(NEdtStartstationprice.Text);

    if (self.edittype = Tedittype.update) then
      Params.ParamByName('schedule.synccode').Value := synccode;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        if pos('班次号', sResult) > 0 then
          NEdtHelpCode.SetFocus;
      end
      else
      begin
        if id>0 then
        begin
          log:='修改班次信息:所属机构='+NovaCbbOrg.Text+',运营线路='+NHelpRoute.Text
          +',班次号='+NEdtHelpCode.Text+',运营类别='+CobWORKTYPE.Text+',营运方式'
          + CobWORKWAYS.Text+',运行区域='+CobDISTRICTTYPE.Text+',班次类型'
          + CobTYPE.Text+',始发时间='+medtStartTime.Text+',运行时间='+NEdtRuntime.Text
          +',检票口'+NHccbTicketEntrance.Text+',乘车库='+NHccbVehiclepark.Text
          +',定员'+NEdtPLANSEATNUM.Text;
          if routename<>NHelpRoute.Text then
              log:=log+',所属线路由原来:'+routename+'改为:'+NHelpRoute.Text;
          if ChkISORIGINATOR.Checked then
            log:=log+',过路班次=是'
          else
            log:=log+',过路班次=否';
          if ChkISSALEAFTERREPORT.Checked then
            log:=log+',报到售票=是'
          else
            log:=log+',报到售票=否';
          if ChkISCANMIXCHECK.Checked then
            log:=log+',允许混检=是'
          else
            log:=log+',允许混检=否';
          if ChkISPROPRIETARY.Checked then
            log:=log+',本站专营=是'
          else
            log:=log+',本站专营=否';
          if chkEditAll.Checked then
            log:=log+',同时修改本线路其他班次=是'
          else
            log:=log+',同时修改本线路其他班次=否';
          if Chkisfixseat.Checked then
            log:=log+',固定座位数=是'
          else
            log:=log+',固定座位数=否';
          SysLog.WriteLog('修改班次信息', '修改', log);            
        end;
        id := Params.ParamByName('scheduleid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSchdeuleEdit.CbxisneedClick(Sender: TObject);
begin
  inherited;
  if Cbxisneed.Checked then
  begin
     NvedtDrivernum.Visible := true;
     Label23.Visible := true;
  end
  else
  begin
     NvedtDrivernum.Visible:=false;
     Label23.Visible := false;
  end;

end;

function TFrmSchdeuleEdit.checkSchedule(var msg: String): boolean;
var
  hh, ss: WideString;
begin
  result := False;
  if NovaCbbOrg.ItemIndex < 0 then
  begin
    msg := '请选择班次所属机构！';
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if ((NHelpRoute.Text = '') or (NHelpRoute.id <= 0)) then
  begin
    msg := '运营线路不能为空！';
    NHelpRoute.SetFocus;
    exit;
  end;
  if trim(NEdtHelpCode.Text) = '' then
  begin
    msg := '班次号不能为空！';
    NEdtHelpCode.SetFocus;
    exit;
  end;
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

  if NHccbVehiclepark.ItemIndex < 0 then
  begin
    msg := '请选择上车卡位！';
    NHccbVehiclepark.SetFocus;
    exit;
  end;
  try
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
  end;
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

  if trim(NEdtPLANSEATNUM.Text) = '' then
  begin
    msg := '请输入定员！';
    NEdtPLANSEATNUM.SetFocus;
    exit;
  end;
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

procedure TFrmSchdeuleEdit.ChkISLINEWORKClick(Sender: TObject);
begin
  inherited;
  if ChkISLINEWORK.Checked then
  begin
    DpEndTime.Enabled := True;
    NovaEdtSpacinginterval.Enabled := True;
  end
  else
  begin
    DpEndTime.Enabled := False;
    NovaEdtSpacinginterval.Enabled := False;
  end;
end;

procedure TFrmSchdeuleEdit.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] := '(1,2)'; // 车站、配客点
    Active := True;
  end;

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

procedure TFrmSchdeuleEdit.NovaCbbOrgChange(Sender: TObject);
begin
  inherited;
  if NovaCbbOrg.ItemIndex >= 0 then
  begin
    NHelpRoute.Params.ParamValues['filter_EQL_t!orgid'] :=
      NovaCbbOrg.HelpFieldValue['id'];
    with NHccbTicketEntrance do
    begin
      Active := False;
      Params.ParamValues['filter_EQL_t!orgid'] := NovaCbbOrg.HelpFieldValue
        ['id'];
      Active := True;
    end;
    with NHccbVehiclepark do
    begin
      Active := False;
      Params.ParamValues['filter_EQL_t!orgid'] := NovaCbbOrg.HelpFieldValue
        ['id'];
      Active := True;
    end;

  end
  else
  begin
    NHelpRoute.Clear;
    NHelpRoute.id := 0;
  end;
end;




end.
