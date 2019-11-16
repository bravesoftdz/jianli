unit QueryTicketDetailPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryTicketDetail;
type

 queryTicketDetailItem = class(TInterfacedObject,IFunctionItem)
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

procedure queryTicketDetailItem.ChangeTheme;
begin

end;

constructor queryTicketDetailItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryTicketDetailItem.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryTicketDetail,frmQueryTicketDetail,self);
end;


function queryTicketDetailItem.getDescribe: String;
begin
  Result:='电子票明细查询';
end;
function queryTicketDetailItem.getKey: TGUID;
begin
  Result:=StringToGUID('{107809D0-0931-49AF-A22A-F6DBB116B3D8}');
end;

function queryTicketDetailItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryTicketDetailItem.IsWorkState: Boolean;
begin

end;

procedure queryTicketDetailItem.Leave;
begin

end;

procedure queryTicketDetailItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
