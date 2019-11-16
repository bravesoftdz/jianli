{------------------------------------
  功能说明：所有窗体的主先类
  创建日期：2010/11/22
  作者：ice
  版权：nova
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
      SysDialogs.ShowError('注册功能找不到，KEY：'+GUIDToString(functionItem.key)+'。功能描述：'+functionItem.getDescribe);
      exit;
    end
    else if not functionPermission.enable then
    begin
      SysDialogs.ShowError('您没有此功能的权限，KEY：'+GUIDToString(functionItem.key)+'。功能描述：'+functionItem.getDescribe);
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
