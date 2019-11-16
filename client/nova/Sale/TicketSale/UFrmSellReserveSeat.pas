unit UFrmSellReserveSeat;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFrmSellTicket, DBGridEhGrouping, Menus, ExtCtrls, DB, ComCtrls,
  Spin, StdCtrls, NovaEdit, NovaHelp, GridsEh, DBGridEh, NvDbgridEh, DBClient,
  jsonClientDataSet,UDMPublic, DBCtrls, Mask, NovaComboBox,SellTicket,DateUtils,
  Buttons;

type
  TFrmSellReserveSeat = class(TFrmSellTicket)
    jcdsqryBookTicket: TjsonClientDataSet;
    grpcustomer: TGroupBox;
    nvedtCERTIFICATENO: TNovaEdit;
    nvcbbCERTIFICATETYPE: TNovaComboBox;
    jsoncdsquerycustomer: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure nvedtCERTIFICATENOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure nvcbbCERTIFICATETYPEChange(Sender: TObject);
  private
    { Private declarations }
    customerid:Int64;
    function getcustomer:boolean;
  protected
    procedure setInsuranceInfo(cdsInsuranceBuffer:TDataSet);override;
  public
    { Public declarations }
    procedure initThroughControl();override;
    procedure findSchedule();override;
    procedure reset;override;//重置界面
    procedure setContextHint(winControl:TWinControl);override;//设置上下文提示
  end;

var
  FrmSellReserveSeat: TFrmSellReserveSeat;

implementation

{$R *.dfm}

{ TFrmSellReserveSeat }

procedure TFrmSellReserveSeat.findSchedule;
var condition: ScheduleAskCondition;
begin
//  inherited;
  if (sellTicket=nil) then exit;
  if ((nvhelpreachstation.Id=0) and (nvhelpSchedule.Id=0))
     and ((nvcbbCERTIFICATETYPE.ItemIndex<0) or (Trim(nvedtCERTIFICATENO.Text)='')) then
  begin
    if (nvcbbCERTIFICATETYPE.ItemIndex<0) then
    begin
      nvedtCERTIFICATENO.SetFocus;
    end
    else
    begin
      nvedtCERTIFICATENO.SetFocus;
    end;
    if dsSchedule.DataSet<>nil then
    begin
      dsSchedule.DataSet.Close;
    end;
  end
  else
  begin
    condition:=ScheduleAskCondition.Create;
    with condition do
    begin
      departDate:=dtpdepartdate.Date;
      departStationId:=nvhelpdepartstation.Id;
      reachStationId:=nvhelpreachstation.Id;
      ScheduleId:=nvhelpSchedule.Id;
      customerid:=self.customerid;
    end;
    sellTicket.findSchedule(condition);
    if dsSchedule.DataSet=nil then
      dsSchedule.DataSet:=sellTicket.cdsSchedule;
  end;
end;

procedure TFrmSellReserveSeat.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbCERTIFICATETYPE.Active:=true;
  nvcbbCERTIFICATETYPE.SetItemIndexByCode('4');
end;

function TFrmSellReserveSeat.getcustomer:boolean;
begin
  Result:=false;
  if (Trim(nvedtCERTIFICATENO.Text)='') or (nvcbbCERTIFICATETYPE.ItemIndex<0) then
  begin
    self.customerid:=0;
  end
  else
  begin
    with jsoncdsquerycustomer do
    begin
      Active:=false;
      Params.ParamValues['filter_EQS_c!certificatetype']:=nvcbbCERTIFICATETYPE.GetSelectCode;
      Params.ParamValues['filter_EQS_c!certificateno']:=nvedtCERTIFICATENO.Text;
      active:=true;
      if RecordCount=1 then
      begin
        self.customerid:=FieldValues['id'];
        Result:=True;
      end
      else
      begin
        self.customerid:=0;
      end
    end;
  end;
  findSchedule;
end;

procedure TFrmSellReserveSeat.initThroughControl;
begin
  inherited;
  gb7.Visible:=false;
  defaultThroughControl.Remove(nvhelpdepartstation);
  fullThroughControl.Remove(nvhelpdepartstation);
  defaultThroughControl.Remove(nvhelpreachstation);

  defaultThroughControl.Insert(0,nvedtCERTIFICATENO);
  fullThroughControl.Insert(2,nvedtCERTIFICATENO);
  fullThroughControl.Insert(2,nvcbbCERTIFICATETYPE);
end;

procedure TFrmSellReserveSeat.nvcbbCERTIFICATETYPEChange(Sender: TObject);
begin
  inherited;
  getcustomer;
end;

procedure TFrmSellReserveSeat.nvedtCERTIFICATENOKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (key=VK_UP) then
  begin
    dtpdepartdate.Date:=IncDay(dtpdepartdate.Date);
    setDepartDateColor;
    findSchedule;
  end
  else if (key=VK_DOWN) then
  begin
    dtpdepartdate.Date:=IncDay(dtpdepartdate.Date,-1);
    setDepartDateColor;
    findSchedule;
  end
  else if Key=VK_RETURN then
  begin
    getcustomer;
  end;
end;

procedure TFrmSellReserveSeat.reset;
begin
  inherited;
  nvcbbCERTIFICATETYPE.SetItemIndexByCode('4');
  nvedtCERTIFICATENO.Text:='';
end;

procedure TFrmSellReserveSeat.setContextHint(winControl: TWinControl);
begin
  if (winControl=nvcbbCERTIFICATETYPE)
    or (winControl=nvedtCERTIFICATENO) then
  begin
    lblContextHint.Caption:='输入订票人信息';
    appendAllContextHint;
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmSellReserveSeat.setInsuranceInfo(cdsInsuranceBuffer: TDataSet);
var selectedSeats:TStringBuilder;
    seatno:word;
begin
  inherited;
  selectedSeats:=TStringBuilder.Create;
  for seatno in seatPlan.selectedSeats do
  begin
    selectedSeats.Append(',').Append(seatno);
  end;
  selectedSeats.Remove(0,1).Insert(0,'(').Append(')');
  with jcdsqryBookTicket do
  begin
    active:=false;
    Params.ParamValues['filter_INS_t!seatno']:=selectedSeats.ToString;
    Params.ParamValues['filter_EQL_t!scheduleplanid']:=dsSchedule.DataSet.FieldByName('scheduleplanid').AsString;
    active:=true;
  end;
  with cdsInsuranceBuffer do
  begin
    first;
    while not eof do
    begin
      jcdsqryBookTicket.First;
      while not jcdsqryBookTicket.Eof do
      begin
        if FieldValues['seatno']=jcdsqryBookTicket.FieldValues['seatno'] then
        begin
          edit;
          FieldValues['customerid']:=jcdsqryBookTicket.FieldValues['customerid'];
          FieldValues['customername']:=jcdsqryBookTicket.FieldValues['customername'];
          FieldValues['certificatetype']:=jcdsqryBookTicket.FieldValues['certificatetype'];
          FieldValues['certificateno']:=jcdsqryBookTicket.FieldValues['certificateno'];
          if State=dsEdit then
          begin
            post;
          end;
          break;
        end;
        next;
      end;
      next;
    end;
  end;
end;

end.
