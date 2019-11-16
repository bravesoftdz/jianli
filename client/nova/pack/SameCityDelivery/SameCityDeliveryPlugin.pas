unit SameCityDeliveryPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TSameCityDeliveryFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmSameCityDelivery,MainFormIntf;


{ TFrmUser}

procedure TSameCityDeliveryFunctionItem.ChangeTheme;
begin

end;

constructor TSameCityDeliveryFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TSameCityDeliveryFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmSameCityDeliveryForm,FrmSameCityDeliveryForm,self);
  //Services.SysMainForm.ShowForm(TFrmDeductItem, FrmDeductItem,self);
end;
function TSameCityDeliveryFunctionItem.getDescribe: String;
begin
  Result:='同城送货';
end;

function TSameCityDeliveryFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{2E7B79F7-CA51-4376-9E92-08C3AB95F174}');//Ctrl+Shift+G生成
end;

function TSameCityDeliveryFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TSameCityDeliveryFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TSameCityDeliveryFunctionItem.Leave;
begin

end;

procedure TSameCityDeliveryFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
