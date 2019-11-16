unit QuerySchedulePricePlugin;

{ ------------------------------------
  ����˵����QuerySchedulePrice.bpl�����Ԫ
  �������ڣ�2011.07.13
  ���ߣ�hhz
  ��Ȩ��nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  querySchedulePriceManage = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmQuerySchedulePrice, MainFormIntf;

{ TScheduleFunctionItem }

procedure querySchedulePriceManage.ChangeTheme;
begin

end;

constructor querySchedulePriceManage.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure querySchedulePriceManage.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmQuerySchedulePrice, FrmQuerySchedulePrice,self);
end;

function querySchedulePriceManage.getDescribe: String;
begin
  Result := '���Ʊ�۲�ѯ';
end;

function querySchedulePriceManage.getKey: TGUID;
begin
  Result := StringToGUID('{152CDE36-7525-4C74-9C4E-68B7BCF4A7CC}');
end;

function querySchedulePriceManage.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function querySchedulePriceManage.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure querySchedulePriceManage.Leave;
begin

end;

procedure querySchedulePriceManage.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
