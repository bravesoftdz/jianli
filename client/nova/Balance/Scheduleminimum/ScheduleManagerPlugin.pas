unit ScheduleManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TScheduleManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmScheduleminimum;

{ SysMenuManager }

procedure TScheduleManagerExport.ChangeTheme;
begin

end;

constructor TScheduleManagerExport.Create;
begin
end;

procedure TScheduleManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmScheduleminimum,FrmScheduleminimum,self);
end;

function TScheduleManagerExport.getDescribe: String;
begin
  Result:='班次保底数';
end;

function TScheduleManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{627D2A7E-7B2B-48A3-A7C5-652138DEC6AF}');
end;

function TScheduleManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TScheduleManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TScheduleManagerExport.Leave;
begin

end;

procedure TScheduleManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
