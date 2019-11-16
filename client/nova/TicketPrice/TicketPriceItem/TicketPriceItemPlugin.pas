unit TicketPriceItemPlugin;
{ ------------------------------------
  功能说明：ticketprice.bpl插件单元
  创建日期：2011.03.03
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TTicketPriceItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmTicketPriceFormulaitem, MainFormIntf;

{ TScheduleFunctionItem }

procedure TTicketPriceItemFunctionItem.ChangeTheme;
begin

end;

constructor TTicketPriceItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TTicketPriceItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmTicketPriceFormulaitem, FrmTicketPriceFormulaitem,self);
end;

function TTicketPriceItemFunctionItem.getDescribe: String;
begin
  Result := '票价项目';
end;

function TTicketPriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{5CA3B0D4-313D-4581-8F2D-BCB490D19259}');
end;

function TTicketPriceItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TTicketPriceItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TTicketPriceItemFunctionItem.Leave;
begin

end;

procedure TTicketPriceItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
