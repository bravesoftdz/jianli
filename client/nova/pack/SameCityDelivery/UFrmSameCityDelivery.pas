unit UFrmSameCityDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient, Services, UDMPublic,
  jsonClientDataSet, USimpleCRUDForm, ImgList, GridsEh, DBGridEh, NvDbgridEh,
  StdCtrls, ComCtrls, Generics.Collections,
  NovaPrint,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmSameCityDeliveryForm = class(TSimpleCRUDForm)
    Label2: TLabel;
    lbl4: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label3: TLabel;

    nvcbborg: TNovaCheckedComboBox;
    outstartdate: TDateTimePicker;
    outenddate: TDateTimePicker;
    nvhlpoutbound: TNovaHelp;
    nvedtdiliveno: TNovaEdit;
    jsondelpackdilivery: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    DBGridDetail: TDBGridEh;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TbtnAdd: TToolButton;
    dsDetailResult: TDataSource;
    packdiliverydetaillist: TjsonClientDataSet;
    pacdiliverydetailprint: TjsonClientDataSet;
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    // procedure tbtnEditClick(Sender: TObject);
    // procedure tbtnDeleteClick(Sender: TObject);
    // procedure tbtnPrinterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure TbtnAddClick(Sender: TObject);
  private
    { Private declarations }
    id: Integer;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
  public
    { Public declarations }
  end;

var
  FrmSameCityDeliveryForm: TFrmSameCityDeliveryForm;

implementation

uses UFrmSameCityDeliveryEdit;
{$R *.dfm}

procedure TFrmSameCityDeliveryForm.jcdsResultAfterScroll(DataSet: TDataSet);
var
  flag: Integer;
  msg: String;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with packdiliverydetaillist do
    begin
      try
        Active := false;
        Params.ParamByName('filter_EQL_pdd!packdiliveryid').Value := jcdsResult.FieldByName('id').AsLargeInt;
        Active := true;
        flag := Params.ParamByName('flag').Value;
        msg := Params.ParamByName('msg').Value;
      except on E:exception do
      begin
        showMessage(e.tostring);
      end;
    end;
  end;
end;

procedure TFrmSameCityDeliveryForm.TbtnAddClick(Sender: TObject);
var
  templtename: string;
begin
  inherited;

  try
    if not Assigned(billPrint) then
    begin
      billPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('同城送货详细', '同城送货详细'));
    end;
    if billPrint = nil then
    begin
      SysDialogs.ShowError('初始化同城送货详细模板失败，未知错误');
    end;
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    begin
      printValue.Clear;
    end;
  except
    on E: Exception do
      SysDialogs.ShowError('初始化同城送货详细模板失败：' + E.Message);
  end;
  try
    with packdiliverydetaillist do
    begin
      if RecordCount > 0 then
        begin
          first;
          while not EOF do
          begin
            billPrint.SingleValue.AddOrSetValue('packno', FieldByName('packno').AsString);
            billPrint.SingleValue.AddOrSetValue('vehiclecode', FieldByName('vehiclecode').AsString);
            billPrint.SingleValue.AddOrSetValue('sendstationname', FieldByName('sendstationname').AsString);
            billPrint.SingleValue.AddOrSetValue('sender', FieldByName('sender').AsString);
            billPrint.SingleValue.AddOrSetValue('name', FieldByName('name').AsString);
            billPrint.SingleValue.AddOrSetValue('packed', FieldByName('packed').AsString);
            billPrint.SingleValue.AddOrSetValue('consignee', FieldByName('consignee').AsString);
            billPrint.SingleValue.AddOrSetValue('consigneephone', FieldByName('consigneephone').AsString);
            billPrint.SingleValue.AddOrSetValue('pieces', FieldByName('pieces').AsString);
            billPrint.SingleValue.AddOrSetValue('weight', FieldByName('weight').AsString);
            billPrint.SingleValue.AddOrSetValue('paymethod', FieldByName('paymethod').AsString);
            billPrint.SingleValue.AddOrSetValue('shiptype', FieldByName('shiptype').AsString);
            billPrint.SingleValue.AddOrSetValue('consigneeaddress', FieldByName('consigneeaddress').AsString);
            billPrint.SingleValue.AddOrSetValue('certificateno', FieldByName('certificateno').AsString);
            billPrint.SingleValue.AddOrSetValue('shipprice', FieldByName('shipprice').AsString);
            billPrint.SingleValue.AddOrSetValue('insuredamount', FieldByName('insuredamount').AsString);
            billPrint.SingleValue.AddOrSetValue('insurance', FieldByName('insurance').AsString);
            billPrint.SingleValue.AddOrSetValue('handfee', FieldByName('handfee').AsString);
            billPrint.SingleValue.AddOrSetValue('packfee', FieldByName('packfee').AsString);
            billPrint.SingleValue.AddOrSetValue('insurancefee', FieldByName('insurancefee').AsString);
            billPrint.SingleValue.AddOrSetValue('transitfee', FieldByName('transitfee').AsString);
            billPrint.SingleValue.AddOrSetValue('deliveryfee', FieldByName('deliveryfee').AsString);
            billPrint.SingleValue.AddOrSetValue('pdddeliveryfee', FieldByName('pdddeliveryfee').AsString);
            billPrint.SingleValue.AddOrSetValue('otherfee', FieldByName('otherfee').AsString);
            billPrint.SingleValue.AddOrSetValue('totalfee', FieldByName('totalfee').AsString);
            billPrint.SingleValue.AddOrSetValue('packprice', FieldByName('packprice').AsString);
            billPrint.SingleValue.AddOrSetValue('unloadfee', FieldByName('unloadfee').AsString);
            billPrint.SingleValue.AddOrSetValue('remak', FieldByName('remak').AsString);
            billPrint.Print;
          next;
          end;
        end;
    end;

  except on E:exception do
     showMessage(e.tostring());
  end;
