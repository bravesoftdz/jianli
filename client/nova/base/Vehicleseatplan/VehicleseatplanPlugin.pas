{ ------------------------------------
  功能说明：Vehicleseatplan.bpl功能对象
  创建日期：2011.2.22
  作者：ice
  版权：nova
  ------------------------------------- }
unit VehicleseatplanPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
{------------------------------------
  功能说明：车辆内部空间管理功能
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
  功能说明：车辆座位图管理功能
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
  Result:='车辆内部空间管理';
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
  Result:='车辆座位图管理';
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
