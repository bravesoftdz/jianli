unit FinancialBalanceMonthFRPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFinancialMonthFR;
type

//财务收支月平衡表
 FinancialFRManager = class(TInterfacedObject,IFunctionItem)
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

procedure FinancialFRManager.ChangeTheme;
begin

end;

constructor FinancialFRManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure FinancialFRManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmFinancialMonthFR,frmFinancialMonthFR,self);
end;


function FinancialFRManager.getDescribe: String;
begin
  Result:='财务月度收支平衡表';
end;
function FinancialFRManager.getKey: TGUID;
begin
  Result:=StringToGUID('{7FB7F632-C766-4BFF-91AF-226242398364}');
end;

function FinancialFRManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function FinancialFRManager.IsWorkState: Boolean;
begin

end;

procedure FinancialFRManager.Leave;
begin

end;

procedure FinancialFRManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
