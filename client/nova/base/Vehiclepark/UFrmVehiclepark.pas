unit UFrmVehiclepark;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaEdit, NovaHelp, NovaCheckedComboBox, NvPrnDbgeh, NvDbgridEh;

type
  TfrmVehiclepark = class(TSimpleCRUDForm)
    lblOrgid: TLabel;
    lblName: TLabel;
    edtName: TNovaEdit;
    jsnclntdtstInitCDSInit: TjsonClientDataSet;
    jsnclntdtstInitCDSDel: TjsonClientDataSet;
    nvckbOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  isaction: string;
  end;

var
  frmVehiclepark: TfrmVehiclepark;

implementation
  uses UFrmVehicleparkEdit, Services, PubFn, UDMPublic;

{$R *.dfm}

procedure TfrmVehiclepark.FormCreate(Sender: TObject);
begin
  inherited;
  {jsnclntdtstInitCDSInit.Active := false;
  jsnclntdtstInitCDSInit.Active := true;
  InitCombox(cbbOrgid, jsnclntdtstInitCDSInit);  }
end;

procedure TfrmVehiclepark.FormShow(Sender: TObject);
begin
  inherited;
   nvckbOrg.Active := True;
end;

procedure TfrmVehiclepark.tbtnDeleteClick(Sender: TObject);
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

  with jsnclntdtstInitCDSDel do
  try
    close;
    Params.ParamByName('delid').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := ' 删除'+jcdsResult.FieldByName('orgname').AsString+'的乘车库:'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('业务管理->上车卡位管理', '删除', log);
      log:='';
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TfrmVehiclepark.tbtnEditClick(Sender: TObject);
var id:integer;isactive:Boolean;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
    frmVehicleparkEdit := TfrmVehicleparkEdit.Create(self);
  with frmVehicleparkEdit do
  begin
    Caption :='修改乘车库信息';
    flag:=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
   orgid := jcdsResult.FieldByName('orgid').AsInteger;
   nvedtname.Text := jcdsResult.FieldByName('name').AsString;
   tname:= jcdsResult.FieldByName('name').AsString;
   nvedtPrintname.Text := jcdsResult.FieldByName('printname').AsString;
   printname := jcdsResult.FieldByName('printname').AsString;
   createtime :=  jcdsResult.FieldByName('createtime').AsString;
   createby :=  jcdsResult.FieldByName('createby').AsString;
   mmoDeseription.Text := jcdsResult.FieldByName('remarks').AsString;
   remarks := jcdsResult.FieldByName('remarks').AsString;
   isedt := True;
    nvhcbbOrg.SetItemIndexByField('name',jcdsResult.FieldByName('orgname').AsString);
    orgname := jcdsResult.FieldByName('orgname').AsString;
    if  SysMainForm.showFormModal(frmVehicleparkEdit,False) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TfrmVehiclepark.tbtnFilterClick(Sender: TObject);
var
  orgid: integer;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamByName('filter_INS_v!orgid').Value := nvckbOrg.GetSelectID;
    Params.ParamByName('filter_LIKES_v!name').Value := edtName.Text;

    Active := True;
  end
end;

procedure TfrmVehiclepark.tbtnInsertClick(Sender: TObject);
begin
  with  frmVehicleparkEdit do
  begin
     frmVehicleparkEdit := TfrmVehicleparkEdit.Create(Self);
    frmVehicleparkEdit.Caption := '添加乘车库信息';
    frmVehicleparkEdit.ShowModal;
    if ModalResult = mrok then
      begin
        tbtnFilterClick(Sender);
      end;
  end;
 end;

end.
