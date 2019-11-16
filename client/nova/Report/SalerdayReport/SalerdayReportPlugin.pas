unit SalerdayReportPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmSalerdayReport,
UFrmLocalSalerSyncOrg,UFrmSyncSaleLocal,UFrmOrgInvoinceDetail,
UFrmBalanceUnitInvoinces,UFrmVehicleIncome,UFrmDayIncomeReport;
type

//
 TSalerdayReprt = class(TInterfacedObject,IFunctionItem)
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

 TSalerOrgSyncReprt = class(TInterfacedObject,IFunctionItem)
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

 TSyncSaleLocalReprt = class(TInterfacedObject,IFunctionItem)
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


   TOrgInvoinceDetailReprt = class(TInterfacedObject,IFunctionItem)
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


   TBalanceUnitInvoinces = class(TInterfacedObject,IFunctionItem)
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

   TPresellMonthRevenue = class(TInterfacedObject,IFunctionItem)
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


   TVehicleIncome = class(TInterfacedObject,IFunctionItem)
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

 TdayIncomeReprt = class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmPresellMonthRevenue;

procedure TSalerdayReprt.ChangeTheme;
begin

end;

constructor TSalerdayReprt.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSalerdayReprt.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmSalerdayReport,FrmSalerdayReport,self);
end;


function TSalerdayReprt.getDescribe: String;
begin
  Result:='售票员售票日报表';
end;
function TSalerdayReprt.getKey: TGUID;
begin
  Result:=StringToGUID('{32A8D9D5-4B42-4DEC-A709-98085A6BC54C}');
end;

function TSalerdayReprt.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TSalerdayReprt.IsWorkState: Boolean;
begin

end;

procedure TSalerdayReprt.Leave;
begin

end;

procedure TSalerdayReprt.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TSalerOrgSyncReprt }

procedure TSalerOrgSyncReprt.ChangeTheme;
begin

end;

constructor TSalerOrgSyncReprt.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSalerOrgSyncReprt.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmLocalSalerSyncOrg,FrmLocalSalerSyncOrg,self);

end;

function TSalerOrgSyncReprt.getDescribe: String;
begin
  Result:='本站售异站票汇总表';
end;

function TSalerOrgSyncReprt.getKey: TGUID;
begin
   Result:=StringToGUID('{C67AAABB-6D4B-4DDB-BC94-4B4695BA4C72}');
end;

function TSalerOrgSyncReprt.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TSalerOrgSyncReprt.IsWorkState: Boolean;
begin

end;

procedure TSalerOrgSyncReprt.Leave;
begin

end;

procedure TSalerOrgSyncReprt.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TSyncSaleLocalReprt }

procedure TSyncSaleLocalReprt.ChangeTheme;
begin

end;

constructor TSyncSaleLocalReprt.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TSyncSaleLocalReprt.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmSyncSaleLocal,FrmSyncSaleLocal,self);
end;

function TSyncSaleLocalReprt.getDescribe: String;
begin
  Result:='异站售本站汇总表';
end;

function TSyncSaleLocalReprt.getKey: TGUID;
begin
   Result:=StringToGUID('{FE4A33AF-BF30-40E3-AD2F-85A497AD1863}');
end;

function TSyncSaleLocalReprt.getSubFunctionList: TList<TSubfunction>;
begin
   Result := FSubFunctionList;
end;

function TSyncSaleLocalReprt.IsWorkState: Boolean;
begin

end;

procedure TSyncSaleLocalReprt.Leave;
begin

end;

procedure TSyncSaleLocalReprt.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TOrgInvoinceDetailReprt }

procedure TOrgInvoinceDetailReprt.ChangeTheme;
begin

end;

constructor TOrgInvoinceDetailReprt.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TOrgInvoinceDetailReprt.Enter(
  const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmOrgInvoinceDetail,FrmOrgInvoinceDetail,self);

end;

function TOrgInvoinceDetailReprt.getDescribe: String;
begin
   Result:='客运站划拨明细表';
end;

