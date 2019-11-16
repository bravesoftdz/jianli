unit FocusTicketSaleQryPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFocusSaleLocalQry,
  UFrmFocusSaleOtherQry;
type

 //集中式售本地票
    TFocusSaleLocalManager = class(TInterfacedObject,IFunctionItem)
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

  //集中式售异地票
   TFocusSaleOtherManager = class(TInterfacedObject,IFunctionItem)
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

//售本地票
procedure TFocusSaleLocalManager.ChangeTheme;
begin

end;

constructor TFocusSaleLocalManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TFocusSaleLocalManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmFocusSalelocalQry, FrmFocusSalelocalQry,self);
end;


function TFocusSaleLocalManager.getDescribe: String;
begin
  Result:='综合查询--集中式异站售本站情况';
end;
function TFocusSaleLocalManager.getKey: TGUID;
begin
  Result:=StringToGUID('{4CC20274-7318-4178-B6A8-4F48B87C0D09}');
end;

function TFocusSaleLocalManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFocusSaleLocalManager.IsWorkState: Boolean;
begin

end;

procedure TFocusSaleLocalManager.Leave;
begin

end;

procedure TFocusSaleLocalManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//售异地票
procedure TFocusSaleOtherManager.ChangeTheme;
begin

end;

constructor TFocusSaleOtherManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TFocusSaleOtherManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmFocusSaleOtherQry,FrmFocusSaleOtherQry,self);
end;


function TFocusSaleOtherManager.getDescribe: String;
begin
  Result:='综合查询--集中式本站售异站情况';
end;
function TFocusSaleOtherManager.getKey: TGUID;
begin
  Result:=StringToGUID('{ECC89BAF-7D0B-4333-9D27-FF81D2EDD3E7}');
end;

function TFocusSaleOtherManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFocusSaleOtherManager.IsWorkState: Boolean;
begin

end;

procedure TFocusSaleOtherManager.Leave;
begin

end;

procedure TFocusSaleOtherManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
