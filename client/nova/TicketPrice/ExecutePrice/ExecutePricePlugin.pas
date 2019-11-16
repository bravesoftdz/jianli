unit ExecutePricePlugin;

{ ------------------------------------
  功能说明：ExecutePrice.bpl插件单元
  创建日期：2011.03.16
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TExecutePriceItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmExecutePrice, MainFormIntf;

{ TScheduleFunctionItem }

procedure TExecutePriceItemFunctionItem.ChangeTheme;
begin

end;

constructor TExecutePriceItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TExecutePriceItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmExecutePrice, FrmExecutePrice,self);
end;

function TExecutePriceItemFunctionItem.getDescribe: String;
begin
  Result := '执行票价管理';
end;

function TExecutePriceItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{D2802F61-A648-440B-A76E-933B72EDE000}');
end;

function TExecutePriceItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TExecutePriceItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TExecutePriceItemFunctionItem.Leave;
begin

end;

procedure TExecutePriceItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
