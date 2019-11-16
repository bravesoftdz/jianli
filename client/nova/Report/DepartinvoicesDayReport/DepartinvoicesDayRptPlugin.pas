unit DepartinvoicesDayRptPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmDepartinvoicesDayReport;
type

//发往各省、地客运量日统计表
 DepartinvoicesDayRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure DepartinvoicesDayRptManager.ChangeTheme;
begin

end;

constructor DepartinvoicesDayRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure DepartinvoicesDayRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmDepartinvoicesDayReport,FrmDepartinvoicesDayReport,self);
end;


function DepartinvoicesDayRptManager.getDescribe: String;
begin
  Result:='发往各省、地客运量日统计表';
end;
function DepartinvoicesDayRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{491CBDCD-4FFD-4D71-9136-F36D3E4A6E49}');
end;

function DepartinvoicesDayRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function DepartinvoicesDayRptManager.IsWorkState: Boolean;
begin

end;

procedure DepartinvoicesDayRptManager.Leave;
begin

end;

procedure DepartinvoicesDayRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
