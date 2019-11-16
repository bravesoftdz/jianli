{------------------------------------
  功能说明：Ticketoutlet.bpl包插件对象
  创建日期：2011.01.21
  作者：蒋伟
  版权：nova
-------------------------------------}
unit VehiclePlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TVehicleFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmVehicle,MainFormIntf;


{ TFrmUser}

procedure TVehicleFunctionItem.ChangeTheme;
begin

end;

constructor TVehicleFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TVehicleFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmVehicle,FrmVehicle,Self);
end;
function TVehicleFunctionItem.getDescribe: String;
begin
  Result:='车辆信息';
end;

function TVehicleFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{BDA8583C-D45F-43AD-919A-AA11A605C9C1}');
end;

function TVehicleFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TVehicleFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TVehicleFunctionItem.Leave;
begin

end;

procedure TVehicleFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
