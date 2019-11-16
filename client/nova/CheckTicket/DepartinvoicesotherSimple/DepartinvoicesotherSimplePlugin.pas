unit DepartinvoicesotherSimplePlugin;



interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmDepartinvoicesotherSimple;

Type
   TDepartinvoicesotherSimpleFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf;


{ TFrmUser}

procedure TDepartinvoicesotherSimpleFunctionItem.ChangeTheme;
begin

end;

constructor TDepartinvoicesotherSimpleFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TDepartinvoicesotherSimpleFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmDepartinvoicesotherSimple,FrmDepartinvoicesotherSimple,self);
  //Services.SysMainForm.ShowForm(TFrmDeductItem, FrmDeductItem,self);
end;
function TDepartinvoicesotherSimpleFunctionItem.getDescribe: String;
begin
  Result:='结算单补录（精简）';
end;

function TDepartinvoicesotherSimpleFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{E70496A0-86C6-4736-BD20-69FD1B9435D0}');//Ctrl+Shift+G生成
end;

function TDepartinvoicesotherSimpleFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDepartinvoicesotherSimpleFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TDepartinvoicesotherSimpleFunctionItem.Leave;
begin

end;

procedure TDepartinvoicesotherSimpleFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
