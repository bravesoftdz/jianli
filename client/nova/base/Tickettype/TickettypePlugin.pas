{------------------------------------
  功能说明：ticketoutlet.bpl包插件对象
  创建日期：2011.01.21
  作者：蒋伟
  版权：nova
-------------------------------------}
unit TickettypePlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TTickettypeFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmTickettype,MainFormIntf;


{ TFrmUser}

procedure TTickettypeFunctionItem.ChangeTheme;
begin

end;

constructor TTickettypeFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TTickettypeFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmTickettype,FrmTickettype,self);
end;
function TTickettypeFunctionItem.getDescribe: String;
begin
  Result:='票种信息';
end;

function TTickettypeFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{1CF1DE8F-6C8A-46FC-9637-E55440B095D0}');
end;

function TTickettypeFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TTickettypeFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TTickettypeFunctionItem.Leave;
begin

end;

procedure TTickettypeFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
