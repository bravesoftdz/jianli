unit UFrmScheduleSeatReserveEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ImgList, NovaEdit,
  ComCtrls, NovaHComboBox, DB, DBClient, jsonClientDataSet, SeatPlan,
  Generics.Collections;

type
  TFrmScheduleSeatReserveEdt = class(TSimpleEditForm)
    rbRoute: TRadioButton;
    rbSchedule: TRadioButton;
    lbl1: TLabel;
    NovaCbbVehiclebrand: TNovaHComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpStartdate: TDateTimePicker;
    lbl4: TLabel;
    dtpEndstart: TDateTimePicker;
    lbl5: TLabel;
    NovaEdtSeats: TNovaEdit;
    grp1: TGroupBox;
    pnlseatplan: TPanel;
    lbl7: TLabel;
    NovaEdtSeatnum: TNovaEdit;
    jcsdQrySave: TjsonClientDataSet;
    lbl6: TLabel;
    edtRemark: TEdit;
    procedure FormShow(Sender: TObject);
    procedure NovaCbbVehiclebrandChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    SeatPlan: TSeatPlanSelect;
    selectedseatno: TList<Word>;
    curseatsStatus: TDictionary<Word, String>;
    seatsTickettype: TDictionary<Word, String>;
    seatstype: TDictionary<Word, String>;
    selectSeatStatus: TList<String>;
    procedure clickseat(seatno: Word);
    procedure reflashseat(seats: Integer;brandModelid:Int64);
  public
    { Public declarations }
    scheduleid, id, createby, updateby,vehicletypeid,brandModelid: Int64;
    createtime,code,seatnos,Seatnum: String;
  end;

var
  FrmScheduleSeatReserveEdt: TFrmScheduleSeatReserveEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleSeatReserveEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log: string;
