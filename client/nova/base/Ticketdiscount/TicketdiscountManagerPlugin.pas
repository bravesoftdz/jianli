unit TicketdiscountManagerPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmTicketdiscount;
type

//发往各省、地客运量日统计表
 TicketdiscountManager = class(TInterfacedObject,IFunctionItem)
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

procedure TicketdiscountManager.ChangeTheme;
begin

end;

constructor TicketdiscountManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TicketdiscountManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmTicketdiscount,FrmTicketdiscount,self);
end;


function TicketdiscountManager.getDescribe: String;
begin
  Result:='折扣管理';
end;
function TicketdiscountManager.getKey: TGUID;
begin
  Result:=StringToGUID('{FD62222F-FEC8-40D5-B5C9-BCF64B9E6492}');
end;

function TicketdiscountManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TicketdiscountManager.IsWorkState: Boolean;
begin

end;

procedure TicketdiscountManager.Leave;
begin

end;

procedure TicketdiscountManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
