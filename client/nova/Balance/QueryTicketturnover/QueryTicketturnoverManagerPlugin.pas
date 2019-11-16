unit QueryTicketturnoverManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TQueryTicketturnoverManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmQueryTicketturnover;

{ SysMenuManager }

procedure TQueryTicketturnoverManagerExport.ChangeTheme;
begin

end;

constructor TQueryTicketturnoverManagerExport.Create;
begin
end;

procedure TQueryTicketturnoverManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
    SysMainForm.ShowForm(TFrmQueryTicketturnover,FrmQueryTicketturnover,self,parameters);
end;

function TQueryTicketturnoverManagerExport.getDescribe: String;
begin
  Result:='售票员缴款查询';
end;

function TQueryTicketturnoverManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{6ACB9F5C-37D7-47FD-9BD4-414BD57228C1}');
end;

function TQueryTicketturnoverManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TQueryTicketturnoverManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TQueryTicketturnoverManagerExport.Leave;
begin

end;

procedure TQueryTicketturnoverManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
