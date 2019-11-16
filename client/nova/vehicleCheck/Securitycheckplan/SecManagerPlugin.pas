unit SecManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSecManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSecuritycheckplan;

{ SysMenuManager }

procedure TSecManagerExport.ChangeTheme;
begin

end;

constructor TSecManagerExport.Create;
begin
end;

procedure TSecManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSec,FrmSec,self);
end;

function TSecManagerExport.getDescribe: String;
begin
  Result:='安检计划';
end;

function TSecManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{41FC8438-E55B-4C1D-B673-3C0A9D5BF4CE}');
end;

function TSecManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSecManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSecManagerExport.Leave;
begin

end;

procedure TSecManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
