{------------------------------------
  ����˵����Role.bpl���������
  �������ڣ�2010.12.01
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit RolePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TRoleFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmRole,MainFormIntf,UFrmRoleAdd;


{ TRoleList }

procedure TRoleFunctionItem.ChangeTheme;
begin

end;

constructor TRoleFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TRoleFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmRole,FrmRole,self);
end;
function TRoleFunctionItem.getDescribe: String;
begin
  Result:='��ɫ��Ϣ';
end;

function TRoleFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{94D664B0-CF3C-4D6C-B9AF-0FBF113A2877}');
end;

function TRoleFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TRoleFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TRoleFunctionItem.Leave;
begin

end;

procedure TRoleFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
