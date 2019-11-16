unit BilldamagedManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TBilldamagedManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmBilldamageds;

{ SysMenuManager }

procedure TBilldamagedManagerExport.ChangeTheme;
begin

end;

constructor TBilldamagedManagerExport.Create;
begin
end;

procedure TBilldamagedManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmBilldamageds,FrmBilldamageds,self);
end;

function TBilldamagedManagerExport.getDescribe: String;
begin
  Result:='坏票登记';
end;

function TBilldamagedManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{EEA9E89D-953E-49C0-96A5-912D497C4BB2}');
end;

function TBilldamagedManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TBilldamagedManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TBilldamagedManagerExport.Leave;
begin

end;

procedure TBilldamagedManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
