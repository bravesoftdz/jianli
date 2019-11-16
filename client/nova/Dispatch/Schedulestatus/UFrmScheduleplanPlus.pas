unit UFrmScheduleplanPlus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, NovaHComboBox,
  NovaComboBox;

type
  TFrmScheduleplanPlus = class(TSimpleEditForm)
    Label2: TLabel;
    NovaHelpRoute: TNovaHelp;
    Label17: TLabel;
    Label19: TLabel;
    dtpStartdate_p: TDateTimePicker;
    dtpEnddate_p: TDateTimePicker;
    Label3: TLabel;
    Label1: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    NEdtHelpCode: TNovaEdit;
    dtpStartTime: TDateTimePicker;
    Label4: TLabel;
    lbl3: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    jscdscheduleplanplus: TjsonClientDataSet;
    Label5: TLabel;
    Nhcbformula: TNovaHComboBox;
    Label8: TLabel;
    Label16: TLabel;
    NEdtPLANSEATNUM: TNovaEdit;
    CheckBox1: TCheckBox;
    NovaEdtMinute: TNovaEdit;
    Label6: TLabel;
    jscdSynSche: TjsonClientDataSet;
    lbl4: TLabel;
    NovaHUnit: TNovaHelp;
    Label7: TLabel;
    CobSchStatus: TComboBox;
    Label9: TLabel;
    jscdgenSchCode: TjsonClientDataSet;
    ChkIsSellstopStation: TCheckBox;
    Label13: TLabel;
    NovaHComDeduct: TNovaHComboBox;
    Label14: TLabel;
    Label22: TLabel;
    CobWORKTYPE: TNovaComboBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHelp;
    chkIsreport: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NvHcbbVehiclebrandmodelIdChange(Sender: TObject);
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
  private
    { Private declarations }
    day:integer;
  public
    { Public declarations }
    scheduleplanid,routeid:Int64;
  end;

var
  FrmScheduleplanPlus: TFrmScheduleplanPlus;

implementation
uses PubFn, Services,  UDMPublic;
{$R *.dfm}

