unit BillinuseBlanceReportPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBillinuseBlanceReportItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmBillinuseBalanceReort, MainFormIntf;

{ TScheduleFunctionItem }

procedure TBillinuseBlanceReportItem.ChangeTheme;
begin

end;

constructor TBillinuseBlanceReportItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBillinuseBlanceReportItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBillinuseBalanceReort, FrmBillinuseBalanceReort,self);
end;

function TBillinuseBlanceReportItem.getDescribe: String;
begin
  Result := '售票员票据销存报表';
end;

function TBillinuseBlanceReportItem.getKey: TGUID;
begin
  Result := StringToGUID('{66819FD6-D6AC-43A8-8F5A-49CB2E0D184F}');
end;

function TBillinuseBlanceReportItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TBillinuseBlanceReportItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBillinuseBlanceReportItem.Leave;
begin

end;

procedure TBillinuseBlanceReportItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
