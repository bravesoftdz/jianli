unit DistrictPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TDistrictManager=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmDistrict;

{ SysMenuManager }

procedure TDistrictManager.ChangeTheme;
begin

end;

constructor TDistrictManager.Create;
begin
end;

procedure TDistrictManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDistrict,FrmDistrict,self);
end;

function TDistrictManager.getDescribe: String;
begin
  Result:='«¯”Úπ‹¿Ì';
end;

function TDistrictManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D0414DF8-256F-46B7-AC0E-27DC5B4D93B6}');
end;

function TDistrictManager.getSubFunctionList: TList<TSubfunction>;
begin
 // Result:=TFrmArea.getSubFunctionList;
end;

function TDistrictManager.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TDistrictManager.Leave;
begin

end;

procedure TDistrictManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
