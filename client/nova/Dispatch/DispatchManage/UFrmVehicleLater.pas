unit UFrmVehicleLater;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, Mask, NovaHelp,
  NovaEdit, ImgList;

type
  TFrmVehicleLater = class(TSimpleEditForm)
    lbl14: TLabel;
    NvEditScheduleCodeL: TNovaEdit;
    lbl16: TLabel;
    NvedtDeparttimeL: TNovaEdit;
    lbl3: TLabel;
    NovaHelpVehiclenoL: TNovaHelp;
    Label1: TLabel;
    MaskEdtCurTime: TMaskEdit;
    LabLater: TLabel;
    CobLaterReason: TComboBox;
    Label2: TLabel;
    NovaEdtLaterMinutes: TNovaEdit;
    Label3: TLabel;
    nvedtotherreason: TNovaEdit;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure CobLaterReasonChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleplanid:int64;
  end;

var
  FrmVehicleLater: TFrmVehicleLater;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmVehicleLater.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(CobLaterReason.Text)='' then
  begin
    CobLaterReason.SetFocus;
    SysDialogs.Warning('请选择晚点原因！');
    exit;
  end;
  ModalResult := mrok;
end;

procedure TFrmVehicleLater.CobLaterReasonChange(Sender: TObject);
begin
  inherited;
  if CobLaterReason.ItemIndex=3 then
  begin
     nvedtotherreason.Visible:=true;
  end
  else
  begin
    nvedtotherreason.Visible:=false;
  end;
end;

procedure TFrmVehicleLater.FormShow(Sender: TObject);
begin
  inherited;
  MaskEdtCurTime.Text:=formatdatetime('hh:mm',now);
  CobLaterReason.ItemIndex:=0;
end;

end.
