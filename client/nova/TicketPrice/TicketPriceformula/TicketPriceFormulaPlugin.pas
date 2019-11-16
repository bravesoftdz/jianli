unit TicketPriceFormulaPlugin;
{ ------------------------------------
  功能说明：ticketprice.bpl插件单元
  创建日期：2011.03.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TTicketPriceFormulaItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmTicketPriceFormula, MainFormIntf;

{ TScheduleFunctionItem }

procedure TTicketPriceFormulaItemFunctionItem.ChangeTheme;
begin

end;

constructor TTicketPriceFormulaItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TTicketPriceFormulaItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmTicketPriceFormula, FrmTicketPriceFormula,self);
end;

function TTicketPriceFormulaItemFunctionItem.getDescribe: String;
begin
  Result := '票价公式';
end;

function TTicketPriceFormulaItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{7F40B415-94BF-4226-825A-A850650A8893}');
end;

function TTicketPriceFormulaItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TTicketPriceFormulaItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TTicketPriceFormulaItemFunctionItem.Leave;
begin

end;

procedure TTicketPriceFormulaItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
