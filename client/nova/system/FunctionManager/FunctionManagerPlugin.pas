{ ------------------------------------
  ����˵����FunctionManager.bpl���ܶ���
  �������ڣ�2011.7.1
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit FunctionManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UFrmFunctionManager;

Type
{------------------------------------
  ����˵�������ܹ�����
-------------------------------------}
  TFunctionManager=class(TInterfacedObject,IFunctionItem)
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

{ TFunctionManager }

procedure TFunctionManager.ChangeTheme;
begin

end;

constructor TFunctionManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TFunctionManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmFunctionManager,FrmFunctionManager,Self);
end;

function TFunctionManager.getDescribe: String;
begin
  Result:='���ܹ���';
end;

function TFunctionManager.getKey: TGUID;
begin
  Result:=StringToGUID('{E7D6C4E5-4046-4CBE-890B-CF20D35603F0}');
end;

function TFunctionManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TFunctionManager.IsWorkState: Boolean;
begin

end;

procedure TFunctionManager.Leave;
begin

end;

procedure TFunctionManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
