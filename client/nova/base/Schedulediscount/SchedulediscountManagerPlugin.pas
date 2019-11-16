unit SchedulediscountManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TSchedulediscountManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmSchedulediscount;

{ SysMenuManager }

procedure TSchedulediscountManagerExport.ChangeTheme;
begin

end;

constructor TSchedulediscountManagerExport.Create;
begin
end;

procedure TSchedulediscountManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmSchedulediscount,Frmschedulediscount,self);
end;

function TSchedulediscountManagerExport.getDescribe: String;
begin
  Result:='班次折扣管理';
end;

function TSchedulediscountManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{AEC61BAD-B28E-4A38-88AE-2C078441DEC6}');
end;

function TSchedulediscountManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TSchedulediscountManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TSchedulediscountManagerExport.Leave;
begin

end;

procedure TSchedulediscountManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
