unit IncomeDepartivoicePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmIncomeDepartivoice;
type

//营收运量统计表
 incomeDepartivoiceManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
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

uses Services,MainFormIntf;

procedure incomeDepartivoiceManager.ChangeTheme;
begin

end;

constructor incomeDepartivoiceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure incomeDepartivoiceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmIncomeDepartivoice,frmIncomeDepartivoice,self);
end;


function incomeDepartivoiceManager.getDescribe: String;
begin
  Result:='营收运量统计表';
end;
function incomeDepartivoiceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{580CE988-C568-4362-8769-485931CBBE1E}');
end;

function incomeDepartivoiceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function incomeDepartivoiceManager.IsWorkState: Boolean;
begin

end;

procedure incomeDepartivoiceManager.Leave;
begin

end;

procedure incomeDepartivoiceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
