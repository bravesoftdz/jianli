unit StationRouteReportManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TStationRouteReportManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf,UFrmStationRouteReport;

{ SysMenuManager }

procedure TStationRouteReportManagerExport.ChangeTheme;
begin

end;

constructor TStationRouteReportManagerExport.Create;
begin
end;

procedure TStationRouteReportManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmStationRouteReport, FrmStationRouteReport,self);
end;

function TStationRouteReportManagerExport.getDescribe: String;
begin
  Result:='客运班线调查统计表';
end;

function TStationRouteReportManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{DFB3E450-8108-429F-9094-FBF77735D6E9}');
end;

function TStationRouteReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TStationRouteReportManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TStationRouteReportManagerExport.Leave;
begin

end;

procedure TStationRouteReportManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
