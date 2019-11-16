unit QueryDayBookingsPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryDayBookings;
type

 queryDayBookingsItem = class(TInterfacedObject,IFunctionItem)
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

procedure queryDayBookingsItem.ChangeTheme;
begin

end;

constructor queryDayBookingsItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryDayBookingsItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryDayBookings,frmQueryDayBookings,self);
end;


function queryDayBookingsItem.getDescribe: String;
begin
  Result:='预售票日报表';
end;
function queryDayBookingsItem.getKey: TGUID;
begin
  Result:=StringToGUID('{7B5FDAE4-0F53-4ABA-BBBF-247CBD3AB94F}');
end;

function queryDayBookingsItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryDayBookingsItem.IsWorkState: Boolean;
begin

end;

procedure queryDayBookingsItem.Leave;
begin

end;

procedure queryDayBookingsItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
