unit InsureReturnPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TInsureReturnFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmInsureReturn,MainFormIntf;


{ TFrmUser}

procedure TInsureReturnFunctionItem.ChangeTheme;
begin

end;

constructor TInsureReturnFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TInsureReturnFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmInsureReturn,FrmInsureReturn,self);
end;
function TInsureReturnFunctionItem.getDescribe: String;
begin
  Result:='∆±÷÷–≈œ¢';
end;

function TInsureReturnFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{B968208D-BE9E-4272-9CE3-C56DF44658F2}');
end;

function TInsureReturnFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TInsureReturnFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TInsureReturnFunctionItem.Leave;
begin

end;

procedure TInsureReturnFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
