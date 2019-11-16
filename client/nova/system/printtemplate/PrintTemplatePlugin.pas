{ ------------------------------------
  ����˵����PrintTemplate.bpl���ܶ���
  �������ڣ�2011.3.04
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit PrintTemplatePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UFrmPrintTemplate,
  UFrmPrintTemplateType;

Type
{------------------------------------
  ����˵������ӡģ�����͹�����
-------------------------------------}
  TPrintTemplateTypeManager=class(TInterfacedObject,IFunctionItem)
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

{------------------------------------
  ����˵������ӡģ�������
-------------------------------------}
  TPrintTemplateManager=class(TInterfacedObject,IFunctionItem)
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

{ TPrintTemplateTypeManager }

procedure TPrintTemplateTypeManager.ChangeTheme;
begin

end;

constructor TPrintTemplateTypeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TPrintTemplateTypeManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPrintTemplateType,FrmPrintTemplateType,Self);
end;

function TPrintTemplateTypeManager.getDescribe: String;
begin
  Result:='��ӡģ�����͹���';
end;

function TPrintTemplateTypeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{317B487F-BBF6-43CA-84A2-13F4BA9A78AE}');
end;

function TPrintTemplateTypeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPrintTemplateTypeManager.IsWorkState: Boolean;
begin

end;

procedure TPrintTemplateTypeManager.Leave;
begin

end;

procedure TPrintTemplateTypeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

{ TVehicleseatplanManager }
procedure TPrintTemplateManager.ChangeTheme;
begin

end;

constructor TPrintTemplateManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TPrintTemplateManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmPrintTemplate,FrmPrintTemplate,Self);
end;

function TPrintTemplateManager.getDescribe: String;
begin
  Result:='��ӡģ�����';
end;

function TPrintTemplateManager.getKey: TGUID;
begin
  Result:=StringToGUID('{0FBE208D-EB77-4D07-91F1-7C151B6FA3E5}');
end;

function TPrintTemplateManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPrintTemplateManager.IsWorkState: Boolean;
begin

end;

procedure TPrintTemplateManager.Leave;
begin

end;

procedure TPrintTemplateManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
