unit PackfeePlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackfeeItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackfee,MainFormIntf;


{ TFrmUser}

procedure TPackfeeItem.ChangeTheme;
begin

end;

constructor TPackfeeItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackfeeItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackfee,FrmPackfee,self);
end;
function TPackfeeItem.getDescribe: String;
begin
  Result:='收费标准设置';
end;

function TPackfeeItem.getKey: TGUID;
begin
  Result:=StringToGUID('{9AD9A7EC-5C40-42CB-AAF5-B2D4E5AAFC01}');//Ctrl+Shift+G生成
end;

function TPackfeeItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackfeeItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackfeeItem.Leave;
begin

end;

procedure TPackfeeItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
