{ ------------------------------------
  功能说明：InitBillNo.bpl功能对象
  创建日期：2011/4/12
  作者：ice
  版权：nova
  ------------------------------------- }
unit InitBillNoPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UFrmInitBillNo,Forms;

Type
{------------------------------------
  功能说明：票号初始化功能
-------------------------------------}

  TInitBillNoFunction=class(TInterfacedObject,IFunctionItem)
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


{ TInitBillNoFunction }

procedure TInitBillNoFunction.ChangeTheme;
begin

end;

constructor TInitBillNoFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

//parameters 票据类型编码
procedure TInitBillNoFunction.Enter(const parameters: TFunctionItemParameters);
begin
  if (parameters=nil) or (parameters.Count=0) then
  begin
    raise Exception.Create('“票号初始化”需要指定票据类型');
  end;
  frmInitBillNo:=TFrmInitBillNo.create(application);
  try
    frmInitBillNo.billCode:=parameters.Strings[0];
    Services.SysMainForm.showFormModal(frmInitBillNo);
  finally
  end;
end;

function TInitBillNoFunction.getDescribe: String;
begin
  Result:='初始化票号';
end;

function TInitBillNoFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}');
end;

function TInitBillNoFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TInitBillNoFunction.IsWorkState: Boolean;
begin

end;

procedure TInitBillNoFunction.Leave;
begin

end;

procedure TInitBillNoFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
