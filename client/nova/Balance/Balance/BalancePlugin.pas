unit BalancePlugin;



{ ------------------------------------
  ����˵����Balance.bpl�����Ԫ
  �������ڣ�2011.06.22
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TBalanceFunctionItem = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;
  {------------------------------------
  ����˵�����а��������
-------------------------------------}
  Type
  TPackBalance = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;
    {------------------------------------
  ����˵�����а�ǰ̨����
-------------------------------------}
  Type
  TPackArrive = class(TInterfacedObject, IFunctionItem)
  private
    FSubFunctionList: TList<TSubfunction>;
    function getKey: TGUID;
  public
    constructor Create();
    procedure Enter(const parameters: TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters: TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState: Boolean;
    function getDescribe: String;
    function getSubFunctionList: TList<TSubfunction>;
    property key: TGUID read getKey;
  end;

implementation

uses Services, UFrmBalance, MainFormIntf,UFrmPackArrive,UFrmPackBalance;

{ TScheduleFunctionItem }

procedure TBalanceFunctionItem.ChangeTheme;
begin

end;

constructor TBalanceFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TBalanceFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmBalance, FrmBalance,self);
end;

function TBalanceFunctionItem.getDescribe: String;
begin
  Result := '���㵥����';
end;

function TBalanceFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{E1466135-2D58-4F98-8C75-F861F66CB3B5}');
end;

function TBalanceFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TBalanceFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TBalanceFunctionItem.Leave;
begin

end;

procedure TBalanceFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;
{ �а�������� }

procedure TPackArrive.ChangeTheme;
begin

end;

constructor TPackArrive.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPackArrive.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPackArrive, FrmPackArrive,self);
end;

function TPackArrive.getDescribe: String;
begin
  Result := '�а��������';
end;

function TPackArrive.getKey: TGUID;
begin
  Result := StringToGUID('{87C00312-6B3F-41D5-BEAA-E5E222EC5094}');
end;

function TPackArrive.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TPackArrive.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPackArrive.Leave;
begin

end;

procedure TPackArrive.refresh
  (const parameters: TFunctionItemParameters);
begin

end;
{ �а�ǰ̨���� }

procedure TPackBalance.ChangeTheme;
begin

end;

constructor TPackBalance.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TPackBalance.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPackBalance, FrmPackBalance,self);
end;

function TPackBalance.getDescribe: String;
begin
  Result := '�а�ǰ̨����';
end;

function TPackBalance.getKey: TGUID;
begin
  Result := StringToGUID('{74322CD5-873C-4F96-87EE-0A022796025E}');
end;

function TPackBalance.getSubFunctionList: TList<TSubfunction>;
begin
  Result :=FSubFunctionList; //TFrmDeductitemApply.getSubFunctionList;
end;

function TPackBalance.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TPackBalance.Leave;
begin

end;

procedure TPackBalance.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
