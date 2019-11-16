unit UFrmVehicletype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin,
  ExtCtrls, UFrmVehicletypeEdit, NvPrnDbgeh, NvDbgridEh, NovaComboBox;

type
  TFrmVehicletype = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    jcdstypename: TjsonClientDataSet;
    jcdsgradename: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultcode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultcustomname: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResulttypename: TWideStringField;
    jcdsResultgradename: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultgrade: TWideStringField;
    jcdsResultrationseatnum: TIntegerField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultisactive: TBooleanField;
    jcdsResultislocaldelete: TBooleanField;
    cbbtype: TNovaComboBox;
    cbbgrade: TNovaComboBox;
    jcdsResultsynccode: TWideStringField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultCDSDelVehicletype: TjsonClientDataSet;
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
  FrmVehicletype: TFrmVehicletype;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVehicletype.FormCreate(Sender: TObject);
begin
  inherited;
  cbbgrade.Active:=false;
  cbbgrade.Active:=true;

  cbbtype.Active:= false;
  cbbtype.Active:= true;
end;

procedure TFrmVehicletype.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jcdsResultCDSDelVehicletype do
  try
    //close;
    Params.ParamByName('vehicletype.id').Value :=jcdsResult.FieldByName('id').AsString ;
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
      SysLog.WriteErr('车辆类型删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmVehicletype.tbtnEditClick(Sender: TObject);
var
  i,j,id:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmVehicletypeEdit do
  begin
    FrmVehicletypeEdit := TFrmVehicletypeEdit.Create(self);
    Caption := '修改车型信息';
    flag:=false;
    id := jcdsResult.FieldByName('id').AsString;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    edtCode.Text := jcdsResult.FieldByName('code').AsString;
    //FrmVehicletypeEdit.cbbtype.Text := jcdsResult.FieldByName('type').AsString;
    //FrmVehicletypeEdit.cbbgrade.Text := jcdsResult.FieldByName('grade').AsString;
    edtcustom.Text := jcdsResult.FieldByName('customname').AsString;
    edtration.Text := jcdsResult.FieldByName('rationseatnum').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    islocal := jcdsResult.FieldByName('islocaldelete').AsString;
    synccode := jcdsResult.FieldByName('synccode').AsString;
    cbbtype.Enabled := False;
    cbbgrade.Enabled := False;
    edtration.Enabled := False;

    for i := 0 to cbbtype.Items.Count - 1  do
    begin
    try
      if TCommInfo(cbbtype.Items.Objects[i]).Value= jcdsResult.FieldByName('type').AsString then
      begin
        cbbtype.ItemIndex:= i;
        break;
      end;
      except

      end;
    end;

    for j := 0 to cbbgrade.Items.Count - 1 do
    begin
    try
      if TCommInfo(cbbgrade.Items.Objects[j]).Value= jcdsResult.FieldByName('grade').AsString then
      begin
        cbbgrade.ItemIndex:= j;
        break;
      end;
      except

      end;
    end;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmVehicletype.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if(trim(edtcode.Text)= '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_t!code'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_t!code'] := edtcode.Text;
    end;
    if(trim(edtname.Text)= '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_t!name'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_t!name'] := edtname.Text;
    end;
    if(trim(cbbtype.Text)= '')then
    begin
      jcdsResult.Params.ParamValues['filter_EQS_t!type'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_EQS_t!type'] := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    if(trim(cbbgrade.Text)= '')then
    begin
      jcdsResult.Params.ParamValues['filter_EQS_t!grade'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_EQS_t!grade'] := TCommInfo(cbbgrade.Items.Objects[cbbgrade.ItemIndex]).Value;
    end;
    Active := true;

  end;
end;

procedure TFrmVehicletype.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmVehicletypeEdit do
  begin
    FrmVehicletypeEdit := TFrmVehicletypeEdit.Create(self);
    Caption := '添加车型信息';
    flag:=false;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
