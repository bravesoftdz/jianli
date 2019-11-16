unit UFrmScheduleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, NovaEdit, NovaHelp, GridsEh, DBGridEh, NvDbgridEh, DB,
  DBClient, jsonClientDataSet,Dispatch;

type
  TFrmScheduleReport = class(TSimpleEditForm)
    grp1: TGroupBox;
    nvdbgrdhResult: TNvDbgridEh;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    ds1: TDataSource;
    Label1: TLabel;
    LblVehicleNo: TLabel;
    Label2: TLabel;
    LblVehicleSeatnum: TLabel;
    chktempvehicle: TCheckBox;
    Label3: TLabel;
    oldschcode: TLabel;
    procedure nvdbgrdhResultKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure NHelpRouteIdChange(Sender: TObject);
    procedure nvdbgrdhResultKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NHelpRouteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    //procedure qryScheduleplan(endstationid: Int64);
  public
    { Public declarations }
    departdate,scheduleids: string;
    isrouteqry : boolean;
    vehiclenoid,departstationid, scheduleplanid, vehicleid, routeid,scheduleid,vehicledriver1: Int64;
    isMustCheck: boolean; // 是否必须安检
    isneedfinger:boolean;//车牌是否需要驾驶员
  end;

var
  FrmScheduleReport: TFrmScheduleReport;

implementation

uses PubFn, Services, UDMPublic, UFrmEmployeeReport;
{$R *.dfm}

procedure TFrmScheduleReport.FormShow(Sender: TObject);
begin
  inherited;
  LblVehicleSeatnum.Caption:=vehReport.jcsdQryScheduleplan.FieldByName('vehicleseat').AsString;
  oldschcode.Caption:=vehReport.jcsdQryScheduleplan.FieldByName('code').AsString;
  ds1.DataSet:=vehReport.jcsdQryScheduleplan;
  //nvdbgrdhResult.OnKeyDown:=nil;
  //qryScheduleplan(0);
  //routeid := 0;
 // nvdbgrdhResult.OnKeyDown:=nvdbgrdhResultKeyDown;
end;

procedure TFrmScheduleReport.NHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  isrouteqry := true;
  //qryScheduleplan(NHelpRoute.Id);
  if  NHelpRoute.Id>0 then
  begin
      vehReport.QryScheduleplan(departdate,sysInfo.LoginUserInfo.StationID,0,
             vehicleid,NHelpRoute.Id);
  end;
end;

procedure TFrmScheduleReport.NHelpRouteKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_ESCAPE then
  begin
    self.Close;
  end;
end;

procedure TFrmScheduleReport.nvdbgrdhResultKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
var
  scheduleid: Int64;
  nResult, curseats, busseats, limitdistance, departdistance: integer;
  sResult, reason, log: string;
  employeeid1, employeeid2: Int64;
  driverfingernum:integer;
begin
  inherited;
  driverfingernum:=0;
  if (Key = vk_return) then
  begin
    Key := 0;
    if (not ds1.DataSet.Active) or
      (ds1.DataSet.RecordCount = 0) then
      exit;



    if FormatDateTime('yyyymmdd',
      ds1.DataSet.FieldByName('departdate').AsDateTime)
      <> FormatDateTime('yyyymmdd', now) then
    begin
      if not SysDialogs.Confirm('报到提示',
        '该车辆报的发车日期是' + FormatDateTime('yyyy-mm-dd',
          ds1.DataSet.FieldByName('departdate').AsDateTime)
          + '的班次，是否继续') then
      begin
        exit;
      end;
    end;

    if ((LblVehicleSeatnum.Caption) <> '') and
      (strtoint(LblVehicleSeatnum.Caption) > 0) then
    begin
      curseats := ds1.DataSet.FieldByName('seatnum').AsInteger;
      busseats := strtoint(LblVehicleSeatnum.Caption);
      if busseats <> curseats then
      begin
        if busseats > curseats then
        begin
          if not SysDialogs.Confirm('报到提示',
            '当前报到车辆座位数(' + inttostr(busseats) + ')大于该班次计划座位数，是否继续报到？') then
          begin
            exit;
          end;
        end
        else if busseats < curseats then
        begin
          if not SysDialogs.Confirm('报到提示',
            '当前报到车辆座位数(' + inttostr(busseats) + ')小于该班次计划座位数，是否继续报到？') then
          begin
            exit;
          end;
        end;
      end;
    end;
    repAskCondition.departstationid:=vehReport.departstationid;
    repAskCondition.departdate:= vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime;
    repAskCondition.scheduleplanid:=vehReport.jcsdQryScheduleplan.FieldByName('id').AsLargeInt;
    repAskCondition.scheduleid:=vehReport.jcsdQryScheduleplan.FieldByName('scheduleid').AsLargeInt;
    repAskCondition.vehicleid:=vehReport.vehicleid;
    repAskCondition.isTempVehicle:=false;

    repAskCondition.orderno:='-1'; //IC卡报班时，流水班orderno 自动增加

    repAskCondition.vehicleno:=LblVehicleNo.Caption;
    repAskCondition.vehicleunit:=vehReport.jcsdQryScheduleplan.FieldByName('unitname').AsString;
    if ds1.DataSet.Active and (ds1.DataSet.RecordCount>0) then
    begin
      repAskCondition.departtime:=ds1.DataSet.FieldByName('departtime').AsString;
      repAskCondition.schedulecode:=ds1.DataSet.FieldByName('code').AsString;
      repAskCondition.reachstation:=ds1.DataSet.FieldByName('endstationname').AsString;
    end;
    repAskCondition.seatno:=LblVehicleSeatnum.Caption;
    repAskCondition.driver1id :=  vehicledriver1;


    try
        vehReport.report(repAskCondition);
        if (vehReport.isShowmsg) then
        begin
           if vehReport.res.flag<1 then
              SysDialogs.Warning(vehReport.res.msg)
           else
           begin
              SysDialogs.ShowMessage(vehReport.res.msg);
              ModalResult := mrok;
           end;
        end
        else
        begin
           if vehReport.res.flag<1 then
              SysDialogs.Warning(vehReport.res.msg)
           else
           begin
              //SysDialogs.ShowMessage(sResult);
              ModalResult := mrok;
           end;
        end;
    except
        on E: Exception do
        begin
          SysLog.WriteErr('IC卡车辆报到失败：' + E.Message);
        end;
    end;


  end;

end;

procedure TFrmScheduleReport.nvdbgrdhResultKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  //Key := 0;
end;

end.
