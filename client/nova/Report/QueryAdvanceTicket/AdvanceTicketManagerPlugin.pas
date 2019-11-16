unit AdvanceTicketManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TAdvanceTicketManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmAdvanceTicket;

{ SysMenuManager }

procedure TAdvanceTicketManagerExport.ChangeTheme;
begin

end;

constructor TAdvanceTicketManagerExport.Create;
begin
end;

procedure TAdvanceTicketManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmAdvanceTicket, FrmAdvanceTicket,self);
end;

function TAdvanceTicketManagerExport.getDescribe: String;
begin
  Result:='预售票情况查询';
end;

function TAdvanceTicketManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{717B8412-EF7D-45C1-B9AD-51FE51AE18CE}');
end;

function TAdvanceTicketManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TAdvanceTicketManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TAdvanceTicketManagerExport.Leave;
begin

end;

procedure TAdvanceTicketManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
