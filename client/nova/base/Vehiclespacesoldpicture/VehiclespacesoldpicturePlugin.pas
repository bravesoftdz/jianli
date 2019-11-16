{ ------------------------------------
  功能说明：Vehiclebrandmodel.bpl输出单元
  创建日期：2011/2/19
  作者：ice
  版权：nova
  ------------------------------------- }
unit VehiclespacesoldpicturePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmVehiclespacesoldpicture;

Type
{------------------------------------
  功能说明：车辆品牌型号管理功能
-------------------------------------}

  TVehiclespacesoldpictureManager=class(TInterfacedObject,IFunctionItem)
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

procedure TVehiclespacesoldpictureManager.ChangeTheme;
begin

end;

constructor TVehiclespacesoldpictureManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehiclespacesoldpictureManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVehiclespacesoldpicture,FrmVehiclespacesoldpicture,Self);
end;

function TVehiclespacesoldpictureManager.getDescribe: String;
begin
  Result:='车辆座位空间售出图片';
end;

function TVehiclespacesoldpictureManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9D222E8A-5AB8-44B4-BF6E-8F2B66ABEE14}');
end;

function TVehiclespacesoldpictureManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TVehiclespacesoldpictureManager.IsWorkState: Boolean;
begin

end;

procedure TVehiclespacesoldpictureManager.Leave;
begin

end;

procedure TVehiclespacesoldpictureManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.

