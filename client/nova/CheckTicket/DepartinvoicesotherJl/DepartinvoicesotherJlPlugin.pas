unit DepartinvoicesotherJlPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
  TDepartinvoicesotherJlFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmDepartinvoicesotherJl;


{ TTicketSaleFunction }

procedure TDepartinvoicesotherJlFunction.ChangeTheme;
begin

end;

constructor TDepartinvoicesotherJlFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TDepartinvoicesotherJlFunction.Enter(const parameters: TFunctionItemParameters);
begin

  SysMainForm.ShowForm(TfrmDepartinvoicesotherJl,frmDepartinvoicesotherJl,self);

end;

function TDepartinvoicesotherJlFunction.getDescribe: String;
begin
  Result:='½áËãµ¥²¹Â¼(¼àÀû)';
end;

function TDepartinvoicesotherJlFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{2072ED1A-2933-4FC0-93A1-02920AFBB0B7}');
end;

function TDepartinvoicesotherJlFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDepartinvoicesotherJlFunction.IsWorkState: Boolean;
begin

end;

procedure TDepartinvoicesotherJlFunction.Leave;
begin

end;

procedure TDepartinvoicesotherJlFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
