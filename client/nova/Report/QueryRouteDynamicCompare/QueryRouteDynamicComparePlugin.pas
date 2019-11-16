unit QueryRouteDynamicComparePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryRouteDynamicCompare;
type

//客运班线动态同期对比表
 routeDynamicCompareManager = class(TInterfacedObject,IFunctionItem)
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

procedure routeDynamicCompareManager.ChangeTheme;
begin

end;

constructor routeDynamicCompareManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure routeDynamicCompareManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryRouteDynamicCompare,frmQueryRouteDynamicCompare,self);
end;


function routeDynamicCompareManager.getDescribe: String;
begin
  Result:='客运班线动态同期对比表';
end;
function routeDynamicCompareManager.getKey: TGUID;
begin
  Result:=StringToGUID('{CD5ADA71-4000-4A87-81F9-9087693E6F8C}');
end;

function routeDynamicCompareManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function routeDynamicCompareManager.IsWorkState: Boolean;
begin

end;

procedure routeDynamicCompareManager.Leave;
begin

end;

procedure routeDynamicCompareManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
