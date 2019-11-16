unit HandHolidayPricePlugin;

{ ------------------------------------
  功能说明：HandHolidayPrice.bpl插件单元
  创建日期：2011.04.27
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  THandHolidayPriceItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmHandHolidayPrice, MainFormIntf;

{ TScheduleFunctionItem }

procedure THandHolidayPriceItemFunctionItem.ChangeTheme;
begin

end;

constructor THandHolidayPriceItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure THandHolidayPriceItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmHandHolidayPrice, FrmHandHolidayPrice,self);
end;

function THandHolidayPriceItemFunctionItem.getDescribe: String;
begin
  Result := '节日票价信息';
end;

function THandHolidayPriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{30A0E9E4-5624-47E3-8686-ED0618ADA101}');
end;

function THandHolidayPriceItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function THandHolidayPriceItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure THandHolidayPriceItemFunctionItem.Leave;
begin

end;

procedure THandHolidayPriceItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
