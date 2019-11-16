unit PasswordManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TPasswordManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmPassword;

{ SysMenuManager }

procedure TPasswordManagerExport.ChangeTheme;
begin

end;

constructor TPasswordManagerExport.Create;
begin
end;

procedure TPasswordManagerExport.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.showFormModal(TFrmPassword,nil);
//  Services.SysMainForm.ShowForm(TFrmLogout,FrmLogout,self);
end;

function TPasswordManagerExport.getDescribe: String;
begin
  Result:='ÐÞ¸ÄÃÜÂë';
end;

function TPasswordManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{0B2D3890-4904-43D8-9D98-D43A486902AE}');
end;

function TPasswordManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TPasswordManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TPasswordManagerExport.Leave;
begin

end;

procedure TPasswordManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