function TOrgInvoinceDetailReprt.getKey: TGUID;
begin
   Result:=StringToGUID('{3F08CB2E-D2C9-45F0-8786-BAB1C5F3D6B7}');
end;

function TOrgInvoinceDetailReprt.getSubFunctionList: TList<TSubfunction>;
begin
   Result := FSubFunctionList;
end;

function TOrgInvoinceDetailReprt.IsWorkState: Boolean;
begin

end;

procedure TOrgInvoinceDetailReprt.Leave;
begin

end;

procedure TOrgInvoinceDetailReprt.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TBalanceUnitInvoinces }

procedure TBalanceUnitInvoinces.ChangeTheme;
begin

end;

constructor TBalanceUnitInvoinces.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TBalanceUnitInvoinces.Enter(
  const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmBalanceUnitInvoinces,FrmBalanceUnitInvoinces,self);

end;

function TBalanceUnitInvoinces.getDescribe: String;
begin
   Result:='各分公司划拨汇总表';
end;

function TBalanceUnitInvoinces.getKey: TGUID;
begin
   Result:=StringToGUID('{66C34538-B241-4589-998B-3599B04AF79F}');
end;

function TBalanceUnitInvoinces.getSubFunctionList: TList<TSubfunction>;
begin
   Result := FSubFunctionList;
end;

function TBalanceUnitInvoinces.IsWorkState: Boolean;
begin

end;

procedure TBalanceUnitInvoinces.Leave;
begin

end;

procedure TBalanceUnitInvoinces.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TPresellMonthRevenue }

procedure TPresellMonthRevenue.ChangeTheme;
begin

end;

constructor TPresellMonthRevenue.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TPresellMonthRevenue.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPresellMonthRevenue,FrmPresellMonthRevenue,self);
end;

function TPresellMonthRevenue.getDescribe: String;
begin
  result:='长途站预售票查询情况表（跨月汇总）';
end;

function TPresellMonthRevenue.getKey: TGUID;
begin
  Result:=StringToGUID('{4FFCE02E-8618-4137-BD6F-65117CB52384}');
end;

function TPresellMonthRevenue.getSubFunctionList: TList<TSubfunction>;
begin
   Result := FSubFunctionList;
end;

function TPresellMonthRevenue.IsWorkState: Boolean;
begin

end;

procedure TPresellMonthRevenue.Leave;
begin

end;

procedure TPresellMonthRevenue.refresh(
  const parameters: TFunctionItemParameters);
begin

end;
//车辆划拨汇总表
{ TVehicleIncome }

procedure TVehicleIncome.ChangeTheme;
begin

end;

constructor TVehicleIncome.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TVehicleIncome.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVehicleIncome,FrmVehicleIncome,self);
end;

function TVehicleIncome.getDescribe: String;
begin
   result:='车辆划拨汇总表';
end;

function TVehicleIncome.getKey: TGUID;
begin
  Result:=StringToGUID('{E4A6F015-6B44-48CE-AD5B-6F1884A0C2F8}');
end;

function TVehicleIncome.getSubFunctionList: TList<TSubfunction>;
begin
    Result := FSubFunctionList;
end;

function TVehicleIncome.IsWorkState: Boolean;
begin

end;

procedure TVehicleIncome.Leave;
begin

end;

procedure TVehicleIncome.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TdayIncomeReprt }

procedure TdayIncomeReprt.ChangeTheme;
begin

end;

constructor TdayIncomeReprt.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TdayIncomeReprt.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDayIncomeReport,FrmDayIncomeReport,self);
end;

function TdayIncomeReprt.getDescribe: String;
begin
   result:='售票每日营收统计表';
end;

function TdayIncomeReprt.getKey: TGUID;
begin
  Result:=StringToGUID('{E194F2B5-97C6-47F4-BCB2-88B08AAF688B}');
end;

function TdayIncomeReprt.getSubFunctionList: TList<TSubfunction>;
begin
    Result := FSubFunctionList;
end;

function TdayIncomeReprt.IsWorkState: Boolean;
begin

end;

procedure TdayIncomeReprt.Leave;
begin

end;

procedure TdayIncomeReprt.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
