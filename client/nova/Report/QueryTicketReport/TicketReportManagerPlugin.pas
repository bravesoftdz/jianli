unit TicketReportManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketReportManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketReport;

{ SysMenuManager }

procedure TTicketReportManagerExport.ChangeTheme;
begin

end;

constructor TTicketReportManagerExport.Create;
begin
end;

procedure TTicketReportManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  Services.SysMainForm.ShowForm(TFrmTicketReport, FrmTicketReport,self);
end;

function TTicketReportManagerExport.getDescribe: String;
begin
  Result:='车票使用汇总表';
end;

function TTicketReportManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{FBCFCE98-2EE2-4198-A03E-41D4E76641D6}');
end;

function TTicketReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketReportManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketReportManagerExport.Leave;
begin

end;

procedure TTicketReportManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
