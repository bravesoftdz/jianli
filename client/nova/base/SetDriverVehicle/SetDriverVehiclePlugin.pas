unit SetDriverVehiclePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmSetDriverVehicle,
     Forms;

Type
  TSetDriverVehicleFunction=class(TInterfacedObject,IFunctionItem)
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


{ TTicketSaleFunction }

procedure TSetDriverVehicleFunction.ChangeTheme;
begin

end;

constructor TSetDriverVehicleFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSetDriverVehicleFunction.Enter(const parameters: TFunctionItemParameters);
begin

  Services.SysMainForm.ShowForm(TfrmSetDriverVehicle,frmSetDriverVehicle,self);

end;

function TSetDriverVehicleFunction.getDescribe: String;
begin
  Result:='º› ª‘±º› ª≥µ¡æ…Ë÷√';
end;

function TSetDriverVehicleFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{322B24DC-07B5-4F91-ADD8-C70B1221B0C7}');
end;

function TSetDriverVehicleFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TSetDriverVehicleFunction.IsWorkState: Boolean;
begin

end;

procedure TSetDriverVehicleFunction.Leave;
begin

end;

procedure TSetDriverVehicleFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
