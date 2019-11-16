unit UFrmBillinventoryManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHComboBox, NvPrnDbgeh, NvDbgridEh,
  NovaCheckedComboBox;

type
  TFrmBillinventoryManager =class(TSimpleCRUDForm)
    btntnbillinuse: TToolButton;
    jsonCDSbilllog: TjsonClientDataSet;
    dsbilllog: TDataSource;
    novahcbbstorage: TNovaHComboBox;
    novahcbbtype: TNovaHComboBox;
    lbl2: TLabel;
    lbl1: TLabel;
    jsonCDSDelBillinventory: TjsonClientDataSet;
    grp2: TGroupBox;
    dbgrdh1: TNvDBGridEh;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    chkcount: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmBillinventoryManager: TFrmBillinventoryManager;

implementation
 uses UFrmBillinventory,UFrmBillinventoryout,UFrmBillLinuse,PubFn;
{$R *.dfm}

procedure TFrmBillinventoryManager.FormCreate(Sender: TObject);
begin
  inherited;
    novahcbbtype.Active:=false;
    novahcbbtype.Active:=true;
    novahcbbstorage.Active:=false;
    novahcbbstorage.Active:=true;
    cbborg.Active := False;
    cbborg.Active := True;
end;

procedure TFrmBillinventoryManager.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount<1 then
  begin
    jsonCDSbilllog.Close;
  end;
end;

procedure TFrmBillinventoryManager.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
      exit;
  if dsResult.DataSet.RecordCount<1 then
      exit;
  with jsonCDSbilllog do
    begin
      Active:=false;
      Params.ParamByName('filter_EQL_b!billinventoryid').Value:=jcdsResult.FieldByName('id').AsLargeInt;
      Active:=true;
    end;
end;

procedure TFrmBillinventoryManager.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg,log: string;
begin
  inherited;
