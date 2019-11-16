unit CheckTicketPlugin;
{ ------------------------------------
  功能说明：CheckTicket.bpl插件单元
  创建日期：2011.05.17
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf,Generics.Collections,UFrmCheckTicket;

Type
  //综合检票
  TCheckTicketItemFunctionItem = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

implementation
uses Services,MainFormIntf;
{ TScheduleFunctionItem }

procedure TCheckTicketItemFunctionItem.ChangeTheme;
begin

end;

constructor TCheckTicketItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TCheckTicketItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
//var checkTickets:TCheckTickets;
begin
  Services.SysMainForm.ShowForm(TFrmCheckTicket, FrmCheckTicket,Self);
 // checkTickets:=TCheckTickets.Create;
end;

function TCheckTicketItemFunctionItem.getDescribe: String;
begin
  Result := '综合检票';
end;

function TCheckTicketItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{A963B06B-2048-4368-8EBF-2EA79D9BE88A}');
end;

function TCheckTicketItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TCheckTicketItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TCheckTicketItemFunctionItem.Leave;
begin

end;

procedure TCheckTicketItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;


end.
