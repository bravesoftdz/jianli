unit UFrmUserAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uBaseForm, Services, USimpleEditForm, Buttons, ExtCtrls,
  DB,
  DBClient, jsonClientDataSet, UDMPublic, FunctionItemIntf,
  Generics.Collections,
  CheckLst, NovaEdit, NovaHComboBox, ImgList, NovaCheckedComboBox, NovaHelp;

type
  TFrmUserAdd = class(TSimpleEditForm)
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    Label1: TLabel;
    lbl10: TLabel;
    jsonCDSUserSave: TjsonClientDataSet;
    jsonCDSOrgInit: TjsonClientDataSet;
    jsonCDSDepInit: TjsonClientDataSet;
    jsonCDSRoleInit: TjsonClientDataSet;
    lbl11: TLabel;
    cbbOrgid: TNovaHComboBox;
    cbbDepid: TNovaHComboBox;
    chklstrole: TCheckListBox;
    Label3: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbl1: TLabel;
    rgismultipoint: TRadioGroup;
    lbl6: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    BtnSetPass: TBitBtn;
    edtcard: TNovaEdit;
    edtdiscount: TNovaEdit;
    edtIdcard: TNovaEdit;
    edtemail: TNovaEdit;
    edtphone: TNovaEdit;
    Label5: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSetPassClick(Sender: TObject);
    procedure edtdiscountExit(Sender: TObject);
    procedure cbbOrgidChange(Sender: TObject);
    procedure cbbDepidChange(Sender: TObject);
  private
  protected
  public
    { Public declarations }
    log : string;
    // class function getSubFunctionList:TList<TSubfunction>;

  private
    { Private declarations }
  public
    flag, ismultipoint, islock: boolean;
    id, orgid, createby, depid: int64;
    password, createtime: String;
    { Public declarations }
  end;

var
  FrmUserAdd: TFrmUserAdd;

implementation

uses PubFn, UFrmSetPassword;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

procedure TFrmUserAdd.bbtnSaveClick(Sender: TObject);
var
  nResult, i: integer;
  sResult, ids,result: string;
