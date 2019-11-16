unit BalanceDividePlugin;

{ ------------------------------------
  功能说明：BalanceDivide.bpl插件单元
  创建日期：2012.08.24
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBalanceDivideFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmBalanceDivide, MainFormIntf;

{ TScheduleFunctionItem }

procedure TBalanceDivideFunctionItem.ChangeTheme;
begin

end;

constructor TBalanceDivideFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBalanceDivideFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBalanceDivide, FrmBalanceDivide,self);
end;

function TBalanceDivideFunctionItem.getDescribe: String;
begin
  Result := '结算分层协议';
end;

function TBalanceDivideFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{9D61D89E-8FCD-464E-9E10-2E4DF6DD8984}');
end;

function TBalanceDivideFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TBalanceDivideFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBalanceDivideFunctionItem.Leave;
begin

end;

procedure TBalanceDivideFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
