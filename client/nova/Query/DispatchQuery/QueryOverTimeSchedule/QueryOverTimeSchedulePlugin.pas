unit QueryOverTimeSchedulePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmOverTimeSchedule;
type

  //班次运行情况查询
   overTimeScheduleManager = class(TInterfacedObject,IFunctionItem)
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

//班次运行情况查询

procedure overTimeScheduleManager.ChangeTheme;
begin

end;

constructor overTimeScheduleManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure overTimeScheduleManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmOverTimeSchedule,frmOverTimeSchedule,self);
end;


function overTimeScheduleManager.getDescribe: String;
begin
  Result:='调度查询--客运站班次加班呢情况';
end;
function overTimeScheduleManager.getKey: TGUID;
begin
  Result:=StringToGUID('{12D1899F-A3DB-47FE-9908-F0F633553F45}');
end;

function overTimeScheduleManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function overTimeScheduleManager.IsWorkState: Boolean;
begin

end;

procedure overTimeScheduleManager.Leave;
begin

end;

procedure overTimeScheduleManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
