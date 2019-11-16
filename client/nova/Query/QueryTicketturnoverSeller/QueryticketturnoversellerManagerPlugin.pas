unit QueryticketturnoversellerManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TQueryTicketturnoverSellerManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmQueryTicketturnoverSeller;

{ SysMenuManager }

procedure TQueryTicketturnoverSellerManagerExport.ChangeTheme;
begin

end;

constructor TQueryTicketturnoverSellerManagerExport.Create;
begin
end;

procedure TQueryTicketturnoverSellerManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmQueryTicketturnoverSeller,FrmQueryTicketturnoverSeller,self);
end;

function TQueryTicketturnoverSellerManagerExport.getDescribe: String;
begin
  Result:='售票员解款情况表';
end;

function TQueryTicketturnoverSellerManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{6B87468F-ADE7-4184-AF4A-F49276BFB399}');
end;

function TQueryTicketturnoverSellerManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TQueryTicketturnoverSellerManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TQueryTicketturnoverSellerManagerExport.Leave;
begin

end;

procedure TQueryTicketturnoverSellerManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
