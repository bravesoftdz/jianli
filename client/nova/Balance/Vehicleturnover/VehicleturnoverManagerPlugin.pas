unit VehicleturnoverManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TVehicleturnoverManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmVehicleturnover;

{ SysMenuManager }

procedure TVehicleturnoverManagerExport.ChangeTheme;
begin

end;

constructor TVehicleturnoverManagerExport.Create;
begin
end;

procedure TVehicleturnoverManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmVehicleturnover,FrmVehicleturnover,self);
end;

function TVehicleturnoverManagerExport.getDescribe: String;
begin
  Result:='车辆预缴款';
end;

function TVehicleturnoverManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{10A6D363-BECB-446C-8F7C-50AF612E0182}');
end;

function TVehicleturnoverManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TVehicleturnoverManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVehicleturnoverManagerExport.Leave;
begin

end;

procedure TVehicleturnoverManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
