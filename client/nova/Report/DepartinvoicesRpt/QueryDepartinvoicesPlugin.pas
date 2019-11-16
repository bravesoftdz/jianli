unit QueryDepartinvoicesPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryDepartinvoices;
type

//班次结算情况查询
 queryDepartinvoicesMG = class(TInterfacedObject,IFunctionItem)
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

   //运量单运量台账
    TQryDepartinvoinceschedule=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf,UFrmQryDepartSchedules;

procedure queryDepartinvoicesMG.ChangeTheme;
begin

end;

constructor queryDepartinvoicesMG.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryDepartinvoicesMG.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryDepartinvoices,frmQueryDepartinvoices,self);
end;


function queryDepartinvoicesMG.getDescribe: String;
begin
  Result:='检票查询--班次结算情况查询';
end;
function queryDepartinvoicesMG.getKey: TGUID;
begin
  Result:=StringToGUID('{61AB876A-E86E-44C5-A20C-090302D87048}');
end;

function queryDepartinvoicesMG.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryDepartinvoicesMG.IsWorkState: Boolean;
begin

end;

procedure queryDepartinvoicesMG.Leave;
begin

end;

procedure queryDepartinvoicesMG.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TQryDepartinvoinceschedule }

procedure TQryDepartinvoinceschedule.ChangeTheme;
begin

end;

constructor TQryDepartinvoinceschedule.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TQryDepartinvoinceschedule.Enter(
  const parameters: TFunctionItemParameters);
begin
   Services.SysMainForm.ShowForm(TFrmQryDepartSchedules,FrmQryDepartSchedules,self);
end;

function TQryDepartinvoinceschedule.getDescribe: String;
begin
  Result:='运量单运量台账';
end;

function TQryDepartinvoinceschedule.getKey: TGUID;
begin
  Result:=StringToGUID('{F6269A0A-1B6C-4CF8-8F73-58BAB2B0BB67}');
end;

function TQryDepartinvoinceschedule.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TQryDepartinvoinceschedule.IsWorkState: Boolean;
begin

end;

procedure TQryDepartinvoinceschedule.Leave;
begin

end;

procedure TQryDepartinvoinceschedule.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
