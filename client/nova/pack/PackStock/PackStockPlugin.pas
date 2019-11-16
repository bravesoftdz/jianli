unit PackStockPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackStockItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackStock,MainFormIntf;


{ TFrmUser}

procedure TPackStockItem.ChangeTheme;
begin

end;

constructor TPackStockItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackStockItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackStock,FrmPackStock,self);
end;
function TPackStockItem.getDescribe: String;
begin
  Result:='行包库存';
end;

function TPackStockItem.getKey: TGUID;
begin
  Result:=StringToGUID('{CAC994BA-EAA9-4A4A-A323-569309B526A9}');//Ctrl+Shift+G生成
end;

function TPackStockItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackStockItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackStockItem.Leave;
begin

end;

procedure TPackStockItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
