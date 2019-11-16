unit SecuritycheckitemManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSecuritycheckitemManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSecuritycheckitem;

{ SysMenuManager }

procedure TSecuritycheckitemManagerExport.ChangeTheme;
begin

end;

constructor TSecuritycheckitemManagerExport.Create;
begin
end;

procedure TSecuritycheckitemManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSecuritycheckitem,FrmSecuritycheckitem,self);
end;

function TSecuritycheckitemManagerExport.getDescribe: String;
begin
  Result:='车辆安检项目';
end;

function TSecuritycheckitemManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{B495CB14-24A9-4D2D-B407-2FEA4698430D}');
end;

function TSecuritycheckitemManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSecuritycheckitemManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSecuritycheckitemManagerExport.Leave;
begin

end;

procedure TSecuritycheckitemManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
