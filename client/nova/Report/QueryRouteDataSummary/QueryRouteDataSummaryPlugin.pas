unit QueryRouteDataSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryRouteDataSummary;
type

//站务分公司班线数据情况汇总表
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
  Services.SysMainForm.ShowForm(TfrmQueryRouteDataSummary,frmQueryRouteDataSummary,self);
end;


function routeDynamicCompareManager.getDescribe: String;
begin
  Result:='站务分公司班线数据情况汇总表';
end;
function routeDynamicCompareManager.getKey: TGUID;
begin
  Result:=StringToGUID('{A5F7E8D8-6463-4B34-8F7F-16303855FCC6}');
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
