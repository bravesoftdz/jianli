unit OperationlogPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmOperationlog;

type
TOperationManager = class(TInterfacedObject,IFunctionItem)
 private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
//    constructor Create();
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


{ TRoleList }

procedure TOperationManager.ChangeTheme;
begin

end;

//constructor TLogManager.Create;
//begin
//  FSubFunctionList:=TList<TSubfunction>.Create;
//end;

 procedure TOperationManager.Enter(const parameters: TFunctionItemParameters);
 var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmOperationlog,FrmOperationlog,self);
end;
function TOperationManager.getDescribe: String;
begin
  Result:='系统管理模块--操作日志查询';
end;

function TOperationManager.getKey: TGUID;
begin
  Result:=StringToGUID('{F5D878AA-3516-4338-BDFA-04AA608E2520}');
end;

function TOperationManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TOperationManager.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TOperationManager.Leave;
begin

end;

procedure TOperationManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.

