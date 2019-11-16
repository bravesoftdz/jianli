unit HandPricePlugin;

{ ------------------------------------
  功能说明：HandPrice.bpl插件单元
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

uses Services, UFrmHandPrice, MainFormIntf;

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
  Services.SysMainForm.ShowForm(TFrmHandPrice, FrmHandPrice,self);
end;

function TTicketPriceItemFunctionItem.getDescribe: String;
begin
  Result := '硬调票价管理';
end;

function TTicketPriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{86C8DEB5-84F6-493B-9205-48DB63E74F00}');
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
