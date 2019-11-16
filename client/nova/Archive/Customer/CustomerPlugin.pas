unit CustomerPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmCustomer,UFrmCustomerEdit;
type
 CustomerManager = class(TInterfacedObject,IFunctionItem)
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

procedure CustomerManager.ChangeTheme;
begin

end;

constructor CustomerManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure CustomerManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmCustomer,frmCustomer,self);
end;


function CustomerManager.getDescribe: String;
begin
  Result:='档案管理--顾客档案管理';
end;
function CustomerManager.getKey: TGUID;
begin
  Result:=StringToGUID('{816A8960-86C5-4C65-B6AF-DC3BD4F91422}');
end;

function CustomerManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function CustomerManager.IsWorkState: Boolean;
begin

end;

procedure CustomerManager.Leave;
begin

end;

procedure CustomerManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
