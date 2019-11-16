unit TicketLossPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmTicketLossForm;

Type
   TTicketLossFunctionItem=class(TInterfacedObject,IFunctionItem)
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

procedure TTicketLossFunctionItem.ChangeTheme;
begin

end;

constructor TTicketLossFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TTicketLossFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmTicketLoss,FrmTicketLoss,self);
  //Services.SysMainForm.ShowForm(TFrmDeductItem, FrmDeductItem,self);
end;
function TTicketLossFunctionItem.getDescribe: String;
begin
  Result:='³µÆ±¹ÒÊ§';
end;

function TTicketLossFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{9654EA78-8746-4D66-8C5D-6403FD154D4F}');//Ctrl+Shift+GÉú³É
end;

function TTicketLossFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TTicketLossFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TTicketLossFunctionItem.Leave;
begin

end;

procedure TTicketLossFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
