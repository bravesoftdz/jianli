unit SellReturnTicketManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSellReturnTicketManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmSellReturnTicket;

{ SysMenuManager }

procedure TSellReturnTicketManagerExport.ChangeTheme;
begin

end;

constructor TSellReturnTicketManagerExport.Create;
begin
end;

procedure TSellReturnTicketManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSellReturnTicket,FrmSellReturnTicket,self);
end;

function TSellReturnTicketManagerExport.getDescribe: String;
begin
  Result:='网购对账报表';
end;

function TSellReturnTicketManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{27651486-AB14-430C-90DA-0FFADA0C09B9}');
end;

function TSellReturnTicketManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSellReturnTicketManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSellReturnTicketManagerExport.Leave;
begin

end;

procedure TSellReturnTicketManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
