unit UFrmAddTempVehi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet,Services;

type
  TFrmAddTempVehi = class(TSimpleEditForm)
    lblvehicleno: TLabel;
    lblunitid: TLabel;
    NovaHelpUnit: TNovaHelp;
    lblvehiclebrandmodelid: TLabel;
    jcsdAddTempVehiSave: TjsonClientDataSet;
    lbl5: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    nvhlpVehiclebrandmodel: TNovaHelp;
    edtvehicleno: TEdit;
    procedure bbtnSaveClick(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
    tempvehicleid: int64;
  end;

var
  FrmAddTempVehi: TFrmAddTempVehi;

implementation
uses PubFn;
{$R *.dfm}

procedure TFrmAddTempVehi.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if edtvehicleno.Text = '' then
  begin
    SysDialogs.ShowMessage('车牌不能为空');
    edtvehicleno.SetFocus;
    exit;
  end;
  if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
  begin
    SysDialogs.ShowMessage('车属单位不能空！');
    NovaHelpUnit.SetFocus;
    exit;
  end;
  if (nvhlpVehiclebrandmodel.id= 0) or (nvhlpVehiclebrandmodel.Text='') then
  begin
    SysDialogs.ShowMessage('请选择品牌型号！');
    nvhlpVehiclebrandmodel.SetFocus;
    exit;
  end;
  

   with jcsdAddTempVehiSave do
    try
      begin
        active := false;
        Params.ParamByName('vehicle.istempvehicle').Value:=true;
        Params.ParamByName('vehicle.vehicleno').Value := edtvehicleno.Text;
        Params.ParamByName('vehicle.unitid').Value := NovaHelpUnit.id;
        Params.ParamByName('vehicle.balanceunitid').Value := NovaHelpUnit.id;
       // Params.ParamByName('vehicle.vehicletypeid').Value :=cbbvehicletype.HelpFieldValue['id'];
        Params.ParamByName('vehicle.vehiclebrandmodelid').Value :=nvhlpVehiclebrandmodel.id;
        Params.ParamByName('vehicle.isaudited').Value := true;
        Params.ParamByName('vehicle.isauditpass').Value := true;
        Params.ParamByName('vehicle.isactive').Value := true;
        Params.ParamByName('vehicle.islocaldelete').Value := false;
        Params.ParamByName('vehicle.type').Value := 0;
        Params.ParamByName('vehicle.color').Value := 1;
        Params.ParamByName('vehicle.rationseatnum').Value := nvhlpVehiclebrandmodel.HelpFieldValue['rationseatnum'];
        Params.ParamByName('vehicle.seatnum').Value := nvhlpVehiclebrandmodel.HelpFieldValue['rationseatnum'];
        Params.ParamByName('vehicle.status').Value := 0;
        try
          Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
         if (nResult <= 0) then
          begin
            SysDialogs.Warning(sResult);
            if (Pos('车牌号码',sResult)>0) and (edtvehicleno.Enabled) then
              begin
              edtvehicleno.SetFocus;
              Exit;
              end;
          end
          else
          begin
            SysDialogs.ShowMessage(sResult);
            tempvehicleid := Params.ParamByName('vehicleid').Value;
            ModalResult := mrok;
          end;
        except
          on E: exception do
          begin
            SysLog.WriteErr('车辆信息失败：' + E.Message);
          end;
        end;
      end;
    finally

    end;


end;

end.
