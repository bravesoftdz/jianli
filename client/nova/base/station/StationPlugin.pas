{------------------------------------
  功能说明：Station.bpl包插件对象
  创建日期：2011.01.21
  作者：蒋伟
  版权：nova
-------------------------------------}
unit StationPlugin;
interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TStationFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmStation,MainFormIntf;


{ TFrmUser}

procedure TStationFunctionItem.ChangeTheme;
begin

end;

constructor TStationFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TStationFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmStation,FrmStation,self);
end;
function TStationFunctionItem.getDescribe: String;
begin
  Result:='站点信息';
end;

function TStationFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{60D760C3-5465-4F0C-A707-B24855F175B9}');
end;

function TStationFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TStationFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TStationFunctionItem.Leave;
begin

end;

procedure TStationFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
