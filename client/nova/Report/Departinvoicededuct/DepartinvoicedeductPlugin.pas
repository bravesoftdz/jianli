unit DepartinvoicedeductPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmDepartinvoicededuct, UFrmVehicleDepartinvoice, UFrmDepartinvoice;
type

//固定扣费项目表
    departinvoicedeductManager = class(TInterfacedObject,IFunctionItem)
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

//车辆结算汇总查询
    vehicleDepartinvoiceManager = class(TInterfacedObject,IFunctionItem)
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


//车辆结算汇总查询
    departinvoiceManager = class(TInterfacedObject,IFunctionItem)
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

procedure departinvoicedeductManager.ChangeTheme;
begin

end;

constructor departinvoicedeductManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure departinvoicedeductManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmDepartinvoicededuct,Frmdepartinvoicededuct,self);
end;


function departinvoicedeductManager.getDescribe: String;
begin
  Result:='固定扣费项目表';
end;
function departinvoicedeductManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9226695C-BF92-44AC-9939-A6DAA891DDB9}');
end;

function departinvoicedeductManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function departinvoicedeductManager.IsWorkState: Boolean;
begin

end;

procedure departinvoicedeductManager.Leave;
begin

end;

procedure departinvoicedeductManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//车辆结算汇总查询
procedure vehicleDepartinvoiceManager.ChangeTheme;
begin

end;

constructor vehicleDepartinvoiceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure vehicleDepartinvoiceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmVehicleDepartinvoices,FrmVehicleDepartinvoices,self);
end;


function vehicleDepartinvoiceManager.getDescribe: String;
begin
  Result:='车辆结算汇总表';
end;
function vehicleDepartinvoiceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{B2960BC5-701C-456F-855F-0D351363A499}');
end;

function vehicleDepartinvoiceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function vehicleDepartinvoiceManager.IsWorkState: Boolean;
begin

end;

procedure vehicleDepartinvoiceManager.Leave;
begin

end;

procedure vehicleDepartinvoiceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//客运结算统计表
procedure departinvoiceManager.ChangeTheme;
begin

end;

constructor departinvoiceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure departinvoiceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmDepartinvoice,FrmDepartinvoice,self);
end;


function departinvoiceManager.getDescribe: String;
begin
  Result:='客运结算统计表';
end;
function departinvoiceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{0D5D1FA0-631D-402F-8097-29C2A0643A58}');
end;

function departinvoiceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function departinvoiceManager.IsWorkState: Boolean;
begin

end;

procedure departinvoiceManager.Leave;
begin

end;

procedure departinvoiceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
