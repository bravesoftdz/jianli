unit SchedulemergeManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSchedulemergeManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSchedulemerge;

{ SysMenuManager }

procedure TSchedulemergeManagerExport.ChangeTheme;
begin

end;

constructor TSchedulemergeManagerExport.Create;
begin
end;

procedure TSchedulemergeManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSchedulemerge,FrmSchedulemerge,self);
end;

function TSchedulemergeManagerExport.getDescribe: String;
begin
  Result:='班次并班';
end;

function TSchedulemergeManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{AC7A60D4-8171-411F-89F0-E33C3FD23F14}');
end;

function TSchedulemergeManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSchedulemergeManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSchedulemergeManagerExport.Leave;
begin

end;

procedure TSchedulemergeManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
