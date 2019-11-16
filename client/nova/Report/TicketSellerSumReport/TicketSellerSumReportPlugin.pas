unit TicketSellerSumReportPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketSellerSumReportExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketSellerSumReport;

{ SysMenuManager }

procedure TTicketSellerSumReportExport.ChangeTheme;
begin

end;

constructor TTicketSellerSumReportExport.Create;
begin
end;

procedure TTicketSellerSumReportExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketSellerSumReport, FrmTicketSellerSumReport,self);
end;

function TTicketSellerSumReportExport.getDescribe: String;
begin
  Result:='售票员手工单营收汇总表查询';
end;

function TTicketSellerSumReportExport.getKey: TGUID;
begin
  Result:=StringToGUID('{1C276159-AA52-4387-BB8B-E5274BD7D158}');
end;

function TTicketSellerSumReportExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketSellerSumReportExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketSellerSumReportExport.Leave;
begin

end;

procedure TTicketSellerSumReportExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
