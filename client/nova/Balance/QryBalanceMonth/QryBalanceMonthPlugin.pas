unit QryBalanceMonthPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBalanceMonthFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmQryBalanceMonth, MainFormIntf;

{ TScheduleFunctionItem }

procedure TBalanceMonthFunctionItem.ChangeTheme;
begin

end;

constructor TBalanceMonthFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBalanceMonthFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmQryBalanceMonth, FrmQryBalanceMonth,
    self);
end;

function TBalanceMonthFunctionItem.getDescribe: String;
begin
  Result := '结算月报查询';
end;

function TBalanceMonthFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{154AD6C6-3A4C-4ECD-9CBA-9101257C885F}');
end;

function TBalanceMonthFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TBalanceMonthFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBalanceMonthFunctionItem.Leave;
begin

end;

procedure TBalanceMonthFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
