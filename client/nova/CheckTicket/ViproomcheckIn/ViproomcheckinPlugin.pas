unit ViproomcheckinPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmViproomcheckin,UFrmViproomcheckinEdit;
type
 viproomcheckinMS = class(TInterfacedObject,IFunctionItem)
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

procedure viproomcheckinMS.ChangeTheme;
begin

end;

procedure viproomcheckinMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmViproomcheckin,frmViproomcheckin,self,parameters);
end;

constructor viproomcheckinMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function viproomcheckinMS.getDescribe: String;
begin
  Result:='档案管理--会员进入贵宾室';
end;
function viproomcheckinMS.getKey: TGUID;
begin
  Result:=StringToGUID('{BDCFE691-DC86-4787-ADD8-4BD25152719D}');
end;

function viproomcheckinMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function viproomcheckinMS.IsWorkState: Boolean;
begin

end;

procedure viproomcheckinMS.Leave;
begin

end;

procedure viproomcheckinMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
