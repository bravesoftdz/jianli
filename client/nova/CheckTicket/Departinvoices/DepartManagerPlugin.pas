unit DepartManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TDepartinvoicesManagerExport=class(TInterfacedObject,IFunctionItem)
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


  TDepartinvoicesJcExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmDepartinvoicesManager,UFrmPrintunInvoices;

{ SysMenuManager }

procedure TDepartinvoicesManagerExport.ChangeTheme;
begin

end;

constructor TDepartinvoicesManagerExport.Create;
begin
end;

procedure TDepartinvoicesManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmDepartinvoicesManager,FrmDepartinvoicesManager,self);
end;

function TDepartinvoicesManagerExport.getDescribe: String;
begin
  Result:='结算单管理';
end;

function TDepartinvoicesManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{81C6415E-576D-47E7-B952-B9C883D7E9B6}');
end;

function TDepartinvoicesManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TDepartinvoicesManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TDepartinvoicesManagerExport.Leave;
begin

end;

procedure TDepartinvoicesManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
{ TDepartinvoicesJcExport }

procedure TDepartinvoicesJcExport.ChangeTheme;
begin

end;

constructor TDepartinvoicesJcExport.Create;
begin

end;

procedure TDepartinvoicesJcExport.Enter(
  const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmPrintunInvoices,FrmPrintunInvoices,self);
end;

function TDepartinvoicesJcExport.getDescribe: String;
begin
  Result:='补开结算单';
end;

function TDepartinvoicesJcExport.getKey: TGUID;
begin
  Result:=StringToGUID('{9C278122-5EB6-43D7-87CF-55913516D853}');
end;

function TDepartinvoicesJcExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TDepartinvoicesJcExport.IsWorkState: Boolean;
begin
   Result:=True;
end;

procedure TDepartinvoicesJcExport.Leave;
begin

end;

procedure TDepartinvoicesJcExport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
