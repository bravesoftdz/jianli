unit StationPricePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmStationPriceEdit,UFrmStationPrice;
type
 StationpriceManager = class(TInterfacedObject,IFunctionItem)
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

procedure StationpriceManager.ChangeTheme;
begin

end;

constructor StationpriceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure StationpriceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmStationPrice,frmStationPrice,self);
end;


function StationpriceManager.getDescribe: String;
begin
  Result:='票价管理--站点平时票价管理';
end;
function StationpriceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{3B0984CB-9199-42B6-A366-7FE1D63FA403}');
end;

function StationpriceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function StationpriceManager.IsWorkState: Boolean;
begin

end;

procedure StationpriceManager.Leave;
begin

end;

procedure StationpriceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
