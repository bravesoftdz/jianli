unit UFrmInsurer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmInsurerEdit, NovaEdit, NovaHComboBox;

type
  TFrmInsurers = class(TSimpleCRUDForm)
    lblname: TLabel;
    lbladdress: TLabel;
    lblorg: TLabel;
    jsonCDSInsurerInit: TjsonClientDataSet;
    jsonCDSDelInsurer: TjsonClientDataSet;
    cbborgid: TNovaHComboBox;
    edtname: TNovaEdit;
    edtaddress: TNovaEdit;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsurers: TFrmInsurers;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInsurers.FormCreate(Sender: TObject);
begin
  inherited;
  cbborgid.Active := false;
  cbborgid.Active := true;

end;

procedure TFrmInsurers.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jsonCDSDelInsurer do
  try
    close;
    Params.ParamByName('insurer.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
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
      SysLog.WriteErr('保险公司删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmInsurers.tbtnEditClick(Sender: TObject);
var id: Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmInsurerEdit do
  begin
    FrmInsurerEdit := TFrmInsurerEdit.Create(self);
    Caption := '修改保险公司信息';
    sign:=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    cbborgid.Text := jcdsResult.FieldByName('orgname').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    edtaddress.Text := jcdsResult.FieldByName('address').AsString;
    edtcontactphone.Text := jcdsResult.FieldByName('contactphone').AsString;
    edtcontactperson.Text := jcdsResult.FieldByName('contactperson').AsString;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    synccode := jcdsResult.FieldByName('synccode').AsString;

    if jcdsResult.FieldByName('interfacetype').IsNull then
      nvcbbinterfacetype.ItemIndex:=-1
    else
      nvcbbinterfacetype.SetItemIndexByCode(self.jcdsResult.FieldByName('interfacetype').AsString);
//      nvcbbinterfacetype.ItemIndex:=jcdsResult.FieldByName('interfacetype').AsInteger;
    nvedtselladdress.Text := jcdsResult.FieldByName('selladdress').AsString;
    nvedtreturnaddress.Text := jcdsResult.FieldByName('returnaddress').AsString;
    nvedtbankcode.Text := jcdsResult.FieldByName('bankcode').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmInsurers.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    if(trim(edtname.Text)='')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_i!name'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_i!name'] := Trim(edtname.Text);
    end;
    if(trim(edtaddress.Text) = '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_i!address'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_i!address'] := Trim(edtaddress.Text);
    end;
    if(cbborgid.ItemIndex <= 0)then
    begin
      jcdsResult.Params.ParamValues['filter_EQL_i!orgid'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_EQL_i!orgid'] := cbborgid.HelpFieldValue['id'];
    end;
    Active:= true;
  end;
end;

procedure TFrmInsurers.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmInsurerEdit do
  begin
    FrmInsurerEdit := TFrmInsurerEdit.Create(self);
    Caption := '添加保险公司信息';
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
