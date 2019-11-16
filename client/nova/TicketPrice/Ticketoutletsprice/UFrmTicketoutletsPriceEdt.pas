unit UFrmTicketoutletsPriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaHComboBox, DB, DBClient,
  jsonClientDataSet, NovaCheckedComboBox, ImgList, NovaHelp, ComCtrls;

type
  TFrmTicketoutletsPriceEdt = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    NovaEdtRoute: TNovaEdit;
    NovaEditSchedule: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    jcsdQryHandprice2: TjsonClientDataSet;
    dshandprice: TDataSource;
    jcsdQryHandprice2scheduleid: TLargeintField;
    jcsdQryHandprice2departstationid: TLargeintField;
    jcsdQryHandprice2reachstationid: TLargeintField;
    jcsdQryHandprice2seattype: TWideStringField;
    jcdsQrySeatTypes: TjsonClientDataSet;
    jcsdQryHandprice2fullprice: TFloatField;
    jcsdQryHandprice2halfprice: TFloatField;
    jcsdQryHandprice2studentprice: TFloatField;
    jcsdQryHandprice2toplimitprice: TFloatField;
    jcsdQryHandprice2lowerlimitprice: TFloatField;
    jcsdQryHandprice2vehicletypeid: TLargeintField;
    jcsdQryHandprice2id: TLargeintField;
    jcsdQryHandprice2createby: TLargeintField;
    jcsdQryHandprice2seattypename: TWideStringField;
    jcsdQryHandprice2vehiclebrandmodelid: TLargeintField;
    NovaCbbVehicletype: TNovaHComboBox;
    lbl1: TLabel;
    mmoSeats: TMemo;
    jcsdQrySeats: TjsonClientDataSet;
    wdstrngfldQryHandpricebrandname: TWideStringField;
    wdstrngfldQryHandpricedepartstation: TWideStringField;
    wdstrngfldQryHandpricereachstation: TWideStringField;
    wdstrngfldQryHandpricevehicletype: TWideStringField;
    Label4: TLabel;
    lblvehiclebrandmodelid: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHComboBox;
    chkiscopyvehicletype: TCheckBox;
    jcsdQryHandprice2difprice: TFloatField;
    lbl3: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    CheckBox1: TCheckBox;
    lbl2: TLabel;
    dtpFromDate: TDateTimePicker;
    lbl4: TLabel;
    EndDate: TDateTimePicker;
    chkdate: TCheckBox;
    jcsdQryHandprice2starttime: TDateField;
    jcsdQryHandprice2endtime: TDateField;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure jcsdQryHandprice2fullpriceChange(Sender: TField);
    procedure jcsdQryHandprice2halfpriceChange(Sender: TField);
    procedure NovaCbbVehicletypeChange(Sender: TObject);
    procedure jcsdQryHandprice2AfterScroll(DataSet: TDataSet);
    procedure NvHcbbVehiclebrandmodelChange(Sender: TObject);
    procedure chkdateClick(Sender: TObject);
  private
    { Private declarations }
    rate: double;
    procedure qrySeats(vehiclebrandmodelid: Int64; seattype: string);
  public
    { Public declarations }
    createby, vehicletypeid, ticketoutletsid, ticketoutletspriceid: Int64;
    saveorupdateflag : Int64;
  end;

var
  FrmTicketoutletsPriceEdt: TFrmTicketoutletsPriceEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmTicketoutletsPriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult, flag, i: integer;
  sResult, result, log: string;
