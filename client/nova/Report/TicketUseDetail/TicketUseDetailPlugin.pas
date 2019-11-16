unit TicketUseDetailPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
  TTicketUseDetailFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmQryTicketUseDetail;


{ TTicketSaleFunction }

procedure TTicketUseDetailFunction.ChangeTheme;
begin

end;

constructor TTicketUseDetailFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TTicketUseDetailFunction.Enter(const parameters: TFunctionItemParameters);
begin

  SysMainForm.ShowForm(TFrmQryTicketUseDetail,FrmQryTicketUseDetail,self);

end;

function TTicketUseDetailFunction.getDescribe: String;
begin
  Result:='票种使用明细表';
end;

function TTicketUseDetailFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{8D1CA4E9-C702-439E-9692-26D4B509224B}');
end;

function TTicketUseDetailFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TTicketUseDetailFunction.IsWorkState: Boolean;
begin

end;

procedure TTicketUseDetailFunction.Leave;
begin

end;

procedure TTicketUseDetailFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
