unit TicketFundsCheckPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmTicketFundsCheck;
type

  //票款对付表
   TTicketFundsCheck = class(TInterfacedObject,IFunctionItem)
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

procedure TTicketFundsCheck.ChangeTheme;
begin

end;

constructor TTicketFundsCheck.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TTicketFundsCheck.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmTicketFundsCheck,FrmTicketFundsCheck,self);

end;

function TTicketFundsCheck.getDescribe: String;
begin
  Result:='票款对付表';
end;

function TTicketFundsCheck.getKey: TGUID;
begin
  Result:=StringToGUID('{772CDBB3-3E78-40B1-BDC8-BBDF6AAB0797}');
end;

function TTicketFundsCheck.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TTicketFundsCheck.IsWorkState:Boolean;
begin

end;

procedure TTicketFundsCheck.Leave;
begin

end;

procedure TTicketFundsCheck.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
