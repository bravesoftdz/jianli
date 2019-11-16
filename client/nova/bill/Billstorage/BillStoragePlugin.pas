{------------------------------------
  功能说明：BillStorage.bpl包插件对象
  创建日期：2011.02.14
  作者：蒋伟
  版权：nova
-------------------------------------}
unit BillStoragePlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TBillStorageFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmBillStorage,MainFormIntf;


{ TFrmUser}

procedure TBillStorageFunctionItem.ChangeTheme;
begin

end;

constructor TBillStorageFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TBillStorageFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmBillStorage,FrmBillStorage,self);
end;
function TBillStorageFunctionItem.getDescribe: String;
begin
  Result:='票库信息';
end;

function TBillStorageFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{6EA87DEA-0036-42CA-9AE8-BF41CD7A07AA}');
end;

function TBillStorageFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TBillStorageFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TBillStorageFunctionItem.Leave;
begin

end;

procedure TBillStorageFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
