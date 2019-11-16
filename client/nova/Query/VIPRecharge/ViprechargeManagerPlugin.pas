unit ViprechargeManagerPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  TViprechargeManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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

  TVipconsumeManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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

  TVipsellticketManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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

  TVipcardturnoverManagerExport=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmViprecharge, UFrmVipconsume, UFrmVipsellticket, UFrmQueryVipcardturnover;

{ SysMenuManager }

procedure TViprechargeManagerExport.ChangeTheme;
begin

end;

constructor TViprechargeManagerExport.Create;
begin
end;

procedure TViprechargeManagerExport.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
    i:Integer;
begin
  if parameters.Strings[0]='1' then
    SysMainForm.showFormModal(TFrmVipRecharge,self,parameters,false)
  else
    SysMainForm.ShowForm(TFrmVipRecharge,FrmVipRecharge,self,parameters);
end;

function TViprechargeManagerExport.getDescribe: String;
begin
  Result:='VIP充值明细';
end;

function TViprechargeManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{E39A6A01-67CD-4E5E-A46B-D033FCBF4239}');
end;

function TViprechargeManagerExport.getSubFunctionList: TList<TSubfunction>;
begin
  // Result:=TFrmArea.getSubFunctionList;
end;

function TViprechargeManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TViprechargeManagerExport.Leave;
begin

end;

procedure TViprechargeManagerExport.refresh(const parameters: TFunctionItemParameters);
begin

end;
{ TVipconsumeManagerExport }

procedure TVipconsumeManagerExport.ChangeTheme;
begin

end;

constructor TVipconsumeManagerExport.Create;
begin

end;

procedure TVipconsumeManagerExport.Enter(
  const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmVipConsume,FrmVipConsume,self,parameters);
end;

function TVipconsumeManagerExport.getDescribe: String;
begin
  Result := 'VIP消费明细';
end;

function TVipconsumeManagerExport.getKey: TGUID;
begin
  Result:=StringToGUID('{1B47A964-83BE-4AAF-B74B-F60535F5836A}');
end;

function TVipconsumeManagerExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TVipconsumeManagerExport.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure TVipconsumeManagerExport.Leave;
begin

end;

procedure TVipconsumeManagerExport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TVipsellticketManagerExport }

procedure TVipsellticketManagerExport.ChangeTheme;
begin

end;

constructor TVipsellticketManagerExport.Create;
begin

end;

procedure TVipsellticketManagerExport.Enter(
  const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmVipsellticket,FrmVipsellticket,self,parameters);
end;

function TVipsellticketManagerExport.getDescribe: String;
begin
  Result := 'VIP购票汇总';
end;

function TVipsellticketManagerExport.getKey: TGUID;
begin
  Result := StringToGUID('{FA2B1F14-F426-4CBC-99B5-74C0F829B5F5}');
end;

function TVipsellticketManagerExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TVipsellticketManagerExport.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TVipsellticketManagerExport.Leave;
begin

end;

procedure TVipsellticketManagerExport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

{ TVipcardturnoverManagerExport }

procedure TVipcardturnoverManagerExport.ChangeTheme;
begin

end;

constructor TVipcardturnoverManagerExport.Create;
begin

end;

procedure TVipcardturnoverManagerExport.Enter(
  const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmQueryVipturnover,FrmQueryVipturnover,self,parameters);
end;

function TVipcardturnoverManagerExport.getDescribe: String;
begin
  Result := 'VIP已缴款查询';
end;

function TVipcardturnoverManagerExport.getKey: TGUID;
begin
  Result := StringToGUID('{044D3AB6-1FEA-4E8B-BF22-66434305423B}');
end;

function TVipcardturnoverManagerExport.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TVipcardturnoverManagerExport.IsWorkState: Boolean;
begin
  Result := True;
end;

procedure TVipcardturnoverManagerExport.Leave;
begin

end;

procedure TVipcardturnoverManagerExport.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
