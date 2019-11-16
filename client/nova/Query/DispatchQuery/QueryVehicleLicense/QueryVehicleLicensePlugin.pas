unit QueryVehicleLicensePlugin;

interface
 uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryVehicleLicense;
type

//车辆应班登记表
 TVehcielLicenseManager = class(TInterfacedObject,IFunctionItem)
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
 uses Services, MainFormIntf ;
{ TVehcielLicenseManager }

procedure TVehcielLicenseManager.ChangeTheme;
begin

end;

constructor TVehcielLicenseManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehcielLicenseManager.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmQueryVehicleLicense, FrmQueryVehicleLicense,self);
end;

function TVehcielLicenseManager.getDescribe: String;
begin
  Result:='车辆应班登记表';
end;

function TVehcielLicenseManager.getKey: TGUID;
begin
  Result:=StringToGUID('{376FC0DE-2CBA-49A0-B9B1-4F02AC65055D}');
end;

function TVehcielLicenseManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TVehcielLicenseManager.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVehcielLicenseManager.Leave;
begin

end;

procedure TVehcielLicenseManager.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