end;

procedure TFrmSameCityDeliveryForm.FormCreate(Sender: TObject);
begin
  inherited;
  outstartdate.DateTime := Now();
  outenddate.DateTime := Now();
  nvcbborg.Active := false;
  nvcbborg.Active := true;
end;

procedure TFrmSameCityDeliveryForm.tbtnDeleteClick(Sender: TObject);
var
  flag: Integer;
  msg: String;
  log: String;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
    if dsResult.DataSet.RecordCount < 1 then
    exit;

    if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;
    with jsondelpackdilivery do
    try
    close;
    Params.ParamByName('packdilivery.id').Value := jcdsResult.FieldByName('id').AsLargeInt;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
    log := '删除同城送货信息：出库人=' + jcdsResult.FieldByName('outboundname').AsString +
    ',送货单号=' + jcdsResult.FieldByName('diliveno').AsString +
    ',机构=' + jcdsResult.FieldByName('orgname').AsString +
    ',出库日期=' + DateToStr(jcdsResult.FieldByName('outdate').AsDateTime) +
    ',送货人=' + jcdsResult.FieldByName('diliver').AsString +
    ',送货日期=' + DateToStr(jcdsResult.FieldByName('dilivedate').AsDateTime);
    tbtnFilterClick(Sender);
    end;
    except
    on E: Exception do
    begin
    SysLog.WriteErr('同城送货信息删除失败：' + E.Message);
    end;
    end;
end;

procedure TFrmSameCityDeliveryForm.tbtnEditClick(Sender: TObject);
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
    if dsResult.DataSet.RecordCount < 1 then
    exit;
    id := jcdsResult.FieldByName('id').AsInteger;

    FrmSameCityDeliveryEditForm := TFrmSameCityDeliveryEditForm.Create(self);
    try
    with FrmSameCityDeliveryEditForm do
    begin
    Caption := '修改同城送货信息';
    packdiliveryid := jcdsResult.FindField('id').AsInteger; // packdilivery id
    nvedtdiliveno.Text := jcdsResult.FindField('diliveno').AsString;
    nvedtoutbound.Text := jcdsResult.FindField('outboundname').AsString;
    nvedtoutbound.id := jcdsResult.FindField('outbound').AsInteger;
    outdate.DateTime := jcdsResult.FindField('outdate').AsDateTime;
    nvedtdiliver.Text := jcdsResult.FindField('dilivername').AsString;
    nvedtdiliver.id := jcdsResult.FindField('diliver').AsInteger;
    dilivedate.DateTime := jcdsResult.FindField('dilivedate').AsDateTime;
    if SysMainForm.showFormModal(FrmSameCityDeliveryEditForm, false) = mrOk then
    begin
    tbtnFilter.Click;
    end;
    end;
    finally
    FreeAndNil(FrmSameCityDeliveryEditForm);
    end;
end;

procedure TFrmSameCityDeliveryForm.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    try
      Active := false;
      Params.ParamValues['filter_INS_pd!orgid'] := nvcbborg.GetSelectID;
      Params.ParamValues['filter_GED_pd!outdate'] := FormatDateTime
        ('yyyy-mm-dd', outstartdate.DateTime);
      Params.ParamValues['filter_LED_pd!outdate'] := FormatDateTime
        ('yyyy-mm-dd', outenddate.DateTime);
      Params.ParamValues['filter_EQS_pd!diliveno'] := trim(nvedtdiliveno.Text);
      if nvhlpoutbound.id > 0 then
        Params.ParamValues['filter_EQL_pd!outbound'] := nvhlpoutbound.id
      else
        Params.ParamValues['filter_EQL_pd!outbound'] := '';
      Active := true;
    except
      on E: exception do
        SysDialogs.ShowMessage(E.tostring());
    end;
  end;

end;

end.
