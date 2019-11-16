unit UFrmNoTicketCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, DB, DBClient,
  jsonClientDataSet;

type
  TFrmNoTicketCheck = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtTickets: TNovaEdit;
    GroupBox1: TGroupBox;
    nvdbgrdhcodelist: TNvDbgridEh;
    jscdQryReportVehicle: TjsonClientDataSet;
    DataSource1: TDataSource;
    jscdCheckTickets: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    curscheduleplanid: int64;
    curticketids: string;
  end;

var
  FrmNoTicketCheck: TFrmNoTicketCheck;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmNoTicketCheck.bbtnSaveClick(Sender: TObject);
var
  nresult: Integer;
  sresult: string;
  vehiclereportid:int64;
begin
  inherited;
  if not jscdQryReportVehicle.Active then exit;
  if jscdQryReportVehicle.RecordCount=0 then exit;

  vehiclereportid:=jscdQryReportVehicle.FieldByName('id').AsLargeInt;
  try
    with jscdCheckTickets do
    begin
      active := false;
      Params.ParamValues['checkstationid'] := sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ticketids'] := curticketids;
      Params.ParamValues['ip'] := sysinfo.LocalHostAddress;
      execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        SysDialogs.ShowMessage(sresult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('ÎÞÆ±¸ù¼ìÆ±Ê§°Ü£º' + E.Message);
    end;
  end;
end;

procedure TFrmNoTicketCheck.FormShow(Sender: TObject);
begin
  inherited;
  with jscdQryReportVehicle do
  begin
    active := false;
    Params.ParamValues['scheduleplanid'] := curscheduleplanid;
    active := true;
  end;
end;

end.
