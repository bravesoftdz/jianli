unit TicketdeliverManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketdeliverManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketdeliver;

{ SysMenuManager }

procedure TTicketdeliverManagerExport.ChangeTheme;
begin

end;

constructor TTicketdeliverManagerExport.Create;
begin
end;

procedure TTicketdeliverManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketdeliver,FrmTicketdeliver,self);
end;

function TTicketdeliverManagerExport.getDescribe: String;
begin
  Result:='送票登记';
end;

function TTicketdeliverManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{B363B07A-F178-4A19-8935-2572AB480AC0}');
end;

function TTicketdeliverManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketdeliverManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketdeliverManagerExport.Leave;
begin

end;

procedure TTicketdeliverManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
