unit InsurersManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TInsurersManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmInsurer;

{ SysMenuManager }

procedure TInsurersManagerExport.ChangeTheme;
begin

end;

constructor TInsurersManagerExport.Create;
begin
end;

procedure TInsurersManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmInsurers,FrmInsurers,self);
end;

function TInsurersManagerExport.getDescribe: String;
begin
  Result:='保险公司';
end;

function TInsurersManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{8E3C53B5-3DCF-451C-9DFE-ED31DCBBA2B4}');
end;

function TInsurersManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInsurersManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInsurersManagerExport.Leave;
begin

end;

procedure TInsurersManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
