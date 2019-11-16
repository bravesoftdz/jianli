{ ------------------------------------
  功能说明：Vehiclebrandmodel.bpl输出单元
  创建日期：2011/2/19
  作者：ice
  版权：nova
  ------------------------------------- }
unit VehiclebrandmodelPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmVehiclebrandmodel;

Type
{------------------------------------
  功能说明：车辆品牌型号管理功能
-------------------------------------}

  TVehiclebrandmodelManager=class(TInterfacedObject,IFunctionItem)
  private
    FSubFunctionList:TList<TSubfunction>;
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

uses Services,MainFormIntf;


{ TSystemManager }

procedure TVehiclebrandmodelManager.ChangeTheme;
begin

end;

constructor TVehiclebrandmodelManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehiclebrandmodelManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVehiclebrandmodel,FrmVehiclebrandmodel,Self);
end;

function TVehiclebrandmodelManager.getDescribe: String;
begin
  Result:='车辆品牌型号管理';
end;

function TVehiclebrandmodelManager.getKey: TGUID;
begin
  Result:=StringToGUID('{E6C76076-863F-44F9-895F-7E9DC40577B3}');
end;

function TVehiclebrandmodelManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TVehiclebrandmodelManager.IsWorkState: Boolean;
begin

end;

procedure TVehiclebrandmodelManager.Leave;
begin

end;

procedure TVehiclebrandmodelManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.

