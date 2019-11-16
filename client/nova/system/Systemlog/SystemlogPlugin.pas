unit SystemlogPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmSystemLog;

type
TLogManager = class(TInterfacedObject,IFunctionItem)
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

procedure TLogManager.ChangeTheme;
begin

end;

//constructor TLogManager.Create;
//begin
//  FSubFunctionList:=TList<TSubfunction>.Create;
//end;

 procedure TLogManager.Enter(const parameters: TFunctionItemParameters);
 var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmSystemLog,FrmSystemLog,self);
end;
function TLogManager.getDescribe: String;
begin
  Result:='系统管理模块--错误日志查询';
end;

function TLogManager.getKey: TGUID;
begin
  Result:=StringToGUID('{EE3FA28C-990F-4610-A69C-348908830A58}');
end;

function TLogManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TLogManager.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TLogManager.Leave;
begin

end;

procedure TLogManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.

