{ ------------------------------------
  功能说明：NovaTakeTicket.bpl功能对象
  创建日期：2011/10/15
  作者：ice
  版权：nova
  ------------------------------------- }
unit NovaTakeTicketPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,Forms;

Type
{------------------------------------
  功能说明：电子票取票功能
-------------------------------------}
  TNovaTakeTicketFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmNovaTakeTicket;


{ TPrintTicketFunction }

procedure TNovaTakeTicketFunction.ChangeTheme;
begin

end;

constructor TNovaTakeTicketFunction.Create;
begin

end;

procedure TNovaTakeTicketFunction.Enter(const parameters: TFunctionItemParameters);
begin
//  Services.SysMainForm.showFormModal(TFrmNovaTakeTicket,Self);
  Services.SysMainForm.ShowForm(TFrmNovaTakeTicket,FrmNovaTakeTicket,Self);
end;

function TNovaTakeTicketFunction.getDescribe: String;
begin
  result:='南凌电子票换票';
end;

function TNovaTakeTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{D7FD56C8-888B-420C-87E4-63C312644C36}');
end;

function TNovaTakeTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TNovaTakeTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TNovaTakeTicketFunction.Leave;
begin

end;

procedure TNovaTakeTicketFunction.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
