{ ------------------------------------
  ����˵����ViewSchedulestops.bpl���ܶ���
  �������ڣ�2011/4/12
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit ViewSchedulestopsPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
{------------------------------------
  ����˵������ʾͣ������ϸ����
-------------------------------------}
  TViewSchedulestopsFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmViewSchedulestops;


{ TTicketSaleFunction }

procedure TViewSchedulestopsFunction.ChangeTheme;
begin

end;

constructor TViewSchedulestopsFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TViewSchedulestopsFunction.Enter(const parameters: TFunctionItemParameters);
begin
  SysMainForm.showFormModal(TFrmViewSchedulestops,self,parameters,false);
//  FrmViewSchedulestops := TFrmViewSchedulestops.Create(Application);
end;

function TViewSchedulestopsFunction.getDescribe: String;
begin
  Result:='��ʾ�����ϸ�б���:����0Ϊ��μƻ�ID������1Ϊ����վID������2Ϊ�Ƿ�������Ρ�����3Ϊ��η������ڡ�����4Ϊ���SYNCCODE������5Ϊ����վCODE';
end;

function TViewSchedulestopsFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{846C8762-1903-48B1-AFC7-B1629A5DE4A8}');
end;

function TViewSchedulestopsFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TViewSchedulestopsFunction.IsWorkState: Boolean;
begin

end;

procedure TViewSchedulestopsFunction.Leave;
begin

end;

procedure TViewSchedulestopsFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
