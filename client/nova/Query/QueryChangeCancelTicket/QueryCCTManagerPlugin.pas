unit QueryCCTManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UfrmQueryChangeCancelTicket;

Type
  TQueryCCTManagerPlugin=class(TInterfacedObject,IFunctionItem)
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

{ TMenuManager }

procedure TQueryCCTManagerPlugin.ChangeTheme;
begin

end;

constructor TQueryCCTManagerPlugin.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TQueryCCTManagerPlugin.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TfrmQueryChangeCancelTicket,frmQueryChangeCancelTicket,Self);
end;

function TQueryCCTManagerPlugin.getDescribe: String;
begin
  Result:='≤Àµ•π‹¿Ì';
end;

function TQueryCCTManagerPlugin.getKey: TGUID;
begin
  Result:=StringToGUID('{5FA703FB-935F-4905-B6AF-2810B18567BD}');
end;

function TQueryCCTManagerPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryCCTManagerPlugin.IsWorkState: Boolean;
begin

end;

procedure TQueryCCTManagerPlugin.Leave;
begin

end;

procedure TQueryCCTManagerPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
