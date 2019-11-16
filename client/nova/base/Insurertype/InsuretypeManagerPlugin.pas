unit InsuretypeManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TInsuretypeManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmInsuretype;

{ SysMenuManager }

procedure TInsuretypeManagerExport.ChangeTheme;
begin

end;

constructor TInsuretypeManagerExport.Create;
begin
end;

procedure TInsuretypeManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmInsuretype,FrmInsuretype,self);
end;

function TInsuretypeManagerExport.getDescribe: String;
begin
  Result:='保险类型';
end;

function TInsuretypeManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{46D651A8-28E8-444C-94A5-8A392A618FD7}');
end;

function TInsuretypeManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInsuretypeManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInsuretypeManagerExport.Leave;
begin

end;

procedure TInsuretypeManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
