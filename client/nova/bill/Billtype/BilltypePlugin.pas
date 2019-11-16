{------------------------------------
  功能说明：Billtype.bpl包插件对象
  创建日期：2011.02.15
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BilltypePlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TBilltypeFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmBilltype,MainFormIntf;


{ TFrmUser}

procedure TBilltypeFunctionItem.ChangeTheme;
begin

end;

constructor TBilltypeFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TBilltypeFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmBilltype,FrmBilltype,self);
end;
function TBilltypeFunctionItem.getDescribe: String;
begin
  Result:='票据类型';
end;

function TBilltypeFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{E2FCCD75-4F09-4157-B54D-196D303151DE}');
end;

function TBilltypeFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TBilltypeFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TBilltypeFunctionItem.Leave;
begin

end;

procedure TBilltypeFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
