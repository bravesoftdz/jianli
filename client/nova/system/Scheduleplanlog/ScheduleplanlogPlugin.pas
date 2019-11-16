unit ScheduleplanlogPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,
  UFrmScheduleplanlog;

type
TScheduleplanlogPlugin = class(TInterfacedObject, IFunctionItem)
  private FSubFunctionList: TList<TSubfunction>;
function getKey: TGUID;
public
  // constructor Create();
  procedure Enter(const parameters: TFunctionItemParameters);
  procedure Leave;
  Procedure refresh(const parameters: TFunctionItemParameters);
  procedure ChangeTheme;
  function IsWorkState: Boolean;
  function getDescribe: String;
  function getSubFunctionList: TList<TSubfunction>;
  property key:TGUID read getKey;
  end;

implementation

uses Services, MainFormIntf;

{ TRoleList }

procedure TScheduleplanlogPlugin.ChangeTheme;
begin

end;

procedure TScheduleplanlogPlugin.Enter(const parameters: TFunctionItemParameters);
var subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmScheduleplanlog, FrmScheduleplanlog, self);
end;

function TScheduleplanlogPlugin.getDescribe: String;
begin
  Result := '系统管理模块--班次计划日志查询';
end;

function TScheduleplanlogPlugin.getKey: TGUID;
begin
  Result := StringToGUID('{A5245870-3CC5-4EFD-8655-C7EF469495C7}');
end;

function TScheduleplanlogPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TScheduleplanlogPlugin.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TScheduleplanlogPlugin.Leave;
begin

end;

procedure TScheduleplanlogPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.

