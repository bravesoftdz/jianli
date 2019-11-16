unit QryCheckWorkMonthPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQryCheckWorkMonthPluginItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQryCheckWorkMonth,MainFormIntf;


{ TFrmUser}

procedure TQryCheckWorkMonthPluginItem.ChangeTheme;
begin

end;

constructor TQryCheckWorkMonthPluginItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQryCheckWorkMonthPluginItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQryCheckWorkMonth,FrmQryCheckWorkMonth,self);
end;
function TQryCheckWorkMonthPluginItem.getDescribe: String;
begin
  Result:='检票工作月报';
end;

function TQryCheckWorkMonthPluginItem.getKey: TGUID;
begin
  Result:=StringToGUID('{36435346-832D-446F-A668-E6728A82E9A7}');//Ctrl+Shift+G生成
end;

function TQryCheckWorkMonthPluginItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQryCheckWorkMonthPluginItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQryCheckWorkMonthPluginItem.Leave;
begin

end;

procedure TQryCheckWorkMonthPluginItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
