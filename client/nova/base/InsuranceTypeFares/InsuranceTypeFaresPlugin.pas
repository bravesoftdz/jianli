unit InsuranceTypeFaresPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TFrmInsuranceTypeFaresItems = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmInsuranceTypeFares, MainFormIntf;

{ TFrmUser }

procedure TFrmInsuranceTypeFaresItems.ChangeTheme;
begin

end;

constructor TFrmInsuranceTypeFaresItems.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TFrmInsuranceTypeFaresItems.Enter
  (const parameters: TFunctionItemParameters);
begin
  // FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmInsuranceTypeFares,
    FrmInsuranceTypeFares, self);
end;

function TFrmInsuranceTypeFaresItems.getDescribe: String;
begin
  Result := '保险类型票价';
end;

function TFrmInsuranceTypeFaresItems.getKey: TGUID;
begin
  Result := StringToGUID('{D13DD21F-DA91-46F5-920E-F921A2DEE7A9}');
  // Ctrl+Shift+G生成
end;

function TFrmInsuranceTypeFaresItems.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFrmInsuranceTypeFaresItems.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TFrmInsuranceTypeFaresItems.Leave;
begin

end;

procedure TFrmInsuranceTypeFaresItems.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
