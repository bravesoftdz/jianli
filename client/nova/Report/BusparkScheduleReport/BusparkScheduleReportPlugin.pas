unit BusparkScheduleReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmBusparkScheduleReport;
type


  TBusparkScheduleReport = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
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

uses Services,MainFormIntf;

{ TBusparkScheduleReport }

procedure TBusparkScheduleReport.ChangeTheme;
begin

end;

constructor TBusparkScheduleReport.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TBusparkScheduleReport.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBusparkScheduleReport,FrmBusparkScheduleReport,self);
end;

function TBusparkScheduleReport.getDescribe: String;
begin
  result:='³µ¿â·¢°à±í';
end;

function TBusparkScheduleReport.getKey: TGUID;
begin
  Result:=StringToGUID('{4BD26147-C1EF-420F-BDA3-1ED2B2AF5D2F}');
end;

function TBusparkScheduleReport.getSubFunctionList: TList<TSubfunction>;
begin
   Result := FSubFunctionList;
end;

function TBusparkScheduleReport.IsWorkState: Boolean;
begin

end;

procedure TBusparkScheduleReport.Leave;
begin

end;

procedure TBusparkScheduleReport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
