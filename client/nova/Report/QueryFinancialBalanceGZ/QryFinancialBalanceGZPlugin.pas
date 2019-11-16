unit QryFinancialBalanceGZPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryFinancialBalanceGZ;
type

 GZManager = class(TInterfacedObject,IFunctionItem)
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

procedure GZManager.ChangeTheme;
begin

end;

constructor GZManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure GZManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryFinancialBalanceGZ,frmQueryFinancialBalanceGZ,self);
end;


function GZManager.getDescribe: String;
begin
  Result:='财务报表--客运收入支出平衡表-赣州';
end;
function GZManager.getKey: TGUID;
begin
  Result:=StringToGUID('{4B241D02-0C35-4AD9-A1A4-653F477AFA49}');
end;

function GZManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function GZManager.IsWorkState: Boolean;
begin

end;

procedure GZManager.Leave;
begin

end;

procedure GZManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
