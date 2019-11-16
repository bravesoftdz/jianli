unit SchedulePlugin;

{ ------------------------------------
  功能说明：schedule.bpl包插件对象
  创建日期：2011.01.28
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TScheduleFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmSchedule, MainFormIntf;

{ TScheduleFunctionItem }

procedure TScheduleFunctionItem.ChangeTheme;
begin

end;

constructor TScheduleFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TScheduleFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmScheduel, FrmScheduel,self);
end;

function TScheduleFunctionItem.getDescribe: String;
begin
  Result := '班次信息----------------';
end;

function TScheduleFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{84AE3648-EADE-4C93-9FA2-A9A0D1EC1E0F}');
end;

function TScheduleFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TScheduleFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TScheduleFunctionItem.Leave;
begin

end;

procedure TScheduleFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
