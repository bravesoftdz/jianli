unit PackIntegrateRulePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TPackIntegrateRule = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmPackIntegrateRule, MainFormIntf;

{ TScheduleFunctionItem }

procedure TPackIntegrateRule.ChangeTheme;
begin

end;

constructor TPackIntegrateRule.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPackIntegrateRule.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPackIntegrateRule, FrmPackIntegrateRule,self);
end;

function TPackIntegrateRule.getDescribe: String;
begin
  Result := '积分规则设置';
end;

function TPackIntegrateRule.getKey: TGUID;
begin
  Result := StringToGUID('{C270403A-E991-103A-7D1A-A15FE840349E}');
end;

function TPackIntegrateRule.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TPackIntegrateRule.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPackIntegrateRule.Leave;
begin

end;

procedure TPackIntegrateRule.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
