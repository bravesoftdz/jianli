unit ScheduleSelltickettypePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmScheduleSelltickettype,UFrmScheduleSelltickettypeEdit;
type
 selltickettypeMS = class(TInterfacedObject,IFunctionItem)
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

procedure selltickettypeMS.ChangeTheme;
begin

end;

procedure selltickettypeMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmScheduleSelltickettype,frmScheduleSelltickettype,self);
end;

constructor selltickettypeMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function selltickettypeMS.getDescribe: String;
begin
  Result:='业务管理--班次预售票种控制';
end;
function selltickettypeMS.getKey: TGUID;
begin
  Result:=StringToGUID('{A65D8B81-3002-4D61-91D6-5F46668CC095}');
end;

function selltickettypeMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmScheduleSelltickettypeEdit.getSubFunctionList;
end;

function selltickettypeMS.IsWorkState: Boolean;
begin

end;

procedure selltickettypeMS.Leave;
begin

end;

procedure selltickettypeMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
