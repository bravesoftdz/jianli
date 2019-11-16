{ ------------------------------------
  ����˵����Permission.bpl���ܶ���
  �������ڣ�2011.7.08
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit PermissionPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmPermissions, UFrmPermission;

Type
{------------------------------------
  ����˵����Ȩ�޹�����
-------------------------------------}
  TPermission=class(TInterfacedObject,IFunctionItem)
  private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

implementation

uses Services,MainFormIntf;

{ TPermission }

procedure TPermission.ChangeTheme;
begin

end;

constructor TPermission.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TPermission.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPermissions,FrmPermissions,Self);
end;

function TPermission.getDescribe: String;
begin
  Result:='Ȩ�޹���';
end;

function TPermission.getKey: TGUID;
begin
  Result:=StringToGUID('{90A7C829-74A8-45C3-B520-B914C0A8CBCD}');
end;

function TPermission.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPermission.IsWorkState: Boolean;
begin

end;

procedure TPermission.Leave;
begin

end;

procedure TPermission.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
