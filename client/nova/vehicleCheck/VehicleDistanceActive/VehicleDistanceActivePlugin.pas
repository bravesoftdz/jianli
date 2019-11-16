unit VehicleDistanceActivePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVehicleDistanceActive;
type
ActiveManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
//    constructor Create();
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
{  parameterAdd }
procedure ActiveManager.ChangeTheme;
begin

end;

procedure ActiveManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmVehicleDistanceActive,FrmVehicleDistanceActive,Self,parameters,true);
end;

function ActiveManager.getDescribe: String;
begin
  Result:='安检管理--车辆行驶里程限制';
end;
function ActiveManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9F2F834B-F217-452A-BD3B-4A4134E40A79}');
end;

function ActiveManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function ActiveManager.IsWorkState: Boolean;
begin

end;

procedure ActiveManager.Leave;
begin

end;

procedure ActiveManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
