unit BilldestroyPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,UFrmBilldestroy;

type
  TBilldestroyPlugin = class(TInterfacedObject, IFunctionItem)
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

uses Services, MainFormIntf;

procedure TBilldestroyPlugin.ChangeTheme;
begin

end;

constructor TBilldestroyPlugin.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBilldestroyPlugin.Enter(const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmBilldestroy, FrmBilldestroy, self);
end;

function TBilldestroyPlugin.getDescribe: String;
begin
  Result := '票据管理-票据废票金额';
end;

function TBilldestroyPlugin.getKey: TGUID;
begin
  Result := StringToGUID('{09731204-2F12-4798-9339-F513F3496BCE}');
end;

function TBilldestroyPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TBilldestroyPlugin.IsWorkState: Boolean;
begin

end;

procedure TBilldestroyPlugin.Leave;
begin

end;

procedure TBilldestroyPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
