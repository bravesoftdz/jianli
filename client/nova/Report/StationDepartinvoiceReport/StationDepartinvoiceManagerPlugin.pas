unit StationDepartinvoiceManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TStationDepartinvoiceManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmStationDepartinvoice;

{ SysMenuManager }

procedure TStationDepartinvoiceManagerExport.ChangeTheme;
begin

end;

constructor TStationDepartinvoiceManagerExport.Create;
begin
end;

procedure TStationDepartinvoiceManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmStationDepartinvoice, FrmStationDepartinvoice,self);
end;

function TStationDepartinvoiceManagerExport.getDescribe: String;
begin
  Result:='停靠站点运量情况汇总表';
end;

function TStationDepartinvoiceManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{750D1A97-7976-44FC-8B26-DA51FD0B2301}');
end;

function TStationDepartinvoiceManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TStationDepartinvoiceManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TStationDepartinvoiceManagerExport.Leave;
begin

end;

procedure TStationDepartinvoiceManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
