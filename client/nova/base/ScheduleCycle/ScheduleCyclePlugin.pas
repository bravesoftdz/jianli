unit ScheduleCyclePlugin;
{ ------------------------------------
  功能说明：schedule.bpl插件单元
  创建日期：2011.03.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TScheduleCycleFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmScheduleCycle, MainFormIntf;

{ TScheduleFunctionItem }

procedure TScheduleCycleFunctionItem.ChangeTheme;
begin

end;

constructor TScheduleCycleFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TScheduleCycleFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmScheduleCycle, FrmScheduleCycle,self);
end;

function TScheduleCycleFunctionItem.getDescribe: String;
begin
  Result := '班次循环';
end;

function TScheduleCycleFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{0718695A-E2FE-457B-814F-BCBACA963CBB}');
end;

function TScheduleCycleFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TScheduleCycleFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TScheduleCycleFunctionItem.Leave;
begin

end;

procedure TScheduleCycleFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
