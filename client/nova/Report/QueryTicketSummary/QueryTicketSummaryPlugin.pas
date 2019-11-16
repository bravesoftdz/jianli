unit QueryTicketSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryTicketSummary;
type

//站务分公司班线数据情况汇总表
 queryTicketSummaryItem = class(TInterfacedObject,IFunctionItem)
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

procedure queryTicketSummaryItem.ChangeTheme;
begin

end;

constructor queryTicketSummaryItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryTicketSummaryItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryTicketSummary,frmQueryTicketSummary,self);
end;


function queryTicketSummaryItem.getDescribe: String;
begin
  Result:='站务分公司网点售票情况汇总表';
end;
function queryTicketSummaryItem.getKey: TGUID;
begin
  Result:=StringToGUID('{11AD6B6B-176C-422C-967B-B42BFB1AE904}');
end;

function queryTicketSummaryItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryTicketSummaryItem.IsWorkState: Boolean;
begin

end;

procedure queryTicketSummaryItem.Leave;
begin

end;

procedure queryTicketSummaryItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
