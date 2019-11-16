unit TicketChargeoffPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmTicketChargeoff;
type
 TicketChargeoffMS = class(TInterfacedObject,IFunctionItem)
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

procedure TicketChargeoffMS.ChangeTheme;
begin

end;

procedure TicketChargeoffMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmTicketChargeoff,frmTicketChargeoff,self);
end;

constructor TicketChargeoffMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function TicketChargeoffMS.getDescribe: String;
begin
  Result:='结算管理--票据核销';
end;
function TicketChargeoffMS.getKey: TGUID;
begin
  Result:=StringToGUID('{86604F48-5BFF-4A40-9D0E-CFF39FC41589}');
end;

function TicketChargeoffMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TicketChargeoffMS.IsWorkState: Boolean;
begin

end;

procedure TicketChargeoffMS.Leave;
begin

end;

procedure TicketChargeoffMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
