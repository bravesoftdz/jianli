unit UFrmRoleAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uBaseForm, Services, USimpleEditForm, FunctionItemIntf,
  Generics.Collections,
  Buttons, ExtCtrls, jsonClientDataSet, jsonConnection, DB, DBClient, UDMPublic,
  NovaHComboBox, NovaEdit, ImgList;

type
  TfrmRoleAdd = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl2: TLabel;
    jsonCDSRoleSave: TjsonClientDataSet;
    jsonCDSOrgInit: TjsonClientDataSet;
    ComboxOrg: TNovaHComboBox;
    mmodes: TMemo;
    edtdiscount: TNovaEdit;
    edtname: TNovaEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    jsonCDSQryUser: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure CreateForm(Sender: TObject);
    procedure edtdiscountExit(Sender: TObject);
  private
  protected
  public
    { Public declarations }
    log : String;
    class function getSubFunctionList: TList<TSubfunction>;
  private
    { Private declarations }
  public
    id,createby: int64;
    flag: boolean;
    createtime: string;
    organizationid:integer;
    rolename: string;
    { Public declarations }
  end;

var
  frmRoleAdd: TfrmRoleAdd;

implementation

uses PubFn;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

procedure TfrmRoleAdd.bbtnSaveClick(Sender: TObject);
var
  nResult, orgid: integer;
  sResult,result: string;
begin
  if edtname.Text = '' then
  begin
    SysDialogs.Warning('角色名不能为空');
    edtname.SetFocus;
    exit;
  end;
  if ComboxOrg.Text = '' then
  begin
    SysDialogs.Warning('所属机构不能为空');
    ComboxOrg.SetFocus;
    exit;
  end;
  if trim(edtdiscount.Text)<>'' then
  if (strtofloat(trim(edtdiscount.Text))>100)  or (strtofloat(trim(edtdiscount.Text))<0) then
  begin
    SysDialogs.Warning('折扣率只能在0和100之间！');
    edtdiscount.SetFocus;
    exit;
  end;

 if (flag=false) and (ComboxOrg.HelpFieldValue['id']<>organizationid)  then

  begin
     with jsonCDSQryUser do
  try
       close;
       Params.ParamByName('roleid').Value := id;
       Execute;
       nResult := Params.ParamByName('flag').Value;
       sResult := Params.ParamByName('msg').Value;
       if(length(trim(sResult))>0) then
       begin
           SysDialogs.ShowMessage('该角色下存在用户,修改失败!');
           exit;
       end;
  except
      on E: Exception do
      begin
        SysLog.WriteErr('查询机构下用户失败：' + E.Message);
      end;
  end;
  end;

  with jsonCDSRoleSave do
  begin
    Close;
    Params.ParamByName('role.id').Value := id;
    if ComboxOrg.ItemIndex >= 0 then
    begin
      orgid := ComboxOrg.HelpFieldValue['id'];
    end;
    Params.ParamByName('role.orgid').Value := orgid;
    Params.ParamByName('role.name').Value := edtname.Text;
    Params.ParamByName('role.ticketdiscount').Value := StrToFloat(edtdiscount.Text)/100;
    Params.ParamByName('role.describe').Value := mmodes.Text;
    Params.ParamByName('role.createby').Value := createby;
    Params.ParamByName('role.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtname.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '角色信息：角色名='+edtname.Text+',折扣率='+edtdiscount.Text+
        ',所属机构='+ComboxOrg.Text+',描述='+mmodes.Text;
        SysLog.WriteLog('系统管理->角色管理',result,log);

        id := Params.ParamByName('roleid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('角色添加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TfrmRoleAdd.CreateForm(Sender: TObject);
begin
  inherited;
  ComboxOrg.Active := false;
  ComboxOrg.Active := true;
end;

procedure TfrmRoleAdd.edtdiscountExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdiscount.Text) > 100) or (StrToFloat(edtdiscount.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtdiscount.SetFocus;
    exit;
  end;
end;

class function TfrmRoleAdd.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

initialization

FSubFunctionList := TList<TSubfunction>.Create;
FSubFunctionList.Add(TSubfunction.Create(
    '{B56CBF18-89E6-4554-B4A3-4DCC81D95098}', '添加'));

finalization

FSubFunctionList.Free;

end.
