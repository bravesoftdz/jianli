unit QryPackDayBalancePlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TFrmQryPackDayBalanceItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQryPackDayBalance,MainFormIntf;


{ TFrmUser}

procedure TFrmQryPackDayBalanceItem.ChangeTheme;
begin

end;

constructor TFrmQryPackDayBalanceItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TFrmQryPackDayBalanceItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQryPackDayBalance,FrmQryPackDayBalance,self);
end;
function TFrmQryPackDayBalanceItem.getDescribe: String;
begin
  Result:='行包日结算表';
end;

function TFrmQryPackDayBalanceItem.getKey: TGUID;
begin
  Result:=StringToGUID('{74939874-26D5-406B-9394-E10EB90C07BC}');//Ctrl+Shift+G生成
end;

function TFrmQryPackDayBalanceItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TFrmQryPackDayBalanceItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TFrmQryPackDayBalanceItem.Leave;
begin

end;

procedure TFrmQryPackDayBalanceItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
