unit UFrmScheduleplanPlus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, NovaHComboBox;

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
    Label12: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHComboBox;
    NovaVehicletype: TNovaHComboBox;
    Label8: TLabel;
    Label16: TLabel;
    NEdtPLANSEATNUM: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaVehicletypeChange(Sender: TObject);
    procedure NvHcbbVehiclebrandmodelChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleplanid:Int64;
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

 with jscdscheduleplanplus do
  begin
    close;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.starttime').Value := FormatDateTime('hh:mm',dtpStartTime.Time);
    Params.ParamByName('schedule.createby').Value :=Sysinfo.LoginUserInfo.UserID;
    Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd',dtpStartdate_p.Date);
    Params.ParamByName('enddate').Value :=formatdatetime('yyyy-mm-dd',dtpEnddate_p.Date);
    Params.ParamByName('vehicleid').Value := NovaHelpVehicleno.Id;
    Params.ParamByName('vehiclebrandmodelid').Value := NvHcbbVehiclebrandmodel.HelpFieldValue['id'];
    Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
    if Nhcbformula.ItemIndex>=0 then
      Params.ParamByName('balanceformulaid').Value := Nhcbformula.HelpFieldValue['id']
    else
      Params.ParamByName('balanceformulaid').Value := 0;
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
  NovaVehicletype.Active:=false;
  NovaVehicletype.Active:=true;
end;

procedure TFrmScheduleplanPlus.FormShow(Sender: TObject);
begin
  inherited;
  if getParametervalue('2016', sysInfo.LoginUserInfo.OrgID) = '1' then
    begin
      self.Label5.Visible:=true;
      Nhcbformula.Visible:=true;
    end
  else
    begin
      self.Label5.Visible:=False;
      Nhcbformula.Visible:=False;
    end;
  Nhcbformula.Active:=false;
  Nhcbformula.Active:=True;
  NEdtHelpCode.SetFocus;
end;

procedure TFrmScheduleplanPlus.NovaHelpVehiclenoIdChange(Sender: TObject);
begin
  inherited;
  if NovaHelpVehicleno.Id>0 then
  begin
    NovaVehicletype.SetItemIndexByField('id',NovaHelpVehicleno.HelpFieldValue['vehicletypeid']);
    NovaVehicletypeChange(sender);
    NvHcbbVehiclebrandmodel.SetItemIndexByField('id',NovaHelpVehicleno.HelpFieldValue['brandid']);
    NovaVehicletype.Enabled:=false;
    NvHcbbVehiclebrandmodel.Enabled:=false;
    NEdtPLANSEATNUM.Text:= NovaHelpVehicleno.HelpFieldValue['seatnum']  ;
  end
  else
  begin
    NovaVehicletype.Enabled:=true;
    NvHcbbVehiclebrandmodel.Enabled:=true;
  end;
end;

procedure TFrmScheduleplanPlus.NovaVehicletypeChange(Sender: TObject);
begin
  inherited;
  if NovaVehicletype.ItemIndex>=0 then
  begin
    NvHcbbVehiclebrandmodel.Active:=false;
    NvHcbbVehiclebrandmodel.Params.ParamValues['filter_EQL_t!vehicletypeid']:=NovaVehicletype.HelpFieldValue['id'];
    NvHcbbVehiclebrandmodel.Active:=True;
  end;
end;

procedure TFrmScheduleplanPlus.NvHcbbVehiclebrandmodelChange(Sender: TObject);
begin
  inherited;
  if NvHcbbVehiclebrandmodel.ItemIndex>=0 then
  begin
    NEdtPLANSEATNUM.Text:=NvHcbbVehiclebrandmodel.HelpFieldValue['rationseatnum'];
  end;
end;

end.
