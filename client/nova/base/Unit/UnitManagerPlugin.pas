unit UnitManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TUnitManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmUnit;

{ SysMenuManager }

procedure TUnitManagerExport.ChangeTheme;
begin

end;

constructor TUnitManagerExport.Create;
begin
end;

procedure TUnitManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmUnit,FrmUnit,self);
end;

function TUnitManagerExport.getDescribe: String;
begin
  Result:='车属单位';
end;

function TUnitManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{144C8962-92E8-4C89-8D08-1748039B4E3F}');
end;

function TUnitManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TUnitManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TUnitManagerExport.Leave;
begin

end;

procedure TUnitManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
