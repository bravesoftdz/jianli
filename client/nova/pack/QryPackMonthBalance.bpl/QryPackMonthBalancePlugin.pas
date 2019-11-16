unit QryPackMonthBalancePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TPackMonthBalanceItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmQryPackMonthBalance, MainFormIntf;

{ TFrmUser }

procedure TPackMonthBalanceItem.ChangeTheme;
begin

end;

constructor TPackMonthBalanceItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPackMonthBalanceItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  // FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQryPackMonthBalance,
    FrmQryPackMonthBalance, self);
end;

function TPackMonthBalanceItem.getDescribe: String;
begin
  Result := '货物月结算表';
end;

function TPackMonthBalanceItem.getKey: TGUID;
begin
  Result := StringToGUID('{464497EE-5F74-4875-9E91-1DB4A20B928E}');
  // Ctrl+Shift+G生成
end;

function TPackMonthBalanceItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TPackMonthBalanceItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPackMonthBalanceItem.Leave;
begin

end;

procedure TPackMonthBalanceItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
