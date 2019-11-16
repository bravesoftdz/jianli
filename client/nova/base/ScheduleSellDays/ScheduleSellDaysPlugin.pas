unit ScheduleSellDaysPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmScheduleSellDays,UFrmScheduleSellDaysEdit;
type
 ScheduleSellDaysMS = class(TInterfacedObject,IFunctionItem)
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

procedure ScheduleSellDaysMS.ChangeTheme;
begin

end;

procedure ScheduleSellDaysMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmScheduleSellDays,frmScheduleSellDays,self);
end;

constructor ScheduleSellDaysMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function ScheduleSellDaysMS.getDescribe: String;
begin
  Result:='业务管理--班次预售天数控制';
end;
function ScheduleSellDaysMS.getKey: TGUID;
begin
  Result:=StringToGUID('{A6C63387-90D0-4E1D-9CCC-3D37720B9459}');
end;

function ScheduleSellDaysMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmScheduleSellDaysEdit.getSubFunctionList;
end;

function ScheduleSellDaysMS.IsWorkState: Boolean;
begin

end;

procedure ScheduleSellDaysMS.Leave;
begin

end;

procedure ScheduleSellDaysMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
