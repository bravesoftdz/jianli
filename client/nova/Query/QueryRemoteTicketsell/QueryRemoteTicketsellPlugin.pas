unit QueryRemoteTicketsellPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryRemoteTicketsell;
type

 queryRemoteTicketsellItem = class(TInterfacedObject,IFunctionItem)
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

procedure queryRemoteTicketsellItem.ChangeTheme;
begin

end;

constructor queryRemoteTicketsellItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryRemoteTicketsellItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryRemoteTicketsell,frmQueryRemoteTicketsell,self);
end;


function queryRemoteTicketsellItem.getDescribe: String;
begin
  Result:='‘∂≥ÃºÏ∆±≤È—Ø';
end;
function queryRemoteTicketsellItem.getKey: TGUID;
begin
  Result:=StringToGUID('{F81A88F8-48B4-4BD4-94B5-CC626CD4873A}');
end;

function queryRemoteTicketsellItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryRemoteTicketsellItem.IsWorkState: Boolean;
begin

end;

procedure queryRemoteTicketsellItem.Leave;
begin

end;

procedure queryRemoteTicketsellItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