procedure TFrmScheduleplanPlus.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (formatdatetime('yyyymmdd', dtpStartdate_p.Date) > formatdatetime('yyyymmdd',
      dtpEnddate_p.Date)) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    dtpStartdate_p.SetFocus;
    exit;
  end;

  if (dtpEnddate_p.Date-trunc(now))>day then
  begin
     SysDialogs.ShowMessage('加班天数不能超过'+inttostr(day)+'天！');
     dtpEnddate_p.SetFocus;
     exit;
  end;


  if trim(NEdtHelpCode.Text)='' then
  begin
    SysDialogs.ShowMessage('班次号不能为空！');
    NEdtHelpCode.SetFocus;
    exit;
  end;
  if NvHcbbVehiclebrandmodel.id<=0 then
  begin
    SysDialogs.ShowMessage('计划车辆厂牌不允许为空！');
    NvHcbbVehiclebrandmodel.SetFocus;
    exit;
  end;
  if CobWORKTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('营运类别不允许为空！');
    CobWORKTYPE.SetFocus;
    exit;
  end;
  if (chkIsreport.Checked) and (NovaHelpVehicleno.Id<=0) then
  begin
    SysDialogs.ShowMessage('报班时计划车辆不能为空！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;


 with jscdscheduleplanplus do
  begin
    close;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.worktype').Value := CobWORKTYPE.ItemIndex;
    Params.ParamByName('schedule.starttime').Value := FormatDateTime('hh:mm',dtpStartTime.Time);
    Params.ParamByName('schedule.createby').Value :=Sysinfo.LoginUserInfo.UserID;
    Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd',dtpStartdate_p.Date);
    Params.ParamByName('enddate').Value :=formatdatetime('yyyy-mm-dd',dtpEnddate_p.Date);
    Params.ParamByName('vehicleid').Value := NovaHelpVehicleno.Id;
    Params.ParamByName('vehiclebrandmodelid').Value := NvHcbbVehiclebrandmodel.id;
    Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
    if Nhcbformula.ItemIndex>=0 then
      Params.ParamByName('balanceformulaid').Value := Nhcbformula.HelpFieldValue['id']
    else
      Params.ParamByName('balanceformulaid').Value := 0;
    if NovaHComDeduct.ItemIndex>=0 then
      Params.ParamByName('balancedeductitemid').Value := NovaHComDeduct.HelpFieldValue['id']
    else
      Params.ParamByName('balancedeductitemid').Value := 0;
    Params.ParamByName('unitid').Value := NovaHUnit.Id;
    if  CobSchStatus.ItemIndex=0 then
      Params.ParamByName('status').Value := 0
    else
      Params.ParamByName('status').Value := 5;//停售

    Params.ParamByName('delayminute').Value := NovaEdtMinute.text;
    Params.ParamByName('issellstopstation').Value := ChkIsSellstopStation.Checked;
    Params.ParamByName('isreport').Value := chkIsreport.Checked;
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
        scheduleplanid:=Params.ParamByName('newscheduleplanid').Value;
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

procedure TFrmScheduleplanPlus.FormCreate(Sender: TObject);
begin
  inherited;
  CobWORKTYPE.Active:=false;
  CobWORKTYPE.Active:=true;
end;

procedure TFrmScheduleplanPlus.FormShow(Sender: TObject);
var
  isStowage:boolean;
begin
  inherited;
  day:=StrToInt(getParametervalue('0009', Sysinfo.LoginUserInfo.OrgID));
  with jscdgenSchCode do
  begin
    active:=false;
    Params.ParamByName('routeid').Value :=NovaHelpRoute.Id;
    execute;
    NEdtHelpCode.Text:=Params.ParamByName('schcode').Value;
  end;
  if getParametervalue('2016', sysInfo.LoginUserInfo.OrgID) = '1' then
    begin
      self.Label5.Visible:=true;
      Nhcbformula.Visible:=true;
      Label13.Visible:=true;
      NovaHComDeduct.Visible:=true;
    end
  else
    begin
      self.Label5.Visible:=False;
      Nhcbformula.Visible:=False;
      Label13.Visible:=false;
      NovaHComDeduct.Visible:=false;
    end;
  Nhcbformula.Active:=false;
  Nhcbformula.Active:=True;
  //20160328王远媛添加--固定扣费帮助框：机构过滤
  with NovaHComDeduct do
  begin
    Params.ParamByName('filter_EQL_t!orgid').Value := Sysinfo.LoginUserInfo.OrgID;
  end;
  NovaHComDeduct.Active:=false;
  NovaHComDeduct.Active:=true;
  with jscdSynSche do
  begin
    active:=false;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    execute;
    isStowage := Params.ParamByName('stowage').AsBoolean;
    if isStowage then
    begin
      CheckBox1.Enabled:=true;
      NovaEdtMinute.Enabled:=true;
    end
    else
    begin
      CheckBox1.Enabled:=false;
      NovaEdtMinute.Enabled:=false;
    end;
  end;

  dtpStartTime.SetFocus;
end;


procedure TFrmScheduleplanPlus.NovaHelpVehiclenoIdChange(Sender: TObject);
var
  brandid :String;
begin
  inherited;
//  brandid := NovaHelpVehicleno.HelpFieldValue['brandid'];
  NvHcbbVehiclebrandmodel.Text:= NovaHelpVehicleno.HelpFieldValue['brandname'];
  NvHcbbVehiclebrandmodel.Id :=  NovaHelpVehicleno.HelpFieldValue['brandid'];
  NEdtPLANSEATNUM.text :=  NovaHelpVehicleno.HelpFieldValue['seatnum'];
end;

procedure TFrmScheduleplanPlus.NvHcbbVehiclebrandmodelIdChange(Sender: TObject);
begin
  inherited;
  if NvHcbbVehiclebrandmodel.isactive and (NvHcbbVehiclebrandmodel.Id>0)
  then
  begin
     NEdtPLANSEATNUM.Text:= NvHcbbVehiclebrandmodel.HelpFieldValue['rationseatnum'];
  end;
end;

end.
