unit SchPlanManagePlugin;

{ ------------------------------------
  功能说明：SchPlanManage.bpl输出单元
  创建日期：2012.07.19
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TSchPlanManageItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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
uses Services, UFrmSchPlanManage, MainFormIntf;


{ TSchPlanManageItemFunctionItem }

procedure TSchPlanManageItemFunctionItem.ChangeTheme;
begin

end;

constructor TSchPlanManageItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TSchPlanManageItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmSchPlanManage, FrmSchPlanManage,self,parameters,true);
end;

function TSchPlanManageItemFunctionItem.getDescribe: String;
begin
  Result := '综合调度管理';
end;

function TSchPlanManageItemFunctionItem.getKey: TGUID;
begin
 // Result := StringToGUID('{3670A819-1D06-45F8-A57F-CD67550CFABC}');
  Result := StringToGUID('{BCB36FAB-7758-48AE-A6D6-10C99B833501}');

end;

function TSchPlanManageItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TSchPlanManageItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TSchPlanManageItemFunctionItem.Leave;
begin

end;

procedure TSchPlanManageItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
