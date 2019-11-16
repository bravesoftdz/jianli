unit PrintItemSetPlugin;

interface


uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TPrintItemSetFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmPrintItemSet, MainFormIntf;

{ TScheduleFunctionItem }

procedure TPrintItemSetFunctionItem.ChangeTheme;
begin

end;

constructor TPrintItemSetFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPrintItemSetFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPrintItemSet, FrmPrintItemSet);
end;

function TPrintItemSetFunctionItem.getDescribe: String;
begin
  Result := '不打印项目设置';
end;

function TPrintItemSetFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{4A0EAB42-841E-4932-9575-FAA0DAE784A6}');
end;

function TPrintItemSetFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TPrintItemSetFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPrintItemSetFunctionItem.Leave;
begin

end;

procedure TPrintItemSetFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
