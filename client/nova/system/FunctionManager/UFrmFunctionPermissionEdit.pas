unit UFrmFunctionPermissionEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit,UDMPublic, ImgList;

type
  TFrmFunctionPermissionEdit = class(TSimpleEditForm)
    lblname: TLabel;
    lblkey: TLabel;
    lbldescribe: TLabel;
    mmodescribe: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    nvedtname: TNovaEdit;
    nvedtkey: TNovaEdit;
    jcdsFunctionPermissionSave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    operationid,functionregid:int64;
    createtime,createby,updatetime,updateby:String;
  end;

var
  FrmFunctionPermissionEdit: TFrmFunctionPermissionEdit;

implementation
uses services;

{$R *.dfm}

procedure TFrmFunctionPermissionEdit.bbtnSaveClick(Sender: TObject);
var result : String;
begin
  inherited;
  if Trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowMessage('功能名称不能为空!');
    nvedtname.SetFocus;
    exit;
  end;
  if Trim(nvedtkey.Text)='' then
  begin
    SysDialogs.ShowMessage('功能GUID不能为空!');
    nvedtkey.SetFocus;
    exit;
  end;
  try
    StringToGUID(Trim(nvedtkey.Text));
  except
    SysDialogs.ShowMessage('功能GUID不正确!');
    nvedtkey.SetFocus;
    exit;
  end;
  with jcdsFunctionPermissionSave do
  begin
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['functionpermissionreg.id']:=operationid;
      Params.ParamValues['functionpermissionreg.createtime']:=createtime;
      Params.ParamValues['functionpermissionreg.createby']:=createby;
      Params.ParamValues['functionpermissionreg.updatetime']:=updatetime;
      Params.ParamValues['functionpermissionreg.updateby']:=updateby;
    end;
    Params.ParamValues['functionpermissionreg.functionregid']:=functionregid;
    Params.ParamValues['functionpermissionreg.permissionname']:=Trim(nvedtname.Text);
    Params.ParamValues['functionpermissionreg.permissionkey']:=trim(nvedtkey.Text);
    Params.ParamValues['functionpermissionreg.permissiondescribe']:=mmodescribe.Text;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      if operationid > 0then
        result := '修改'
      else
        result := '添加';
      log := result + '功能管理可分配权限子功能：功能名称='+nvedtname.Text+
      ',GUID='+nvedtkey.Text+',功能描述='+mmodescribe.Text;
      SysLog.WriteLog('系统管理->功能管理',result,log);
      self.ModalResult:=mrOk;
    end;
    operationid:=Params.ParamValues['functionpermissionregid'];
  end;
end;

end.
