unit ViolationManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TViolationManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmVehicleviolation;

{ SysMenuManager }

procedure TViolationManagerExport.ChangeTheme;
begin

end;

constructor TViolationManagerExport.Create;
begin
end;

procedure TViolationManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmVehicleviolation,FrmVehicleviolation,self);
end;

function TViolationManagerExport.getDescribe: String;
begin
  Result:='营运车辆违规处理';
end;

function TViolationManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{AA7A3556-EC72-4CEE-A610-E2A4315398F1}');
end;

function TViolationManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TViolationManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TViolationManagerExport.Leave;
begin

end;

procedure TViolationManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
