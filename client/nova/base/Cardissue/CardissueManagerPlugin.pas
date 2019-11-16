unit CardissueManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TCardissueManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmCardissue;

{ SysMenuManager }

procedure TCardissueManagerExport.ChangeTheme;
begin

end;

constructor TCardissueManagerExport.Create;
begin
end;

procedure TCardissueManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmCardissue,FrmCardissue,self);
end;

function TCardissueManagerExport.getDescribe: String;
begin
  Result:='发卡记录';
end;

function TCardissueManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{76C46E18-1757-4927-A229-88234B2BDB39}');
end;

function TCardissueManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TCardissueManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TCardissueManagerExport.Leave;
begin

end;

procedure TCardissueManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
