unit paramPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmParameter;
type
TparamManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
//    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;
//             {UFrmParameterFind  }
//  TParameterFind = class(TInterfacedObject,IFunctionItem)
//    private
//    FSubFunctionList:TList<TSubfunction>;
//    function getKey:TGUID;
//  public
////    constructor Create();
//    procedure Enter(const parameters:TFunctionItemParameters);
//    procedure Leave;
//    Procedure refresh(const parameters:TFunctionItemParameters);
//    procedure ChangeTheme;
//    function IsWorkState:Boolean;
//    function getDescribe:String;
//    function getSubFunctionList:TList<TSubfunction>;
//    property key:TGUID read getKey;
//  end;
implementation

uses Services,MainFormIntf;
{  parameterAdd }
procedure TparamManager.ChangeTheme;
begin

end;

procedure TparamManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmParameter,FrmParameter,Self,parameters,true);
end;

function TparamManager.getDescribe: String;
begin
  Result:='系统管理模块--参数设置';
end;
function TparamManager.getKey: TGUID;
begin
  Result:=StringToGUID('{A967BCD7-1092-4694-8F22-71E3DA5FF317}');
end;

function TparamManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TparamManager.IsWorkState: Boolean;
begin

end;

procedure TparamManager.Leave;
begin

end;

procedure TparamManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
//
//{UFrmParameterFind}
//procedure TParameterFind.ChangeTheme;
//begin
//
//end;
//
////constructor TParameterFind.Create;
////begin
////  FSubFunctionList:=TList<TSubfunction>.Create;
////end;
//
//procedure TParameterFind.Enter(const parameters: TFunctionItemParameters);
//var subFunction:TSubFunction;
//begin
//  Services.SysMainForm.ShowForm(TFrmParameterAdd,FrmParameterAdd);
//end;
//
//function TParameterFind.getDescribe: String;
//begin
//  Result:='显于系统参数设置信息';
//end;
//
//function TParameterFind.getKey: TGUID;
//begin
//  Result:=StringToGUID('{8B6A8F8F-E412-426D-B888-78FC133679E0}');
//end;
//
//function TParameterFind.getSubFunctionList: TList<TSubfunction>;
//begin
//  Result:=FSubFunctionList;
//end;
//
//function TParameterFind.IsWorkState: Boolean;
//begin
//
//end;
//
//procedure TParameterFind.Leave;
//begin
//
//end;
//
//procedure TParameterFind.refresh(const parameters: TFunctionItemParameters);
//begin
//
//end;
end.
