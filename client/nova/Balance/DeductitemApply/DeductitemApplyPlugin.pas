unit DeductitemApplyPlugin;


{ ------------------------------------
  ����˵����DeductitemApply.bpl�����Ԫ
  �������ڣ�2011.06.08
  ���ߣ�lanckun
  ��Ȩ��nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TDeductItemApplyFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmDeductitemApply, MainFormIntf;

{ TScheduleFunctionItem }

procedure TDeductItemApplyFunctionItem.ChangeTheme;
begin

end;

constructor TDeductItemApplyFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TDeductItemApplyFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDeductitemApply, FrmDeductitemApply,Self);
end;

function TDeductItemApplyFunctionItem.getDescribe: String;
begin
  Result := '����̶��۷���ĿӦ��';
end;

function TDeductItemApplyFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{6CC23832-F449-4C41-B7FB-BF20555AB4ED}');
end;

function TDeductItemApplyFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := getSubFunctionList;
end;

function TDeductItemApplyFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TDeductItemApplyFunctionItem.Leave;
begin

end;

procedure TDeductItemApplyFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
