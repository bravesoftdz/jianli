unit ComplexfeePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  ComplexfeeMS=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmComplexfee;

{ SysMenuManager }

procedure ComplexfeeMS.ChangeTheme;
begin

end;

constructor ComplexfeeMS.Create;
begin
end;

procedure ComplexfeeMS.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmComplexfee,FrmComplexfee,self);
end;

function ComplexfeeMS.getDescribe: String;
begin
  Result:='综合收费信息管理';
end;

function ComplexfeeMS.getKey: TGUID;
begin
  Result:=StringToGUID('{C3029FE6-42C4-4E88-BD2F-6652ADDE3574}');
end;

function ComplexfeeMS.getSubFunctionList: TList<TSubfunction>;
begin

end;

function ComplexfeeMS.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure ComplexfeeMS.Leave;
begin

end;

procedure ComplexfeeMS.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
