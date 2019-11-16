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

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
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
      log := '删除[票据入库批次号]:'+jcdsResult.FieldByName('batchno').AsString
            +',[票库名称]:'+jcdsResult.FieldByName('storagename').AsString
            +',[票据类型]:'+jcdsResult.FieldByName('typename').AsString
            +',[机构]:'+jcdsResult.FieldByName('orgname').Asstring
            +',[起始号]:'+jcdsResult.FieldByName('putinstartno').AsString
            +',[结束号]:'+jcdsResult.FieldByName('putinendno').AsString
            +',[可用张数]:'+jcdsResult.FieldByName('availablecount').AsString;
      SysLog.WriteLog('票据管理-票据库存','删除票据库存',log);
      log :='';
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('票据库存信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBillinventoryManager.tbtnEditClick(Sender: TObject);

begin
  inherited;
  if not dsResult.DataSet.Active then
  begin
    SysDialogs.ShowMessage('请先查询数据，再出库');
    exit;
  end;

  if dsResult.DataSet.RecordCount < 1 then
    exit;
 with FrmBillinventoryout do
 begin
    FrmBillinventoryout := TFrmBillinventoryout.Create(self);
    Caption:= '票据出库';
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
    try      Active:=true;      log :=log+'条件有：';      if cbborg.GetSelectID <>'' then        log :=log +',[机构]:'+cbborg.text;      if novahcbbstorage.ItemIndex>=0 then        log :=log +',[票库名称]:'+novahcbbstorage.text;
      if novahcbbtype.ItemIndex>=0 then
        log :=log +',[票据类型]:'+novahcbbtype.text;      SysLog.WriteLog('票据管理-票据库存','查询',log);      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
    Active := true;
  end
end;



procedure TFrmBillinventoryManager.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmBillinventory := TFrmBillinventory.Create(self);
  with FrmBillinventory do
  begin
    Caption := '票据入库';
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
     SysDialogs.ShowMessage('请先查询数据，再领用');
      exit;
   end;

  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('availablecount').AsInteger = 0 then
  begin
    SysDialogs.ShowMessage('可用票数为0，不能进行领用。') ;
    Exit;
  end;
  with FrmBillinuse do
  begin
    FrmBillinuse := TFrmBillLinuse.Create(self);
    Caption:= '票据领用';
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
