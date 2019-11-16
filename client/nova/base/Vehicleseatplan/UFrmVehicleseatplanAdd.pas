unit UFrmVehicleseatplanAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, SeatPlan,
  ImgList;

type
  TFrmVehicleseatplanAdd = class(TSimpleEditForm)
    pnlbrandModel: TPanel;
    pnlseatplan: TPanel;
    lblbrand: TLabel;
    nvedtbrand: TNovaEdit;
    nvedtModel: TNovaEdit;
    lblModel: TLabel;
    Label1: TLabel;
    nvedtrationseatnum: TNovaEdit;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure pnlOperationResize(Sender: TObject);
  private
    { Private declarations }
    seatPlanEdit:TSeatPlanEdit;
    vehicleSeatPlanDecorato:TVehicleSeatPlanDecorator;
  public
    { Public declarations }
    brandModelid:Int64;
    rationseatnum:integer;
  end;

var
  FrmVehicleseatplanAdd: TFrmVehicleseatplanAdd;

implementation

{$R *.dfm}

procedure TFrmVehicleseatplanAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if seatPlanEdit.save then
  begin
    self.ModalResult:=mrOk;
  end;
end;

procedure TFrmVehicleseatplanAdd.FormShow(Sender: TObject);
begin
  inherited;
  if not Assigned(seatPlanEdit) then
  begin
    seatPlanEdit:=TSeatPlanEdit.Create(pnlseatplan);
    vehicleSeatPlanDecorato:=TVehicleSeatPlanDecorator.Create(self,seatPlanEdit);
    with vehicleSeatPlanDecorato do
    begin
      setParent(self.pnlseatplan);
      Align:=alClient;
    end;
    with seatPlanEdit do
    begin
      brandModelid:=self.brandModelid;
      rationseatnum:=self.rationseatnum;
      nvedtrationseatnum.Text:=IntToStr(self.rationseatnum);
    end;
    self.Width:=self.Width+vehicleSeatPlanDecorato.actualwidth-pnlseatplan.Width;
    self.Height:=self.Height+vehicleSeatPlanDecorato.actualheight-pnlseatplan.Height;
  end;
end;

procedure TFrmVehicleseatplanAdd.pnlOperationResize(Sender: TObject);
var newleft:integer;
begin
  inherited;
  newleft:=(TWinControl(Sender).Width-(bbtnClose.Left+bbtnClose.Width-bbtnSave.Left)) div 2;
  bbtnClose.Left:=bbtnClose.Left-(bbtnSave.Left-newleft);
  bbtnSave.Left:=newleft;
end;

end.
