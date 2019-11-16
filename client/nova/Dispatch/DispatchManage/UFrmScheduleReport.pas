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
    isMustCheck: boolean; // �Ƿ���밲��
    isneedfinger:boolean;//�����Ƿ���Ҫ��ʻԱ
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
      if not SysDialogs.Confirm('������ʾ',
        '�ó������ķ���������' + FormatDateTime('yyyy-mm-dd',
          ds1.DataSet.FieldByName('departdate').AsDateTime)
          + '�İ�Σ��Ƿ����') then
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
          if not SysDialogs.Confirm('������ʾ',
            '��ǰ����������λ��(' + inttostr(busseats) + ')���ڸð�μƻ���λ�����Ƿ����������') then
          begin
            exit;
          end;
        end
        else if busseats < curseats then
        begin
          if not SysDialogs.Confirm('������ʾ',
            '��ǰ����������λ��(' + inttostr(busseats) + ')С�ڸð�μƻ���λ�����Ƿ����������') then
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

    repAskCondition.orderno:='-1'; //IC������ʱ����ˮ��orderno �Զ�����

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
          SysLog.WriteErr('IC����������ʧ�ܣ�' + E.Message);
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
