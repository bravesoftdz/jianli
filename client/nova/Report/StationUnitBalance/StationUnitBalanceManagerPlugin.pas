unit StationUnitBalanceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TStationUnitBalanceManagerPlugin=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmQryStationUnitBalance;

{ SysMenuManager }

procedure TStationUnitBalanceManagerPlugin.ChangeTheme;
begin

end;

constructor TStationUnitBalanceManagerPlugin.Create;
begin
end;

procedure TStationUnitBalanceManagerPlugin.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  Services.SysMainForm.ShowForm(TFrmQryStationUnitBalance,FrmQryStationUnitBalance,self);
end;

function TStationUnitBalanceManagerPlugin.getDescribe: String;
begin
  Result:='车站各经营单位核算表';
end;

function TStationUnitBalanceManagerPlugin.getKey: TGUID;
begin
  Result:=StringToGUID('{921B5570-13B6-4059-8462-D8BBAF71C2BD}');
end;

function TStationUnitBalanceManagerPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TStationUnitBalanceManagerPlugin.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TStationUnitBalanceManagerPlugin.Leave;
begin

end;

procedure TStationUnitBalanceManagerPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
