{ ------------------------------------
  功能说明：TicketReturn.bpl功能对象
  创建日期：2011/4/12
  作者：ice
  版权：nova
  ------------------------------------- }
unit TicketReturnPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
{------------------------------------
  功能说明：退票功能
-------------------------------------}
  TReturnTicketFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmTicketReturn,UFrmTicketRetrunRe;


{ TTicketSaleFunction }

procedure TReturnTicketFunction.ChangeTheme;
begin

end;

constructor TReturnTicketFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TReturnTicketFunction.Enter(const parameters: TFunctionItemParameters);
begin
  //SysMainForm.ShowForm(TFrmTicketReturn,FrmTicketReturn,self);
  SysMainForm.ShowForm(TFrmTicketRetrunRe,FrmTicketRetrunRe,self);
//  FrmTicketReturn := TFrmTicketReturn.Create(Application);
end;

function TReturnTicketFunction.getDescribe: String;
begin
  Result:='退票功能';
end;

function TReturnTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{93370E13-F678-4A4C-A424-4FA831296D11}');
end;

function TReturnTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TReturnTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TReturnTicketFunction.Leave;
begin

end;

procedure TReturnTicketFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
