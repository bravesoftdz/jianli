unit hirebusacceptPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   ThirebusacceptItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmhirebusaccept,MainFormIntf;


{ TFrmUser}

procedure ThirebusacceptItem.ChangeTheme;
begin

end;

constructor ThirebusacceptItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure ThirebusacceptItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmhirebusaccept,Frmhirebusaccept,self);
end;
function ThirebusacceptItem.getDescribe: String;
begin
  Result:='包车信息';
end;

function ThirebusacceptItem.getKey: TGUID;
begin
  Result:=StringToGUID('{F39823A8-D66C-4422-BF13-C79E8E2ECFE0}');//Ctrl+Shift+G生成
end;

function ThirebusacceptItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function ThirebusacceptItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure ThirebusacceptItem.Leave;
begin

end;

procedure ThirebusacceptItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
