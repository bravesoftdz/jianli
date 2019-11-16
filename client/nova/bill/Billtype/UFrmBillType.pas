unit UFrmBilltype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NvPrnDbgeh, NvDbgridEh, UFrmBilltypeEdit;

type
  TFrmBilltype =class(TSimpleCRUDForm)
    jsonCDSDelBilltype: TjsonClientDataSet;
    lblmedium: TLabel;
    edtcode: TNovaEdit;
    lbllbcode: TLabel;
    jsonjcdsdistrictmedium: TjsonClientDataSet;
    cbbmedium: TNovaComboBox;
    jcdsResultid: TLargeintField;
    jcdsResultmediumvalue: TWideStringField;
    jcdsResultisactive: TBooleanField;
    jcdsResultparvalue: TFloatField;
    jcdsResultcreatetime: TDateTimeField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBilltype: TFrmBilltype;

implementation
 uses PubFn;
{$R *.dfm}



procedure TFrmBilltype.FormShow(Sender: TObject);
begin
  inherited;

 cbbmedium.Active:=false;
  cbbmedium.Active:=true;
    with jsonjcdsdistrictmedium do
  begin

    Params.ParamValues['tablename']:='billtype';
    Params.ParamValues['columnname']:='medium';

    Active:=true;
  end;
end;

procedure TFrmBilltype.tbtnDeleteClick(Sender: TObject);
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

  with jsonCDSDelBilltype do
  try
    close;
    log := '删除票据类型：票据名称='+jcdsResult.FieldByName('name').AsString;
    Params.ParamByName('billtype.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
      SysLog.WriteLog('删除票据类型','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('票据类型信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBilltype.tbtnEditClick(Sender: TObject);
var i:integer;
begin
  inherited;
if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 with FrmBilltypeEdit do
 begin
    FrmBilltypeEdit := TFrmBilltypeEdit.Create(self);
    Caption:= '修改票据类型信息';
    id :=  jcdsResult.FieldByName('id').AsInteger;
    edtcode.ReadOnly:=true;
    edtname.Text:=jcdsResult.FieldByName('name').AsString;
    edtcode.Text:=jcdsResult.FieldByName('code').AsString;
    edtprintname.Text:=jcdsResult.FieldByName('printname').AsString;
    edtparvalue.Text:=jcdsResult.FieldByName('parvalue').AsString;
    edtnumperbox.Text:=jcdsResult.FieldByName('numperbox').AsString;
    edtticketnolength.Text:=jcdsResult.FieldByName('ticketnolength').AsString;
   // FrmBilltypeEdit.cbbmedium.Text:=jcdsResult.FieldByName('medium').AsString;
    createby:=jcdsResult.FieldByName('createby').AsInteger;
    createtime:=jcdsResult.FieldByName('createtime').AsString;
    mmodes.Text:=jcdsResult.FieldByName('description').AsString;
    isactive:= jcdsResult.FieldByName('isactive').AsBoolean;
    for i := 0 to cbbmedium.Items.Count - 1 do
    begin
      try
      //TCommInfo(cbbgrade.Items.Objects[i]).Value
        if TCommInfo(cbbmedium.Items.Objects[i]).Value= jcdsResult.FieldByName('medium').AsString then
        begin
             cbbmedium.ItemIndex:=  i;
             break;
        end;
      except

      end;
    end;
    edtcode.Enabled := False;
    edtname.Enabled := True;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
 end;
end;

procedure TFrmBilltype.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamByName('filter_EQS_b!medium').Value :=cbbmedium.GetSelectCode;
    Params.ParamByName('filter_LIKES_b!code').Value :=edtcode.Text;
    Active := true;
  end
end;



procedure TFrmBilltype.tbtnInsertClick(Sender: TObject);
begin
  inherited;
    FrmBilltypeEdit := TFrmBilltypeEdit.Create(self);
    with FrmBilltypeEdit do
    begin
      Caption := '添加票据类型信息';
      if SysMainForm.showFormModal(FrmBilltypeEdit) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
      end;
    end;
end;

end.
     