begin
  inherited;
  if NovaCbbVehiclebrand.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择营运车辆厂牌！');
    NovaCbbVehiclebrand.SetFocus;
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpStartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEndstart.Date) then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期！');
    dtpStartdate.SetFocus;
    exit;
  end;
  if (NovaEdtSeatnum.Text='') or (NovaEdtSeatnum.Text='0') or (SeatPlan.getSelectedSeats.Count = 0) then
  begin
    SysDialogs.Warning('请选择座位号！');
    exit;
  end;
  with jcsdQrySave do
  begin
    close;
    log:='班次号='+code;
    log:=log+',营运厂牌='+NovaCbbVehiclebrand.Text;
    log:=log+',开始日期='+  FormatDateTime
      ('yyyy-mm-dd', dtpStartdate.Date);
    log:=log+',结束日期='+  FormatDateTime
      ('yyyy-mm-dd', dtpEndstart.Date);
    log:=log+',座位号='+  NovaEdtSeats.Text;

    Params.ParamByName('scheduleseatreserve.id').Value := id;
    if rbSchedule.Checked then
      Params.ParamByName('issameroute').Value := false
    else
      Params.ParamByName('issameroute').Value := True;
    Params.ParamByName('scheduleseatreserve.vehiclebrandmodelid').Value :=
      NovaCbbVehiclebrand.HelpFieldValue['id'];
    Params.ParamByName('scheduleseatreserve.vehicletypeid').Value :=
      NovaCbbVehiclebrand.HelpFieldValue['vehicletypeid'];
    Params.ParamByName('scheduleseatreserve.startdate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpStartdate.Date);
    Params.ParamByName('scheduleseatreserve.enddate').Value := FormatDateTime
      ('yyyy-mm-dd', dtpEndstart.Date);
    Params.ParamByName('scheduleseatreserve.scheduleid').Value := scheduleid;
    Params.ParamByName('scheduleseatreserve.seatnos').Value :=
      NovaEdtSeats.Text;
    Params.ParamByName('scheduleseatreserve.seatnum').Value := NovaEdtSeatnum.Text;
    Params.ParamByName('scheduleseatreserve.createby').Value := createby;
    if createtime<>'' then
      Params.ParamByName('scheduleseatreserve.createtime').Value := createtime;
    Params.ParamByName('scheduleseatreserve.updateby').Value := SysInfo.LoginUserInfo.UserID;
    Params.ParamByName('scheduleseatreserve.remarks').Value := edtRemark.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        exit;
      end
      else
      begin
        id := Params.ParamByName('scheduleseatreserveid').Value;
        SysLog.WriteLog('添加、修改固定留位信息', '添加、修改', log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('固定留位信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmScheduleSeatReserveEdt.clickseat(seatno: Word);
var
  i: Integer;
begin
  if Assigned(SeatPlan) then
  begin
    NovaEdtSeats.Clear;
    selectedseatno := SeatPlan.getSelectedSeats;
    selectedseatno.Sort;
    for i := 0 to selectedseatno.Count - 1 do
    begin
      NovaEdtSeats.Text := NovaEdtSeats.Text + inttostr
        (selectedseatno.Items[i]) + '.';
    end;
    NovaEdtSeatnum.Text := inttostr(selectedseatno.Count);
  end;
end;

procedure TFrmScheduleSeatReserveEdt.FormCreate(Sender: TObject);
begin
  inherited;
  curseatsStatus := TDictionary<Word, String>.Create;
  seatsTickettype:= TDictionary<Word, String>.Create;
  seatstype:= TDictionary<Word, String>.Create;
  selectSeatStatus := TList<string>.Create;
  SeatPlan := TSeatPlanSelect.Create(pnlseatplan);
  selectedseatno := TList<Word>.Create;
end;

procedure TFrmScheduleSeatReserveEdt.FormShow(Sender: TObject);
var
   ss,seatno:string;
   seats:integer;
begin
  inherited;
  with NovaCbbVehiclebrand do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleid;
    Active := true;
  end;
  if NovaCbbVehiclebrand.Items.Count = 0 then
  begin
    SysDialogs.Warning('该班次还未设置班次循环！');
    exit;
  end;
  if (edittype=Tedittype.update) then
  begin
    NovaCbbVehiclebrand.SetItemIndexByField('id',brandModelid);
    seats :=NovaCbbVehiclebrand.HelpFieldValue['rationseatnum'];
    reflashseat(seats,NovaCbbVehiclebrand.HelpFieldValue['id']) ;
    NovaEdtSeats.Text:=seatnos;
    NovaEdtSeatnum.Text:=Seatnum;
    NovaCbbVehiclebrand.Enabled:=False;
    ss:=seatnos;
    while(Length(ss)>0) do
    begin
      seatno:=Copy(ss,1,Pos('.',ss)-1);
      ss:=Copy(ss,Pos('.',ss)+1,Length(ss));
      selectedseatno.Add(StrToInt(seatno));
    end;
    SeatPlan.setSelectedSeats(selectedseatno);
  end
  else
  begin
    dtpStartdate.Date := now;
    //dtpEndstart.Date := now;
    seats:=NovaCbbVehiclebrand.HelpFieldValue['rationseatnum'];
    reflashseat(seats,NovaCbbVehiclebrand.HelpFieldValue['id']) ;
  end;


end;

procedure TFrmScheduleSeatReserveEdt.NovaCbbVehiclebrandChange(Sender: TObject);
begin
  inherited;
  reflashseat(NovaCbbVehiclebrand.HelpFieldValue['rationseatnum'],NovaCbbVehiclebrand.HelpFieldValue['id'])
end;

procedure TFrmScheduleSeatReserveEdt.reflashseat(seats: Integer;brandModelid:Int64);
var
  i: Integer;
begin
  if seats > 0 then
  begin
    NovaEdtSeats.Clear;
    NovaEdtSeatnum.Text:='0';
    selectSeatStatus.Clear;
    curseatsStatus.Clear;
    if Assigned(SeatPlan.selectedSeats) then
      SeatPlan.selectedSeats.Clear;
    selectSeatStatus.Add('0');
    for i := 1 to seats do
    begin
      curseatsStatus.Add(i, '0');
    end;
    SeatPlan.defaultcellwidth := 50;
    SeatPlan.defaultcellheight := 56;
    SeatPlan.defaultcolcount := 13;
    SeatPlan.selectSeatNum := seats;
    SeatPlan.brandModelid:= brandModelid;
    SeatPlan.seatsStatus := curseatsStatus;
    SeatPlan.selectSeatStatus := selectSeatStatus;
    SeatPlan.seatstype:=seatstype;
    SeatPlan.seatsTickettype := seatsTickettype;
    SeatPlan.OnSelectSeatno := clickseat;
    SeatPlan.setParent(pnlseatplan);
    SeatPlan.Align := alClient;
  end;
end;

end.
