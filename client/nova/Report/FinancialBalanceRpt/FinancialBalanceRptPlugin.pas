unit FinancialBalanceRptPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFinancialBalanceRpt;
type

//财务收支平衡表
 FinancialBalanceRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure FinancialBalanceRptManager.ChangeTheme;
begin

end;

constructor FinancialBalanceRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure FinancialBalanceRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmFinancialBalanceRpt,frmFinancialBalanceRpt,self);
end;


function FinancialBalanceRptManager.getDescribe: String;
begin
  Result:='财务收支平衡表';
end;
function FinancialBalanceRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{B83D3545-3343-47E6-B40E-774E37051D6C}');
end;

function FinancialBalanceRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function FinancialBalanceRptManager.IsWorkState: Boolean;
begin

end;

procedure FinancialBalanceRptManager.Leave;
begin

end;

procedure FinancialBalanceRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
