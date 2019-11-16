unit BalanceformulaPlugin;


{ ------------------------------------
  功能说明：Balanceformula.bpl插件单元
  创建日期：2011.06.10
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBalanceformulaFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmBalanceformula, MainFormIntf;

{ TScheduleFunctionItem }

procedure TBalanceformulaFunctionItem.ChangeTheme;
begin

end;

constructor TBalanceformulaFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBalanceformulaFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBalanceformula, FrmBalanceformula,self);
end;

function TBalanceformulaFunctionItem.getDescribe: String;
begin
  Result := '结算扣费公式设置';
end;

function TBalanceformulaFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{7F41FA06-2109-4256-83F4-BBCAC1AD52D4}');
end;

function TBalanceformulaFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TBalanceformulaFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBalanceformulaFunctionItem.Leave;
begin

end;

procedure TBalanceformulaFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
