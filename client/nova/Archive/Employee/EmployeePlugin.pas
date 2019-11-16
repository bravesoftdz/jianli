unit EmployeePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmEmployeeEdit,UFrmEmployee;
type
 employeeManager = class(TInterfacedObject,IFunctionItem)
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

  employeeEdit = class(TInterfacedObject,IFunctionItem)
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

procedure employeeManager.ChangeTheme;
begin

end;

constructor employeeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure employeeManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmEmployee,frmEmployee,self);
end;


function employeeManager.getDescribe: String;
begin
  Result:='档案管理--员工档案管理';
end;
function employeeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{F78F4A4A-8DB6-427D-AB88-1BDC377CE585}');
end;

function employeeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function employeeManager.IsWorkState: Boolean;
begin

end;

procedure employeeManager.Leave;
begin

end;

procedure employeeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {driverEdit 编辑窗口}
procedure employeeEdit.ChangeTheme;
begin

end;

constructor employeeEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure employeeEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmEmployeeEdt,frmEmployeeEdt);
end;

function employeeEdit.getDescribe: String;
begin
  Result:='员工档案信息编辑';
end;

function employeeEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{A45E85D7-CC2E-4F92-B29A-C06347D3B013}');
end;

function employeeEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function employeeEdit.IsWorkState: Boolean;
begin

end;

procedure employeeEdit.Leave;
begin

end;

procedure employeeEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
