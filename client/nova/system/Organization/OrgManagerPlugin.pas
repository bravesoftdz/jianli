unit OrgManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TOrgManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmOrganization;

{ SysMenuManager }

procedure TOrgManagerExport.ChangeTheme;
begin

end;

constructor TOrgManagerExport.Create;
begin
end;

procedure TOrgManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmOrganization,FrmOrganization,self);
end;

function TOrgManagerExport.getDescribe: String;
begin
  Result:='区域管理';
end;

function TOrgManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{FF6927F5-AE79-46F7-B5D7-9C189DF98365}');
end;

function TOrgManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TOrgManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TOrgManagerExport.Leave;
begin

end;

procedure TOrgManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
