unit DispatchManagePlugin;
{ ------------------------------------
  功能说明：DispatchManage.bpl插件单元
  创建日期：2011.03.16
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TDispatchManageItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

  TICReportItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmDispatchManage, MainFormIntf;

{ TScheduleFunctionItem }

procedure TDispatchManageItemFunctionItem.ChangeTheme;
begin

end;

constructor TDispatchManageItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TDispatchManageItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDispatchManage, FrmDispatchManage,self);
end;

function TDispatchManageItemFunctionItem.getDescribe: String;
begin
  Result := '综合调度管理';
end;

function TDispatchManageItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{D1A84A36-DD5D-4C9B-8EA6-BFFD8E04BB3C}');
end;

function TDispatchManageItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TDispatchManageItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TDispatchManageItemFunctionItem.Leave;
begin

end;

procedure TDispatchManageItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

{ TICReportItemFunctionItem }

procedure TICReportItemFunctionItem.ChangeTheme;
begin

end;

constructor TICReportItemFunctionItem.Create;
begin

end;

procedure TICReportItemFunctionItem.Enter(
  const parameters: TFunctionItemParameters);
begin

end;

function TICReportItemFunctionItem.getDescribe: String;
begin
  Result := 'IC卡报班';
end;

function TICReportItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{E74E7BED-361F-410C-8A06-75861F35BA71}');
end;

function TICReportItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TICReportItemFunctionItem.IsWorkState: Boolean;
begin

end;

procedure TICReportItemFunctionItem.Leave;
begin

end;

procedure TICReportItemFunctionItem.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
