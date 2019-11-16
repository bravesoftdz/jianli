unit PackWarehousingPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackWarehousingItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackWarehousing,MainFormIntf;


{ TFrmUser}

procedure TPackWarehousingItem.ChangeTheme;
begin

end;

constructor TPackWarehousingItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackWarehousingItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackWarehousing,FrmPackWarehousing,self);
end;
function TPackWarehousingItem.getDescribe: String;
begin
  Result:='到货入仓';
end;

function TPackWarehousingItem.getKey: TGUID;
begin
  Result:=StringToGUID('{FE5FD31E-6C5E-4039-8CC6-DA3B9D79AD4A}');//Ctrl+Shift+G生成
end;

function TPackWarehousingItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackWarehousingItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackWarehousingItem.Leave;
begin

end;

procedure TPackWarehousingItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
