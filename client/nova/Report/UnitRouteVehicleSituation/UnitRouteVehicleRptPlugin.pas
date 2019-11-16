unit UnitRouteVehicleRptPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmUnitRouteVehicleRpt;
type

//发班运量统计表
 unitRouteVehicleRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure unitRouteVehicleRptManager.ChangeTheme;
begin

end;

constructor unitRouteVehicleRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure unitRouteVehicleRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmUnitRouteVehicleRpt,frmUnitRouteVehicleRpt,self);
end;


function unitRouteVehicleRptManager.getDescribe: String;
begin
  Result:='发班运量统计表';
end;
function unitRouteVehicleRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{CD4E3D99-FE12-4BD8-B920-09EA39ACD7BA}');
end;

function unitRouteVehicleRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function unitRouteVehicleRptManager.IsWorkState: Boolean;
begin

end;

procedure unitRouteVehicleRptManager.Leave;
begin

end;

procedure unitRouteVehicleRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
