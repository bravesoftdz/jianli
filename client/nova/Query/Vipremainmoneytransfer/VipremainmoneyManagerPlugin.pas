unit VipremainmoneyManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TVipremainmoneyExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmVipremainmoneytransfer;

{ SysMenuManager }

procedure TVipremainmoneyExport.ChangeTheme;
begin

end;

constructor TVipremainmoneyExport.Create;
begin
end;

procedure TVipremainmoneyExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmVipremainmoneytransfer, FrmVipremainmoneytransfer,self);
end;

function TVipremainmoneyExport.getDescribe: String;
begin
  Result:='VIP补卡明细查询';
end;

function TVipremainmoneyExport.getKey: TGUID;
begin
  Result:=StringToGUID('{5D6D76FD-2312-47B8-B8A3-BD1779EDC1C0}');
end;

function TVipremainmoneyExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TVipremainmoneyExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVipremainmoneyExport.Leave;
begin

end;

procedure TVipremainmoneyExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
