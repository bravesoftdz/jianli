unit SchedulestationcontrolPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmSchedulestationcontrol,UFrmSchedulestationcontrolEdit;
type
 schedulestationcontrolMS = class(TInterfacedObject,IFunctionItem)
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

procedure schedulestationcontrolMS.ChangeTheme;
begin

end;

procedure schedulestationcontrolMS.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSchedulestationcontrol,frmSchedulestationcontrol,self);
end;

constructor schedulestationcontrolMS.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function schedulestationcontrolMS.getDescribe: String;
begin
  Result:='业务管理--班次站点售票控制';
end;
function schedulestationcontrolMS.getKey: TGUID;
begin
  Result:=StringToGUID('{51490F9B-405E-4FB8-A2BE-0A7D2A73206D}');
end;

function schedulestationcontrolMS.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmSchedulestationcontrolEdit.getSubFunctionList;
end;

function schedulestationcontrolMS.IsWorkState: Boolean;
begin

end;

procedure schedulestationcontrolMS.Leave;
begin

end;

procedure schedulestationcontrolMS.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
