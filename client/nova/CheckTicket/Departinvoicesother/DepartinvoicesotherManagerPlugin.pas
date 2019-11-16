unit DepartinvoicesotherManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
  //结算单补录
  TDepartinvoicesotherManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmDepartinvoicesother;

{ SysMenuManager }

//结算单补录
procedure TDepartinvoicesotherManagerExport.ChangeTheme;
begin

end;

constructor TDepartinvoicesotherManagerExport.Create;
begin
end;

procedure TDepartinvoicesotherManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmDepartinvoices,FrmDepartinvoices,self);
end;

function TDepartinvoicesotherManagerExport.getDescribe: String;
begin
  Result:='结算单补录';
end;

function TDepartinvoicesotherManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{BB009896-E6AD-469F-AF6E-8C554B3E2E09}');
end;

function TDepartinvoicesotherManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TDepartinvoicesotherManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TDepartinvoicesotherManagerExport.Leave;
begin

end;

procedure TDepartinvoicesotherManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
