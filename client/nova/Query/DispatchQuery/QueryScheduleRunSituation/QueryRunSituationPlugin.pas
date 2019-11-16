unit QueryRunSituationPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmScheduleRunSituation,UFrmScheduleDayIncome;
type

  //班次运行情况查询
   scheduleRunSituationManager = class(TInterfacedObject,IFunctionItem)
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


    //客运每日班次营收汇总
   TdayscheduleIncomeManager = class(TInterfacedObject,IFunctionItem)
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

procedure scheduleRunSituationManager.ChangeTheme;
begin

end;

constructor scheduleRunSituationManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure scheduleRunSituationManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmScheduleRunSituation,frmScheduleRunSituation,self);
end;


function scheduleRunSituationManager.getDescribe: String;
begin
  Result:='调度查询--客运站班次运营情况';
end;
function scheduleRunSituationManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D937BA09-526C-4957-AD8E-E0FFF52825D2}');
end;

function scheduleRunSituationManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function scheduleRunSituationManager.IsWorkState: Boolean;
begin

end;

procedure scheduleRunSituationManager.Leave;
begin

end;

procedure scheduleRunSituationManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
{ TdayscheduleIncomeManager }

procedure TdayscheduleIncomeManager.ChangeTheme;
begin

end;

constructor TdayscheduleIncomeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure tdayscheduleIncomeManager.Enter(
  const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmScheduleDayIncome,FrmScheduleDayIncome,self);

end;

function TdayscheduleIncomeManager.getDescribe: String;
begin
  Result:=' 客运每日班次营收汇总';
end;

function TdayscheduleIncomeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{4D3C2FF3-3DFD-463F-AC93-78EA7A72AC7F}');
end;

function TdayscheduleIncomeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TdayscheduleIncomeManager.IsWorkState: Boolean;
begin

end;

procedure TdayscheduleIncomeManager.Leave;
begin

end;

procedure TdayscheduleIncomeManager.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
