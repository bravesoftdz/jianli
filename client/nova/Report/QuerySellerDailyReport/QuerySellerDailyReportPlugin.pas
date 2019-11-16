unit QuerySellerDailyReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySellerDailyReport;
type

//班线发车时间表
 dailyReportManager = class(TInterfacedObject,IFunctionItem)
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

procedure dailyReportManager.ChangeTheme;
begin

end;

constructor dailyReportManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure dailyReportManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySellerDailyReport,frmQuerySellerDailyReport,self);
end;


function dailyReportManager.getDescribe: String;
begin
  Result:='财务人员--售票员营收情况日报表';
end;
function dailyReportManager.getKey: TGUID;
begin
  Result:=StringToGUID('{8F9E3669-D685-46B4-8973-9BF4741A6FB3}');
end;

function dailyReportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function dailyReportManager.IsWorkState: Boolean;
begin

end;

procedure dailyReportManager.Leave;
begin

end;

procedure dailyReportManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
