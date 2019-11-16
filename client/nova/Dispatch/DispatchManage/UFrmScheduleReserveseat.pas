unit UFrmScheduleReserveseat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Generics.Collections, Buttons, ExtCtrls,
  SeatPlan,
  DB, DBClient, jsonClientDataSet, NovaEdit, ImgList, ComCtrls;

type
  TFrmScheduleReserveseat = class(TSimpleEditForm)
    pnl1: TPanel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lbldepartdate: TLabel;
    edtroute: TNovaEdit;
    edtstartdate: TNovaEdit;
    edtschedule: TNovaEdit;
    pnlseatplan: TPanel;
    lblautocanceltime: TLabel;
    dtpautocanceltime: TDateTimePicker;
    chkcheck: TCheckBox;
    Label1: TLabel;
    NovaEdtNum: TNovaEdit;
    rbReserveSeat: TRadioButton;
    rbCancelReserveSeat: TRadioButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    SeatPlan: TSeatPlanSelect;
    curseatsStatus: TDictionary<Word, String>;
    vehicleSeatPlanDecorato: TVehicleSeatPlanDecorator;
  public
    { Public declarations }
    brandModelid, scheduleplanid: Int64;
  end;

var
  FrmScheduleReserveseat: TFrmScheduleReserveseat;

implementation
uses Services, UDMPublic, PubFn;
{$R *.dfm}

procedure TFrmScheduleReserveseat.FormShow(Sender: TObject);
begin
  inherited;
  curseatsStatus := getScheduleSeatstatus(scheduleplanid);
  if not Assigned(SeatPlan) then
  begin
    SeatPlan := TSeatPlanSelect.Create(pnlseatplan);
    SeatPlan.defaultcellwidth := 60;
    SeatPlan.defaultcellheight := 60;
    SeatPlan.defaultcolcount := 14;
    SeatPlan.brandModelid:=brandModelid;
    SeatPlan.seatsStatus := curseatsStatus;
    SeatPlan.setShowspacename(false);

    vehicleSeatPlanDecorato := TVehicleSeatPlanDecorator.Create(self, SeatPlan);
    with vehicleSeatPlanDecorato do
    begin
      setParent(self.pnlseatplan);
      // Align:=alClient;
    end;
    if self.Width + vehicleSeatPlanDecorato.actualwidth - pnlseatplan.Width >
      self.Width then
      self.Width := self.Width + vehicleSeatPlanDecorato.actualwidth -
        pnlseatplan.Width
    else
    begin
      vehicleSeatPlanDecorato.Left :=
        ((self.Width - vehicleSeatPlanDecorato.actualwidth) DIV 2);
    end;
    vehicleSeatPlanDecorato.Top:=10;
    self.Height := self.Height + vehicleSeatPlanDecorato.actualheight -
      pnlseatplan.Height+10;

  end;
end;

end.
