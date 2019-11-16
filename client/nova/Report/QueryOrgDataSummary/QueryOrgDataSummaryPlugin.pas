unit QueryOrgDataSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryOrgDataSummary;
type

 QueryOrgDataSummaryItem = class(TInterfacedObject,IFunctionItem)
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

procedure QueryOrgDataSummaryItem.ChangeTheme;
begin

end;

constructor QueryOrgDataSummaryItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure QueryOrgDataSummaryItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryOrgDataSummary,frmQueryOrgDataSummary,self);
end;


function QueryOrgDataSummaryItem.getDescribe: String;
begin
  Result:='站务作业统计报表';
end;
function QueryOrgDataSummaryItem.getKey: TGUID;
begin
  Result:=StringToGUID('{CC7911A9-D5C4-4210-8A08-88B18A580F09}');
end;

function QueryOrgDataSummaryItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function QueryOrgDataSummaryItem.IsWorkState: Boolean;
begin

end;

procedure QueryOrgDataSummaryItem.Leave;
begin

end;

procedure QueryOrgDataSummaryItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
