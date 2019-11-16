unit ScheduleOperationReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmScheduleOperationReport;
type

//班线运营情况汇总表
 scheduleOperationManager = class(TInterfacedObject,IFunctionItem)
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

procedure scheduleOperationManager.ChangeTheme;
begin

end;

constructor scheduleOperationManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure scheduleOperationManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmScheduleOperationReport,FrmScheduleOperationReport,self);
end;


function scheduleOperationManager.getDescribe: String;
begin
  Result:='班线运营情况汇总表';
end;
function scheduleOperationManager.getKey: TGUID;
begin
  Result:=StringToGUID('{38B2D5ED-DAE9-4B2F-AFDB-88C199CC12BC}');
end;

function scheduleOperationManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function scheduleOperationManager.IsWorkState: Boolean;
begin

end;

procedure scheduleOperationManager.Leave;
begin

end;

procedure scheduleOperationManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
