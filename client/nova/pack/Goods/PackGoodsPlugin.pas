unit PackGoodsPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackGoodsItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackGoods,MainFormIntf;


{ TFrmUser}

procedure TPackGoodsItem.ChangeTheme;
begin

end;

constructor TPackGoodsItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackGoodsItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackGoods,FrmPackGoods,self);
end;
function TPackGoodsItem.getDescribe: String;
begin
  Result:='小件寄存';
end;

function TPackGoodsItem.getKey: TGUID;
begin
  Result:=StringToGUID('{D3E680CB-761D-4A0A-8A16-BC677C2A8D24}');//Ctrl+Shift+G生成
end;

function TPackGoodsItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackGoodsItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackGoodsItem.Leave;
begin

end;

procedure TPackGoodsItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
