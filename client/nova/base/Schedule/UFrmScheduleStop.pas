unit UFrmScheduleStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls,
  NovaHComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmScheduleStop = class(TSimpleEditForm)
    Label24: TLabel;
    Label25: TLabel;
    NHccbTicketEntrance: TNovaHComboBox;
    NHccbVehiclepark: TNovaHComboBox;
    Label1: TLabel;
    ChkIsDepart: TCheckBox;
    Label2: TLabel;
    dtStartTime: TDateTimePicker;
    Label9: TLabel;
    NEdtRuntime: TNovaEdit;
    Label14: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    jcdsSaveSchStop: TjsonClientDataSet;
    jcdsLoadRouteStop: TjsonClientDataSet;
    NovaHCbbStation: TNovaHComboBox;
    chkIssellable: TCheckBox;
    lbl1: TLabel;
    nvedtremark1: TNovaEdit;
    lbl2: TLabel;
    nvedtremark2: TNovaEdit;
    lbl3: TLabel;
    nvedtremark3: TNovaEdit;
    lbl4: TLabel;
    nvedtremark4: TNovaEdit;
    lbl5: TLabel;
    nvedtremark5: TNovaEdit;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHCbbStationChange(Sender: TObject);
    procedure ChkIsDepartClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, scheduleid, scheduleorgid: Int64;
    createtime, runtime, TicketEntrance, vehiclepark,synccode: string;
    isedit, isdepart: boolean;
    orderno: integer;
    routeid,stationid: Int64;
    vehicleparkid, ticketentranceid: Int64;
    departtime: TDatetime;
  end;

var
  FrmScheduleStop: TFrmScheduleStop;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleStop.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log: string;
