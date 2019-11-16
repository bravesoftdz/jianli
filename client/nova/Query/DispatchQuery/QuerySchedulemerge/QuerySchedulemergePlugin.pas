unit QuerySchedulemergePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySchedulemerge;
type

//班线发车时间表
 querySchedulemergeManager = class(TInterfacedObject,IFunctionItem)
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

procedure querySchedulemergeManager.ChangeTheme;
begin

end;

constructor querySchedulemergeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure querySchedulemergeManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySchedulemerge,frmQuerySchedulemerge,self);
end;


function querySchedulemergeManager.getDescribe: String;
begin
  Result:='调度查询--并班情况查询';
end;
function querySchedulemergeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{36E6DD28-4A41-49B2-9ABA-7C67B81E28E2}');
end;

function querySchedulemergeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function querySchedulemergeManager.IsWorkState: Boolean;
begin

end;

procedure querySchedulemergeManager.Leave;
begin

end;

procedure querySchedulemergeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
