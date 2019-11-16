unit SecurityManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSecurityManagerExport=class(TInterfacedObject,IFunctionItem)
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

  TSecurityReportManagerExport=class(TInterfacedObject,IFunctionItem)
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

  TSecurityFeeReportManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSecuritycheck, UFrmSecuritycheckReport,UFrmSecuritycheckFeeReport;

{ SysMenuManager }

procedure TSecurityManagerExport.ChangeTheme;
begin

end;

constructor TSecurityManagerExport.Create;
begin
end;

procedure TSecurityManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSecurity,FrmSecurity,self);
end;

function TSecurityManagerExport.getDescribe: String;
begin
  Result:='车辆安检';
end;

function TSecurityManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{54D372AC-BF88-4DBF-9411-CE497EEDAEA1}');
end;

function TSecurityManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSecurityManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSecurityManagerExport.Leave;
begin

end;

procedure TSecurityManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
{ TSecurityReportManagerExport }

procedure TSecurityReportManagerExport.ChangeTheme;
begin

end;

constructor TSecurityReportManagerExport.Create;
begin

end;

procedure TSecurityReportManagerExport.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmSecuritycheckReport,FrmSecuritycheckReport,self);
end;

function TSecurityReportManagerExport.getDescribe: String;
begin
  Result := '车辆安检月统计表';
end;

function TSecurityReportManagerExport.getKey: TGUID;
begin
  Result := StringToGUID('{D54DC1A3-6745-455F-8122-6E9D3B4DB6C5}');
end;

function TSecurityReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TSecurityReportManagerExport.IsWorkState: Boolean;
begin

end;

procedure TSecurityReportManagerExport.Leave;
begin

end;

procedure TSecurityReportManagerExport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TSecurityFeeReportManagerExport }

procedure TSecurityFeeReportManagerExport.ChangeTheme;
begin

end;

constructor TSecurityFeeReportManagerExport.Create;
begin
end;

procedure TSecurityFeeReportManagerExport.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmSecuritycheckFeeReport,FrmSecuritycheckFeeReport,self);
end;

function TSecurityFeeReportManagerExport.getDescribe: String;
begin
  Result:='车辆安检费统计表';
end;

function TSecurityFeeReportManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{304BBD15-6049-442F-86EE-68DB33490C65}');
end;

function TSecurityFeeReportManagerExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TSecurityFeeReportManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSecurityFeeReportManagerExport.Leave;
begin

end;

procedure TSecurityFeeReportManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
