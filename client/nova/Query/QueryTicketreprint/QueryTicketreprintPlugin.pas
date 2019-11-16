unit QueryTicketreprintPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TQueryTicketreprintExport=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmQueryTicketreprint;

{ SysMenu }

procedure TQueryTicketreprintExport.ChangeTheme;
begin

end;

constructor TQueryTicketreprintExport.Create;
begin
end;

procedure TQueryTicketreprintExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  Services.SysMainForm.ShowForm(TFrmQueryTicketreprint, FrmQueryTicketreprint,self);
end;

function TQueryTicketreprintExport.getDescribe: String;
begin
  Result:='车票换号重打查询';
end;

function TQueryTicketreprintExport.getKey: TGUID;
begin
  Result:=StringToGUID('{1D75BA2B-D31B-4704-9E26-9A15D4EC40E7}');
end;

function TQueryTicketreprintExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TQueryTicketreprintExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TQueryTicketreprintExport.Leave;
begin

end;

procedure TQueryTicketreprintExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
