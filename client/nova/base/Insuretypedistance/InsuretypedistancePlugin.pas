unit InsuretypedistancePlugin;

interface

uses SysUtils, Classes, FunctionItemIntf, Generics.Collections;

Type
  TInsuretypedistanceFunctionItem = class(TInterfacedObject, IFunctionItem)
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
  TInsuretypepriceFunctionItem = class(TInterfacedObject, IFunctionItem)
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

uses Services, UFrmInsuretypedistance, MainFormIntf,UFrmInsuretypeticketprice;

{ 里程 }

procedure TInsuretypedistanceFunctionItem.ChangeTheme;
begin

end;

constructor TInsuretypedistanceFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TInsuretypedistanceFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmInsuretypedistance, FrmInsuretypedistance,self);
end;

function TInsuretypedistanceFunctionItem.getDescribe: String;
begin
  Result := '保险类型里程相关';
end;

function TInsuretypedistanceFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{5EB7DB5A-C947-4813-9F42-B08075D03CB4}');
end;

function TInsuretypedistanceFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TInsuretypedistanceFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TInsuretypedistanceFunctionItem.Leave;
begin

end;

procedure TInsuretypedistanceFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;
{ 票价 }

procedure TInsuretypepriceFunctionItem.ChangeTheme;
begin

end;

constructor TInsuretypepriceFunctionItem.Create;
begin
  FSubFunctionList := TList<TSubfunction>.Create;
end;

procedure TInsuretypepriceFunctionItem.Enter
  (const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TfrmInsuretypeticketprice,frmInsuretypeticketprice ,self);
end;

function TInsuretypepriceFunctionItem.getDescribe: String;
begin
  Result := '保险类型票价相关';
end;

function TInsuretypepriceFunctionItem.getKey: TGUID;
begin
  Result := StringToGUID('{15F7E53D-313E-446E-9389-942FD5BD2F4F}');
end;

function TInsuretypepriceFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TInsuretypepriceFunctionItem.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TInsuretypepriceFunctionItem.Leave;
begin

end;

procedure TInsuretypepriceFunctionItem.refresh
  (const parameters: TFunctionItemParameters);
begin

end;

end.
