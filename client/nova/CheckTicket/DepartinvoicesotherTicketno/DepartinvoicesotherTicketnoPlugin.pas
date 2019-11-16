unit DepartinvoicesotherTicketnoPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
  //结算单补录
  TDepartinvoicesotherTicketnoExport=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmDepartinvoicesotherTicketno;

{ SysMenuManager }

//结算单补录
procedure TDepartinvoicesotherTicketnoExport.ChangeTheme;
begin

end;

constructor TDepartinvoicesotherTicketnoExport.Create;
begin
end;

procedure TDepartinvoicesotherTicketnoExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmDepartinvoicesotherTicketno,FrmDepartinvoicesotherTicketno,self);
end;

function TDepartinvoicesotherTicketnoExport.getDescribe: String;
begin
  Result:='结算单补录(票号)';
end;

function TDepartinvoicesotherTicketnoExport.getKey: TGUID;
begin
  Result:=StringToGUID('{58140F1E-2904-4A85-AF40-8F0C26DE8259}');
end;

function TDepartinvoicesotherTicketnoExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TDepartinvoicesotherTicketnoExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TDepartinvoicesotherTicketnoExport.Leave;
begin

end;

procedure TDepartinvoicesotherTicketnoExport.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
