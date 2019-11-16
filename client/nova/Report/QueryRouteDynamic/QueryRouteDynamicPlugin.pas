unit QueryRouteDynamicPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryRouteDynamic;
type

//客运班线动态表
 routeDynamicManager = class(TInterfacedObject,IFunctionItem)
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

procedure routeDynamicManager.ChangeTheme;
begin

end;

constructor routeDynamicManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure routeDynamicManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryRouteDynamic,frmQueryRouteDynamic,self);
end;


function routeDynamicManager.getDescribe: String;
begin
  Result:='客运班线动态表';
end;
function routeDynamicManager.getKey: TGUID;
begin
  Result:=StringToGUID('{30EBFDF3-20CC-4A9F-8113-624DB39B2D78}');
end;

function routeDynamicManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function routeDynamicManager.IsWorkState: Boolean;
begin

end;

procedure routeDynamicManager.Leave;
begin

end;

procedure routeDynamicManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
