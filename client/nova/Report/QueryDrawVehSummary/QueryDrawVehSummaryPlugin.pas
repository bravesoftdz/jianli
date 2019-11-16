unit QueryDrawVehSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryDrawVehSummary;
type

 queryDrawVehSummaryItem = class(TInterfacedObject,IFunctionItem)
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

procedure queryDrawVehSummaryItem.ChangeTheme;
begin

end;

constructor queryDrawVehSummaryItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryDrawVehSummaryItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryDrawVehSummary,frmQueryDrawVehSummary,self);
end;


function queryDrawVehSummaryItem.getDescribe: String;
begin
  Result:='站务分公司进站车辆汇总表';
end;
function queryDrawVehSummaryItem.getKey: TGUID;
begin
  Result:=StringToGUID('{5B88648C-43B9-4E14-BEEF-DD3A499A4CD4}');
end;

function queryDrawVehSummaryItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryDrawVehSummaryItem.IsWorkState: Boolean;
begin

end;

procedure queryDrawVehSummaryItem.Leave;
begin

end;

procedure queryDrawVehSummaryItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
