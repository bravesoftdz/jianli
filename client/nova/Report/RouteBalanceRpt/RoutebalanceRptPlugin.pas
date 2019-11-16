unit RouteBalanceRptPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type

  TRouteBalanceRptExport = class(TInterfacedObject, IFunctionItem)
  private
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

uses Services, MainFormIntf, UFrmRouteBalanceRpt;

{ SysMenuManager }

procedure TRouteBalanceRptExport.ChangeTheme;
begin

end;

constructor TRouteBalanceRptExport.Create;
begin
end;

procedure TRouteBalanceRptExport.Enter
  (const parameters: TFunctionItemParameters);
begin
 // Services.SysMainForm.showFormModal(TFrmNetSchedule, nil);
  Services.SysMainForm.ShowForm(TFrmRouteBalanceRpt,FrmRouteBalanceRpt,self);
end;

function TRouteBalanceRptExport.getDescribe: String;
begin
  Result := 'test';
end;

function TRouteBalanceRptExport.getKey: TGUID;
begin
  Result := StringToGUID('{C5A27E76-2F76-417D-AD85-EA297C1D863E}');
end;

function TRouteBalanceRptExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TRouteBalanceRptExport.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TRouteBalanceRptExport.Leave;
begin

end;

procedure TRouteBalanceRptExport.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.



