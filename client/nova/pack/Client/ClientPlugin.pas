unit ClientPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmClient,UFrmClientEdit;
type
 ClientManager = class(TInterfacedObject,IFunctionItem)
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

procedure ClientManager.ChangeTheme;
begin

end;

constructor ClientManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ClientManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmClient,frmClient,self);
end;


function ClientManager.getDescribe: String;
begin
  Result:='行包管理--客户档案管理';
end;
function ClientManager.getKey: TGUID;
begin
  Result:=StringToGUID('{BC99C9F0-E0C6-4A1B-8AB1-B259ED8913F6}');
end;

function ClientManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function ClientManager.IsWorkState: Boolean;
begin

end;

procedure ClientManager.Leave;
begin

end;

procedure ClientManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
