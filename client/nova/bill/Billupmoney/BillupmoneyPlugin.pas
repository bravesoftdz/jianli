unit BillupmoneyPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,
  UFrmBillupmoney;

type
TBillupmoneyPlugin = class(TInterfacedObject, IFunctionItem)
  private FSubFunctionList: TList<TSubfunction>;
function getKey: TGUID;
public
  // constructor Create();
  procedure Enter(const parameters: TFunctionItemParameters);
  procedure Leave;
  Procedure refresh(const parameters: TFunctionItemParameters);
  procedure ChangeTheme;
  function IsWorkState: Boolean;
  function getDescribe: String;
  function getSubFunctionList: TList<TSubfunction>;
  property key:TGUID read getKey;
  end;

implementation

uses Services, MainFormIntf;

{ TRoleList }

procedure TBillupmoneyPlugin.ChangeTheme;
begin

end;

procedure TBillupmoneyPlugin.Enter(const parameters: TFunctionItemParameters);
var subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmBillupmoney, FrmBillupmoney, self);
end;

function TBillupmoneyPlugin.getDescribe: String;
begin
  Result := '票据管理--定额票缴款';
end;

function TBillupmoneyPlugin.getKey: TGUID;
begin
  Result := StringToGUID('{65BE9293-6064-4FA1-AD75-C9A65C301C25}');
end;

function TBillupmoneyPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TBillupmoneyPlugin.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBillupmoneyPlugin.Leave;
begin

end;

procedure TBillupmoneyPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
