unit UFrmUser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, NovaEdit, NovaHComboBox,
  NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh,
  NvDbgridEh, ComCtrls, ToolWin, ExtCtrls, UFrmUserAdd, UDMPublic, UFrmSetPassword,
  NovaCheckedComboBox;

type
  TFrmUser = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl3: TLabel;
    lbl1: TLabel;
    lbl4: TLabel;
    cbb_depid: TNovaHComboBox;
    edt_name: TNovaEdit;
    edt_code: TNovaEdit;
    dsuserrole: TDataSource;
    jsonCDSUserDel: TjsonClientDataSet;
    jsonCDSRoleResult: TjsonClientDataSet;
    lbl5: TLabel;
    edtcardno: TNovaEdit;
    grp2: TGroupBox;
    dbgrdh1: TDBGridEh;
    cbborg: TNovaCheckedComboBox;
    lblrole: TLabel;
    nhcbbrole: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure cbb_depidEnter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmUser: TFrmUser;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmUser.cbb_depidEnter(Sender: TObject);
begin
  inherited;
  with cbb_depid do
  begin
    cbb_depid.Active := False;
      Params.ParamValues['filter_INS_t!parentid'] := cbborg.GetSelectID ;
    cbb_depid.Active := True;
  end;
end;

procedure TFrmUser.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  nhcbbrole.Active:=False;
  nhcbbrole.Active:=True;
end;

procedure TFrmUser.FormShow(Sender: TObject);
begin
  inherited;
  cbborg.CheckById(true, sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmUser.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jsonCDSRoleResult.Close;
  end;
end;

procedure TFrmUser.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jsonCDSRoleResult do
  begin
    Active:=false;
    Params.ParamByName('filter_EQL_a!id.userid').Value:=jcdsResult.FieldByName('id').AsInteger;
    Active:=true;
  end;
end;

procedure TFrmUser.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('code').AsString='ADMIN'  then
  begin
      SysDialogs.Warning('ADMIN用户不允许删除！');
      exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSUserDel do
  try
    close;
    Params.ParamByName('user.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('nResult').Value;
    sResult := Params.ParamByName('sResult').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := '删除用户信息：用户名='+jcdsResult.FieldByName('code').AsString+
      ',姓名='+jcdsResult.FieldByName('name').AsString+',所属机构='+
      jcdsResult.FieldByName('orgname').AsString+',所属部门='+
      jcdsResult.FieldByName('depname').AsString;
      SysLog.WriteLog('系统管理->用户信息','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('用户信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmUser.tbtnEditClick(Sender: TObject);
var
  i,x,roleid:integer;
  discount : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmUserAdd do
  begin
    FrmUserAdd := TFrmUserAdd.Create(self);
    Caption := '修改用户信息';
    flag:=false;
    edittype := Tedittype.update;
    id:= jcdsResult.FieldByName('id').AsLargeInt;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    depid:= jcdsResult.FieldByName('departmentid').AsLargeInt;
    edtcode.Text:=jcdsResult.FieldByName('code').AsString;
    edtcard.Text:=jcdsResult.FieldByName('cardno').AsString;
    edtemail.Text:=jcdsResult.FieldByName('email').AsString;
    edtIdcard.Text:=jcdsResult.FieldByName('idcard').AsString;
    discount :=jcdsResult.FieldByName('ticketdiscount').AsString;
    edtdiscount.Text := FloatToStr(StrToFloat(discount)*100);
    edtphone.Text:=jcdsResult.FieldByName('phone').AsString;
    createby:=jcdsResult.FieldByName('createby').AsLargeInt;
    createtime:=jcdsResult.FieldByName('createtime').AsString;
    islock:=jcdsResult.FieldByName('islock').AsBoolean;
    ismultipoint:=jcdsResult.FieldByName('ismultipoint').AsBoolean;
    password := jcdsResult.FieldByName('password').AsString;
    cbbOrgid.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
    nvhelpTicketoutlets.text := jcdsResult.FieldByName('ticketoutlet').AsString;
    nvhelpTicketoutlets.Id := jcdsResult.FieldByName('ticketoutletid').AsLargeInt;

    cbbOrgidChange(sender);
    cbbDepid.SetItemIndexByField('id',jcdsResult.FieldByName('departmentid').AsLargeInt);
    cbbDepidChange(sender);
    if jcdsResult.FieldByName('ismultipoint').AsBoolean then
    begin
      rgismultipoint.ItemIndex := 0;
    end else
    begin
      rgismultipoint.ItemIndex := 1;
    end;
    for I := 0 to jsonCDSRoleResult.RecordCount- 1 do
    begin
    roleid:=jsonCDSRoleResult.fieldbyname('id').AsInteger;
     for x :=0  to FrmUserAdd.chklstrole.Items.Count-1 do
        begin
         try
            if TCommInfo(FrmUserAdd.chklstrole.Items.Objects[x]).ID=roleid then
            begin
               FrmUserAdd.chklstrole.Checked[x]:=True;
            end;
          except

          end;
        end;
      jsonCDSRoleResult.Next;
    end;
    edtcode.Enabled := False;
    cbbOrgid.Enabled := False;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
  
end;


procedure TFrmUser.tbtnFilterClick(Sender: TObject);
var orgid: Integer;
    depid:integer;
begin
  inherited;
 with jcdsResult do
   begin
   Active := false;
     Params.ParamByName('filter_LIKES_u!name').Value := edt_name.Text;
     Params.ParamByName('filter_LIKES_u!code').Value := edt_code.Text;
     Params.ParamValues['filter_LIKES_u!cardno'] := edtcardno.Text;
     if cbborg.CheckedCount = 0 then
       Params.ParamByName('filter_INS_r!orgid').Value := SysInfo.LoginUserInfo.OrgIDs
     else
      Params.ParamByName('filter_INS_r!orgid').Value := cbborg.GetSelectID;

     if cbb_depid.ItemIndex>=0 then
     begin
       depid:=cbb_depid.HelpFieldValue['id'];
       Params.ParamByName('filter_EQL_u!departmentid').Value := depid;
     end else
     begin
       Params.ParamByName('filter_EQL_u!departmentid').Value := '';
     end;

     if nhcbbrole.ItemIndex>=0 then
     begin
       Params.ParamByName('filter_EQL_r!id').Value := nhcbbrole.HelpFieldValue['id'];
     end else
     begin
       Params.ParamByName('filter_EQL_r!id').Value := '';
     end;

     jcdsResult.AfterScroll:=nil;
    try      Active:=true;      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
   Active := true;
   end;
end;

procedure TFrmUser.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmUserAdd := TFrmUserAdd.Create(self);
  with FrmUserAdd do
  begin
    Caption := '添加用户信息';
    if SysMainForm.showFormModal(FrmUserAdd) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
