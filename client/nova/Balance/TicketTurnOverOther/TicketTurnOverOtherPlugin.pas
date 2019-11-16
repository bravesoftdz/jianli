unit TicketTurnOverOtherPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
  TicketTurnOverOtherFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmTicketTurnOverOther;


{ TTicketSaleFunction }

procedure TicketTurnOverOtherFunction.ChangeTheme;
begin

end;

constructor TicketTurnOverOtherFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TicketTurnOverOtherFunction.Enter(const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmTicketTurnOverOther,FrmTicketTurnOverOther,self);
end;

function TicketTurnOverOtherFunction.getDescribe: String;
begin
  Result:='手工单缴款';
end;

function TicketTurnOverOtherFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{8DACFA3F-E845-4D2E-A1E0-BBF9AF85306D}');
end;

function TicketTurnOverOtherFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TicketTurnOverOtherFunction.IsWorkState: Boolean;
begin

end;

procedure TicketTurnOverOtherFunction.Leave;
begin

end;

procedure TicketTurnOverOtherFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
