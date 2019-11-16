unit UpdatefilePlugin;

interface

uses SysUtils,Controls,Forms, Classes, FunctionItemIntf,
Windows, Generics.Collections,ShellAPI,Services;

Type
  TUpdatefileFunction = class(TInterfacedObject, IFunctionItem)
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


{ TUpdatefileFunction }

procedure TUpdatefileFunction.ChangeTheme;
begin

end;

constructor TUpdatefileFunction.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TUpdatefileFunction.Enter(const parameters: TFunctionItemParameters);
begin
   if SysDialogs.Ask('系统自动升级','自动升级将关闭当前程序，是否继续？') then
      ShellExecute(application.Handle, nil, PChar('AutoUpdate.exe'), nil, nil, SW_SHOWNORMAL) ;
end;

function TUpdatefileFunction.getDescribe: String;
begin
  Result := '更新bpl';
end;

function TUpdatefileFunction.getKey: TGUID;
begin
  Result := StringToGUID('{65C76F14-C4B1-4244-8946-5E08A7C15FD3}');
end;

function TUpdatefileFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TUpdatefileFunction.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TUpdatefileFunction.Leave;
begin

end;

procedure TUpdatefileFunction.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