begin
  inherited;
  if NovaHCbbStation.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择停靠点！');
    NovaHCbbStation.SetFocus;
    Exit;
  end;
  if Trim(NEdtRuntime.Text) = '' then
  begin
    SysDialogs.Warning('请输入运行时间！');
    NEdtRuntime.SetFocus;
    Exit;
  end;

  if ChkIsDepart.Checked then
  begin
   if NHccbTicketEntrance.ItemIndex < 0 then
    begin
      SysDialogs.Warning('请选择检票口！');
      NHccbTicketEntrance.SetFocus;
      Exit;
    end;
    if NHccbVehiclepark.ItemIndex < 0 then
    begin
      SysDialogs.Warning('请选择上车卡位！');
      NHccbVehiclepark.SetFocus;
      Exit;
    end;
  end;

  with jcdsSaveSchStop do
  begin
    close;
    Params.ParamByName('scheduleStop.id').Value := id;
    Params.ParamByName('scheduleStop.schedule.id').Value := scheduleid;
    Params.ParamByName('scheduleStop.stationid').Value := NovaHCbbStation.HelpFieldValue['id'];
    Params.ParamByName('scheduleStop.runtime').Value := NEdtRuntime.Text;
    Params.ParamByName('scheduleStop.orderno').Value := orderno;
    Params.ParamByName('scheduleStop.remark1').Value := nvedtremark1.Text;
    Params.ParamByName('scheduleStop.remark2').Value := nvedtremark2.Text;
    Params.ParamByName('scheduleStop.remark3').Value := nvedtremark3.Text;
    Params.ParamByName('scheduleStop.remark4').Value := nvedtremark4.Text;
    Params.ParamByName('scheduleStop.remark5').Value := nvedtremark5.Text;
    Params.ParamByName('scheduleStop.synccode').Value := synccode;
    if ChkIsDepart.Checked then
    begin
      Params.ParamByName('scheduleStop.isdepart').Value := True;
      if NHccbTicketEntrance.ItemIndex>=0 then
      begin
        ticketentranceid := NHccbTicketEntrance.HelpFieldValue['id'];
        Params.ParamByName('scheduleStop.ticketentrance.id').Value := ticketentranceid;
      end;
      if NHccbVehiclepark.ItemIndex>=0 then
      begin
        vehicleparkid := NHccbVehiclepark.HelpFieldValue['id'];
        Params.ParamByName('scheduleStop.vehiclepark.id').Value := vehicleparkid;
      end;
    end
    else
      Params.ParamByName('scheduleStop.isdepart').Value := False;
    if chkIssellable.Checked then
      Params.ParamByName('scheduleStop.issellable').Value := True
    else
      Params.ParamByName('scheduleStop.issellable').Value := False;
    Params.ParamByName('scheduleStop.departtime').Value := formatdatetime
      ('hh:mm', dtStartTime.Time);
    //Params.ParamByName('scheduleStop.ticketentrance.id').Value :=ticketentranceid;
    //Params.ParamByName('scheduleStop.vehiclepark.id').Value := vehicleparkid;
    Params.ParamByName('scheduleStop.isactive').Value := True;
    Params.ParamByName('scheduleStop.createby').Value := createby;
    if createtime<>'' then
       Params.ParamByName('scheduleStop.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHCbbStation.SetFocus;
      end
      else
      begin
        log:='添加、修改停靠站点:停靠站点='+NovaHCbbStation.Text;
        log:=log+',运行时间='+NEdtRuntime.Text;
        if ChkIsDepart.Checked then
        begin
            log:=log+',是否发车站=是';
            log:=log+',发车时间='+ formatdatetime('hh:mm',dtStartTime.Time);
            log:=log+',检票口='+NHccbTicketEntrance.text;
            log:=log+',乘车库='+NHccbVehiclepark.text;
        end
        else
            log:=log+',是否发车站=否';
         if chkIssellable.Checked then
            log:=log+',是否允许售票=是'
          else
            log:=log+',是否允许售票=否';
        SysLog.WriteLog('修改班次停靠信息', '修改', log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次停靠点增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmScheduleStop.ChkIsDepartClick(Sender: TObject);
begin
  inherited;

    if ChkIsDepart.Checked then
    begin
       if not NovaHCbbStation.HelpFieldValue['isdepart'] then
          begin
            SysDialogs.Warning('该站点不是发车站！');
            ChkIsDepart.Checked:=false;
            exit;
          end;
      //ChkIsDepart.Checked := True;
      dtStartTime.Enabled := True;
      NHccbTicketEntrance.Enabled := True;
      NHccbVehiclepark.Enabled := True;
      NHccbTicketEntrance.Active := False;
      //NHccbTicketEntrance.Params.ParamValues['filter_EQL_o!station.id'] := stationid;
      NHccbTicketEntrance.Active := True;

      NHccbVehiclepark.Active := False;
     // NHccbVehiclepark.Params.ParamValues['filter_EQL_o!station.id'] := stationid;
      NHccbVehiclepark.Active := True;
      Label4.Visible := True;
      Label5.Visible := True;
      Label6.Visible := True;
    end
    else
    begin
      //ChkIsDepart.Checked := False;
      dtStartTime.Enabled := False;
      NHccbTicketEntrance.Enabled := False;
      NHccbVehiclepark.Enabled := False;
      dtStartTime.Time := strtodatetime('00:00');
      NHccbTicketEntrance.ItemIndex := -1;
      NHccbVehiclepark.ItemIndex := -1;
      Label4.Visible := False;
      Label5.Visible := False;
      Label6.Visible := False;
    end;
end;

procedure TFrmScheduleStop.FormShow(Sender: TObject);
begin
  inherited;
  with NovaHCbbStation do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!route.id'] := routeid;
    Active := True;
  end;

  if isedit then
  begin
    NovaHCbbStation.SetItemIndexByField('stationid', stationid);
    NEdtRuntime.Text := runtime;
    ChkIsDepart.Checked := isdepart;
    NovaHCbbStation.Enabled := False;
    if isdepart then
    begin
      NHccbTicketEntrance.Active := False;
      //NHccbTicketEntrance.Params.ParamValues['filter_EQL_o!id'] := stationid;
      NHccbTicketEntrance.Active := True;

      NHccbVehiclepark.Active := False;
     // NHccbVehiclepark.Params.ParamValues['filter_EQL_o!id'] := stationid;
      NHccbVehiclepark.Active := True;

      dtStartTime.Time := departtime;
      NHccbTicketEntrance.ItemIndex := NHccbTicketEntrance.Items.IndexOf
        (TicketEntrance);
      NHccbVehiclepark.ItemIndex := NHccbVehiclepark.Items.IndexOf(vehiclepark);
    end
    else
    begin
      NHccbTicketEntrance.Enabled := False;
      NHccbVehiclepark.Enabled := False;
      dtStartTime.Time := strtodatetime('00:00');
      dtStartTime.Enabled:=False;
      NHccbTicketEntrance.ItemIndex := -1;
      NHccbVehiclepark.ItemIndex := -1;
      Label4.Visible := False;
      Label5.Visible := False;
      Label6.Visible := False;
    end;
  end;
end;

procedure TFrmScheduleStop.NovaHCbbStationChange(Sender: TObject);
begin
  inherited;
  if NovaHCbbStation.ItemIndex >= 0 then
  begin
    if NovaHCbbStation.HelpFieldValue['isdepart'] then
    begin
      ChkIsDepart.Checked := True;
      dtStartTime.Enabled := True;
      //NHccbTicketEntrance.Enabled := True;

      NHccbTicketEntrance.Active := False;
      //NHccbTicketEntrance.Params.ParamValues['filter_EQL_o!station.id'] := NovaHCbbStation.HelpFieldValue['id'];
      NHccbTicketEntrance.Active := True;

      NHccbVehiclepark.Active := False;
     // NHccbVehiclepark.Params.ParamValues['filter_EQL_o!station.id'] := NovaHCbbStation.HelpFieldValue['id'];
      NHccbVehiclepark.Active := True;
      Label4.Visible := True;
      Label5.Visible := True;
      Label6.Visible := True;
    end
    else
    begin
       ChkIsDepart.Checked := False;
      //dtStartTime.Enabled := False;
      NHccbTicketEntrance.Enabled := False;
      NHccbVehiclepark.Enabled := False;
      dtStartTime.Time := strtodatetime('00:00');
      NHccbTicketEntrance.ItemIndex := -1;
      NHccbVehiclepark.ItemIndex := -1;
      Label4.Visible := False;
      Label5.Visible := False;
      Label6.Visible := False;
    end;
  end;

end;

end.

