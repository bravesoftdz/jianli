unit TickettypepermissionPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTickettypepermissionManager=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTickettypepermission;

{ SysMenuManager }

procedure TTickettypepermissionManager.ChangeTheme;
begin

end;

constructor TTickettypepermissionManager.Create;
begin
end;

procedure TTickettypepermissionManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTickettypepermission,FrmTickettypepermission,self);
end;

function TTickettypepermissionManager.getDescribe: String;
begin
  Result:='车票类型可售权限控制';
end;

function TTickettypepermissionManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D0FDDF35-14A6-4375-94B8-12D4224C12DA}');
end;

function TTickettypepermissionManager.getSubFunctionList: TList<TSubfunction>;
begin
 // Result:=TFrmArea.getSubFunctionList;
end;

function TTickettypepermissionManager.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTickettypepermissionManager.Leave;
begin

end;

procedure TTickettypepermissionManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
