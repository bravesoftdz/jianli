unit RechargePromotionPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmRechargePromotion,UFrmRechargePromotionEdit;
type
 RechargePromotionManager = class(TInterfacedObject,IFunctionItem)
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

procedure RechargePromotionManager.ChangeTheme;
begin

end;

constructor RechargePromotionManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure RechargePromotionManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmRechargePromotion,frmRechargePromotion,self);
end;


function RechargePromotionManager.getDescribe: String;
begin
  Result:='业务管理--充值优惠活动管理';
end;
function RechargePromotionManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9C9B3825-1EA8-4B8A-A031-AAC006FDF238}');
end;

function RechargePromotionManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function RechargePromotionManager.IsWorkState: Boolean;
begin

end;

procedure RechargePromotionManager.Leave;
begin

end;

procedure RechargePromotionManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
