unit QueryBalanceitemManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TBalanceitemManagerExport=class(TInterfacedObject,IFunctionItem)
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
  TQryTakeTicketLogManagerExport=class(TInterfacedObject,IFunctionItem)
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
  uses Services, MainFormIntf, UFrmQueryBalanceitem,UFrmQryTakeTicketLog;

{ SysMenuManager }

procedure TBalanceitemManagerExport.ChangeTheme;
begin

end;

constructor TBalanceitemManagerExport.Create;
begin
end;

procedure TBalanceitemManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters<>nil then
  begin
    for I := 0 to parameters.Count - 1 do
      SysDialogs.ShowMessage('功能参数'+IntToStr(i)+':'+parameters.Strings[i]);
  end;
  Services.SysMainForm.ShowForm(TFrmQueryBalanceitem, FrmQueryBalanceitem,self);
end;

function TBalanceitemManagerExport.getDescribe: String;
begin
  Result:='运费结算明细表';
end;

function TBalanceitemManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{35FF1FD2-B078-45F0-95C5-F2C740D729DF}');
end;

function TBalanceitemManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TBalanceitemManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TBalanceitemManagerExport.Leave;
begin

end;

procedure TBalanceitemManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;


{取票日志查询}

procedure TQryTakeTicketLogManagerExport.ChangeTheme;
begin

end;

constructor TQryTakeTicketLogManagerExport.Create;
begin
end;

procedure TQryTakeTicketLogManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  Services.SysMainForm.ShowForm(TFrmQryTakeTicketLog, FrmQryTakeTicketLog,self);
end;

function TQryTakeTicketLogManagerExport.getDescribe: String;
begin
  Result:='取票日志查询';
end;

function TQryTakeTicketLogManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{F8699BEC-4720-4F15-876F-8006C014F7D6}');
end;

function TQryTakeTicketLogManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TQryTakeTicketLogManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TQryTakeTicketLogManagerExport.Leave;
begin

end;

procedure TQryTakeTicketLogManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
