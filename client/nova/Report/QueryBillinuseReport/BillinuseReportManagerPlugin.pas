unit BillinuseReportManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TBillinuseReportManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmBillinuseReport;

{ SysMenuManager }

procedure TBillinuseReportManagerExport.ChangeTheme;
begin

end;

constructor TBillinuseReportManagerExport.Create;
begin
end;

procedure TBillinuseReportManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmBillinuseReport, FrmBillinuseReport,self);
end;

function TBillinuseReportManagerExport.getDescribe: String;
begin
  Result:='售票员票证使用情况查询';
end;

function TBillinuseReportManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{28864E7C-41DD-4F25-B893-E889ED546BCA}');
end;

function TBillinuseReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TBillinuseReportManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TBillinuseReportManagerExport.Leave;
begin

end;

procedure TBillinuseReportManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
