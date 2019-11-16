unit QuerySchTicketpricePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySchTicketprice;
type

 querySchTicketpriceItem = class(TInterfacedObject,IFunctionItem)
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

procedure querySchTicketpriceItem.ChangeTheme;
begin

end;

constructor querySchTicketpriceItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure querySchTicketpriceItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySchTicketprice,frmQuerySchTicketprice,self);
end;


function querySchTicketpriceItem.getDescribe: String;
begin
  Result:='站务分公司各班线票价情况汇总表';
end;
function querySchTicketpriceItem.getKey: TGUID;
begin
  Result:=StringToGUID('{2A2A4BDE-F7AB-4611-AB77-20FBBD4DC775}');
end;

function querySchTicketpriceItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function querySchTicketpriceItem.IsWorkState: Boolean;
begin

end;

procedure querySchTicketpriceItem.Leave;
begin

end;

procedure querySchTicketpriceItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
