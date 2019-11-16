unit TicketoutletsunssellstationManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketoutletsunssellstationManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketoutletsunsellstation;

{ SysMenuManager }

procedure TTicketoutletsunssellstationManagerExport.ChangeTheme;
begin

end;

constructor TTicketoutletsunssellstationManagerExport.Create;
begin
end;

procedure TTicketoutletsunssellstationManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketstation ,FrmTicketstation,self);
end;

function TTicketoutletsunssellstationManagerExport.getDescribe: String;
begin
  Result:='售票点不可售站点控制';
end;

function TTicketoutletsunssellstationManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{5758DD6C-7DBF-424E-BC2D-ADE2BC20347C}');
end;

function TTicketoutletsunssellstationManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketoutletsunssellstationManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketoutletsunssellstationManagerExport.Leave;
begin

end;

procedure TTicketoutletsunssellstationManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
