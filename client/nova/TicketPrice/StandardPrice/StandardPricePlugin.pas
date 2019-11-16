unit StandardPricePlugin;


{ ------------------------------------
  功能说明：StandardPrice.bpl插件单元
  创建日期：2011.03.16
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TStandardPriceFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmStandardprice, MainFormIntf;

{ TScheduleFunctionItem }

procedure TStandardPriceFunctionItem.ChangeTheme;
begin

end;

constructor TStandardPriceFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TStandardPriceFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmStandardprice, FrmStandardprice,self);
end;

function TStandardPriceFunctionItem.getDescribe: String;
begin
  Result := '公式票价';
end;

function TStandardPriceFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{7C82C2A9-7915-484C-A3C9-3721B427E085}');
end;

function TStandardPriceFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TStandardPriceFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TStandardPriceFunctionItem.Leave;
begin

end;

procedure TStandardPriceFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
