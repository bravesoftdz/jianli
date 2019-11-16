{ ------------------------------------
  功能说明：TicketQuery.bpl功能对象
  创建日期：2011/6/29
  作者：ice
  版权：nova
  ------------------------------------- }
unit TicketQueryPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
      UTicketQuery,Forms;

Type
{------------------------------------
  功能说明：售票问讯功能
-------------------------------------}
  TTicketQueryFunction=class(TInterfacedObject,IFunctionItem)
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


{ TTicketQueryFunction }

procedure TTicketQueryFunction.ChangeTheme;
begin

end;

constructor TTicketQueryFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TTicketQueryFunction.Enter(const parameters: TFunctionItemParameters);
var TicketQuery:TTicketQuery;
begin
  TicketQuery:=TTicketQuery.Create(Application);
end;

function TTicketQueryFunction.getDescribe: String;
begin
  Result:='售票问询';
end;

function TTicketQueryFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{A6406192-0298-4873-92A2-34EA04BF0F77}');
end;

function TTicketQueryFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TTicketQueryFunction.IsWorkState: Boolean;
begin

end;

procedure TTicketQueryFunction.Leave;
begin

end;

procedure TTicketQueryFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
