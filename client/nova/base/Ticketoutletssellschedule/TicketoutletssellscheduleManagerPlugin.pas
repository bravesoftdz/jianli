unit TicketoutletssellscheduleManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketoutletssellscheduleManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketoutletssellschedule;

{ SysMenuManager }

procedure TTicketoutletssellscheduleManagerExport.ChangeTheme;
begin

end;

constructor TTicketoutletssellscheduleManagerExport.Create;
begin
end;

procedure TTicketoutletssellscheduleManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketoutlet,FrmTicketoutlet,self);
end;

function TTicketoutletssellscheduleManagerExport.getDescribe: String;
begin
  Result:='售票点可售班次控制';
end;

function TTicketoutletssellscheduleManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{F79279B1-E973-41F3-9BDD-D035505FE31E}');
end;

function TTicketoutletssellscheduleManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketoutletssellscheduleManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketoutletssellscheduleManagerExport.Leave;
begin

end;

procedure TTicketoutletssellscheduleManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
