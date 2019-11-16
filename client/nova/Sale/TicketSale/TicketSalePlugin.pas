{ ------------------------------------
  ����˵����TicketSale.bpl���ܶ���
  �������ڣ�2011/4/12
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit TicketSalePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
      SellTicket,Forms;

Type
{------------------------------------
  ����˵������Ʊ����
-------------------------------------}
  TSellTicketFunction=class(TInterfacedObject,IFunctionItem)
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

{------------------------------------
  ����˵�����ش�Ʊ����
-------------------------------------}
  TPrintTicketFunction=class(TInterfacedObject,IFunctionItem)
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


{ TTicketSaleFunction }

procedure TSellTicketFunction.ChangeTheme;
begin

end;

constructor TSellTicketFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSellTicketFunction.Enter(const parameters: TFunctionItemParameters);
var sellTicket:TSellTicket;
begin
  if (parameters=nil) or (parameters.Count=0) then
  begin
    raise Exception.Create('����Ʊ���ܡ���Ҫָ����Ʊ��ʽ');
  end;
  SellTicket:=TsellTicket.Create(Application,parameters.Strings[0]);
end;

function TSellTicketFunction.getDescribe: String;
begin
  Result:='���ڱ�����Ĺ�����Ϣ';
end;

function TSellTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{28C5062D-338E-4C4A-A4AF-0056355D2481}');
end;

function TSellTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TSellTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TSellTicketFunction.Leave;
begin

end;

procedure TSellTicketFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


{ TPrintTicketFunction }

procedure TPrintTicketFunction.ChangeTheme;
begin

end;

constructor TPrintTicketFunction.Create;
begin

end;

procedure TPrintTicketFunction.Enter(const parameters: TFunctionItemParameters);
var ticketsellid:int64;
    isnet:boolean;
    curticketno:String;
begin
  if (parameters=nil) or (parameters.Count<1) then
  begin
    raise Exception.Create('���ش�Ʊ���ܡ���Ҫָ����Ʊ��ƱID');
  end
  else if (parameters.Count<2) then
  begin
    raise Exception.Create('���ش�Ʊ���ܡ���Ҫָ����Ʊ�Ƿ�������Ʊ');
  end;
  ticketsellid:=StrToInt64Def(parameters.Strings[0],0);
  isnet:=StrToBoolDef(parameters.Strings[1],false);
  if ticketsellid<=0 then
  begin
    raise Exception.Create('������Ʊ��ƱID��������');
  end;
  curticketno:='';
  if parameters.Count=3 then
  begin
    curticketno:=parameters.Strings[2];
  end;
  TsellTicket.printTicketById(ticketsellid,isnet,curticketno);
end;

function TPrintTicketFunction.getDescribe: String;
begin
  result:='�ش�Ʊ';
end;

function TPrintTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{ECFCAF62-D9B1-42E8-A5F7-3395FCD94E0C}');
end;

function TPrintTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TPrintTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TPrintTicketFunction.Leave;
begin

end;

procedure TPrintTicketFunction.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
