unit SeatreserveManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSeatreserveManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSeatreserve;

{ SysMenuManager }

procedure TSeatreserveManagerExport.ChangeTheme;
begin

end;

constructor TSeatreserveManagerExport.Create;
begin
end;

procedure TSeatreserveManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSeatreserve,FrmSeatreserve,self);
end;

function TSeatreserveManagerExport.getDescribe: String;
begin
  Result:='订票留位信息';
end;

function TSeatreserveManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{F06A57BC-10FA-4B32-A3F2-7FADB61DD264}');
end;

function TSeatreserveManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSeatreserveManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSeatreserveManagerExport.Leave;
begin

end;

procedure TSeatreserveManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
