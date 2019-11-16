{------------------------------------
  功能说明：BillAmountDestroy.bpl包插件对象
  创建日期：2011.02.15
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillAmountDestroyPlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,Dialogs;

Type
   TBillAmountDestroyFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmBillAmountDestroy,MainFormIntf;


{ TFrmUser}

procedure TBillAmountDestroyFunctionItem.ChangeTheme;
begin

end;

constructor TBillAmountDestroyFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TBillAmountDestroyFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmBillAmountDestroy,FrmBillAmountDestroy,self);
//  ShowMessage('ssssssssssssss');
end;
function TBillAmountDestroyFunctionItem.getDescribe: String;
begin
  Result:='票据金额核销';
end;

function TBillAmountDestroyFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{28D823BB-4F7F-4A37-9987-67939BE2DD71}');
end;

function TBillAmountDestroyFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TBillAmountDestroyFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TBillAmountDestroyFunctionItem.Leave;
begin

end;

procedure TBillAmountDestroyFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
