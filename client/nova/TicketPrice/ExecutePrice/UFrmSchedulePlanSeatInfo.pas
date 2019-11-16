unit UFrmSchedulePlanSeatInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Generics.Collections, Buttons, ExtCtrls,
  SeatPlan,
  DB, DBClient, jsonClientDataSet, NovaEdit, ImgList;

type
  TFrmSchedulePlanSeatInfo = class(TSimpleEditForm)
    pnlseatplan: TPanel;
    jcdsQryScheduleSeat: TjsonClientDataSet;
    Panel1: TPanel;
    Label1: TLabel;
    NovaEdtSchedule: TNovaEdit;
    NovaEdtRoute: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtPlanVehicle: TNovaEdit;
    NovaEdtBrand: TNovaEdit;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    SeatPlan: TSeatPlan;
    seatpichelp: TSeatPicHelp;
    curseatsStatus: TDictionary<Word, String>;
    vehicleSeatPlanDecorato: TVehicleSeatPlanDecorator;
  public
    { Public declarations }
    brandModelid, scheduleplanid: Int64;
  end;

var
  FrmSchedulePlanSeatInfo: TFrmSchedulePlanSeatInfo;

implementation

uses Services, UDMPublic, PubFn;
{$R *.dfm}

procedure TFrmSchedulePlanSeatInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  seatpichelp.Free;
  inherited;

end;

procedure TFrmSchedulePlanSeatInfo.FormCreate(Sender: TObject);
begin
  inherited;
  seatpichelp := TSeatPicHelp.Create;
end;

procedure TFrmSchedulePlanSeatInfo.FormShow(Sender: TObject);
begin
  inherited;
  bbtnClose.Left:=(pnlOperation.Width div 2) -  (bbtnClose.Width div 2);

  //curseatsStatus := getScheduleSeatstatus(scheduleplanid);
  seatpichelp.qryScheduleSeatstatus(scheduleplanid);
  seatpichelp.qrySeatstatus(scheduleplanid,true);
  if not Assigned(SeatPlan) then
  begin
    SeatPlan := TSeatPlan.Create(pnlseatplan);
   // SeatPlan.defaultcellwidth := 60;
   // SeatPlan.defaultcellheight := 60;
   // SeatPlan.defaultcolcount := 14;
    SeatPlan.brandModelid:=brandModelid;
    SeatPlan.seatsStatus := seatpichelp.seatsStatus;
    SeatPlan.ShowHint:=true;
    SeatPlan.seatshint:=seatpichelp.seatshint;
    SeatPlan.seatsTickettype:=seatpichelp.seatsTickettype;
    //SeatPlan.seatsreachstationname := seatpichelp.seatStation;
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
   // SeatPlan.Top:=10;
    vehicleSeatPlanDecorato.Top:=10;
   // vehicleSeatPlanDecorato.Height:=vehicleSeatPlanDecorato.Height+10;
    // if (self.Height+vehicleSeatPlanDecorato.actualheight-pnlseatplan.Height)>self.Height then
    self.Height := self.Height + vehicleSeatPlanDecorato.actualheight -
      pnlseatplan.Height+10;

  end;

end;

end.
