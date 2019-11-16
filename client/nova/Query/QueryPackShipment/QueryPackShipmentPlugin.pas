unit QueryPackShipmentPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQueryPackShipmentItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQueryPackShipment,MainFormIntf;


{ TFrmUser}

procedure TQueryPackShipmentItem.ChangeTheme;
begin

end;

constructor TQueryPackShipmentItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQueryPackShipmentItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQueryPackShipment,FrmQueryPackShipment,self);
end;
function TQueryPackShipmentItem.getDescribe: String;
begin
  Result:='行包发货营收统计';
end;

function TQueryPackShipmentItem.getKey: TGUID;
begin
  Result:=StringToGUID('{A5181DC2-BBDD-4F76-BEB2-2A5208E99A23}');//Ctrl+Shift+G生成
end;

function TQueryPackShipmentItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryPackShipmentItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQueryPackShipmentItem.Leave;
begin

end;

procedure TQueryPackShipmentItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
