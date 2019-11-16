unit QueryGoodsPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQueryGoodsItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQueryGoods,MainFormIntf;


{ TFrmUser}

procedure TQueryGoodsItem.ChangeTheme;
begin

end;

constructor TQueryGoodsItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQueryGoodsItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQueryGoods,FrmQueryGoods,self);
end;
function TQueryGoodsItem.getDescribe: String;
begin
  Result:='小件营收统计';
end;

function TQueryGoodsItem.getKey: TGUID;
begin
  Result:=StringToGUID('{726753CF-BE43-43C6-8639-9BE6FC99F7A6}');//Ctrl+Shift+G生成
end;

function TQueryGoodsItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryGoodsItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQueryGoodsItem.Leave;
begin

end;

procedure TQueryGoodsItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
