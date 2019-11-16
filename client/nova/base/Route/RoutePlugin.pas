{ ------------------------------------
  ����˵����Route.bpl���ܶ���
  �������ڣ�2011/1/26
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit RoutePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
{------------------------------------
  ����˵������·������
-------------------------------------}

  TRouteManager=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmRoute,MainFormIntf;


{ TSystemManager }

procedure TRouteManager.ChangeTheme;
begin

end;

constructor TRouteManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TRouteManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmRoute,FrmRoute,Self);
end;

function TRouteManager.getDescribe: String;
begin
  Result:='���ڱ�����Ĺ�����Ϣ';
end;

function TRouteManager.getKey: TGUID;
begin
  Result:=StringToGUID('{A8B3F63A-8EC7-4055-BAFC-CC10D4A66B65}');
end;

function TRouteManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TRouteManager.IsWorkState: Boolean;
begin

end;

procedure TRouteManager.Leave;
begin

end;

procedure TRouteManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
