unit RouteChecktimePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,
  UFrmRouteChecktime;

type
  TRouteChecktimePlugin = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    // constructor Create();
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

uses Services, MainFormIntf;

{ TRoleList }

procedure TRouteChecktimePlugin.ChangeTheme;
begin

end;

procedure TRouteChecktimePlugin.Enter
  (const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmRouteChecktime, FrmRouteChecktime, self);
end;

function TRouteChecktimePlugin.getDescribe: String;
begin
  Result := '检票管理-检票开始时间设置';
end;

function TRouteChecktimePlugin.getKey: TGUID;
begin
  Result := StringToGUID('{3C42EA90-3A01-42D0-82F7-1D3B1273535C}');
end;

function TRouteChecktimePlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TRouteChecktimePlugin.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TRouteChecktimePlugin.Leave;
begin

end;

procedure TRouteChecktimePlugin.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
