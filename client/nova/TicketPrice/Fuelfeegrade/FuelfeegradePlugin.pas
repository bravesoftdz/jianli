unit FuelfeegradePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TFuelfeegradeFunctionItem = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

implementation

uses Services, UFuelfeegrade, MainFormIntf;

{ TFuelfeegradeFunctionItem }

procedure TFuelfeegradeFunctionItem.ChangeTheme;
begin

end;

constructor TFuelfeegradeFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TFuelfeegradeFunctionItem.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmFuelfeegrade, FrmFuelfeegrade,self);
end;

function TFuelfeegradeFunctionItem.getDescribe: String;
begin
  Result := '»º”Õ∏Ωº”∑—…Ë÷√';
end;

function TFuelfeegradeFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{398017A0-A1F5-41D4-BC0A-5508E452EF85}');
end;

function TFuelfeegradeFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFuelfeegradeFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TFuelfeegradeFunctionItem.Leave;
begin

end;

procedure TFuelfeegradeFunctionItem.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
