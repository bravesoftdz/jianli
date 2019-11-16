unit NetSchedulePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type

  TNetScheduleExport = class(TInterfacedObject, IFunctionItem)
  private
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;

  end;

implementation

uses Services, MainFormIntf, UFrmNetSchedule;

{ SysMenuManager }

procedure TNetScheduleExport.ChangeTheme;
begin

end;

constructor TNetScheduleExport.Create;
begin
end;

procedure TNetScheduleExport.Enter
  (const parameters: TFunctionItemParameters);
begin
 // Services.SysMainForm.showFormModal(TFrmNetSchedule, nil);
  Services.SysMainForm.ShowForm(TFrmNetSchedule,FrmNetSchedule,self);
end;

function TNetScheduleExport.getDescribe: String;
begin
  Result := '联网配客班次设置';
end;

function TNetScheduleExport.getKey: TGUID;
begin
  Result := StringToGUID('{9DB1C14C-F88B-413B-96E6-DACF63C6301B}');
end;

function TNetScheduleExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TNetScheduleExport.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TNetScheduleExport.Leave;
begin

end;

procedure TNetScheduleExport.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
