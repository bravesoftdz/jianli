unit OnecardschedulePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmOnecardschedule,UFrmOnecardscheduleEdit;
type
 onecardscheduleMS = class(TInterfacedObject,IFunctionItem)
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

procedure onecardscheduleMS.ChangeTheme;
begin

end;

procedure onecardscheduleMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmOnecardschedule,frmOnecardschedule,self);
end;

constructor onecardscheduleMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function onecardscheduleMS.getDescribe: String;
begin
  Result:='业务管理--一卡通参与班次控制';
end;
function onecardscheduleMS.getKey: TGUID;
begin
  Result:=StringToGUID('{D6991AD3-5BCC-45C0-BF41-349535F01095}');
end;

function onecardscheduleMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmOnecardscheduleEdit.getSubFunctionList;
end;

function onecardscheduleMS.IsWorkState: Boolean;
begin

end;

procedure onecardscheduleMS.Leave;
begin

end;

procedure onecardscheduleMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
