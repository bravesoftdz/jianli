unit QueryVehicleReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryVehicleReport;
type

//班线发车时间表
 queryVehicleReportManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryVehicleReportManager.ChangeTheme;
begin

end;

constructor queryVehicleReportManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryVehicleReportManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryVehicleReport,frmQueryVehicleReport,self);
end;


function queryVehicleReportManager.getDescribe: String;
begin
  Result:='检票查询--班次报班情况查询';
end;
function queryVehicleReportManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D7ABAC5A-8135-458C-96D2-7D0AFDF74B5A}');
end;

function queryVehicleReportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryVehicleReportManager.IsWorkState: Boolean;
begin

end;

procedure queryVehicleReportManager.Leave;
begin

end;

procedure queryVehicleReportManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
