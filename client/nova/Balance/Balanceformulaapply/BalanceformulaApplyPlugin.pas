unit BalanceformulaApplyPlugin;


{ ------------------------------------
  功能说明：BalanceformulaApply.bpl插件单元
  创建日期：2011.06.11
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBalanceformulaApplyFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmBalanceformulaApply, MainFormIntf;

{ TScheduleFunctionItem }

procedure TBalanceformulaApplyFunctionItem.ChangeTheme;
begin

end;

constructor TBalanceformulaApplyFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBalanceformulaApplyFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBalanceformulaApply, FrmBalanceformulaApply,self);
end;

function TBalanceformulaApplyFunctionItem.getDescribe: String;
begin
  Result := '结算扣费公式应用';
end;

function TBalanceformulaApplyFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{4868A287-D754-46A1-A143-52B5E9F5E4ED}');
end;

function TBalanceformulaApplyFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TBalanceformulaApplyFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBalanceformulaApplyFunctionItem.Leave;
begin

end;

procedure TBalanceformulaApplyFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
