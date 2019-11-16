unit QuerySellBalanceSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySellBalanceSummary;
type
 SellBalanceManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

implementation

uses Services,MainFormIntf;

procedure SellBalanceManager.ChangeTheme;
begin

end;

constructor SellBalanceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SellBalanceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySellbalanceSummary,frmQuerySellbalanceSummary,self);
end;


function SellBalanceManager.getDescribe: String;
begin
  Result:='报表统计--售票点结算汇总表';
end;
function SellBalanceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{1AB86E83-B17C-4DCD-92E9-A204C8C312FC}');
end;

function SellBalanceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function SellBalanceManager.IsWorkState: Boolean;
begin

end;

procedure SellBalanceManager.Leave;
begin

end;

procedure SellBalanceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
