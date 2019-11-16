unit DeductitemPlugin;

{ ------------------------------------
  功能说明：Deductitem.bpl插件单元
  创建日期：2011.06.13
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TDeductItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmDeductItem, MainFormIntf;

{ TScheduleFunctionItem }

procedure TDeductItemFunctionItem.ChangeTheme;
begin

end;

constructor TDeductItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TDeductItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDeductItem, FrmDeductItem,self);
end;

function TDeductItemFunctionItem.getDescribe: String;
begin
  Result := '结算固定扣费项目管理';
end;

function TDeductItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{85C4570B-E137-4CD3-915B-4084EE9BF923}');
end;

function TDeductItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TDeductItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TDeductItemFunctionItem.Leave;
begin

end;

procedure TDeductItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
