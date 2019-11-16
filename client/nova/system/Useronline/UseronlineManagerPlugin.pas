unit UseronlineManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TUseronlineManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmUseronline;

{ SysMenuManager }

procedure TUseronlineManagerExport.ChangeTheme;
begin

end;

constructor TUseronlineManagerExport.Create;
begin
end;

procedure TUseronlineManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmUseronline,FrmUseronline,self);
end;

function TUseronlineManagerExport.getDescribe: String;
begin
  Result:='用户在线管理';
end;

function TUseronlineManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{888587B0-4BEB-422A-8624-D76EDC68C12E}');
end;

function TUseronlineManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TUseronlineManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TUseronlineManagerExport.Leave;
begin

end;

procedure TUseronlineManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
