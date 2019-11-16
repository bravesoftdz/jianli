unit VehicleStowageReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVehicleStowageReport;
type

//车辆营运配载统计表
 vehicleStowageReportManager = class(TInterfacedObject,IFunctionItem)
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

procedure vehicleStowageReportManager.ChangeTheme;
begin

end;

constructor vehicleStowageReportManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure vehicleStowageReportManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmVehicleStowageReport,frmVehicleStowageReport,self);
end;


function vehicleStowageReportManager.getDescribe: String;
begin
  Result:='车辆营运配载统计表';
end;
function vehicleStowageReportManager.getKey: TGUID;
begin
  Result:=StringToGUID('{A9BEB057-A6A2-472A-A447-47825B47919E}');
end;

function vehicleStowageReportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function vehicleStowageReportManager.IsWorkState: Boolean;
begin

end;

procedure vehicleStowageReportManager.Leave;
begin

end;

procedure vehicleStowageReportManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
