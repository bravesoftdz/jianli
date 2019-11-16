unit UPlusScheduleEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, Services,
  NovaHComboBox, ComCtrls, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet,
  ImgList;

type
  TFrmPlusScheduleEdt = class(TSimpleEditForm)
    Label2: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label1: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    NHelpRoute: TNovaHelp;
    NEdtHelpCode: TNovaEdit;
    dtStartTime: TDateTimePicker;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    lbl4: TLabel;
    NovaHUnit: TNovaHelp;
    Label12: TLabel;
    lbl3: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    Label23: TLabel;
    Label26: TLabel;
    GpOtherInfo: TGroupBox;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label9: TLabel;
    NEdtRuntime: TNovaEdit;
    CobWORKTYPE: TNovaComboBox;
    CobWORKWAYS: TNovaComboBox;
    CobDISTRICTTYPE: TNovaComboBox;
    CobTYPE: TNovaComboBox;
    ChkISCANMIXCHECK: TCheckBox;
    ChkISORIGINATOR: TCheckBox;
    ChkISSELLRETURNTICKET: TCheckBox;
    ChkISSALEAFTERREPORT: TCheckBox;
    ChkISPROPRIETARY: TCheckBox;
    Label17: TLabel;
    DpStartdate: TDateTimePicker;
    Label19: TLabel;
    DpEnddate: TDateTimePicker;
    Label20: TLabel;
    NEdtPRINTINFO: TNovaEdit;
    jcsdqryCycleVehicletype: TjsonClientDataSet;
    Label21: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    jcdsScheduleplus: TjsonClientDataSet;
    NEdtPLANSEATNUM: TNovaEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label30: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHComboBox;
    NovaVehicletype: TNovaHComboBox;
    Label31: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaVehicletypeChange(Sender: TObject);
    procedure NvHcbbVehiclebrandmodelChange(Sender: TObject);
    procedure DpStartdateChange(Sender: TObject);
    procedure DpEnddateChange(Sender: TObject);
  private
    { Private declarations }
    routeidchange: boolean;
    day:integer;
  public
    { Public declarations }
    id, createby: int64;
    scheduleid,curorgid:Int64;//模版班次
    editstartdate,editenddate:TDateTime;
  end;

var
  FrmPlusScheduleEdt: TFrmPlusScheduleEdt;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmPlusScheduleEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (formatdatetime('yyyymmdd', DpStartdate.Date) > formatdatetime('yyyymmdd',
      DpEnddate.Date)) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    DpStartdate.SetFocus;
    exit;
  end;
  if (DpEnddate.Date-trunc(now))>day then
  begin
     SysDialogs.ShowMessage('加班天数不能超过'+inttostr(day)+'天！');
     DpEnddate.SetFocus;
     exit;
  end;
  if NHelpRoute.id <= 0 then
  begin
    SysDialogs.ShowMessage('营运线路不能为空！');
    NHelpRoute.SetFocus;
    exit;
  end;
  if trim(NEdtHelpCode.Text)='' then
  begin
    SysDialogs.ShowMessage('班次号不能为空！');
    NEdtHelpCode.SetFocus;
    exit;
  end;

  if NvHcbbVehiclebrandmodel.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('计划车辆厂牌不允许为空！');
    NvHcbbVehiclebrandmodel.SetFocus;
    exit;
  end;
  if trim(NEdtPLANSEATNUM.Text)='' then
  begin
    SysDialogs.ShowMessage('定员不能为空！');
    NEdtPLANSEATNUM.SetFocus;
    exit;
  end
  else if trim(NEdtPLANSEATNUM.Text) = '0' then
  begin
    SysDialogs.ShowMessage('定员不能为0！');
    NEdtPLANSEATNUM.SetFocus;
    exit;
  end;

  if NHccbTicketEntrance.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择检票口！');
    NHccbTicketEntrance.SetFocus;
    exit;
  end;

  if NHccbVehiclepark.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择上车卡位！');
    NHccbVehiclepark.SetFocus;
    exit;
  end;

  if CobWORKTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择运营类别！');
    CobWORKTYPE.SetFocus;
    exit;
  end;
  if CobWORKWAYS.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择营运方式！');

    CobWORKWAYS.SetFocus;
    exit;
  end;

  if CobDISTRICTTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择运行区域！');
    CobDISTRICTTYPE.SetFocus;
    exit;
  end;
  if CobTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择班次类型！');
    CobTYPE.SetFocus;
    exit;
  end;

 with jcdsScheduleplus do
  begin
    close;
    Params.ParamByName('mbscheduleid').Value := scheduleid;
    Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.route.id').Value := NHelpRoute.id;
    Params.ParamByName('schedule.worktype').Value := CobWORKTYPE.GetSelectCode;
    Params.ParamByName('schedule.workways').Value := CobWORKWAYS.GetSelectCode;
    Params.ParamByName('schedule.districttype').Value :=
      CobDISTRICTTYPE.GetSelectCode;
    Params.ParamByName('schedule.type').Value := CobTYPE.GetSelectCode;
    Params.ParamByName('schedule.starttime').Value := FormatDateTime('hh:mm',dtStartTime.Time);
    Params.ParamByName('schedule.runtime').Value := trim(NEdtRuntime.Text);
    Params.ParamByName('schedule.planseatnum').Value := trim
      (NEdtPLANSEATNUM.Text);
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

    if ChkISSALEAFTERREPORT.Checked then
      Params.ParamByName('schedule.issaleafterreport').Value := True
    else
      Params.ParamByName('schedule.issaleafterreport').Value := False;
    if ChkISORIGINATOR.Checked then
      Params.ParamByName('schedule.isoriginator').Value := True
    else
      Params.ParamByName('schedule.isoriginator').Value := False;

    Params.ParamByName('schedule.printinfo').Value := trim(NEdtPRINTINFO.Text);
    Params.ParamByName('schedule.createby').Value :=createby;
    Params.ParamByName('schedule.ticketentranceid').Value :=NHccbTicketEntrance.HelpFieldValue['id'];
    Params.ParamByName('schedule.vehcileparkid').Value := NHccbVehiclepark.HelpFieldValue['id'];
    Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd',DpStartdate.Date);
    Params.ParamByName('enddate').Value :=formatdatetime('yyyy-mm-dd',DpEnddate.Date);
    Params.ParamByName('unitid').Value :=NovaHUnit.id;
    Params.ParamByName('vehicletypeid').Value := NovaVehicletype.HelpFieldValue['id'];
    Params.ParamByName('vehiclebrandmodelid').Value := NvHcbbVehiclebrandmodel.HelpFieldValue['id'];
    Params.ParamByName('vehicleid').Value := NovaHelpVehicleno.Id;
    Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
    Params.ParamByName('schedule.orgid').Value := curorgid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NEdtHelpCode.SetFocus;
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        id:=Params.ParamByName('scheduleid').Value;
        editstartdate := DpStartdate.Date;
        editenddate:=DpEnddate.Date;
        ModalResult := mrok;

      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('加班操作失败：' + E.Message);
      end;
    end;
  end;


