unit SchedulePeikeReportPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSchedulePeikeReportPlugin=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSchedulepeikeReport;

{ SysMenuManager }

procedure TSchedulePeikeReportPlugin.ChangeTheme;
begin

end;

constructor TSchedulePeikeReportPlugin.Create;
begin
end;

procedure TSchedulePeikeReportPlugin.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  Services.SysMainForm.ShowForm(TFrmSchedulepeikeReport, FrmSchedulepeikeReport,self);
end;

function TSchedulePeikeReportPlugin.getDescribe: String;
begin
  Result:='班次配客情况表';
end;

function TSchedulePeikeReportPlugin.getKey: TGUID;
begin
  Result:=StringToGUID('{873B87BF-14EA-4630-8868-A49B84106685}');
end;

function TSchedulePeikeReportPlugin.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSchedulePeikeReportPlugin.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSchedulePeikeReportPlugin.Leave;
begin

end;

procedure TSchedulePeikeReportPlugin.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
