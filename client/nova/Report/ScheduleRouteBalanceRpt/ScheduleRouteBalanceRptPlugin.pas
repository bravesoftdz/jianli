unit ScheduleRouteBalanceRptPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmScheduleRouteBalanceRpt;
type

//班线结算统计表
 scheduleRouteBalanceRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure scheduleRouteBalanceRptManager.ChangeTheme;
begin

end;

constructor scheduleRouteBalanceRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure scheduleRouteBalanceRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmScheduleRouteBalanceRpt,frmScheduleRouteBalanceRpt,self);
end;


function scheduleRouteBalanceRptManager.getDescribe: String;
begin
  Result:='班线结算统计表';
end;
function scheduleRouteBalanceRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D6B18610-4DE3-4806-807A-FFFA0610C6E1}');
end;

function scheduleRouteBalanceRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function scheduleRouteBalanceRptManager.IsWorkState: Boolean;
begin

end;

procedure scheduleRouteBalanceRptManager.Leave;
begin

end;

procedure scheduleRouteBalanceRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
