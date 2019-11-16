unit RouteSaleTicketReportPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmRouteSaleTicketReport;
type

  //��·��Ʊͳ�Ʊ�
   TRouteSaleTicket = class(TInterfacedObject,IFunctionItem)
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

//������������ѯ
{ TRouteSaleReportManager }

procedure TRouteSaleTicket.ChangeTheme;
begin

end;

constructor TRouteSaleTicket.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TRouteSaleTicket.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmRouteSaleTicketReport,FrmRouteSaleTicketReport,self);

end;

function TRouteSaleTicket.getDescribe: String;
begin
  Result:='��·��Ʊͳ�Ʊ�';
end;

function TRouteSaleTicket.getKey: TGUID;
begin
  Result:=StringToGUID('{FADE86D4-19CC-4780-8A35-F2FCC5C5EB6A}');
end;

function TRouteSaleTicket.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TRouteSaleTicket.IsWorkState:Boolean;
begin

end;

procedure TRouteSaleTicket.Leave;
begin

end;

procedure TRouteSaleTicket.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
