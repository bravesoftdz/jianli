unit VehicleReportStatusPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVehicleReportStatus;
type

//车辆报班情况一览表
 vehicleReportStatusManager = class(TInterfacedObject,IFunctionItem)
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

procedure vehicleReportStatusManager.ChangeTheme;
begin

end;

constructor vehicleReportStatusManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure vehicleReportStatusManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmVehicleReportStatus,FrmVehicleReportStatus,self);
end;


function vehicleReportStatusManager.getDescribe: String;
begin
  Result:='车辆报班情况一览表';
end;
function vehicleReportStatusManager.getKey: TGUID;
begin
  Result:=StringToGUID('{324D94AA-2BB2-49CA-961A-C173C5FDB406}');
end;

function vehicleReportStatusManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function vehicleReportStatusManager.IsWorkState: Boolean;
begin

end;

procedure vehicleReportStatusManager.Leave;
begin

end;

procedure vehicleReportStatusManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
