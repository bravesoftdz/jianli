unit TicketentrancePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmTicketentrance,UFrmTicketentranceEdit;
type
TticketentranceManager = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
   // constructor Create();
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

procedure TticketentranceManager.ChangeTheme;
begin

end;

procedure TticketentranceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmTicketentrance,FrmTicketentrance,self);
end;

function TticketentranceManager.getDescribe: String;
begin
  Result:='业务管理模块--检票口设置';
end;
function TticketentranceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{BBB24592-4B35-49A3-87F5-813D4BAF59E5}');
end;

function TticketentranceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:= FSubFunctionList;
end;

function TticketentranceManager.IsWorkState: Boolean;
begin

end;

procedure TticketentranceManager.Leave;
begin

end;

procedure TticketentranceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
