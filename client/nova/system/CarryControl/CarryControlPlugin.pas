{ ------------------------------------
  ����˵����CarryControl.bpl���ܶ���
  �������ڣ�2011/3/21
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit CarryControlPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
{------------------------------------
  ����˵������·������
-------------------------------------}

  TCarryControlManager=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmCarryControl,MainFormIntf;


{ TCarryControlManager }

procedure TCarryControlManager.ChangeTheme;
begin

end;

constructor TCarryControlManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TCarryControlManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmCarryControl,FrmCarryControl,Self);
end;

function TCarryControlManager.getDescribe: String;
begin
  Result:='���ڱ�����Ĺ�����Ϣ';
end;

function TCarryControlManager.getKey: TGUID;
begin
  Result:=StringToGUID('{451EF758-38CB-456C-9237-F7F8BCA1C080}');
end;

function TCarryControlManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TCarryControlManager.IsWorkState: Boolean;
begin

end;

procedure TCarryControlManager.Leave;
begin

end;

procedure TCarryControlManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
