unit QuerySellerTicketSummaryPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySellerTicketSummary;
type

//站务分公司售票员售票情况汇总表
 QuerySellerTicketSummaryItem = class(TInterfacedObject,IFunctionItem)
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

procedure QuerySellerTicketSummaryItem.ChangeTheme;
begin

end;

constructor QuerySellerTicketSummaryItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure QuerySellerTicketSummaryItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySellerTicketSummary,frmQuerySellerTicketSummary,self);
end;


function QuerySellerTicketSummaryItem.getDescribe: String;
begin
  Result:='站务分公司售票员售票情况汇总表';
end;
function QuerySellerTicketSummaryItem.getKey: TGUID;
begin
  Result:=StringToGUID('{A274E552-82A6-442D-BB5A-147168F5E052}');
end;

function QuerySellerTicketSummaryItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function QuerySellerTicketSummaryItem.IsWorkState: Boolean;
begin

end;

procedure QuerySellerTicketSummaryItem.Leave;
begin

end;

procedure QuerySellerTicketSummaryItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
