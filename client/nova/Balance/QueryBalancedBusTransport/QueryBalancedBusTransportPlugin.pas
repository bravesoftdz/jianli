unit QueryBalancedBusTransportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryBalancedBusTransport;
type

//已结算单查询
 queryBalancedBusTransportManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryBalancedBusTransportManager.ChangeTheme;
begin

end;

constructor queryBalancedBusTransportManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryBalancedBusTransportManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryBalancedBusTransport,frmQueryBalancedBusTransport,Self);
end;


function queryBalancedBusTransportManager.getDescribe: String;
begin
  Result:='结算管理--已结算查询';
end;
function queryBalancedBusTransportManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9A7EC9D2-3DF8-407E-8007-D8277557089E}');
end;

function queryBalancedBusTransportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryBalancedBusTransportManager.IsWorkState: Boolean;
begin

end;

procedure queryBalancedBusTransportManager.Leave;
begin

end;

procedure queryBalancedBusTransportManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
