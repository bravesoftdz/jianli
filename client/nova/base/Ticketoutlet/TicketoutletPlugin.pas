{------------------------------------
  功能说明：Ticketoutlet.bpl包插件对象
  创建日期：2011.01.21
  作者：蒋伟
  版权：nova
-------------------------------------}
unit TicketoutletPlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TTicketoutletFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmTicketoutlet,MainFormIntf;


{ TFrmUser}

procedure TticketoutletFunctionItem.ChangeTheme;
begin

end;

constructor TticketoutletFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TticketoutletFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmTicketoutlet,FrmTicketoutlet,self);
end;
function TticketoutletFunctionItem.getDescribe: String;
begin
  Result:='售票点管理';
end;

function TticketoutletFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{8FBB64E2-FF9C-4B3C-BEE7-6F4A2C4C0C0F}');
end;

function TticketoutletFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TticketoutletFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TticketoutletFunctionItem.Leave;
begin

end;

procedure TticketoutletFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
