unit OrgdayneedBalanceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TOrgdayneedBalanceManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmOrgdayneedBalance;

{ SysMenuManager }

procedure TOrgdayneedBalanceManagerExport.ChangeTheme;
begin

end;

constructor TOrgdayneedBalanceManagerExport.Create;
begin
end;

procedure TOrgdayneedBalanceManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmOrgdayneedBalance, FrmOrgdayneedBalance, self);
end;

function TOrgdayneedBalanceManagerExport.getDescribe: String;
begin
  Result:='机构每日结算';
end;

function TOrgdayneedBalanceManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{D0A80BFE-9B88-4923-A426-01B8AF7DBE8A}');
end;

function TOrgdayneedBalanceManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TOrgdayneedBalanceManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TOrgdayneedBalanceManagerExport.Leave;
begin

end;

procedure TOrgdayneedBalanceManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
