unit RoutePricePlugin;

{ ------------------------------------
  功能说明：RoutePrice.bpl插件单元
  创建日期：2014.12.18
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TRoutePriceItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmRoutePrice, MainFormIntf;

{ TScheduleFunctionItem }

procedure TRoutePriceItemFunctionItem.ChangeTheme;
begin

end;

constructor TRoutePriceItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TRoutePriceItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmRoutePrice, FrmRoutePrice,self);
end;

function TRoutePriceItemFunctionItem.getDescribe: String;
begin
  Result := '线路票价信息';
end;

function TRoutePriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{4F050117-5961-4479-B2B4-8FB9FE841401}');
end;

function TRoutePriceItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TRoutePriceItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TRoutePriceItemFunctionItem.Leave;
begin

end;

procedure TRoutePriceItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
