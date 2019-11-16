unit QueryCustomerBookingPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmQueryCustomerBooking,UFrmPersellSum;
type

 routeDynamicCompareManager = class(TInterfacedObject,IFunctionItem)
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

   PersellSum = class(TInterfacedObject,IFunctionItem)
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

procedure routeDynamicCompareManager.ChangeTheme;
begin

end;

constructor routeDynamicCompareManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure routeDynamicCompareManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryCustomerBooking,frmQueryCustomerBooking,self);
end;


function routeDynamicCompareManager.getDescribe: String;
begin
  Result:='订票统计查询';
end;
function routeDynamicCompareManager.getKey: TGUID;
begin
  Result:=StringToGUID('{819AE1C3-1888-4B9B-8D92-470828CA0744}');
end;

function routeDynamicCompareManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function routeDynamicCompareManager.IsWorkState: Boolean;
begin

end;

procedure routeDynamicCompareManager.Leave;
begin

end;

procedure routeDynamicCompareManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


//预售票统计
procedure PersellSum.ChangeTheme;
begin

end;

constructor PersellSum.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure PersellSum.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmPersellSum,frmPersellSum,self);
end;


function PersellSum.getDescribe: String;
begin
  Result:='班次预售情况汇总表';
end;
function PersellSum.getKey: TGUID;
begin
  Result:=StringToGUID('{EC0832CC-727A-490A-A19D-6479B800A862}');
end;

function PersellSum.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function PersellSum.IsWorkState: Boolean;
begin

end;

procedure PersellSum.Leave;
begin

end;

procedure PersellSum.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
