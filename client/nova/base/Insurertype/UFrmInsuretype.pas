unit UFrmInsuretype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmInsuretypeEdit, NovaEdit, NovaHelp, UFrmInsuretypedetail,
  NovaCheckedComboBox;

type
  TFrmInsuretype = class(TSimpleCRUDForm)
    jcdsResultInsuretypedetail: TjsonClientDataSet;
    dsSourceInsuretype: TDataSource;
    grp1: TGroupBox;
    jsonCDSDelInsuretype: TjsonClientDataSet;
    NvDbgridEh1: TNvDbgridEh;
    lblcode: TLabel;
    lblorg: TLabel;
    nvhlpcode: TNovaHelp;
    prntdbgrdh1: TNvPrintDBGridEh;
    jcdsResultCDSDelInsuretypedetail: TjsonClientDataSet;
    ToolBar1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    ToolButton5: TToolButton;
    btndelDep: TToolButton;
    il1: TImageList;
    cbborg: TNovaCheckedComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure btnInsertDepClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsuretype: TFrmInsuretype;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInsuretype.btndelDepClick(Sender: TObject);
var
  nResult, id : integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('删除明细提示', '确认要删除该保险类型明细吗？') then
    exit;
  with jcdsResultCDSDelInsuretypedetail do
  try
    close;
    id := jcdsResult.FieldByName('id').Value;
    Params.ParamByName('insuretypedetail.id').Value :=jcdsResultInsuretypedetail.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保险类型信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmInsuretype.btnInsertDepClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmInsuretypedetail do
  begin
    FrmInsuretypedetail := TFrmInsuretypedetail.Create(self);
    Caption := '添加保险类型明细信息';
    sign:=true;
    nvhlpinsuretype.Text := jcdsResult.FieldByName('name').AsString;
    insuretypeid := jcdsResult.FieldByName('id').AsInteger;
    nvhlpinsuretype.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', insuretypeid, []);
      jcdsResultInsuretypedetail.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmInsuretype.btnUpdateDepClick(Sender: TObject);
begin
  inherited;
  if not dsSourceInsuretype.DataSet.Active then
    exit;
  if dsSourceInsuretype.DataSet.RecordCount < 1 then
    exit;
  with FrmInsuretypedetail do
  begin
    FrmInsuretypedetail := TFrmInsuretypedetail.Create(self);
    Caption := '修改保险类型信息';
    sign:=false;
    id :=  jcdsResultInsuretypedetail.FieldByName('id').AsInteger;
    insuretypeid := jcdsResultInsuretypedetail.FieldByName('insuretypeid').AsInteger;
    edtname.Text := jcdsResultInsuretypedetail.FieldByName('name').AsString;
    edtCode.Text := jcdsResultInsuretypedetail.FieldByName('code').AsString;
    createby := jcdsResultInsuretypedetail.FieldByName('createby').AsString;
    createtime := jcdsResultInsuretypedetail.FieldByName('createtime').AsString;
    edtmaxinsureamount.Text := jcdsResultInsuretypedetail.FieldByName('insureamount').AsString;
    mmodescription.Text := jcdsResultInsuretypedetail.FieldByName('description').AsString;
    nvhlpinsuretype.Text := jcdsResultInsuretypedetail.FieldByName('typename').AsString;
    nvhlpinsuretype.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmInsuretype.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmInsuretype.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResultInsuretypedetail.Close;
  end;
end;

procedure TFrmInsuretype.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResultInsuretypedetail do
  begin
    Active:=false;
      Params.ParamValues['filter_LIKEL_i!insuretype.id']:=jcdsResult.FieldByName('id').AsInteger;
    Active:=true;
  end;
end;

procedure TFrmInsuretype.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('删除提示', '确认要删除该记录吗?') then
    exit;

  with jsonCDSDelInsuretype do
  try
    close;
    log := '删除保险类型：'+jcdsResult.FieldByName('name').AsString;
    Params.ParamByName('insuretype.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除保险类型','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保险类型删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmInsuretype.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmInsuretypeEdit do
  begin
    FrmInsuretypeEdit := TFrmInsuretypeEdit.Create(self);
    Caption := '修改保险类型信息';
    sign:=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    insurersid := jcdsResult.FieldByName('insurersid').AsInteger;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    edtCode.Text := jcdsResult.FieldByName('code').AsString;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    edtpremium.Text := jcdsResult.FieldByName('premium').AsString;
    edtYWmoney.Text:=jcdsResult.FieldByName('ywmoney').AsString;
    edtSHmoney.Text:=jcdsResult.FieldByName('shmoney').AsString;
    edtEmoney.Text:=jcdsResult.FieldByName('emoney').AsString;
    edtEMmoney.Text:=jcdsResult.FieldByName('emmoney').AsString;

    edtmaxinsureamount.Text := jcdsResult.FieldByName('maxinsureamount').AsString;
    edtdividedrate.Text := FloatToStr(jcdsResult.FieldByName('dividedrate').AsFloat*100);
    mmodescription.Text := jcdsResult.FieldByName('description').AsString;
    cbborgid.Text := jcdsResult.FieldByName('orgname').AsString;
    cbbinsurersid.Text := jcdsResult.FieldByName('insurersname').AsString;
    edtmaxinsureamount.Enabled := false;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmInsuretype.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    if Trim(nvhlpcode.Text) = '' then
    begin
      jcdsResult.Params.ParamValues['filter_EQL_i!id'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_EQL_i!id'] := nvhlpcode.Id;
    end;
    jcdsResult.Params.ParamValues['filter_INS_i!orgid'] := cbborg.GetSelectID;
    Active:= true;
  end;
end;

procedure TFrmInsuretype.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmInsuretypeEdit do
  begin
    FrmInsuretypeEdit := TFrmInsuretypeEdit.Create(self);
    Caption := '添加保险类型信息';
    sign:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
