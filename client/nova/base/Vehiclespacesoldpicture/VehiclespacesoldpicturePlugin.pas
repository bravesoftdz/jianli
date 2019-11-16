{ ------------------------------------
  ����˵����Vehiclebrandmodel.bpl�����Ԫ
  �������ڣ�2011/2/19
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit VehiclespacesoldpicturePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmVehiclespacesoldpicture;

Type
{------------------------------------
  ����˵��������Ʒ���ͺŹ�����
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
  Result:='������λ�ռ��۳�ͼƬ';
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

