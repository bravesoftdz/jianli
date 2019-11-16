unit QryVehiclebalancedPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TVehicleBalanceFunctionItem = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

implementation

uses Services, UFrmQryVehiclebalanced, MainFormIntf;

{ TScheduleFunctionItem }

procedure TVehicleBalanceFunctionItem.ChangeTheme;
begin

end;

constructor TVehicleBalanceFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TVehicleBalanceFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmQryVehiclebalanced, FrmQryVehiclebalanced,self);
end;

function TVehicleBalanceFunctionItem.getDescribe: String;
begin
  Result := '单车结算情况查询';
end;

function TVehicleBalanceFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{3CA5A489-D22F-4576-BFD4-08528E8BE355}');
end;

function TVehicleBalanceFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList;
end;

function TVehicleBalanceFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TVehicleBalanceFunctionItem.Leave;
begin

end;

procedure TVehicleBalanceFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
