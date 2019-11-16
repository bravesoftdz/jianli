unit QueryBilldetailReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryBilldetailReport;
type

 routeDynamicCompareManager = class(TInterfacedObject,IFunctionItem)
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

procedure routeDynamicCompareManager.ChangeTheme;
begin

end;

constructor routeDynamicCompareManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure routeDynamicCompareManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryBilldetailReport,frmQueryBilldetailReport,self);
end;


function routeDynamicCompareManager.getDescribe: String;
begin
  Result:='站务分公司使用票证明细帐';
end;
function routeDynamicCompareManager.getKey: TGUID;
begin
  Result:=StringToGUID('{F03BECC8-4E7D-48EB-979C-0CCD43A81696}');
end;

function routeDynamicCompareManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function routeDynamicCompareManager.IsWorkState: Boolean;
begin

end;

procedure routeDynamicCompareManager.Leave;
begin

end;

procedure routeDynamicCompareManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
