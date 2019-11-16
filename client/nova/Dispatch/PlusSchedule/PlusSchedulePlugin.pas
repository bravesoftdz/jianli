unit PlusSchedulePlugin;

{ ------------------------------------
  功能说明：PlusSchedule.bpl插件单元
  创建日期：2011.07.09
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TPlusScheduleItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UPlusSchedule, MainFormIntf;

{ TScheduleFunctionItem }

procedure TPlusScheduleItemFunctionItem.ChangeTheme;
begin

end;

constructor TPlusScheduleItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPlusScheduleItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPlusSchedule, FrmPlusSchedule,self);
end;

function TPlusScheduleItemFunctionItem.getDescribe: String;
begin
  Result := '加班管理';
end;

function TPlusScheduleItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{9B3C7950-1FB0-4431-95FA-9F2577CFEB9B}');
end;

function TPlusScheduleItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TPlusScheduleItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPlusScheduleItemFunctionItem.Leave;
begin

end;

procedure TPlusScheduleItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
