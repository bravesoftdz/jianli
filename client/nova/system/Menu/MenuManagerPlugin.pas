{ ------------------------------------
  功能说明：MenuManager.bpl功能对象
  创建日期：2011.7.07
  作者：ice
  版权：nova
  ------------------------------------- }
unit MenuManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UFrmMenu,UFrmMenus;

Type
{------------------------------------
  功能说明：菜单管理功能
-------------------------------------}
  TMenuManager=class(TInterfacedObject,IFunctionItem)
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

{ TMenuManager }

procedure TMenuManager.ChangeTheme;
begin

end;

constructor TMenuManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TMenuManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmMenus,FrmMenus,Self);
end;

function TMenuManager.getDescribe: String;
begin
  Result:='菜单管理';
end;

function TMenuManager.getKey: TGUID;
begin
  Result:=StringToGUID('{581553A5-9C78-4720-9850-D823A5DA9682}');
end;

function TMenuManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TMenuManager.IsWorkState: Boolean;
begin

end;

procedure TMenuManager.Leave;
begin

end;

procedure TMenuManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
