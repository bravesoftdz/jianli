unit QueryVehicleStopPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryVehicleStop;
type

//班线发车时间表
 queryVehicleStopManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryVehicleStopManager.ChangeTheme;
begin

end;

constructor queryVehicleStopManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryVehicleStopManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryVehicleStop,frmQueryVehicleStop,self);
end;


function queryVehicleStopManager.getDescribe: String;
begin
  Result:='调度查询--停班班次情况查询';
end;
function queryVehicleStopManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9B15FF65-54C4-4D64-BEC7-F12B6055F996}');
end;

function queryVehicleStopManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryVehicleStopManager.IsWorkState: Boolean;
begin

end;

procedure queryVehicleStopManager.Leave;
begin

end;

procedure queryVehicleStopManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
