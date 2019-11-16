unit QueryBalancedPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryBalanced;
type

//�ѽ��㵥��ѯ
 queryBalancedManager = class(TInterfacedObject,IFunctionItem)
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
  //�а��ѽ��˵���ѯ
 packqryBalanceManager = class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf,UFrmQryPackBalance;

procedure queryBalancedManager.ChangeTheme;
begin

end;

constructor queryBalancedManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryBalancedManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryBalanced,frmQueryBalanced,Self);
end;


function queryBalancedManager.getDescribe: String;
begin
  Result:='�������--�ѽ����ѯ';
end;
function queryBalancedManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9BC4A19C-CA01-4400-B7F3-82278DB41B11}');
end;

function queryBalancedManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryBalancedManager.IsWorkState: Boolean;
begin

end;

procedure queryBalancedManager.Leave;
begin

end;

procedure queryBalancedManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

{�а��ѽ��˲�ѯ}
procedure packqryBalanceManager.ChangeTheme;
begin

end;

constructor packqryBalanceManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure packqryBalanceManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmQryPackBalance,FrmQryPackBalance,Self);
end;


function packqryBalanceManager.getDescribe: String;
begin
  Result:='�а�����--�а��ѽ��˲�ѯ';
end;
function packqryBalanceManager.getKey: TGUID;
begin
  Result:=StringToGUID('{BF5B8885-7473-4AC8-AA8A-75B50D84A58A}');
end;

function packqryBalanceManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function packqryBalanceManager.IsWorkState: Boolean;
begin

end;

procedure packqryBalanceManager.Leave;
begin

end;

procedure packqryBalanceManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
