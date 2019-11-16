unit TicketoutletStrPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketoutletStrExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketoutletStr;

{ SysMenuManager }

procedure TTicketoutletStrExport.ChangeTheme;
begin

end;

constructor TTicketoutletStrExport.Create;
begin
end;

procedure TTicketoutletStrExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmTicketoutletStr, FrmTicketoutletStr,self);
end;

function TTicketoutletStrExport.getDescribe: String;
begin
  Result:='保险销售明细查询';
end;

function TTicketoutletStrExport.getKey: TGUID;
begin
  Result:=StringToGUID('{089F3486-716C-4E4B-80CF-4D66F9F2AC9F}');
end;

function TTicketoutletStrExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketoutletStrExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketoutletStrExport.Leave;
begin

end;

procedure TTicketoutletStrExport.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
