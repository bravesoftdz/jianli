unit UFrmDepartinvoicesotherSimple;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit, NovaCheckedComboBox, Services, UDMPublic;

type
  TFrmDepartinvoicesotherSimple = class(TSimpleCRUDForm)
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
    nvhlpUserid: TNovaHelp;
    lbl7: TLabel;
    jcdsResultDelDepartinvoicesother: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicesotherSimple: TFrmDepartinvoicesotherSimple;

implementation

uses UFrmDepartinvoicesotherSimpleEdit;

{$R *.dfm}

procedure TFrmDepartinvoicesotherSimple.FormShow(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.CheckById(True, SysInfo.LoginUserInfo.OrgID);

  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  // nvhlpvehicle.Action := False;
  // nvhlpvehicle.Action := True;
end;


procedure TFrmDepartinvoicesotherSimple.tbtnFilterClick(Sender: TObject);
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
      Params.ParamValues['filter_EQS_r!routeid'] := inttostr(nvhlpNHelpRoute.id);
    end
    else
    begin
      Params.ParamValues['filter_EQS_r!routeid'] := '';
    end;

    if (Trim(nvhlpUserid.Text) <> '') and (nvhlpUserid.Id > 0) then
    begin
      Params.ParamValues['filter_EQS_t!seller'] := inttostr(nvhlpUserid.id);
    end
    else
    begin
      Params.ParamValues['filter_EQS_t!seller'] := '';
    end;

    Active := True;

  end;
end;

procedure TFrmDepartinvoicesotherSimple.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmDepartinvoicesotherSimpleEdit := TFrmDepartinvoicesotherSimpleEdit.Create(Self);
  with FrmDepartinvoicesotherSimpleEdit do
  begin
    Caption := '添加结算单补录信息';
    edittype := Tedittype.add;

//    ShowModal;
    if SysMainForm.showFormModal(FrmDepartinvoicesotherSimpleEdit) = mrok then
    begin
      tbtnFilterClick(Self);
//      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;
end;


procedure TFrmDepartinvoicesotherSimple.tbtnDeleteClick(Sender: TObject);
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

procedure TFrmDepartinvoicesotherSimple.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  FrmDepartinvoicesotherSimpleEdit := TFrmDepartinvoicesotherSimpleEdit.Create(Self);
  with FrmDepartinvoicesotherSimpleEdit do
  begin
    Caption := '修改结算单补录信息';
    edittype := Tedittype.update;

    departinvoicesotherid := jcdsResult.FieldByName('id').AsInteger;
    dtpdepartdate.DateTime :=  jcdsResult.FieldByName('departdate').AsDateTime;
    vehicleid:= jcdsResult.FieldByName('vehicleid').AsInteger;
    nvhlpvehicle.Text := jcdsResult.FieldByName('vehicleno').AsString;
    routeid := jcdsResult.FieldByName('routeid').AsInteger;
    nvhlpNHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    nvedtno.Text := jcdsResult.FieldByName('departinvoicesno').AsString;
    nvhlptime.Text := jcdsResult.FieldByName('departtime').AsString;
    nvedtTicketnum.Text := jcdsResult.FieldByName('ticketnum').AsString;
    nvedtPieces.Text := jcdsResult.FieldByName('pieces').AsString;
    edttotalmoney.Text :=  jcdsResult.FieldByName('totalmoney').AsString;
    sellerid := jcdsResult.FieldByName('sellerid').AsInteger;
    nvhlpUserid.Text :=  jcdsResult.FieldByName('sellername').AsString;

 //   ShowModal;
    if SysMainForm.showFormModal(FrmDepartinvoicesotherSimpleEdit) = mrok then
    begin
      tbtnFilterClick(Self);
//      jcdsResult.Locate('id', departinvoicesotherid, []);
    end;
  end;
end;

end.
