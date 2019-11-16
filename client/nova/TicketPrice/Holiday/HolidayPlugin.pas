unit HolidayPlugin;


{ ------------------------------------
  功能说明：Holiday.bpl插件单元
  创建日期：2011.04.27
  作者：lanckun
  版权：nova
  ------------------------------------- }
interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  THolidayItemFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmHoliday, MainFormIntf;

{ TScheduleFunctionItem }

procedure THolidayItemFunctionItem.ChangeTheme;
begin

end;

constructor THolidayItemFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure THolidayItemFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmHoliday, FrmHoliday,self);
end;

function THolidayItemFunctionItem.getDescribe: String;
begin
  Result := '节日信息';
end;

function THolidayItemFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{4C23E9BB-B794-4136-9652-756B801B7BCC}');
end;

function THolidayItemFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function THolidayItemFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure THolidayItemFunctionItem.Leave;
begin

end;

procedure THolidayItemFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
