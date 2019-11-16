unit TicketoutletsPricePlugin;

{ ------------------------------------
  功能说明：TicketoutletsPrice.bpl插件单元
  创建日期：2011.03.16
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

uses Services, UFrmTicketoutletsPrice, MainFormIntf;

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
  Services.SysMainForm.ShowForm(TFrmTicketoutletsPrice, FrmTicketoutletsPrice,self);
end;

function TTicketPriceItemFunctionItem.getDescribe: String;
begin
  Result := '售票点票价差额管理';
end;

function TTicketPriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{962B9AF2-2889-4FEE-82DA-57DD7C7D0FE4}');
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
