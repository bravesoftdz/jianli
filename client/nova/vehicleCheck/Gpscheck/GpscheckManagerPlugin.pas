unit GpscheckManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TGpscheckManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmGpscheck;

{ SysMenuManager }

procedure TGpscheckManagerExport.ChangeTheme;
begin

end;

constructor TGpscheckManagerExport.Create;
begin
end;

procedure TGpscheckManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
//  if parameters<>nil then
//  begin
//    for I := 0 to parameters.Count - 1 do
//      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
//  end;
//  Services.SysMainForm.ShowForm(TFrmGpscheck,FrmGpscheck,self);
  Services.SysMainForm.ShowForm(TfrmGpscheck,frmGpscheck,self,parameters);
end;

function TGpscheckManagerExport.getDescribe: String;
begin
  Result:='GPS检查管理';
end;

function TGpscheckManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{9595273F-2AE2-4990-A543-D6DC7F6A654F}');
end;

function TGpscheckManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
//   Result:=TFrmArea.getSubFunctionList;
end;

function TGpscheckManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TGpscheckManagerExport.Leave;
begin

end;

procedure TGpscheckManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
