unit TicketmixcheckManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketmixcheckManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketmixcheck;

{ SysMenuManager }

procedure TTicketmixcheckManagerExport.ChangeTheme;
begin

end;

constructor TTicketmixcheckManagerExport.Create;
begin
end;

procedure TTicketmixcheckManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketmixcheck, FrmTicketmixcheck,self);
end;

function TTicketmixcheckManagerExport.getDescribe: String;
begin
  Result:='混检查询';
end;

function TTicketmixcheckManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{B4028A2D-D3C5-4A9A-B1FD-8BDE0DA13CB5}');
end;

function TTicketmixcheckManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketmixcheckManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketmixcheckManagerExport.Leave;
begin

end;

procedure TTicketmixcheckManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
