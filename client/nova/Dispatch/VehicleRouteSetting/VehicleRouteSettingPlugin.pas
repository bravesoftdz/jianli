unit VehicleRouteSettingPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TFrmVehicleRouteSettingItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmVehicleRouteSetting,MainFormIntf;


{ TFrmUser}

procedure TFrmVehicleRouteSettingItem.ChangeTheme;
begin

end;

constructor TFrmVehicleRouteSettingItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TFrmVehicleRouteSettingItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmVehicleRouteSetting,FrmVehicleRouteSetting,self);
end;
function TFrmVehicleRouteSettingItem.getDescribe: String;
begin
  Result:='车辆运营线路设置';
end;

function TFrmVehicleRouteSettingItem.getKey: TGUID;
begin
  Result:=StringToGUID('{C1591827-4528-429E-B027-29EA6495ED4C}');//Ctrl+Shift+G生成
end;

function TFrmVehicleRouteSettingItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TFrmVehicleRouteSettingItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TFrmVehicleRouteSettingItem.Leave;
begin

end;

procedure TFrmVehicleRouteSettingItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
