unit UFrmTicketdeliver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmTicketdeliverEdit, UFrmTicketdeliverdetail, NovaEdit,
  NovaHelp;

type
  TFrmTicketdeliver = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    dbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    ToolBar1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    ToolButton5: TToolButton;
    btndelDep: TToolButton;
    il1: TImageList;
    dataSource: TDataSource;
    jcdsResult1: TjsonClientDataSet;
    jcdsDelTicketdeliver: TjsonClientDataSet;
    jcdsResultDelTicketdeliverdetail: TjsonClientDataSet;
    lbl1: TLabel;
    dtpdepartdate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpdeliverby: TNovaHelp;
    lbl4: TLabel;
    edtarea: TNovaEdit;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure btnInsertDepClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketdeliver: TFrmTicketdeliver;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTicketdeliver.btndelDepClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jcdsResultDelTicketdeliverdetail do
  try
    close;
    Params.ParamByName('ticketdeliverdetail.id').Value :=jcdsResult1.FieldByName('id').AsString ;
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
      SysLog.WriteErr('��Ʊ��¼��ϸɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmTicketdeliver.btnInsertDepClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmTicketdeliverdetail do
  begin
    FrmTicketdeliverdetail := TFrmTicketdeliverdetail.Create(Self);
    Caption := '��Ʊ��¼��ϸ';
    sign := true;
    edtarea.text := jcdsResult.FieldByName('area').AsString;
    edtaddress.Text := jcdsResult.FieldByName('address').AsString;
    ticketdeliverid := jcdsResult.FieldByName('id').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Self);
      jcdsResult.Locate('id', ticketdeliverid, []);
    end;
  end;
end;

procedure TFrmTicketdeliver.btnUpdateDepClick(Sender: TObject);
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  with FrmTicketdeliverdetail do
  begin
    FrmTicketdeliverdetail := TFrmTicketdeliverdetail.Create(self);
    Caption := '�޸���Ʊ�Ǽ���Ϣ';
    sign:=false;
    ticketdeliverid := jcdsResult1.FieldByName('deliverid').AsString;
    id :=  jcdsResult1.FieldByName('id').AsString;
    createby := jcdsResult1.FieldByName('createby').AsString;
    createtime := jcdsResult1.FieldByName('createtime').AsString;

    edtarea.Text := jcdsResult1.FieldByName('area').AsString;
    edtaddress.Text := jcdsResult1.FieldByName('address').AsString;
    dtpdepartdate.DateTime := jcdsResult1.FieldByName('departdate').AsDateTime;
    //cbbschedule.Text := jcdsResult1.FieldByName('schedulecode').AsString;
    //cbbticketno.Text := jcdsResult1.FieldByName('ticketno').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult1.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmTicketdeliver.FormCreate(Sender: TObject);
begin
  inherited;
  dtpdepartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
end;

procedure TFrmTicketdeliver.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResult1.Close;
  end;
end;

procedure TFrmTicketdeliver.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResult1 do
  begin
    Active:=false;
    Params.ParamByName('filter_EQL_td!id').Value:=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
end;

procedure TFrmTicketdeliver.tbtnDeleteClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jcdsDelTicketdeliver do
  try
    close;
    Params.ParamByName('ticketdeliver.id').Value :=jcdsResult.FieldByName('id').AsString ;
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
      SysLog.WriteErr('��Ʊ��¼ɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmTicketdeliver.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmTicketdeliverEdit do
  begin
    FrmTicketdeliverEdit := TFrmTicketdeliverEdit.Create(self);
    Caption := '�޸���Ʊ�Ǽ���Ϣ';
    sign:=false;
    id :=  jcdsResult.FieldByName('id').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    deliverdate := jcdsResult.FieldByName('deliverdate').AsString;
    isturnover := jcdsResult.FieldByName('isturnover').AsString;
    turnoverid := jcdsResult.FieldByName('turnoverid').AsString;

    edtarea.Text := jcdsResult.FieldByName('area').AsString;
    edtaddress.Text := jcdsResult.FieldByName('address').AsString;
    edtclientname.Text := jcdsResult.FieldByName('clientname').AsString;
    edtclientphone.Text := jcdsResult.FieldByName('clientphone').AsString;
    nvhlpdeliverby.Text := jcdsResult.FieldByName('deliverby').AsString;
    edtserviceprice.Text := jcdsResult.FieldByName('serviceprice').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmTicketdeliver.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!deliverdate'] := FormatDateTime('yyyy-mm-dd',dtpdepartdate.Date);
      Params.ParamValues['filter_LED_t!deliverdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
      if Trim(edtarea.Text) = '' then
      begin
        Params.ParamValues['filter_LIKES_t!area'] := '';
      end else
      begin
        Params.ParamValues['filter_LIKES_t!area'] := edtarea.Text;
      end;
      if Trim(nvhlpdeliverby.Text) = '' then
      begin
        Params.ParamValues['filter_LIKES_t!deliverby'] := '';
      end else
      begin
        Params.ParamValues['filter_LIKES_t!deliverby'] := nvhlpdeliverby.Text;
      end;
      jcdsResult.AfterScroll:=nil;
    try      Active:=true;      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
    Active := True;
  end;
  
end;

procedure TFrmTicketdeliver.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmTicketdeliverEdit do
  begin
    FrmTicketdeliverEdit := TFrmticketdeliverEdit.Create(Self);
    Caption := '������Ʊ��¼';
    sign := True;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Self);
    end;

  end;
end;

end.
