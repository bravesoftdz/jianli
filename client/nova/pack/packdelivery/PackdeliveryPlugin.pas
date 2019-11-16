unit PackdeliveryPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackdeliveryItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackdelivery,MainFormIntf;


{ TFrmUser}

procedure TPackdeliveryItem.ChangeTheme;
begin

end;

constructor TPackdeliveryItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackdeliveryItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackdelivery,FrmPackdelivery,self);
end;
function TPackdeliveryItem.getDescribe: String;
begin
  Result:='同城送货';
end;

function TPackdeliveryItem.getKey: TGUID;
begin
  Result:=StringToGUID('{663BB510-FF7E-41D4-9AC1-EF8A6FCA95F9}');//Ctrl+Shift+G生成
end;

function TPackdeliveryItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackdeliveryItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackdeliveryItem.Leave;
begin

end;

procedure TPackdeliveryItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
