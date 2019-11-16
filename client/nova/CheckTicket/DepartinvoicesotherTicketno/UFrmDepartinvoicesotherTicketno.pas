unit UFrmDepartinvoicesotherTicketno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp,Services, UDMPublic;

type
  TFrmDepartinvoicesotherTicketno = class(TSimpleCRUDForm)
    lbl1: TLabel;
    cbborg: TNovaCheckedComboBox;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvedtno: TNovaEdit;
    lbl3: TLabel;
    nvhlpvehicle: TNovaHelp;
    lbl6: TLabel;
    nvhlpNHelpRoute: TNovaHelp;
    lblschedule: TLabel;
    nvhlpschedule: TNovaHelp;
    nvhlpcreateby: TNovaHelp;
    Label2: TLabel;
    Label9: TLabel;
    nvhlpprintby: TNovaHelp;
    jcdsResultDelDepartinvoicesother: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    param_3068 : string ;
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicesotherTicketno: TFrmDepartinvoicesotherTicketno;

implementation

uses UFrmDepartinvoicesotherTicketnoEdit;

{$R *.dfm}

procedure TFrmDepartinvoicesotherTicketno.FormShow(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.CheckById(True,SysInfo.LoginUserInfo.OrgID);

  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;


procedure TFrmDepartinvoicesotherTicketno.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmDepartinvoicesotherTicketnoEdit := TFrmDepartinvoicesotherTicketnoEdit.Create(Self);
  with FrmDepartinvoicesotherTicketnoEdit do
  begin
    Caption := '添加结算单补录(票号)';
    edittype := Tedittype.add;

//    ShowModal;
    if SysMainForm.showFormModal(FrmDepartinvoicesotherTicketnoEdit) = mrok then
    begin
      tbtnFilterClick(Self);
      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;
end;

procedure TFrmDepartinvoicesotherTicketno.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd', dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;

    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_t!orgid'] := cbborg.GetSelectID;

    Params.ParamValues['filter_GED_t!departdate'] := DateTimeToStr
      (dtpstartdate.DateTime - 1);
    Params.ParamValues['filter_LED_t!departdate'] := DateTimeToStr
      (dtpenddate.DateTime);

    if Trim(nvedtno.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_t!departinvoicesno'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!departinvoicesno'] := Trim(nvedtno.Text);
    end;

    if (Trim(nvhlpvehicle.Text) <> '') and (nvhlpvehicle.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhlpvehicle.id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end;

    if (Trim(nvhlpNHelpRoute.Text) <> '') and (nvhlpNHelpRoute.Id > 0) then
    begin
      Params.ParamValues['filter_EQS_s!routeid'] := inttostr(nvhlpNHelpRoute.id);
    end
    else
    begin
      Params.ParamValues['filter_EQS_s!routeid'] := '';
    end;

    if nvhlpschedule.id > 0 then
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.id
    else
      Params.ParamValues['filter_EQL_s!id'] := null;

    if (Trim(nvhlpprintby.Text) <> '') and (nvhlpprintby.Id > 0) then
    begin
      Params.ParamValues['filter_EQS_t!seller'] := inttostr(nvhlpprintby.id);
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!seller'] := '';
    end;

    if (Trim(nvhlpcreateby.Text) <> '') and (nvhlpcreateby.Id > 0) then
    begin
      Params.ParamValues['filter_EQS_t!balanceby'] := inttostr(nvhlpcreateby.id);
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!balanceby'] := '';
    end;

    Active := True;

  end;
end;


procedure TFrmDepartinvoicesotherTicketno.tbtnDeleteClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;
  with jcdsResultDelDepartinvoicesother do
    try
      close;
      Params.ParamByName('departinvoicesother.id').Value :=
        jcdsResult.FieldByName('id').AsInteger;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录信息删除失败：' + E.Message);
      end;
    end;

end;


procedure TFrmDepartinvoicesotherTicketno.tbtnEditClick(Sender: TObject);
begin
  inherited;
//  if not dsResult.DataSet.Active then
//    exit;
//  if dsResult.DataSet.RecordCount < 1 then
//    exit;
//  if (Trim(jcdsResult.fieldbyname('statusname').AsString) = '已结算') or
//    (Trim(jcdsResult.fieldbyname('isauditvalue').AsString) = '审核') then
//  begin
//    SysDialogs.ShowMessage('已经结算和审核状态的手工单不能修改!');
//    exit;
//  end;

  FrmDepartinvoicesotherTicketnoEdit := TFrmDepartinvoicesotherTicketnoEdit.Create(Self);
  with FrmDepartinvoicesotherTicketnoEdit do
  begin

    Caption := '结算单补录(票号)';
//    p3068 := param_3068;//3068:手工结算单是否进行自动结算扣费  0否，1是
//    sign := true;
    departinvoicesotherid := jcdsResult.fieldbyname('id').AsInteger;
//    nvhlpvehicle.Text := jcdsResult.fieldbyname('vehiclename').AsString;
    nvhlpvehicle.OnIdChange := nil; // 先关闭车牌控件的onidchange事件
    nvhlpvehicle.id := jcdsResult.fieldbyname('vehicleid').AsInteger;
    nvhlpvehicle.OnIdChange := nvhlpvehicle.OnIdChange; // 打开车牌控件的onidchange事件

    nvhlpvehicle.Text := jcdsResult.fieldbyname('vehicleno').AsString;
//    nvhlpvehicle.readOnly := true;
//    nvhlpdepartstation.Text := jcdsResult.fieldbyname('departname').AsString;
    nvhlpreachstation.Text := jcdsResult.fieldbyname('reachstationname').AsString;
    nvhlpreachstation.readOnly := true;
    nvhlpreachstation.id := jcdsResult.fieldbyname('reachstationid').AsInteger;
    edtDepartinvoicesno.Text := jcdsResult.fieldbyname('departinvoicesno').AsString;
    edtDepartinvoicesno.ReadOnly := true;
    // nvhlpschedule.Text := jcdsResult.FieldByName('schedulecode').AsString;
    // scheduleid := jcdsResult.FieldByName('scheduleid').AsInteger;
    dtpdepartdate.DateTime := jcdsResult.fieldbyname('departdate').AsDateTime;
//    NovaEbalancemoney.Text := jcdsResult.fieldbyname('balancemoney').AsString;

    nvhlpschedule.Text := jcdsResult.fieldbyname('schedulecode').AsString;
    nvhlpschedule.id := jcdsResult.fieldbyname('scheduleid').AsInteger;
    nvhlpschedule.id := jcdsResult.fieldbyname('scheduleid').AsInteger;
    // nvhlptime.Text := jcdsResult.FieldByName('starttime').AsString;
    // nvhlpschedule.Enabled := false;

//    departdate := jcdsResult.fieldbyname('departdate').AsString;
//    departno := jcdsResult.fieldbyname('departinvoicesno').AsString;
    nvhlpseller.id := jcdsResult.fieldbyname('seller').AsLargeInt;
    nvhlpseller.Text := jcdsResult.fieldbyname('sellername').AsString;
  with jcdsQrydepartinvoicesotherdetail do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!departinvoicesotherid'] := departinvoicesotherid;
    Active := True;
  end;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;
end;



end.
