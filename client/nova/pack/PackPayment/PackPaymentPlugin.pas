unit PackPaymentPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TPackPaymentItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackPayment,MainFormIntf;


{ TFrmUser}

procedure TPackPaymentItem.ChangeTheme;
begin

end;

constructor TPackPaymentItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TPackPaymentItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackPayment,FrmPackPayment,self);
end;
function TPackPaymentItem.getDescribe: String;
begin
  Result:='行包缴款';
end;

function TPackPaymentItem.getKey: TGUID;
begin
  Result:=StringToGUID('{9C5D0DCD-A93D-4067-9980-B09EDB1C483F}');//Ctrl+Shift+G生成
end;

function TPackPaymentItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPackPaymentItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPackPaymentItem.Leave;
begin

end;

procedure TPackPaymentItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
