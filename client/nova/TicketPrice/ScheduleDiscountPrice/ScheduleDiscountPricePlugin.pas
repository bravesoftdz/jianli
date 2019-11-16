unit ScheduleDiscountPricePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TScheduleDiscountPrice = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmScheduleDiscountPrice, MainFormIntf;

{ TScheduleFunctionItem }

procedure TScheduleDiscountPrice.ChangeTheme;
begin

end;

constructor TScheduleDiscountPrice.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TScheduleDiscountPrice.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmScheduleDiscountPrice, FrmScheduleDiscountPrice,self);
end;

function TScheduleDiscountPrice.getDescribe: String;
begin
  Result := '优惠票价信息';
end;

function TScheduleDiscountPrice.getKey: TGUID;
begin
  Result := StringToGUID('{F0A84769-70E3-CEEC-FAE4-CD76D9A9D8B2}');
end;

function TScheduleDiscountPrice.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TScheduleDiscountPrice.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TScheduleDiscountPrice.Leave;
begin

end;

procedure TScheduleDiscountPrice.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
