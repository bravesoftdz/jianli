unit TicketoutletsSellReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmTicketoutletsSellReport;
type

   ticketoutletsSellMS = class(TInterfacedObject,IFunctionItem)
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


//车辆划拨汇总表
{ TVehicleIncome }

procedure ticketoutletsSellMS.ChangeTheme;
begin

end;

constructor ticketoutletsSellMS.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ticketoutletsSellMS.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmTicketoutletsSellReport,FrmTicketoutletsSellReport,self);
end;

function ticketoutletsSellMS.getDescribe: String;
begin
   result:='售票点班线售票情况表';
end;

function ticketoutletsSellMS.getKey: TGUID;
begin
  Result:=StringToGUID('{40162ACF-8260-4764-B18B-05B4F8B91CA4}');
end;

function ticketoutletsSellMS.getSubFunctionList: TList<TSubfunction>;
begin
    Result := FSubFunctionList;
end;

function ticketoutletsSellMS.IsWorkState: Boolean;
begin

end;

procedure ticketoutletsSellMS.Leave;
begin

end;

procedure ticketoutletsSellMS.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
