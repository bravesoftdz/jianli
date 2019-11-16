unit StationBalanceReportPlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections,
  UFrmStationBalanceReport, UFrmRouteSaleReport;

type

  // 客运站结算汇总表
  TStationBalanceReportManager = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  // 线路售票统计表
  TRouteSaleReportManager = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  // 班次结算日报
  TScheduleBalancePriceManager = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  // 线路结算日报
  TRouteBalancePriceManager = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

  // 线路发班日报
  TQryRouteIncomesManager = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

implementation

uses Services, MainFormIntf, UFrmScheduleBalancePrice, UFrmRouteBalancePrice,UFrmQryRouteIncomes;

// 班次运行情况查询

procedure TStationBalanceReportManager.ChangeTheme;
begin

end;

constructor TStationBalanceReportManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TStationBalanceReportManager.Enter
  (const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmStationBalanceReport,
    FrmStationBalanceReport, self);
end;

function TStationBalanceReportManager.getDescribe: String;
begin
  Result := '客运站结算汇总表';
end;

function TStationBalanceReportManager.getKey: TGUID;
begin
  Result := StringToGUID('{977A49D0-E2B8-4B4E-BA4B-F56FE7BCB7B3}');
end;

function TStationBalanceReportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TStationBalanceReportManager.IsWorkState: Boolean;
begin

end;

procedure TStationBalanceReportManager.Leave;
begin

end;

procedure TStationBalanceReportManager.refresh
  (const parameters: TFunctionItemParameters);
begin

end;
{ TRouteSaleReportManager }

procedure TRouteSaleReportManager.ChangeTheme;
begin

end;

constructor TRouteSaleReportManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TRouteSaleReportManager.Enter
  (const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmRouteSaleReport, FrmRouteSaleReport, self);

end;

function TRouteSaleReportManager.getDescribe: String;
begin
  Result := '线路售票统计表';
end;

function TRouteSaleReportManager.getKey: TGUID;
begin
  Result := StringToGUID('{A6C396D3-8D8D-49EB-8D90-F467B4C35BE9}');
end;

function TRouteSaleReportManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TRouteSaleReportManager.IsWorkState: Boolean;
begin

end;

procedure TRouteSaleReportManager.Leave;
begin

end;

procedure TRouteSaleReportManager.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

{ TScheduleBalancePriceManager }

procedure TScheduleBalancePriceManager.ChangeTheme;
begin

end;

constructor TScheduleBalancePriceManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TScheduleBalancePriceManager.Enter
  (const parameters: TFunctionItemParameters);
var
  subFunction: TSubfunction;
begin
  Services.SysMainForm.ShowForm(TFrmScheduleBalancePrice,
    FrmScheduleBalancePrice, self);
end;

function TScheduleBalancePriceManager.getDescribe: String;
begin

end;

function TScheduleBalancePriceManager.getKey: TGUID;
begin
  Result := StringToGUID('{341A5FD4-6F6F-4D18-94C0-74DCB28EADAC}');
end;

function TScheduleBalancePriceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TScheduleBalancePriceManager.IsWorkState: Boolean;
begin

end;

procedure TScheduleBalancePriceManager.Leave;
begin

end;

procedure TScheduleBalancePriceManager.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

{ TRouteBalancePriceManager }

procedure TRouteBalancePriceManager.ChangeTheme;
begin

end;

constructor TRouteBalancePriceManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TRouteBalancePriceManager.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmRouteBalancePrice, FrmRouteBalancePrice,
    self);
end;

function TRouteBalancePriceManager.getDescribe: String;
begin

end;

function TRouteBalancePriceManager.getKey: TGUID;
begin
  Result := StringToGUID('{B1F78B07-CA58-4120-A9A5-335D9D47E03A}');
end;

function TRouteBalancePriceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TRouteBalancePriceManager.IsWorkState: Boolean;
begin

end;

procedure TRouteBalancePriceManager.Leave;
begin

end;

procedure TRouteBalancePriceManager.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

{ TQryRouteIncomesManager }

procedure TQryRouteIncomesManager.ChangeTheme;
begin

end;

constructor TQryRouteIncomesManager.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TQryRouteIncomesManager.Enter(
  const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmQryRouteIncomes, FrmQryRouteIncomes,
    self);
end;

function TQryRouteIncomesManager.getDescribe: String;
begin

end;

function TQryRouteIncomesManager.getKey: TGUID;
begin
  Result := StringToGUID('{95FF020B-EA72-46CC-92EA-6FB24A6CFC5D}');
end;

function TQryRouteIncomesManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TQryRouteIncomesManager.IsWorkState: Boolean;
begin

end;

procedure TQryRouteIncomesManager.Leave;
begin

end;

procedure TQryRouteIncomesManager.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
