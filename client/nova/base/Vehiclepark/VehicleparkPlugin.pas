unit VehicleparkPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVehiclepark,UFrmVehicleparkEdit;
type
 vehiclepark = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
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

procedure vehiclepark.ChangeTheme;
begin

end;

procedure vehiclepark.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmVehiclepark,frmVehiclepark,self);
end;

function vehiclepark.getDescribe: String;
begin
  Result:='业务管理模块--上车卡位设置';
end;
function vehiclepark.getKey: TGUID;
begin
  Result:=StringToGUID('{4165B9F0-396C-4C40-9D2B-89D273076CD1}');
end;

function vehiclepark.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmVehicleparkEdit.getSubFunctionList;
end;

function vehiclepark.IsWorkState: Boolean;
begin

end;

procedure vehiclepark.Leave;
begin

end;

procedure vehiclepark.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
