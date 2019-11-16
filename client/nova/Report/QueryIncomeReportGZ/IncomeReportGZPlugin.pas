unit IncomeReportGZPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmIncomeReportGZ;
type

 GZManagers = class(TInterfacedObject,IFunctionItem)
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

procedure GZManagers.ChangeTheme;
begin

end;

constructor GZManagers.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure GZManagers.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmIncomeReportGZ,frmIncomeReportGZ,self);
end;


function GZManagers.getDescribe: String;
begin
  Result:='财务报表--单位营收统计表-赣州';
end;
function GZManagers.getKey: TGUID;
begin
  Result:=StringToGUID('{16071FA8-221F-4375-B7C0-D3B61B504B80}');
end;

function GZManagers.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function GZManagers.IsWorkState: Boolean;
begin

end;

procedure GZManagers.Leave;
begin

end;

procedure GZManagers.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
