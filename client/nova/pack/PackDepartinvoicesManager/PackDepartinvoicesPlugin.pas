unit PackDepartinvoicesPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TPackDepartinvoicesPlugin = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmPackDepartinvoices, MainFormIntf;

{ TScheduleFunctionItem }

procedure TPackDepartinvoicesPlugin.ChangeTheme;
begin

end;

constructor TPackDepartinvoicesPlugin.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPackDepartinvoicesPlugin.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPackDepartinvoices, FrmPackDepartinvoices,self);
end;

function TPackDepartinvoicesPlugin.getDescribe: String;
begin
  Result := '行包结算单管理';
end;

function TPackDepartinvoicesPlugin.getKey: TGUID;
begin
  Result := StringToGUID('{761EBB2F-A4A4-49C5-9E0D-C474EE02866A}');
end;

function TPackDepartinvoicesPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TPackDepartinvoicesPlugin.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPackDepartinvoicesPlugin.Leave;
begin

end;

procedure TPackDepartinvoicesPlugin.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
