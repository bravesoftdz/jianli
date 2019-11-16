unit VehicletypeManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TVehicletypeManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmVehicletype;

{ SysMenuManager }

procedure TVehicletypeManagerExport.ChangeTheme;
begin

end;

constructor TVehicletypeManagerExport.Create;
begin
end;

procedure TVehicletypeManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmVehicletype,FrmVehicletype,self);
end;

function TVehicletypeManagerExport.getDescribe: String;
begin
  Result:='车型管理';
end;

function TVehicletypeManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{374BE5C7-E587-42D9-AEB2-B1D277390FC9}');
end;

function TVehicletypeManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TVehicletypeManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVehicletypeManagerExport.Leave;
begin

end;

procedure TVehicletypeManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
