unit TicketReturnRateCfgPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TTicketReturnRateCfgManager=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmTicketReturnRateCfg;

{ SysMenuManager }

procedure TTicketReturnRateCfgManager.ChangeTheme;
begin

end;

constructor TTicketReturnRateCfgManager.Create;
begin
end;

procedure TTicketReturnRateCfgManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmTicketReturnRateCfg,FrmTicketReturnRateCfg,self);
end;

function TTicketReturnRateCfgManager.getDescribe: String;
begin
  Result:='«¯”Úπ‹¿Ì';
end;

function TTicketReturnRateCfgManager.getKey: TGUID;
begin
  Result:=StringToGUID('{AAA04837-2A64-4F96-AE7C-6E70EBB77646}');
end;

function TTicketReturnRateCfgManager.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TTicketReturnRateCfgManager.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TTicketReturnRateCfgManager.Leave;
begin

end;

procedure TTicketReturnRateCfgManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
