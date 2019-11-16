{ ------------------------------------
  功能说明：Vehiclebrandmodel.bpl输出单元
  创建日期：2011/2/19
  作者：ice
  版权：nova
  ------------------------------------- }
unit SeatstatuspicturePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmSeatstatuspicture;

Type
{------------------------------------
  功能说明：车辆品牌型号管理功能
-------------------------------------}

  TSeatstatuspictureManager=class(TInterfacedObject,IFunctionItem)
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

procedure TSeatstatuspictureManager.ChangeTheme;
begin

end;

constructor TSeatstatuspictureManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSeatstatuspictureManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmSeatstatuspicture,FrmSeatstatuspicture,Self);
end;

function TSeatstatuspictureManager.getDescribe: String;
begin
  Result:='默认座位状态图片';
end;

function TSeatstatuspictureManager.getKey: TGUID;
begin
  Result:=StringToGUID('{AA9624D1-43D1-4212-8CC9-10B8E4D9AF5C}');
end;

function TSeatstatuspictureManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TSeatstatuspictureManager.IsWorkState: Boolean;
begin

end;

procedure TSeatstatuspictureManager.Leave;
begin

end;

procedure TSeatstatuspictureManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.

