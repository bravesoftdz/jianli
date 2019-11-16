unit QueryDepartTimePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmQryScheduleDepartTime;
type

//班线发车时间表
 scheduleDepartTimeManager = class(TInterfacedObject,IFunctionItem)
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

procedure scheduleDepartTimeManager.ChangeTheme;
begin

end;

constructor scheduleDepartTimeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure scheduleDepartTimeManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQryScheduleDepartTime,frmQryScheduleDepartTime,self);
end;


function scheduleDepartTimeManager.getDescribe: String;
begin
  Result:='调度查询--客运班线发车时刻表';
end;
function scheduleDepartTimeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{65F8CBFC-1536-4009-8BEB-91FE3B7A4497}');
end;

function scheduleDepartTimeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function scheduleDepartTimeManager.IsWorkState: Boolean;
begin

end;

procedure scheduleDepartTimeManager.Leave;
begin

end;

procedure scheduleDepartTimeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
