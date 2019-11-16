unit ScheduleStationDepartinvoiceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TScheduleStationDepartinvoiceManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmScheduleStationDepart;

{ SysMenuManager }

procedure TScheduleStationDepartinvoiceManagerExport.ChangeTheme;
begin

end;

constructor TScheduleStationDepartinvoiceManagerExport.Create;
begin
end;

procedure TScheduleStationDepartinvoiceManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmScheduleStationDepart, FrmScheduleStationDepart,self);
end;

function TScheduleStationDepartinvoiceManagerExport.getDescribe: String;
begin
  Result:='班线停和靠站点运量情况汇总表';
end;

function TScheduleStationDepartinvoiceManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{4D017670-0C73-4318-BC59-DDA9EE7C6706}');
end;

function TScheduleStationDepartinvoiceManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TScheduleStationDepartinvoiceManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TScheduleStationDepartinvoiceManagerExport.Leave;
begin

end;

procedure TScheduleStationDepartinvoiceManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
