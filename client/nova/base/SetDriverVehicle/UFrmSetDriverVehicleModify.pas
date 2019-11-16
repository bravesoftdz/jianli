unit UFrmSetDriverVehicleModify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHelp, NovaHComboBox;

type
  TfrmSetDriverVehicleModify = class(TSimpleEditForm)
    lbl1: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lbl2: TLabel;
    NovaHelpDriver: TNovaHelp;
    lbl3: TLabel;
    nvhlpVehicleno: TNovaHelp;
    lblxing11: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    jcdsModify: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ID, orgid, driverid, vehicleid:string;
  end;

var
  frmSetDriverVehicleModify: TfrmSetDriverVehicleModify;

implementation
uses Services;
{$R *.dfm}

procedure TfrmSetDriverVehicleModify.bbtnSaveClick(Sender: TObject);
var
    nResult:Integer;
    sResult:string;
begin
  inherited;
  if nvhlpVehicleno.Text='' then
  begin
    SysDialogs.ShowInfo('ÇëÊäÈë³µÅÆºÅ£¡');
    nvhlpVehicleno.SetFocus;
    exit;
  end;

  with jcdsModify do
  begin
    Params.ParamValues['setDriverVehicle.id'] := ID;
    Params.ParamValues['setDriverVehicle.orgid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['setDriverVehicle.driverid'] := NovaHelpDriver.ID;
    Params.ParamValues['setDriverVehicle.vehicleid'] := nvhlpVehicleno.ID;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if nResult>0 then
    begin
      self.ModalResult := mrOk;
    end;
  end;
end;

procedure TfrmSetDriverVehicleModify.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active := False;
  NovaHCbbOrg.Active := True;
  nvhlpVehicleno.SetFocus;
end;

end.
