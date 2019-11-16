unit VipGiftPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
  UFrmVipGift,UFrmVipGiftEdit;
type
 VipGiftManager = class(TInterfacedObject,IFunctionItem)
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

procedure VipGiftManager.ChangeTheme;
begin

end;

constructor VipGiftManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure VipGiftManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmVipGift,frmVipGift,self);
end;


function VipGiftManager.getDescribe: String;
begin
  Result:='档案管理--会员礼品管理';
end;
function VipGiftManager.getKey: TGUID;
begin
  Result:=StringToGUID('{107B24C7-D516-4A66-82FD-43895DB3E82B}');
end;

function VipGiftManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function VipGiftManager.IsWorkState: Boolean;
begin

end;

procedure VipGiftManager.Leave;
begin

end;

procedure VipGiftManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
