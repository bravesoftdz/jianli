unit UFrmVehicleRouteSettingEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, NovaHComboBox, DB, DBClient, jsonClientDataSet,Services;

type
  TFrmVehicleRouteSettingEdit = class(TSimpleEditForm)
    lbl3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    NRoute: TNovaHelp;
    Nvehicleno: TNovaHelp;
    cbborg: TNovaEdit;
    jcdssave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
  id : int64;
    { Public declarations }
  end;

var
  FrmVehicleRouteSettingEdit: TFrmVehicleRouteSettingEdit;

implementation

{$R *.dfm}

procedure TFrmVehicleRouteSettingEdit.bbtnSaveClick(Sender: TObject);
var
  nResult : Integer;
  sResult : string;
begin
  inherited;
  if NRoute.Text ='' then
  begin
    SysDialogs.Warning('营运线路不能为空!');
    Exit;
  end;
  with jcdssave do
  begin
    Active:=False;
    Params.ParamValues['id'] :=id;
    Params.ParamValues['routeids'] :=  NRoute.Id;
    Params.ParamValues['vehicleid'] := Nvehicleno.Id ;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult=-1 then exit;

      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保存失败：' + E.Message);
      end;
    end;
  end;
end;

end.
