unit TicketSaleQryPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFocusSaleLocalQry,
  UFrmFocusSaleOtherQry;
type

 //����ʽ�۱���Ʊ
    FocusSaleLocalManager = class(TInterfacedObject,IFunctionItem)
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

  //����ʽ�����Ʊ
   FocusSaleOtherManager = class(TInterfacedObject,IFunctionItem)
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

//�۱���Ʊ
procedure FocusSaleLocalManager.ChangeTheme;
begin

end;

constructor FocusSaleLocalManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure FocusSaleLocalManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(,frmSaleLocalTicketQry);
end;


function FocusSaleLocalManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--����ʽ��վ�۱�վ���';
end;
function SaleLocalManager.getKey: TGUID;
begin
  Result:=StringToGUID('{C251A299-B45C-4245-BC31-0AC33E8572B0}');
end;

function FocusSaleLocalManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function FocusSaleLocalManager.IsWorkState: Boolean;
begin

end;

procedure FocusSaleLocalManager.Leave;
begin

end;

procedure FocusSaleLocalManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//�����Ʊ
procedure SaleOtherManager.ChangeTheme;
begin

end;

constructor SaleOtherManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SaleOtherManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSaleOtherTicketQry,frmSaleOtherTicketQry);
end;


function SaleOtherManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--����ʽ��վ����վ���';
end;
function SaleOtherManager.getKey: TGUID;
begin
  Result:=StringToGUID('{275A0E4A-B185-448B-901E-072DFB3ECB98}');
end;

function SaleOtherManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function SaleOtherManager.IsWorkState: Boolean;
begin

end;

procedure SaleOtherManager.Leave;
begin

end;

procedure SaleOtherManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
