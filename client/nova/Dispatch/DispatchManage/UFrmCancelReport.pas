unit UFrmCancelReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp, NovaEdit, DB,
  DBClient, jsonClientDataSet, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh,
  ComCtrls, ImgList;

type
  TFrmCancelReport = class(TSimpleEditForm)
    jcdsCancelReport: TjsonClientDataSet;
    CobCancelReason: TComboBox;
    Label2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    islineWork: boolean;
    scheduleplanid,curStationid,reportorgid, reportid, updateby, vehicleid, scheduleid: int64;
    departdate,schedulecode,vehicleno: String;
  end;

var
  FrmCancelReport: TFrmCancelReport;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmCancelReport.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, reason,log: string;
begin
  inherited;
  if trim(CobCancelReason.Text) = '' then
  begin
    CobCancelReason.SetFocus;
    SysDialogs.Warning('请选择取消原因！');
    exit;
  end;

  reason := trim(CobCancelReason.Text);
  with jcdsCancelReport do
  begin
    Active := false;
    Params.ParamValues['vehiclereport.id'] := reportid;
    Params.ParamValues['vehiclereport.updateby'] := updateby;
    Params.ParamValues['vehiclereport.scheduleplanid'] := scheduleplanid;
    Params.ParamValues['vehiclereport.reportorgid'] := reportorgid;
    Params.ParamValues['vehiclereport.scheduleid'] := scheduleid;
    Params.ParamValues['vehiclereport.vehicleid'] := vehicleid;
    Params.ParamValues['vehiclereport.reason'] := reason;
    Params.ParamValues['departstationid'] := curStationid;

    try
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
        log := '取消报到车站:' + sysInfo.LoginUserInfo.OrgName + ',取消报到班次：'
             +schedulecode + ',报到车辆:' +
            ',取消报到的车辆:' + vehicleno+',取消人:'+sysInfo.LoginUserInfo.UserName;
          SysLog.WriteLog('综合调度', '取消报到', log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('报到取消失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmCancelReport.FormShow(Sender: TObject);
begin
  inherited;
{  if islineWork then
  begin
    PaneNotIsLine.Visible:=false;
    PaneIsLine.Visible:=true;
    PaneIsLine.Left:=Label2.Left;
    with jscdQryVehicleReport do
    begin
      Active := false;
      Params.ParamValues['vehiclereport.reportorgid'] := reportorgid;
      Params.ParamValues['vehiclereport.scheduleid'] := scheduleid;
      Params.ParamValues['vehiclereport.departdate'] := departdate;
      Active := true;
    end;
  end
  else
  begin
    PaneNotIsLine.Visible:=true;
    PaneIsLine.Visible:=false;
  end;}
end;

end.