begin
  if cbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择所属机构！');
    cbbOrgid.SetFocus;
    exit;
  end;
  if cbbDepid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择所属部门！');
    cbbDepid.SetFocus;
    exit;
  end;
  for i := 0 to chklstrole.Items.Count - 1 do
  begin
    if chklstrole.Checked[i] then
    begin
      ids := ids + ',' + IntToStr(TCommInfo(chklstrole.Items.Objects[i]).id);
    end;
  end;
  if (ids='') or (ids=',') then
  begin
    SysDialogs.Warning('请选择拥有角色！');
    chklstrole.SetFocus;
    exit;
  end;
  ids:=copy(ids,2,length(ids));
  if edtcode.Text = '' then
  begin
    SysDialogs.Warning('用户编码不能为空');
    edtcode.SetFocus;
    exit;
  end;
  if edtname.Text = '' then
  begin
    SysDialogs.Warning('姓名不能为空');
    edtname.SetFocus;
    exit;
  end;
  if (self.edittype = Tedittype.add) and (password = '') then
  begin
    SysDialogs.Warning('请设置密码！');
    BtnSetPass.SetFocus;
    exit;
  end;
  orgid := cbbOrgid.HelpFieldValue['id'];
  depid := cbbDepid.HelpFieldValue['id'];
  with jsonCDSUserSave do
  begin
    Params.ParamByName('user.id').Value := id;
    Params.ParamByName('user.orgid').Value := orgid;
    Params.ParamByName('user.departmentid').Value := depid;
    Params.ParamByName('user.roles').Value := ids;
    Params.ParamByName('user.code').Value := edtcode.Text;
    Params.ParamByName('user.name').Value := edtname.Text;
    Params.ParamByName('user.password').Value := password;
    Params.ParamByName('user.cardno').Value := edtcard.Text;
    Params.ParamByName('user.idcard').Value := edtIdcard.Text;
    Params.ParamByName('user.ticketdiscount').Value := StrToFloat(edtdiscount.Text)/100;
    Params.ParamByName('user.email').Value := edtemail.Text;
    Params.ParamByName('user.phone').Value := edtphone.Text;
    Params.ParamByName('user.createby').Value := createby;
    Params.ParamByName('user.createtime').Value := createtime;
    Params.ParamByName('user.islock').Value := islock;
    Params.ParamByName('user.ismultipoint').Value := ismultipoint;
    Params.ParamByName('ticketoutlet').Value := nvhelpTicketoutlets.id;
    if rgismultipoint.ItemIndex = 0 then
    begin
      Params.ParamByName('user.ismultipoint').Value := 'true';
    end else
    begin
      Params.ParamByName('user.ismultipoint').Value := 'false';
    end;
    try
      Execute;
      nResult := Params.ParamByName('nResult').Value;
      sResult := Params.ParamByName('sResult').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtcode.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result +'用户信息：所属机构='+cbbOrgid.Text+',所属部门='+cbbDepid.Text+
        ',用户名='+edtcode.Text+',姓名='+edtname.Text;
        for i := 0 to chklstrole.Items.Count - 1 do
        begin
          if chklstrole.Checked[i] then
          begin
            ids := ids + ',' + TCommInfo(chklstrole.Items.Objects[i]).Name;
          end;
        end;
        log := log + ',所属角色='+ids;
        SysLog.WriteLog('系统管理->用户管理',result,log);
        id := Params.ParamByName('userid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('用户添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmUserAdd.BtnSetPassClick(Sender: TObject);
begin
  inherited;
  FrmSetPassword := TFrmSetPassword.Create(self);
  try
    with FrmSetPassword do
    begin
      caption:='设置密码';
      if SysMainForm.showFormModal(FrmSetPassword, false) = mrok then
      begin
        password := trim(NovaEdtPassword.Text);
      end;
    end;
  finally
    FreeAndNil(FrmSetPassword);
  end;
end;

procedure TFrmUserAdd.cbbDepidChange(Sender: TObject);
begin
  inherited;
  if (cbbOrgid.ItemIndex>=0) or (cbbDepid.ItemIndex>=0) then
  with jsonCDSRoleInit do
  begin
    Active := False;
    jsonCDSRoleInit.Params.ParamValues['filter_EQL_t!orgid'] := cbbOrgid.HelpFieldValue['id'];
    Active := True;
    if recordcount>0 then
      InitCheckListBox(chklstrole, jsonCDSRoleInit)
    else
      chklstrole.Clear;
  end
  else
  begin
    chklstrole.Clear;
  end;
end;

procedure TFrmUserAdd.cbbOrgidChange(Sender: TObject);
begin
  inherited;
  with cbbDepid do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_t!parentid'] := cbbOrgid.HelpFieldValue['id'];
    Active := True;
    chklstrole.Clear;
  end;


end;

procedure TFrmUserAdd.edtdiscountExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdiscount.Text) > 100) or (StrToFloat(edtdiscount.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtdiscount.SetFocus;
    exit;
  end;

end;

procedure TFrmUserAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TFrmUserAdd.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.Active := false;
  cbbOrgid.Active := true;

 { with cbbDepid do
  begin
    Active := false;
    if orgid > 0 then
    begin
      Params.ParamValues['filter_EQL_t!parentid'] := orgid;
    end
    else
    begin
      Params.ParamValues['filter_EQL_t!parentid'] := SysInfo.LoginUserInfo.OrgID
    end;
    Active := true;
  end;

  with jsonCDSRoleInit do
  begin
    Active := false;
    if orgid > 0 then
    begin
      Params.ParamValues['filter_EQL_t!orgid'] := orgid;
    end else
    begin
      Params.ParamValues['filter_EQL_t!orgid'] := SysInfo.LoginUserInfo.OrgID
    end;
    Active := true;
    InitCheckListBox(chklstrole, jsonCDSRoleInit);
  end; }
end;

// class function TFrmUserAdd.getSubFunctionList: TList<TSubfunction>;
// begin
// Result:=FSubFunctionList;
// end;
initialization

FSubFunctionList := TList<TSubfunction>.Create;
FSubFunctionList.add(TSubfunction.Create(
    '{B56CBF18-89E6-4554-B4A3-4DCC81D95098}', '添加'));

finalization

FSubFunctionList.Free;

end.
