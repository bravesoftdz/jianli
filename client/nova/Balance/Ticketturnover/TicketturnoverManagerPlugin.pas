unit TicketturnoverManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketturnoverManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketturnover;

{ SysMenuManager }

procedure TTicketturnoverManagerExport.ChangeTheme;
begin

end;

constructor TTicketturnoverManagerExport.Create;
begin
end;

procedure TTicketturnoverManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters.Strings[0]='3' then
    SysMainForm.showFormModal(TFrmTicketturnover,self,parameters,false)
  else
    SysMainForm.ShowForm(TFrmTicketturnover,FrmTicketturnover,self,parameters,true);
end;

function TTicketturnoverManagerExport.getDescribe: String;
begin
  Result:='售票员营收缴款';
end;

function TTicketturnoverManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{E7535C96-EF93-4836-BA70-1AAFC5DEAA94}');
end;

function TTicketturnoverManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TTicketturnoverManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketturnoverManagerExport.Leave;
begin

end;

procedure TTicketturnoverManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.

