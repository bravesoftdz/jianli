unit InsuranceReportManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TInsuranceReportManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmInsuranceReport;

{ SysMenuManager }

procedure TInsuranceReportManagerExport.ChangeTheme;
begin

end;

constructor TInsuranceReportManagerExport.Create;
begin
end;

procedure TInsuranceReportManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmInsuranceReport, FrmInsuranceReport,self);
end;

function TInsuranceReportManagerExport.getDescribe: String;
begin
  Result:='售票员保险销售统计';
end;

function TInsuranceReportManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{9FC6174B-2F09-412D-8C73-EF78A899D363}');
end;

function TInsuranceReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInsuranceReportManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInsuranceReportManagerExport.Leave;
begin

end;

procedure TInsuranceReportManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
