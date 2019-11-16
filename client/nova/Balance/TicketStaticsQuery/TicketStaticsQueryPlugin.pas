unit TicketStaticsQueryPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
  TStaticsTicketFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmTicketStaticsQuery;


{ TTicketSaleFunction }

procedure TStaticsTicketFunction.ChangeTheme;
begin

end;

constructor TStaticsTicketFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TStaticsTicketFunction.Enter(const parameters: TFunctionItemParameters);
begin

  SysMainForm.ShowForm(TFrmTicketStaticsQuery,FrmTicketStaticsQuery,self);

end;

function TStaticsTicketFunction.getDescribe: String;
begin
  Result:='营收统计查询功能';
end;

function TStaticsTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{73A6D49C-B76E-429B-9B6B-D2DBCC4632D2}');
end;

function TStaticsTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TStaticsTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TStaticsTicketFunction.Leave;
begin

end;

procedure TStaticsTicketFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
