unit TicketsellIncomePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,
  UFrmTicketsellIncomeRpt;

type

  // 售票营收统计表
  TTicketsellIncomeManager = class(TInterfacedObject, IFunctionItem)
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

uses Services, MainFormIntf;

procedure TTicketsellIncomeManager.ChangeTheme;
begin

end;

constructor TTicketsellIncomeManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TTicketsellIncomeManager.Enter
  (const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmTicketsellIncomeRpt,
    FrmTicketsellIncomeRpt,self);
end;

function TTicketsellIncomeManager.getDescribe: String;
begin
  Result := '售票营收统计表';
end;

function TTicketsellIncomeManager.getKey: TGUID;
begin
  Result := StringToGUID('{7744FCC7-4A54-402E-A74D-C2EE9091E372}');
end;

function TTicketsellIncomeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TTicketsellIncomeManager.IsWorkState: Boolean;
begin

end;

procedure TTicketsellIncomeManager.Leave;
begin

end;

procedure TTicketsellIncomeManager.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
