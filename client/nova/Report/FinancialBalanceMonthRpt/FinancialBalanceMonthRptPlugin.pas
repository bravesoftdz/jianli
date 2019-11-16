unit FinancialBalanceMonthRptPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFinancialMonthRpt;
type

//财务收支月平衡表
 FinancialRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure FinancialRptManager.ChangeTheme;
begin

end;

constructor FinancialRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure FinancialRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmFinancialMonthRpt,frmFinancialMonthRpt,self);
end;


function FinancialRptManager.getDescribe: String;
begin
  Result:='财务收支月平衡表';
end;
function FinancialRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{FB06D1E8-E4FA-4F71-BD02-8BA66364810D}');
end;

function FinancialRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function FinancialRptManager.IsWorkState: Boolean;
begin

end;

procedure FinancialRptManager.Leave;
begin

end;

procedure FinancialRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