begin
  inherited;
  if chkdate.Checked then
  begin
    if Trunc(dtpFromDate.Date) > Trunc(EndDate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      EndDate.SetFocus;
      exit;
    end;
  end;
  try

    with jcsdQryHandprice2 do
      while (not eof) do
      begin
        if (FieldByName('fullprice').AsFloat > FieldByName('toplimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('全票票价不能超过上限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('fullprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('全票票价不能低于下限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        next;
      end;

    with jcsdQryHandprice2 do
    begin
      if chkiscopyvehicletype.Checked then
        Params.ParamValues['iscopyvehicletype'] := true
      else
        Params.ParamValues['iscopyvehicletype'] := False;
      Params.ParamValues['ticketoutletsprice.ticketoutletsid'] :=
        ticketoutletsid;
      Params.ParamValues['ticketoutletsprice.id'] := ticketoutletspriceid;
      Params.ParamValues['ticketoutletsprice.scheduleid'] :=
        NovaEditSchedule.Id;
      // 日期判断
      Params.ParamValues['ticketoutletsprice.starttime'] := FormatDateTime
        ('yyyy-mm-dd', dtpFromDate.Date);
      Params.ParamValues['ticketoutletsprice.endtime'] := FormatDateTime
        ('yyyy-mm-dd', EndDate.Date);

      if chkdate.Checked then // 设置日期
      begin
        Params.ParamValues['getDateTime'] := 0;
      end
      else
      begin
        Params.ParamValues['getDateTime'] := 1;
      end;
      nResult := jcsdQryHandprice2.ApplyUpdates(-1);
      sResult := jcsdQryHandprice2.Params.ParamValues['msg'];
      flag := jcsdQryHandprice2.Params.ParamValues['flag'];
      log := '';
      if flag <= 0 then
      begin
        SysDialogs.ShowMessage(sResult);
        exit;
      end
      else
      begin
        log := '售票点票价差额设置：营运线路=' + NovaEdtRoute.Text + ',班次号=' +
          NovaEditSchedule.Text + ',营运车型=' + NovaCbbVehicletype.Text +
          ',品牌型号=' + NvHcbbVehiclebrandmodel.Text + ',座位号=' +
          mmoSeats.Text;
        with jcsdQryHandprice2 do
        begin
          first;
          while (not eof) do
          begin
            result := result + ',上车站=' + FieldByName('departstation')
              .AsString + ',到达站=' + FieldByName('reachstation')
              .AsString + ',车型=' + FieldByName('vehicletype')
              .AsString + ',全价=' + FieldByName('fullprice')
              .AsString + ',半价=' + FieldByName('halfprice')
              .AsString + ',学生价=' + FieldByName('studentprice')
              .AsString + '，售票点票价差额=' + FieldByName('difprice')
              .AsString;
            next;
          end;
        end;
        log := log + result;
        if chkiscopyvehicletype.Checked then
          log := log + ',该票价同时复制到本线路其他车型';
        SysLog.WriteLog('票价管理——>售票点票价差额管理', '售票点票价差额设置', log);
        SysDialogs.ShowMessage('保存成功！');
        ModalResult := mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存平时票价信息失败：' + E.Message);
    end;
  end;

end;

procedure TFrmTicketoutletsPriceEdt.chkdateClick(Sender: TObject);
begin
  inherited;
  if chkdate.Checked then
  begin
    lbl2.Visible := true;
    lbl4.Visible := true;
    dtpFromDate.Visible := true;
    EndDate.Visible := true;
    dtpFromDate.DateTime := now;
    EndDate.DateTime := now;
  end
  else
  begin
    lbl2.Visible := False;
    lbl4.Visible := False;
    dtpFromDate.Visible := False;
    EndDate.Visible := False;
  end;
end;

procedure TFrmTicketoutletsPriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  jcdsQrySeatTypes.Active := False;
  jcdsQrySeatTypes.Active := true;
  chkdate.Enabled:=False;
   dtpFromDate.DateTime := now;
          EndDate.DateTime :=Now;
  with NovaCbbVehicletype do
  begin
    Active := False;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.Id;
    Active := true;
  end;
  NovaCbbVehicletype.SetItemIndexByField('id', vehicletypeid);
  NovaCbbVehicletypeChange(Sender);
  try
    rate := strtofloat(getParametervalue('0017', Sysinfo.LoginUserInfo.OrgID));
  except
    on E: Exception do
      rate := 0.5;
  end;
end;

procedure TFrmTicketoutletsPriceEdt.jcsdQryHandprice2AfterScroll
  (DataSet: TDataSet);
begin
  inherited;
  qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid').AsInteger,
    jcsdQryHandprice2.FieldByName('seattype').AsString);
end;

procedure TFrmTicketoutletsPriceEdt.jcsdQryHandprice2fullpriceChange
  (Sender: TField);
var
  price: double;
  toplimitprice, lowerlimitprice: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  toplimitprice := jcsdQryHandprice2.FieldByName('toplimitprice').AsFloat;
  lowerlimitprice := jcsdQryHandprice2.FieldByName('lowerlimitprice').AsFloat;
  jcsdQryHandprice2.FieldByName('halfprice').Value := round(price * rate);
  jcsdQryHandprice2.FieldByName('studentprice').Value := price;
  if (price > toplimitprice) then
  begin
    SysDialogs.Warning('全票票价不能超过上限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('全票票价不能低于下限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmTicketoutletsPriceEdt.jcsdQryHandprice2halfpriceChange
  (Sender: TField);
var
  price, fullprice: double;
  lowerlimitprice: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  fullprice := jcsdQryHandprice2.FieldByName('fullprice').AsFloat;
  lowerlimitprice := jcsdQryHandprice2.FieldByName('lowerlimitprice').AsFloat;
  if (price > fullprice) then
  begin
    SysDialogs.Warning('半票票价不能超过全票票价！');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('半票票价不能低于下限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmTicketoutletsPriceEdt.NovaCbbVehicletypeChange(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  jcsdQryHandprice2.AfterScroll := nil;
  if NovaCbbVehicletype.ItemIndex >= 0 then
    with jcsdQryHandprice2 do
    begin
      Active := False;
      Params.ParamValues['ticketoutletsprice.scheduleid'] :=
        NovaEditSchedule.Id;
      Params.ParamValues['ticketoutletsprice.vehicletypeid'] :=
        NovaCbbVehicletype.HelpFieldValue['id'];
      Params.ParamValues['ticketoutletsprice.createby'] := createby;
      Params.ParamValues['ticketoutletsprice.ticketoutletsid'] :=
        ticketoutletsid;
      Params.ParamValues['ticketoutletsprice.vehiclebrandmodelid'] := null;
      if ticketoutletspriceid > 0 then
      begin
        Params.ParamValues['ticketoutletsprice.id'] := ticketoutletspriceid;
      end;
      if saveorupdateflag>0 then
      begin
        Params.ParamValues['saveorupdateflag'] := saveorupdateflag;
      end;
      Active := true;
      nResult := Params.ParamValues['flag'];
      if nResult <> 1 then
      begin
        sResult := Params.ParamValues['msg'];
        SysDialogs.Warning(sResult);
        mmoSeats.Clear;
        exit;

      end
      else
      begin
        qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid')
            .AsInteger, jcsdQryHandprice2.FieldByName('seattype').AsString);
      end;
      NvHcbbVehiclebrandmodel.Active := False;
      NvHcbbVehiclebrandmodel.Params.ParamValues['filter_EQL_t!vehicletypeid']
        := NovaCbbVehicletype.HelpFieldValue['id'];
      NvHcbbVehiclebrandmodel.Active := true;
    end;
  jcsdQryHandprice2.AfterScroll := jcsdQryHandprice2AfterScroll;
end;

procedure TFrmTicketoutletsPriceEdt.NvHcbbVehiclebrandmodelChange
  (Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if NvHcbbVehiclebrandmodel.ItemIndex >= 0 then
  begin
    with jcsdQryHandprice2 do
    begin
      Active := False;
      Params.ParamValues['ticketoutletsprice.scheduleid'] :=
        NovaEditSchedule.Id;
      Params.ParamValues['ticketoutletsprice.vehicletypeid'] :=
        NovaCbbVehicletype.HelpFieldValue['id'];
      Params.ParamValues['ticketoutletsprice.createby'] := createby;
      Params.ParamValues['ticketoutletsprice.ticketoutletsid'] :=
        ticketoutletsid;
      Params.ParamValues['ticketoutletsprice.vehiclebrandmodelid'] :=
        NvHcbbVehiclebrandmodel.HelpFieldValue['id'];
      if ticketoutletspriceid > 0 then
      begin
        Params.ParamValues['ticketoutletsprice.id'] := ticketoutletspriceid;
      end;
      if saveorupdateflag>0 then
      begin
        Params.ParamValues['saveorupdateflag'] := saveorupdateflag;
      end;
      Active := true;
      nResult := Params.ParamValues['flag'];
      if nResult <> 1 then
      begin
        // sResult:=Params.ParamValues['msg'];
        // SysDialogs.Warning(sResult);
        // mmoSeats.Clear;
        // exit;
      end
      else
      begin
        qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid')
            .AsInteger, jcsdQryHandprice2.FieldByName('seattype').AsString);
      end;
    end;
  end;
end;

procedure TFrmTicketoutletsPriceEdt.qrySeats(vehiclebrandmodelid: Int64;
  seattype: string);
begin
  with jcsdQrySeats do
  begin
    Active := False;
    Params.ParamValues['vehiclebrandmodelid'] := vehiclebrandmodelid;
    Params.ParamValues['seattype'] := seattype;
    Execute;
    mmoSeats.Text := Params.ParamValues['seatnos'];
  end;
end;

end.
