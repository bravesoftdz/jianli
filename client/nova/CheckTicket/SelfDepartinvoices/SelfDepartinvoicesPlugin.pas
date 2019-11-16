unit SelfDepartinvoicesPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf,Generics.Collections,UFrmSelfDepartinvoices;

Type

  TSelfDepartinvoicesItem = class(TInterfacedObject, IFunctionItem)
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
uses Services,MainFormIntf;
{ TScheduleFunctionItem }

procedure TSelfDepartinvoicesItem.ChangeTheme;
begin

end;

constructor TSelfDepartinvoicesItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TSelfDepartinvoicesItem.Enter
  (const parameters: TFunctionItemParameters);

begin
  Services.SysMainForm.ShowForm(TFrmSelfDepartinvoices, FrmSelfDepartinvoices,Self);

end;

function TSelfDepartinvoicesItem.getDescribe: String;
begin
  Result := '×ÔÖú·¢°à';
end;

function TSelfDepartinvoicesItem.getKey: TGUID;
begin
  Result := StringToGUID('{64FF9C1A-B00F-4881-B1FE-4D697CFEDEE8}');
end;

function TSelfDepartinvoicesItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TSelfDepartinvoicesItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TSelfDepartinvoicesItem.Leave;
begin

end;

procedure TSelfDepartinvoicesItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;


end.
