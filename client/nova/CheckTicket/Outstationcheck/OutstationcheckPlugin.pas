unit OutstationcheckPlugin;

interface


uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type

  TOutstationcheckExport=class(TInterfacedObject,IFunctionItem)
  private

    FSubFunctionList: TList<TSubfunction>;
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
  uses Services, MainFormIntf, UFrmOutstationcheck;

{ TOutstationcheckExport }

procedure TOutstationcheckExport.ChangeTheme;
begin

end;

constructor TOutstationcheckExport.Create;
begin
end;

procedure TOutstationcheckExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmOutstationcheck,FrmOutstationcheck,self);
end;

function TOutstationcheckExport.getDescribe: String;
begin
  Result:='»ü²é¹ÜÀí';
end;

function TOutstationcheckExport.getKey: TGUID;
begin
  Result:=StringToGUID('{7051F3FB-E600-4ED0-AF1E-C7241EA565F7}');
end;

function TOutstationcheckExport.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TOutstationcheckExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TOutstationcheckExport.Leave;
begin

end;

procedure TOutstationcheckExport.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
