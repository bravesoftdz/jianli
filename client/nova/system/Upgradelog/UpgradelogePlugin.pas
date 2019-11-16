unit UpgradelogePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmUpgradelog;
type
  upgradelog = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
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

procedure upgradelog.ChangeTheme;
begin

end;

procedure upgradelog.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmUpgradelog,frmUpgradelog,self);
end;


function upgradelog.getDescribe: String;
begin
  Result:='系统升级日志';
end;
function upgradelog.getKey: TGUID;
begin
  Result:=StringToGUID('{6F3560B4-03BA-44EF-9585-A07A4F7FE00D}');
end;

function upgradelog.getSubFunctionList: TList<TSubfunction>;
begin

end;

function upgradelog.IsWorkState: Boolean;
begin

end;

procedure upgradelog.Leave;
begin

end;

procedure upgradelog.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
