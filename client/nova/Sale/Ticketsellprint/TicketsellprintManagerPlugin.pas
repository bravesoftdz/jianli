unit TicketsellprintManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketsellprintManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketsellprint;

{ SysMenuManager }

procedure TTicketsellprintManagerExport.ChangeTheme;
begin

end;

constructor TTicketsellprintManagerExport.Create;
begin
end;

procedure TTicketsellprintManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketsellprint,FrmTicketsellprint,self);
end;

function TTicketsellprintManagerExport.getDescribe: String;
begin
  Result:='重打车票';
end;

function TTicketsellprintManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{CF5F26C0-BD03-4A6D-ACCA-532EFFEA213A}');
end;

function TTicketsellprintManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketsellprintManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketsellprintManagerExport.Leave;
begin

end;

procedure TTicketsellprintManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
