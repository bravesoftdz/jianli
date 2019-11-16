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
    SysDialogs.Warning('��ɫ������Ϊ��');
    edtname.SetFocus;
    exit;
  end;
  if ComboxOrg.Text = '' then
  begin
    SysDialogs.Warning('������������Ϊ��');
    ComboxOrg.SetFocus;
    exit;
  end;
  if trim(edtdiscount.Text)<>'' then
  if (strtofloat(trim(edtdiscount.Text))>100)  or (strtofloat(trim(edtdiscount.Text))<0) then
  begin
    SysDialogs.Warning('�ۿ���ֻ����0��100֮�䣡');
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
           SysDialogs.ShowMessage('�ý�ɫ�´����û�,�޸�ʧ��!');
           exit;
       end;
  except
      on E: Exception do
      begin
        SysLog.WriteErr('��ѯ�������û�ʧ�ܣ�' + E.Message);
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
          result := '�޸�'
        else
          result := '���';
        log := result + '��ɫ��Ϣ����ɫ��='+edtname.Text+',�ۿ���='+edtdiscount.Text+
        ',��������='+ComboxOrg.Text+',����='+mmodes.Text;
        SysLog.WriteLog('ϵͳ����->��ɫ����',result,log);

        id := Params.ParamByName('roleid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��ɫ���ʧ�ܣ�' + E.Message);
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
    SysDialogs.ShowMessage('������0-100֮�����');
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
    '{B56CBF18-89E6-4554-B4A3-4DCC81D95098}', '���'));

finalization

FSubFunctionList.Free;

end.
