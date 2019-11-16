unit UFrmScheduleplanRoutePlus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, NovaHComboBox, Services,
  NovaComboBox;

type
  TFrmScheduleplanRoutePlus = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHelpRoute: TNovaHelp;
    dtpStartdate_p: TDateTimePicker;
    dtpEnddate_p: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NEdtHelpCode: TNovaEdit;
    Label6: TLabel;
    dtpStartTime: TDateTimePicker;
    ChkIsSellstopStation: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHelp;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    jscdscheduleplanplus: TjsonClientDataSet;
    CobSchStatus: TComboBox;
    CobWORKTYPE: TNovaComboBox;
    Label20: TLabel;
    Nhcbformula: TNovaHComboBox;
    Label25: TLabel;
    NovaHComDeduct: TNovaHComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    NcbbTicketEntrance: TNovaHComboBox;
    NcbbVehiclepark: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NvHcbbVehiclebrandmodelIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleid:Int64;
  end;

var
  FrmScheduleplanRoutePlus: TFrmScheduleplanRoutePlus;

implementation
{$R *.dfm}

procedure TFrmScheduleplanRoutePlus.FormCreate(Sender: TObject);
begin
  inherited;
  CobWORKTYPE.Active := False;
  CobWORKTYPE.Active := True;

  // SysDialogs.ShowMessage('chjuangjiaj！');
end;

procedure TFrmScheduleplanRoutePlus.FormShow(Sender: TObject);
begin
  inherited;
  CobWORKTYPE.ItemIndex:=0;
    with NcbbTicketEntrance do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!orgid'] := SysInfo.LoginUserInfo.OrgID;
    Active := True;
    NcbbTicketEntrance.ItemIndex:=0;
  end;
  with NcbbVehiclepark do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!orgid'] := SysInfo.LoginUserInfo.OrgID;
    Active := True;
    NcbbVehiclepark.ItemIndex:=0;
  end;


 
end;

procedure TFrmScheduleplanRoutePlus.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHelpRoute.Text)='' )or (NovaHelpRoute.Id<=0) then
  begin
    SysDialogs.ShowMessage('运营线路不能为空！');
    NovaHelpRoute.SetFocus;
    exit;
  end;
  if (formatdatetime('yyyymmdd', dtpStartdate_p.Date) > formatdatetime
      ('yyyymmdd', dtpEnddate_p.Date)) then
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
  if (trim(NvHcbbVehiclebrandmodel.Text)='') or (NvHcbbVehiclebrandmodel.Id<=0) then
  begin
    SysDialogs.ShowMessage('厂牌型号不能为空！');
    NvHcbbVehiclebrandmodel.SetFocus;
    exit;
  end;
  with jscdscheduleplanplus do
  begin
    close;
    Params.ParamByName('routeid').Value := NovaHelpRoute.Id;
    Params.ParamByName('schedule.code').Value := trim(NEdtHelpCode.Text);
    Params.ParamByName('schedule.worktype').Value := CobWORKTYPE.ItemIndex;
      params.ParamByName('schedule.vehcileparkid').Value :=
        NcbbVehiclepark.HelpFieldValue['id'];
      params.ParamByName('schedule.ticketentranceid').Value :=
        NcbbTicketEntrance.HelpFieldValue['id'];
    Params.ParamByName('schedule.starttime').Value := FormatDateTime('hh:mm',dtpStartTime.Time);
    Params.ParamByName('schedule.createby').Value :=Sysinfo.LoginUserInfo.UserID;
    Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd',dtpStartdate_p.Date);
    Params.ParamByName('enddate').Value :=formatdatetime('yyyy-mm-dd',dtpEnddate_p.Date);
    //Params.ParamByName('vehicleid').Value := NovaHelpVehicleno.Id;
    Params.ParamByName('vehiclebrandmodelid').Value := NvHcbbVehiclebrandmodel.HelpFieldValue['id'];
    Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
    if Nhcbformula.ItemIndex>=0 then
      Params.ParamByName('balanceformulaid').Value := Nhcbformula.HelpFieldValue['id']
    else
      Params.ParamByName('balanceformulaid').Value := 0;
    if NovaHComDeduct.ItemIndex>=0 then
      Params.ParamByName('balancedeductitemid').Value := NovaHComDeduct.HelpFieldValue['id']
    else
      Params.ParamByName('balancedeductitemid').Value := 0;
   // Params.ParamByName('unitid').Value := NovaHUnit.Id;
    if  CobSchStatus.ItemIndex=0 then
      Params.ParamByName('status').Value := 0
    else
      Params.ParamByName('status').Value := 5;//停售

   // Params.ParamByName('delayminute').Value := NovaEdtMinute.text;
    Params.ParamByName('issellstopstation').Value := ChkIsSellstopStation.Checked;

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
        scheduleid:=Params.ParamByName('scheduleid').Value;
        ModalResult := mrok;

      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('线路加班操作失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmScheduleplanRoutePlus.NvHcbbVehiclebrandmodelIdChange
  (Sender: TObject);
begin
  inherited;
  if NvHcbbVehiclebrandmodel.Id > 0 then
  begin
    Label11.Caption := NvHcbbVehiclebrandmodel.HelpFieldValue
      ['rationseatnum'];
  end;

end;

end.
