{ ------------------------------------
  ����˵����InsureSale.bpl���ܶ���
  �������ڣ�2011/7/4
  ���ߣ�ice
  ��Ȩ��nova
  ------------------------------------- }
unit InsureSalePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
{------------------------------------
  ����˵�������۱��չ���
-------------------------------------}
  TInsureSaleFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmInsureSale;


{ TTicketSaleFunction }

procedure TInsureSaleFunction.ChangeTheme;
begin

end;

constructor TInsureSaleFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TInsureSaleFunction.Enter(const parameters: TFunctionItemParameters);
begin
  SysMainForm.ShowForm(TFrmInsureSale,FrmInsureSale,self);
end;

function TInsureSaleFunction.getDescribe: String;
begin
  Result:='���۱��չ���';
end;

function TInsureSaleFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{9980B260-30A1-4DAD-A01E-2F329D7E685A}');
end;

function TInsureSaleFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TInsureSaleFunction.IsWorkState: Boolean;
begin

end;

procedure TInsureSaleFunction.Leave;
begin

end;

procedure TInsureSaleFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
