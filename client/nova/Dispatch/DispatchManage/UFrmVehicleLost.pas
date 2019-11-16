unit UFrmVehicleLost;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, ComCtrls, NovaHelp, NovaEdit, ImgList;

type
  TFrmVehicleLost = class(TSimpleEditForm)
    lbl13: TLabel;
    lbl14: TLabel;
    NvEdtRoute: TNovaEdit;
    nvedtcode: TNovaEdit;
    lbl16: TLabel;
    lbl3: TLabel;
    NvedtDeparttimeL: TNovaEdit;
    NovaHelpVehiclenoL: TNovaHelp;
    lbl17: TLabel;
    nvedtSeatnum: TNovaEdit;
    Label1: TLabel;
    NovaEdtUnit: TNovaEdit;
    lbl15: TLabel;
    nvedttickettype: TNovaEdit;
    lbl1: TLabel;
    LabLater: TLabel;
    jscdVehicleLost: TjsonClientDataSet;
    NovaEdtDepartDate: TNovaEdit;
    ChkPunish: TCheckBox;
    NvEdtLostReason: TNovaEdit;
    cbbReportName: TComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpVehiclenoLIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleplanid:int64;
  end;

var
  FrmVehicleLost: TFrmVehicleLost;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmVehicleLost.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (NovaHelpVehiclenoL.Text='') or (NovaHelpVehiclenoL.Id=0) then
  begin
    NovaHelpVehiclenoL.SetFocus;
    SysDialogs.Warning('«Î ‰»ÎÕ—∞‡≥µ¡æ£°');
    exit;
  end;
  if (cbbReportName.ItemIndex<0) then
  begin
    cbbReportName.SetFocus;
    SysDialogs.Warning('«Î—°‘Ò…Í±®»À£°');
    exit;
  end;
  if trim(NvEdtLostReason.Text)='' then
  begin
    NvEdtLostReason.SetFocus;
    SysDialogs.Warning('«Î ‰»ÎÕ—∞‡‘≠“Ú£°');
    exit;
  end;


  with jscdVehicleLost do
  begin
    Active := false;
    Params.ParamValues['vehiclelost.createby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['vehiclelost.isautolost'] := false;
    Params.ParamValues['vehiclelost.reason'] := trim(NvEdtLostReason.Text);
    Params.ParamValues['vehiclelost.scheduleid'] := nvedtcode.Id;
    Params.ParamValues['vehiclelost.scheduleplanid'] := scheduleplanid;
    Params.ParamValues['vehiclelost.unitid'] := NovaEdtUnit.Id;
    Params.ParamByName('vehiclelost.reportname').Value := cbbReportName.Text;

    Params.ParamValues['vehiclelost.vehicle.id'] := NovaHelpVehiclenoL.Id ;
    Params.ParamValues['vehiclelost.orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['vehiclelost.ispunish'] := ChkPunish.Checked;
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
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Õ—∞‡≤Ÿ◊˜ ß∞‹£∫' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicleLost.NovaHelpVehiclenoLIdChange(Sender: TObject);
begin
  inherited;
  if (self.NovaHelpVehiclenoL.isactive)
   and (NovaHelpVehiclenoL.Id>0) then
  begin
    NovaEdtUnit.Enabled:=false;
    NovaEdtUnit.Text:= NovaHelpVehiclenoL.HelpFieldValue['unitname'];
  end
  else
  begin
    NovaEdtUnit.Enabled:=true;
  end;
end;

end.
