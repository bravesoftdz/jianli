unit QueryNetworkTicketSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryNetworkTicketSummary;
type

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
  Services.SysMainForm.ShowForm(TfrmQueryNetworkTicketSummary,frmQueryNetworkTicketSummary,self);
end;


function routeDynamicCompareManager.getDescribe: String;
begin
  Result:='联网售票统计报表';
end;
function routeDynamicCompareManager.getKey: TGUID;
begin
  Result:=StringToGUID('{56ECB741-DC69-49BA-83B1-D509EDCA8135}');
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
