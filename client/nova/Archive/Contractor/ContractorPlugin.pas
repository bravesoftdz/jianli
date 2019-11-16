unit ContractorPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmContractor,UFrmContractorEdit;
type
 constructorManager = class(TInterfacedObject,IFunctionItem)
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

procedure constructorManager.ChangeTheme;
begin

end;

constructor constructorManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure constructorManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmContractor,frmContractor,self);
end;


function constructorManager.getDescribe: String;
begin
  Result:='档案管理--承包者档案管理';
end;
function constructorManager.getKey: TGUID;
begin
  Result:=StringToGUID('{E286E2B7-EEEC-4926-BA1D-6039A7CBAEE5}');
end;

function constructorManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function constructorManager.IsWorkState: Boolean;
begin

end;

procedure constructorManager.Leave;
begin

end;

procedure constructorManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
