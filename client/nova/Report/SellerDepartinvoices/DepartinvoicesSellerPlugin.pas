unit DepartinvoicesSellerPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmSellerDepartinvoices;
type
TDSManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
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
{  parameterAdd }
procedure TDSManager.ChangeTheme;
begin

end;

procedure TDSManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmSellerDepartinvoices,FrmSellerDepartinvoices,Self,parameters,true);
end;

function TDSManager.getDescribe: String;
begin
  Result:='财务报表-售票员结算单';
end;
function TDSManager.getKey: TGUID;
begin
  Result:=StringToGUID('{2A57C5B6-A16A-41D5-A39F-0A2CDDBAB3AC}');
end;

function TDSManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDSManager.IsWorkState: Boolean;
begin

end;

procedure TDSManager.Leave;
begin

end;

procedure TDSManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
