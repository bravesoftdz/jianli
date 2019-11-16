unit UFrmUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, UFrmUnitEdit, NvPrnDbgeh, NvDbgridEh, NovaComboBox, NovaHelp;

type
  TFrmUnit = class(TSimpleCRUDForm)
    jsonCDSDelUnit: TjsonClientDataSet;
    jcdstypename: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    jcdsResultid: TLargeintField;
    jcdsResultfullname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultaccountno: TWideStringField;
    jcdsResultcontactperson: TWideStringField;
    jcdsResultcontactphone: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultdistrictname: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResultdistrictid: TLargeintField;
    jcdsResultcardno: TWideStringField;
    jcdsResulttypename: TWideStringField;
    jcdsResultisactive: TBooleanField;
    jcdsResultislocaldelete: TBooleanField;
    jcdsResultsynccode: TWideStringField;
    wdstrngfldResultjianpin: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    cbbtype: TNovaComboBox;
    nvhlpdistrictid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUnit: TFrmUnit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmUnit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtype.Active := False;
  cbbtype.Active := True;
end;

procedure TFrmUnit.tbtnDeleteClick(Sender: TObject);
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

  with jsonCDSDelUnit do
  try
    close;
    Params.ParamByName('unit.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
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
      SysLog.WriteErr('车属单位删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmUnit.tbtnEditClick(Sender: TObject);
var i,id:integer;
begin

  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmUnitEdit do
  begin
    FrmUnitEdit := TFrmUnitEdit.Create(self);
    Caption := '修改车属单位信息';
    flag:=false;
    id :=  jcdsResult.FieldByName('id').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    edtcode.Text := jcdsResult.FieldByName('code').AsString;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    isactive := jcdsResult.FieldByName('isactive').AsBoolean;
    islocaldelete := jcdsResult.FieldByName('islocaldelete').AsBoolean;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    edtfullname.Text := jcdsResult.FieldByName('fullname').AsString;
    edtphone.Text := jcdsResult.FieldByName('contactphone').AsString;
    edtaccountno.Text := jcdsResult.FieldByName('accountno').AsString;
    edtperson.Text := jcdsResult.FieldByName('contactperson').AsString;
    cbbdistrictid.Text := jcdsResult.FieldByName('districtname').AsString;
    districtid := jcdsResult.FieldByName('districtid').AsInteger;
    nvhlpcard.Text := jcdsResult.FieldByName('cardno').AsString; //getComboxIndexByid(FrmUnitEdit.cbbcardno,jcdsResult.FieldByName('cardno').AsInteger);
    edtjianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    //FrmUnitEdit.cbbtype.Text := jcdsResult.FieldByName('type').AsString;
    for i := 0 to FrmUnitEdit.cbbtype.Items.Count - 1 do
    begin
    try
    //TCommInfo(cbbgrade.Items.Objects[i]).Value
      if TCommInfo(cbbtype.Items.Objects[i]).Value= jcdsResult.FieldByName('type').AsString then
      begin
        cbbtype.ItemIndex:= i;
        break;
      end;
      except

      end;
    end;
    edtfullname.Enabled:=false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmUnit.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if Trim(edtcode.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_t!code').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_t!code').Value := edtcode.Text;
    end;
    if Trim(edtname.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_t!name').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_t!name').Value := edtname.Text;
    end;
    if Trim(cbbtype.Text) = '' then
    begin
      Params.ParamByName('filter_EQS_t!type').Value := '';
    end else
    begin
      Params.ParamByName('filter_EQS_t!type').Value := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    if Trim(nvhlpdistrictid.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_t!districtid').Value := '';
    end else
    begin
      Params.ParamByName('filter_EQL_t!districtid').Value := nvhlpdistrictid.Id;
    end;


    Active := true;
  end;
end;

procedure TFrmUnit.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmUnitEdit do
  begin
    FrmUnitEdit := TFrmUnitEdit.Create(self);
    Caption := '添加车属单位信息';
    flag:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
