unit QueryVehicleLatePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryVehicleLate;
type

//班线发车时间表
 queryVehicleLateManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryVehicleLateManager.ChangeTheme;
begin

end;

constructor queryVehicleLateManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryVehicleLateManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryVehicleLate,frmQueryVehicleLate,self);
end;


function queryVehicleLateManager.getDescribe: String;
begin
  Result:='调度查询--晚点班次情况查询';
end;
function queryVehicleLateManager.getKey: TGUID;
begin
  Result:=StringToGUID('{350FFD44-4E24-40F1-AC9A-FBA3E969C106}');
end;

function queryVehicleLateManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryVehicleLateManager.IsWorkState: Boolean;
begin

end;

procedure queryVehicleLateManager.Leave;
begin

end;

procedure queryVehicleLateManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
