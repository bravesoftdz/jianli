unit PackacceptPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackacceptItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackaccept,MainFormIntf;


{ TFrmUser}

procedure TPackacceptItem.ChangeTheme;
begin

end;

constructor TPackacceptItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackacceptItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackaccept,FrmPackaccept,self);
end;
function TPackacceptItem.getDescribe: String;
begin
  Result:='行包受理';
end;

function TPackacceptItem.getKey: TGUID;
begin
  Result:=StringToGUID('{B665E7E1-FC16-45A2-822E-00CFB022C002}');//Ctrl+Shift+G生成
end;

function TPackacceptItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackacceptItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackacceptItem.Leave;
begin

end;

procedure TPackacceptItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
