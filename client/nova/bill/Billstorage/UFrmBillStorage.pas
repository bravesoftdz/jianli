unit UFrmBillStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls,
  NvPrnDbgeh, NvDbgridEh, NovaHComboBox, NovaCheckedComboBox;

type
  TFrmBillStorage = class(TSimpleCRUDForm)
    lbl1: TLabel;
    jsonCDSDelBillstorage: TjsonClientDataSet;
    cbbNovaCkbOrg: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmBillStorage: TFrmBillStorage;

implementation

uses UFrmBillStorageEdit, PubFn;
{$R *.dfm}

procedure TFrmBillStorage.FormCreate(Sender: TObject);
begin
  inherited;
  cbbNovaCkbOrg.Active := false;
  cbbNovaCkbOrg.Active := True;
end;

procedure TFrmBillStorage.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelBillstorage do
    try
      close;
      Params.ParamByName('billstorage.id').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      flag := Params.ParamByName('flag').Value;
      msg := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(msg);
      if (flag = 1) then
      begin
        log := '删除票据库存信息：所属客运站='+jcdsResult.FieldByName('orgname').AsString+
        ',票据名称='+jcdsResult.FieldByName('name').AsString+',编码='+
        jcdsResult.FieldByName('code').AsString;
        SysLog.WriteLog('票据管理——>票据库存','删除',log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据库存信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmBillStorage.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmBillStorageEdit do
  begin
    FrmBillStorageEdit := TFrmBillStorageEdit.Create(self);
    Caption := '修改票库信息';
    id := jcdsResult.FieldByName('id').AsInteger;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    edtcode.Text := jcdsResult.FieldByName('code').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    cbborgid.Text := jcdsResult.FieldByName('orgname').AsString;
    edtfunctionary.Text := jcdsResult.FieldByName('functionary').AsString;
    mmodes.Text := jcdsResult.FieldByName('description').AsString;
    isactive := jcdsResult.FieldByName('isactive').AsBoolean;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    edtname.Enabled := False;
    edtcode.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmBillStorage.tbtnFilterClick(Sender: TObject);
var
  orgid: integer;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if cbbNovaCkbOrg.CheckedCount = 0 then
        Params.ParamByName('filter_INS_b!orgid').Value := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamByName('filter_INS_b!orgid').Value := cbbNovaCkbOrg.GetSelectID;
    Active := True;
  end
end;

procedure TFrmBillStorage.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmBillStorageEdit := TFrmBillStorageEdit.Create(self);

  with FrmBillStorageEdit do
  begin
    Caption := '添加票库信息';
    if SysMainForm.showFormModal(FrmBillStorageEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;

  end;
end;

end.
