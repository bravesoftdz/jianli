unit VipturnoverManagerPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmVipturnover;
type

//发往各省、地客运量日统计表
 VipturnoverManager = class(TInterfacedObject,IFunctionItem)
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

procedure VipturnoverManager.ChangeTheme;
begin

end;

constructor VipturnoverManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure VipturnoverManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmVipturnover,FrmVipturnover,Self,nil,true);
end;


function VipturnoverManager.getDescribe: String;
begin
  Result:='VIP缴款';
end;
function VipturnoverManager.getKey: TGUID;
begin
  Result:=StringToGUID('{1B6D1078-2F3B-4B73-B269-B3AA3A589866}');
end;

function VipturnoverManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function VipturnoverManager.IsWorkState: Boolean;
begin

end;

procedure VipturnoverManager.Leave;
begin

end;

procedure VipturnoverManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
