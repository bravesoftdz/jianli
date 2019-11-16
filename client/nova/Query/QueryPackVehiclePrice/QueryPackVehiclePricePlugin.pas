unit QueryPackVehiclePricePlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQueryPackVehiclePriceItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQueryPackVehiclePrice,MainFormIntf;


{ TFrmUser}

procedure TQueryPackVehiclePriceItem.ChangeTheme;
begin

end;

constructor TQueryPackVehiclePriceItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQueryPackVehiclePriceItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQueryPackVehiclePrice,FrmQueryPackVehiclePrice,self);
end;
function TQueryPackVehiclePriceItem.getDescribe: String;
begin
  Result:='车辆返款统计';
end;

function TQueryPackVehiclePriceItem.getKey: TGUID;
begin
  Result:=StringToGUID('{0BFED298-3356-4992-A41A-99562C65CA48}');//Ctrl+Shift+G生成
end;

function TQueryPackVehiclePriceItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryPackVehiclePriceItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQueryPackVehiclePriceItem.Leave;
begin

end;

procedure TQueryPackVehiclePriceItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
