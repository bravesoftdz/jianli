{ ------------------------------------
  ����˵����TakeTicket.bpl���ܶ���
  �������ڣ�2011/10/15
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit TakeTicketPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,Forms;

Type
{------------------------------------
  ����˵��������ƱȡƱ����
-------------------------------------}
  TTakeTicketFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmTakeTicket;


{ TPrintTicketFunction }

procedure TTakeTicketFunction.ChangeTheme;
begin

end;

constructor TTakeTicketFunction.Create;
begin

end;

procedure TTakeTicketFunction.Enter(const parameters: TFunctionItemParameters);
begin
//  Services.SysMainForm.showFormModal(TFrmTakeTicket,Self);
  Services.SysMainForm.ShowForm(TFrmTakeTicket,FrmTakeTicket,Self);
end;

function TTakeTicketFunction.getDescribe: String;
begin
  result:='����Ʊ��Ʊ';
end;

function TTakeTicketFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{E1B104A7-C2CA-4C22-B258-BC37EBF198BA}');
end;

function TTakeTicketFunction.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TTakeTicketFunction.IsWorkState: Boolean;
begin

end;

procedure TTakeTicketFunction.Leave;
begin

end;

procedure TTakeTicketFunction.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
