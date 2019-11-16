unit VehicleTicketCountPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVehicleTicketCount;
type

//发往各省、地客运量日统计表
 VehicleTicketCountManager = class(TInterfacedObject,IFunctionItem)
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

procedure VehicleTicketCountManager.ChangeTheme;
begin

end;

constructor VehicleTicketCountManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure VehicleTicketCountManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmVehicleTicketCount,FrmVehicleTicketCount,self);
end;


function VehicleTicketCountManager.getDescribe: String;
begin
  Result:='车辆售票流量统计';
end;
function VehicleTicketCountManager.getKey: TGUID;
begin
  Result:=StringToGUID('{3A937783-9855-4658-812E-74ED6497F3A3}');
end;

function VehicleTicketCountManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function VehicleTicketCountManager.IsWorkState: Boolean;
begin

end;

procedure VehicleTicketCountManager.Leave;
begin

end;

procedure VehicleTicketCountManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
