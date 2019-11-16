{------------------------------------
  功能说明：BillStorage.bpl包插件对象
  创建日期：2011.02.14
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillinusePlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TBillinuseFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmBillinuseManager,MainFormIntf;


{ TFrmUser}

procedure TBillinuseFunctionItem.ChangeTheme;
begin

end;

constructor TBillinuseFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TBillinuseFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmBillinuseManager,FrmBillinuseManager,self);
end;
function TBillinuseFunctionItem.getDescribe: String;
begin
  Result:='领用信息';
end;

function TBillinuseFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{BBF5A77B-FB6E-4C27-9A4E-BCDF67F43995}');
end;

function TBillinuseFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TBillinuseFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TBillinuseFunctionItem.Leave;
begin

end;

procedure TBillinuseFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
