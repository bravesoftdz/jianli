{ ------------------------------------
  功能说明：TicketCancel.bpl功能对象
  创建日期：2011/4/16
  作者：ice
  版权：nova
  ------------------------------------- }
unit TicketCancelPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
{------------------------------------
  功能说明：废票功能
-------------------------------------}
  TCancelTicketFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmTicketCancel;


{ TTicketSaleFunction }

procedure TCancelTicketFunction.ChangeTheme;
begin

end;

constructor TCancelTicketFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TCancelTicketFunction.Enter(const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmTicketCancel,FrmTicketCancel,self);
//  FrmTicketCancel := TFrmTicketCancel.Create(Application);
end;

function TCancelTicketFunction.getDescribe: String;
begin
  Result:='废票功能';
end;

function TCancelTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{1872AE2C-3310-4EE4-8C73-95899E31675B}');
end;

function TCancelTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TCancelTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TCancelTicketFunction.Leave;
begin

end;

procedure TCancelTicketFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
