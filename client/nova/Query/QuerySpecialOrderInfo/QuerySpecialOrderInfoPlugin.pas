unit QuerySpecialOrderInfoPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQuerySpecialOrderInfo;
type

//班线发车时间表
 QuerySpecialOrderInfoManager = class(TInterfacedObject,IFunctionItem)
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

procedure QuerySpecialOrderInfoManager.ChangeTheme;
begin

end;

constructor QuerySpecialOrderInfoManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure QuerySpecialOrderInfoManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQuerySpecialOrderInfo,frmQuerySpecialOrderInfo,self);
end;


function QuerySpecialOrderInfoManager.getDescribe: String;
begin
  Result:='调度查询--停班班次情况查询';
end;
function QuerySpecialOrderInfoManager.getKey: TGUID;
begin
  Result:=StringToGUID('{36FB9648-F3AF-47F9-BCCF-40934CF36924}');
end;

function QuerySpecialOrderInfoManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function QuerySpecialOrderInfoManager.IsWorkState: Boolean;
begin

end;

procedure QuerySpecialOrderInfoManager.Leave;
begin

end;

procedure QuerySpecialOrderInfoManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
