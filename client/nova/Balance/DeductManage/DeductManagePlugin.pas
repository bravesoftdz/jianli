unit DeductManagePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmDeductManage;

Type
{------------------------------------
  功能说明：扣费管理功能
-------------------------------------}
  TDeductManager=class(TInterfacedObject,IFunctionItem)
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

{ TDeductManager }

procedure TDeductManager.ChangeTheme;
begin

end;

constructor TDeductManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TDeductManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDeductManage,FrmDeductManage,Self);
end;

function TDeductManager.getDescribe: String;
begin
  Result:='扣费管理';
end;

function TDeductManager.getKey: TGUID;
begin
  Result:=StringToGUID('{690C3DBA-E075-449F-9061-FF363E504B7D}');
end;

function TDeductManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDeductManager.IsWorkState: Boolean;
begin

end;

procedure TDeductManager.Leave;
begin

end;

procedure TDeductManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
