unit PackpickPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackpickItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackpick,MainFormIntf;


{ TFrmUser}

procedure TPackpickItem.ChangeTheme;
begin

end;

constructor TPackpickItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackpickItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackpick,FrmPackpick,self);
end;
function TPackpickItem.getDescribe: String;
begin
  Result:='行包提领';
end;

function TPackpickItem.getKey: TGUID;
begin
  Result:=StringToGUID('{CE65532E-ECA2-4FE3-A393-5CE4F402B900}');//Ctrl+Shift+G生成
end;

function TPackpickItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackpickItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackpickItem.Leave;
begin

end;

procedure TPackpickItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
