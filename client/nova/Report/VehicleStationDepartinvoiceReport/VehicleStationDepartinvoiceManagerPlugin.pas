unit VehicleStationDepartinvoiceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TVehicleStationDepartinvoiceManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmVehicleStationDepartinvoice;

{ SysMenuManager }

procedure TVehicleStationDepartinvoiceManagerExport.ChangeTheme;
begin

end;

constructor TVehicleStationDepartinvoiceManagerExport.Create;
begin
end;

procedure TVehicleStationDepartinvoiceManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmVehicleStationDepartinvoice, FrmVehicleStationDepartinvoice,self);
end;

function TVehicleStationDepartinvoiceManagerExport.getDescribe: String;
begin
  Result:='车辆站点运量情况汇总表';
end;

function TVehicleStationDepartinvoiceManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{1AD47BD6-07A9-4CEE-946F-8A45E0C4D3E6}');
end;

function TVehicleStationDepartinvoiceManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TVehicleStationDepartinvoiceManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVehicleStationDepartinvoiceManagerExport.Leave;
begin

end;

procedure TVehicleStationDepartinvoiceManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
