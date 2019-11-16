unit QueryVehicleLostPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryVehicleLost;
type

//班线发车时间表
 queryVehicleLostManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryVehicleLostManager.ChangeTheme;
begin

end;

constructor queryVehicleLostManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryVehicleLostManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryVehicleLost,frmQueryVehicleLost,self);
end;


function queryVehicleLostManager.getDescribe: String;
begin
  Result:='调度查询--脱班班次情况查询';
end;
function queryVehicleLostManager.getKey: TGUID;
begin
  Result:=StringToGUID('{6F387F0F-C9CE-4FD1-B10E-7A36E9C5C7DB}');
end;

function queryVehicleLostManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryVehicleLostManager.IsWorkState: Boolean;
begin

end;

procedure queryVehicleLostManager.Leave;
begin

end;

procedure queryVehicleLostManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
