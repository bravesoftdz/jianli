{ ------------------------------------
  ����˵����Vehicleseatplan.bpl���ܶ���
  �������ڣ�2011.2.22
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit VehicleseatplanPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
{------------------------------------
  ����˵���������ڲ��ռ������
-------------------------------------}
  TVehiclespaceManager=class(TInterfacedObject,IFunctionItem)
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

{------------------------------------
  ����˵����������λͼ������
-------------------------------------}
  TVehicleseatplanManager=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmVehiclespace,MainFormIntf,UFrmVehicleseatplan;

{ TVehiclespaceManager }

procedure TVehiclespaceManager.ChangeTheme;
begin

end;

constructor TVehiclespaceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehiclespaceManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVehiclespace,FrmVehiclespace,Self);
end;

function TVehiclespaceManager.getDescribe: String;
begin
  Result:='�����ڲ��ռ����';
end;

function TVehiclespaceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{F5C520A1-2E7A-4BCA-955F-EF6E8BF620F3}');
end;

function TVehiclespaceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TVehiclespaceManager.IsWorkState: Boolean;
begin

end;

procedure TVehiclespaceManager.Leave;
begin

end;

procedure TVehiclespaceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TVehicleseatplanManager }
procedure TVehicleseatplanManager.ChangeTheme;
begin

end;

constructor TVehicleseatplanManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehicleseatplanManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVehicleseatplan,FrmVehicleseatplan,Self);
end;

function TVehicleseatplanManager.getDescribe: String;
begin
  Result:='������λͼ����';
end;

function TVehicleseatplanManager.getKey: TGUID;
begin
  Result:=StringToGUID('{7A698920-667C-44BB-8CFA-87D5D0CCCCBC}');
end;

function TVehicleseatplanManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TVehicleseatplanManager.IsWorkState: Boolean;
begin

end;

procedure TVehicleseatplanManager.Leave;
begin

end;

procedure TVehicleseatplanManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
