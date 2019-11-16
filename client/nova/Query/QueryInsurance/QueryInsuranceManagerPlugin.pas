unit QueryInsuranceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TInsuranceManagerExport=class(TInterfacedObject,IFunctionItem)
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
  //汇总表
  TInsuranceExport= class (TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmQueryInsurance, UFrmQueryInsuranceDetail;

{ SysMenuManager }

procedure TInsuranceManagerExport.ChangeTheme;
begin

end;

constructor TInsuranceManagerExport.Create;
begin
end;

procedure TInsuranceManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmQueryInsurance, FrmQueryInsurance,self);
end;

function TInsuranceManagerExport.getDescribe: String;
begin
  Result:='保险销售明细查询';
end;

function TInsuranceManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{65BF587C-8E4C-42A4-8B9C-7E055D10AE26}');
end;

function TInsuranceManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInsuranceManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInsuranceManagerExport.Leave;
begin

end;

procedure TInsuranceManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;

procedure TInsuranceExport.ChangeTheme;
begin

end;

constructor TInsuranceExport.Create;
begin
end;

procedure TInsuranceExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmQueryInsuranceDetail, FrmQueryInsuranceDetail,self);
end;

function TInsuranceExport.getDescribe: String;
begin
  Result:='保险销售汇总查询';
end;

function TInsuranceExport.getKey: TGUID;
begin
  Result:=StringToGUID('{03FCF2FF-7B6A-48A9-8E15-FE6C27551726}');
end;

function TInsuranceExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TInsuranceExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TInsuranceExport.Leave;
begin

end;

procedure TInsuranceExport.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
