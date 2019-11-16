{ ------------------------------------
  功能说明：ViewSchedulestops.bpl功能对象
  创建日期：2011/4/12
  作者：ice
  版权：nova
  ------------------------------------- }
unit ViewSchedulestopsPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
     Forms;

Type
{------------------------------------
  功能说明：显示停靠点明细功能
-------------------------------------}
  TViewSchedulestopsFunction=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf, UFrmViewSchedulestops;


{ TTicketSaleFunction }

procedure TViewSchedulestopsFunction.ChangeTheme;
begin

end;

constructor TViewSchedulestopsFunction.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TViewSchedulestopsFunction.Enter(const parameters: TFunctionItemParameters);
begin
  SysMainForm.showFormModal(TFrmViewSchedulestops,self,parameters,false);
//  FrmViewSchedulestops := TFrmViewSchedulestops.Create(Application);
end;

function TViewSchedulestopsFunction.getDescribe: String;
begin
  Result:='显示班次明细列表功能:参数0为班次计划ID、参数1为发车站ID、参数2为是否联网班次、参数3为班次发车日期、参数4为班次SYNCCODE、参数5为发车站CODE';
end;

function TViewSchedulestopsFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{846C8762-1903-48B1-AFC7-B1629A5DE4A8}');
end;

function TViewSchedulestopsFunction.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TViewSchedulestopsFunction.IsWorkState: Boolean;
begin

end;

procedure TViewSchedulestopsFunction.Leave;
begin

end;

procedure TViewSchedulestopsFunction.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
