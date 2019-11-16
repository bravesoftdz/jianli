unit MsgreadlogPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,Forms,Windows,ShellAPI,
UFrmMsgreadlog,Messages, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

Type
  TMsgFunction = class(TInterfacedObject, IFunctionItem)
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
    //调用服务端 ，获取是否 有需要提示用户 的日志信息
//    function isneedopen(frompath, topath: string): boolean;
  end;

implementation
 uses services,LoginIntf;

{ TReLoginFunction }

procedure TMsgFunction.ChangeTheme;
begin

end;


constructor TMsgFunction.Create;
begin
//   SysFunctionMgr.exec(StringToGUID('{6BAC2D48-6984-4CBF-95AB-FC418087267F}'),nil);
//  ShellExecute(Application.Handle, 'OPEN', PChar(paramstr(0)),
//    '', '', SW_SHOWNORMAL);
////  Services.SysMainForm.ShowForm(TfrmMsgreadlog,frmMsgreadlog);
///
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TMsgFunction.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TfrmMsgreadlog,frmMsgreadlog);
end;

function TMsgFunction.getDescribe: String;
begin

end;

function TMsgFunction.getKey: TGUID;
begin
  Result := StringToGUID('{6BAC2D48-6984-4CBF-95AB-FC418087267F}');
end;

function TMsgFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TMsgFunction.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TMsgFunction.Leave;
begin

end;

procedure TMsgFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
