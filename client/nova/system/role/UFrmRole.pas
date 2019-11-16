unit UFrmRole;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox;

type
  TFrmRole = class(TSimpleCRUDForm)
    lbl_org: TLabel;
    lbl_role: TLabel;
    cbb_orgid: TNovaHComboBox;
    edt_role: TEdit;
    jsonCDSDelRole: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmRole: TFrmRole;

implementation

uses Services, UFrmRoleAdd;
{$R *.dfm}

procedure TFrmRole.FormCreate(Sender: TObject);
begin
  inherited;
  cbb_orgid.Active := False;
  cbb_orgid.Active := True;
end;

procedure TFrmRole.tbtnDeleteClick(Sender: TObject);
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
  if jcdsResult.FieldByName('name').AsString='超级管理员'  then
  begin
      SysDialogs.Warning('超级管理员角色不允许删除！');
      exit;
  end;
  with jsonCDSDelRole do
    try
      close;
      Params.ParamByName('role.id').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := '删除角色：角色='+jcdsResult.FieldByName('name').AsString+',所属机构='+
        jcdsResult.FieldByName('orgname').AsString+',售票折扣率='+
        jcdsResult.FieldByName('ticketdiscount').AsString+',描述='+
        jcdsResult.FieldByName('describe').AsString;
        SysLog.WriteLog('系统管理->角色管理','删除',log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('角色信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmRole.tbtnEditClick(Sender: TObject);
var
  id: integer;
  discount : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with frmRoleAdd do
  begin
    frmRoleAdd := TfrmRoleAdd.Create(self);
    frmRoleAdd.Caption := '修改角色信息';
    frmRoleAdd.flag := False;
    id := jcdsResult.FieldByName('id').AsLargeInt;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    rolename:=jcdsResult.FieldByName('name').AsString;
    ComboxOrg.SetItemIndexByField('id',
      jcdsResult.FieldByName('orgid').AsLargeInt);
    organizationid :=jcdsResult.FieldByName('orgid').AsLargeInt;
    mmodes.Text := jcdsResult.FieldByName('describe').AsString;
    discount := jcdsResult.FieldByName('ticketdiscount').AsString;
    edtdiscount.Text := FloatToStr(StrToFloat(discount)*100);
    ComboxOrg.Text := jcdsResult.FieldByName('orgname').AsString;
    createby := jcdsResult.FieldByName('createby').AsLargeInt;
    createtime := jcdsResult.FieldByName('createtime').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmRole.tbtnFilterClick(Sender: TObject);
var
  orgid: integer;
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('filter_LIKES_r!name').Value := trim(edt_role.Text);
    if cbb_orgid.ItemIndex >= 0 then
    begin
      orgid := cbb_orgid.HelpFieldValue['id'];
      Params.ParamByName('filter_EQL_org!id').Value := orgid;
    end
    else
      Params.ParamByName('filter_EQL_org!id').Value := null;
    Active := True;
  end;
end;

procedure TFrmRole.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  try
    frmRoleAdd := TfrmRoleAdd.Create(self);
    with frmRoleAdd do
    begin
      Caption := '角色信息';
      flag := True;
      createby:=Sysinfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(frmRoleAdd, False) = mrok then
      begin
        curid := id;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(frmRoleAdd);
  end;
end;

end.
