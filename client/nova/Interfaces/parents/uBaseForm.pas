{------------------------------------
  ����˵�������д����������
  �������ڣ�2010/11/22
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit uBaseForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,AuthoritySvrIntf, Services,FunctionItemIntf;

type
  TBaseFormClass = class of TBaseForm;
  TBaseForm = class(TForm,IAuthorityCtrl)
  private

  protected
    FfunctionItem:IFunctionItem;
    {IAuthorityCtrl}
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);Virtual;
  public
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); dynamic;
    Destructor Destroy; override;
    property functionItem:IFunctionItem read FfunctionItem;
  end;

var
  BaseForm: TBaseForm;

implementation


{$R *.dfm}

{ TBaseForm }

Constructor TBaseForm.Create(AOwner: TComponent;functionItem:IFunctionItem;parameter:TFunctionItemParameters;checkpermission:boolean);
var functionPermission:TFunctionPermission;
    subfunctionPermission:TSubfunctionPermission;
begin
  inherited Create(AOwner);
  self.FfunctionItem:= functionItem;
  if not assigned(functionItem) then exit;
    if checkpermission then
    begin
    functionPermission:=SysFunctionMgr.getFunctionPermission(functionItem,parameter);
    if not assigned(functionPermission) then
    begin
      SysDialogs.ShowError('ע�Ṧ���Ҳ�����KEY��'+GUIDToString(functionItem.key)+'������������'+functionItem.getDescribe);
      exit;
    end
    else if not functionPermission.enable then
    begin
      SysDialogs.ShowError('��û�д˹��ܵ�Ȩ�ޣ�KEY��'+GUIDToString(functionItem.key)+'������������'+functionItem.getDescribe);
      exit;
    end;
    for subfunctionPermission in functionPermission.subFunctionPermissionList do
    begin
      self.HandleAuthority(subfunctionPermission.key,subfunctionPermission.enable);
    end;
  end;
end;

Destructor TBaseForm.Destroy;
begin
  inherited;
end;

procedure TBaseForm.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin

end;

end.