end;

procedure TFrmPlusScheduleEdt.DpEnddateChange(Sender: TObject);
begin
  inherited;
  if DpStartdate.Date>DpEnddate.Date then
     DpStartdate.Date:= DpEnddate.Date;
end;

procedure TFrmPlusScheduleEdt.DpStartdateChange(Sender: TObject);
begin
  inherited;
  if DpStartdate.Date>DpEnddate.Date then
    DpEnddate.Date :=  DpStartdate.Date;
end;

procedure TFrmPlusScheduleEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NHccbTicketEntrance.Active := false;
  NHccbTicketEntrance.Active := true;
  NHccbVehiclepark.Active := false;
  NHccbVehiclepark.Active := true;
  CobWORKTYPE.Active := false;
  CobWORKTYPE.Active := true;
  CobWORKWAYS.Active := false;
  CobWORKWAYS.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
  CobTYPE.Active := false;
  CobTYPE.Active := true;
  DpStartdate.Date:=now;
  DpEnddate.Date:=now;
  NovaVehicletype.Active:=false;
  NovaVehicletype.Active:=true;
end;

procedure TFrmPlusScheduleEdt.FormShow(Sender: TObject);
begin
  inherited;
  day:=StrToInt(getParametervalue('0009', Sysinfo.LoginUserInfo.OrgID));
  with jcsdqryCycleVehicletype do
  begin
      Active := false;
      Params.ParamValues['scheduleid'] := scheduleid;
      Active := true;
      if recordcount > 0 then
      begin
         NovaHUnit.Text:=fieldbyname('unitname').AsString;
         NovaHUnit.Id:=fieldbyname('unitid').AsLargeInt;
         NovaVehicletype.SetItemIndexByField('id',fieldbyname('vehicletypeid').AsLargeInt);
         NovaVehicletypeChange(Sender);
         NvHcbbVehiclebrandmodel.SetItemIndexByField('id',fieldbyname('vehiclebrandmodelid').AsLargeInt);
         NvHcbbVehiclebrandmodelChange(Sender);
      end;
  end;
end;

procedure TFrmPlusScheduleEdt.NovaHelpVehiclenoIdChange(Sender: TObject);
begin
  inherited;
  if (NovaHelpVehicleno.isactive)
   and  (NovaHelpVehicleno.Id>0) then
  begin
    NovaVehicletype.SetItemIndexByField('id',NovaHelpVehicleno.HelpFieldValue['vehicletypeid']);
    NovaHUnit.Text:= NovaHelpVehicleno.HelpFieldValue['unitname'];
    NovaHUnit.id:= NovaHelpVehicleno.HelpFieldValue['unitid'];
    NEdtPLANSEATNUM.Text:=NovaHelpVehicleno.HelpFieldValue['seatnum'];
  end;
end;


procedure TFrmPlusScheduleEdt.NovaVehicletypeChange(Sender: TObject);
begin
  inherited;
  if NovaVehicletype.ItemIndex>=0 then
  begin
    NvHcbbVehiclebrandmodel.Active:=false;
    NvHcbbVehiclebrandmodel.Params.ParamValues['filter_EQL_t!vehicletypeid']:=NovaVehicletype.HelpFieldValue['id'];
    NvHcbbVehiclebrandmodel.Active:=True;
  end;
end;

procedure TFrmPlusScheduleEdt.NvHcbbVehiclebrandmodelChange(Sender: TObject);
begin
  inherited;
  if NvHcbbVehiclebrandmodel.ItemIndex>=0 then
  begin
    NEdtPLANSEATNUM.Text:=NvHcbbVehiclebrandmodel.HelpFieldValue['rationseatnum'];
  end;
end;

end.
