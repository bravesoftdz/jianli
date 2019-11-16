unit InitManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TInitManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmInitcard;

{ SysMenuManager }

procedure TInitManagerExport.ChangeTheme;
begin

end;

constructor TInitManagerExport.Create;
begin
end;

procedure TInitManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmInit,FrmInit,self);
end;

function TInitManagerExport.getDescribe: String;
begin
  Result:='智能卡管理';
end;

function TInitManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{0978EF66-E587-4771-8995-EBDF0FA42DA6}');
end;

function TInitManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInitManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInitManagerExport.Leave;
begin

end;

procedure TInitManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
