{------------------------------------
  功能说明：Billtype.bpl包插件对象
  创建日期：2011.02.15
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillinventoryPlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TBillinventoryFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmBillinventoryManager,MainFormIntf;


{ TFrmUser}

procedure TBillinventoryFunctionItem.ChangeTheme;
begin

end;

constructor TBillinventoryFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TBillinventoryFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmBillinventoryManager,FrmBillinventoryManager,self);
end;
function TBillinventoryFunctionItem.getDescribe: String;
begin
  Result:='票据库存';
end;

function TBillinventoryFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{7B21D77B-4040-461F-9577-C95725C330B2}');
end;

function TBillinventoryFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TBillinventoryFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TBillinventoryFunctionItem.Leave;
begin

end;

procedure TBillinventoryFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
