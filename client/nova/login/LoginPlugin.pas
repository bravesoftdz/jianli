unit LoginPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,Forms,Windows,ShellAPI;

Type
  TReLoginFunction = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  TLoginOutFunction = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  TLockSystemFunction = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;


implementation
 uses LoginImpl,services,LoginIntf;

{ TReLoginFunction }

procedure TReLoginFunction.ChangeTheme;
begin

end;

constructor TReLoginFunction.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TReLoginFunction.Enter(const parameters: TFunctionItemParameters);
var _login:Ilogin;
begin
//  application.Terminate;
  SysFunctionMgr.exec(StringToGUID('{77C3AE74-3F62-4741-ACA4-E365FF6AB562}'),nil);
  ShellExecute(Application.Handle, 'OPEN', PChar(paramstr(0)),
    '', '', SW_SHOWNORMAL);
//  _login := TLogin.Create;
//  _login.ChangeUser;
end;

function TReLoginFunction.getDescribe: String;
begin
  Result := '重新登录';
end;

function TReLoginFunction.getKey: TGUID;
begin
  Result := StringToGUID('{390B1C43-4ECE-4D75-9AC1-4C6BAB6EFC6F}');
end;

function TReLoginFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TReLoginFunction.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TReLoginFunction.Leave;
begin

end;

procedure TReLoginFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TLoginOutFunction }

procedure TLoginOutFunction.ChangeTheme;
begin

end;

constructor TLoginOutFunction.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TLoginOutFunction.Enter(const parameters: TFunctionItemParameters);
var _login:Ilogin;
begin
  _login := TLogin.Create;
  _login.Logout;
end;

function TLoginOutFunction.getDescribe: String;
begin
  Result := '退出登录';
end;

function TLoginOutFunction.getKey: TGUID;
begin
  Result := StringToGUID('{77C3AE74-3F62-4741-ACA4-E365FF6AB562}');
end;

function TLoginOutFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TLoginOutFunction.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TLoginOutFunction.Leave;
begin

end;

procedure TLoginOutFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TLockSystemFunction }

procedure TLockSystemFunction.ChangeTheme;
begin

end;

constructor TLockSystemFunction.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TLockSystemFunction.Enter(const parameters: TFunctionItemParameters);
begin
  (SysService as ILogin).LockSystem;
end;

function TLockSystemFunction.getDescribe: String;
begin
  Result:='锁定系统';
end;

function TLockSystemFunction.getKey: TGUID;
begin
  result:=StringToGUID('{334691FC-3E05-4CA2-BC24-555DF89226F0}');
end;

function TLockSystemFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TLockSystemFunction.IsWorkState: Boolean;
begin

end;

procedure TLockSystemFunction.Leave;
begin

end;

procedure TLockSystemFunction.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