if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jsonCDSDelBillinventory do
  try
    close;
    Params.ParamByName('billinventory.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
      log := 'ɾ��[Ʊ��������κ�]:'+jcdsResult.FieldByName('batchno').AsString
            +',[Ʊ������]:'+jcdsResult.FieldByName('storagename').AsString
            +',[Ʊ������]:'+jcdsResult.FieldByName('typename').AsString
            +',[����]:'+jcdsResult.FieldByName('orgname').Asstring
            +',[��ʼ��]:'+jcdsResult.FieldByName('putinstartno').AsString
            +',[������]:'+jcdsResult.FieldByName('putinendno').AsString
            +',[��������]:'+jcdsResult.FieldByName('availablecount').AsString;
      SysLog.WriteLog('Ʊ�ݹ���-Ʊ�ݿ��','ɾ��Ʊ�ݿ��',log);
      log :='';
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Ʊ�ݿ����Ϣɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmBillinventoryManager.tbtnEditClick(Sender: TObject);

begin
  inherited;
  if not dsResult.DataSet.Active then
  begin
    SysDialogs.ShowMessage('���Ȳ�ѯ���ݣ��ٳ���');
    exit;
  end;

  if dsResult.DataSet.RecordCount < 1 then
    exit;
 with FrmBillinventoryout do
 begin
    FrmBillinventoryout := TFrmBillinventoryout.Create(self);
    Caption:= 'Ʊ�ݳ���';
    id :=  jcdsResult.FieldByName('id').AsInteger;
    edtbillstorage.Text:=jcdsResult.FieldByName('storagename').AsString;
    storageid:=jcdsResult.FieldByName('storageid').AsLargeInt;
    edtbilltypename.Text:=jcdsResult.FieldByName('typename').AsString;

    billtypeid:=jcdsResult.FieldByName('billtypeid').AsLargeInt;
    availablestartno:= jcdsResult.FieldByName('availablestartno').AsLargeInt;
    availableenno:=jcdsResult.FieldByName('availableenno').AsLargeInt;
    edtstartnum.Text :=jcdsResult.FieldByName('availablestartno').AsString;
    edtendnum.Text :=jcdsResult.FieldByName('availableenno').AsString;
    edtstartno.MaxLength:=jcdsResult.FieldByName('ticketnolength').AsInteger;
    edtendno.MaxLength:=jcdsResult.FieldByName('ticketnolength').AsInteger;
    edtstartno.Text:=jcdsResult.FieldByName('availablestartno').AsString;
    edtavailablecount.Text := jcdsResult.FieldByName('availablecount').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;

end;

end;


procedure TFrmBillinventoryManager.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_b!orgid'] := cbborg.GetSelectID;
    if novahcbbstorage.ItemIndex>=0 then
      Params.ParamByName('filter_EQL_b!storageid').Value :=novahcbbstorage.HelpFieldValue['id']
    else
      Params.ParamByName('filter_EQL_b!storageid').Value :='';
    if novahcbbtype.ItemIndex>=0 then
      Params.ParamByName('filter_EQL_b!billtypeid').Value :=novahcbbtype.HelpFieldValue['id']
    else
      Params.ParamByName('filter_EQL_b!billtypeid').Value :='';
    if chkcount.Checked then
      Params.ParamByName('filter_NOEQL_b!availableenno').Value := 0
    else
      Params.ParamByName('filter_NOEQL_b!availableenno').Value := '';
    jcdsResult.AfterScroll:=nil;
    try      Active:=true;      log :=log+'�����У�';      if cbborg.GetSelectID <>'' then        log :=log +',[����]:'+cbborg.text;      if novahcbbstorage.ItemIndex>=0 then        log :=log +',[Ʊ������]:'+novahcbbstorage.text;
      if novahcbbtype.ItemIndex>=0 then
        log :=log +',[Ʊ������]:'+novahcbbtype.text;      SysLog.WriteLog('Ʊ�ݹ���-Ʊ�ݿ��','��ѯ',log);      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
    Active := true;
  end
end;



procedure TFrmBillinventoryManager.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmBillinventory := TFrmBillinventory.Create(self);
  with FrmBillinventory do
  begin
    Caption := 'Ʊ�����';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(FrmBillinventory);
    end;
  end;
end;

procedure TFrmBillinventoryManager.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
   begin
     SysDialogs.ShowMessage('���Ȳ�ѯ���ݣ�������');
      exit;
   end;

  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('availablecount').AsInteger = 0 then
  begin
    SysDialogs.ShowMessage('����Ʊ��Ϊ0�����ܽ������á�') ;
    Exit;
  end;
  with FrmBillinuse do
  begin
    FrmBillinuse := TFrmBillLinuse.Create(self);
    Caption:= 'Ʊ������';
    inventoryid :=  jcdsResult.FieldByName('id').AsLargeInt;
    edtbillstorage.Text:=jcdsResult.FieldByName('storagename').AsString;
    edtbilltypename.Text:=jcdsResult.FieldByName('typename').AsString;
    billtypeid:=jcdsResult.FieldByName('billtypeid').AsLargeInt;
    availablestartno:= jcdsResult.FieldByName('availablestartno').AsLargeInt;
    availableenno:=jcdsResult.FieldByName('availableenno').AsLargeInt;
    availablecount := jcdsResult.FieldByName('availablecount').AsLargeInt;
    edtstartno.MaxLength:=jcdsResult.FieldByName('ticketnolength').AsInteger;
    edtendno.MaxLength:=jcdsResult.FieldByName('ticketnolength').AsInteger;
    edtstartno.Text:=jcdsResult.FieldByName('availablestartno').AsString;
     receiveorg:=jcdsResult.FieldByName('orgname').AsString;
     parvalue:=jcdsResult.FieldByName('parvalue').AsString;
    edtstartnum.Text :=jcdsResult.FieldByName('availablestartno').AsString;
    edtendnum.Text :=jcdsResult.FieldByName('availableenno').AsString;
    numperbox :=  jcdsResult.FieldByName('numperbox').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', inventoryid, []);
      jsonCDSbilllog.Locate('id', id, []);
    end;
  end;
end;

end.
