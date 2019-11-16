unit QueryScheduleMissPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryScheduleMiss;
type

//���߷���ʱ���
 queryScheduleMissManager = class(TInterfacedObject,IFunctionItem)
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

procedure queryScheduleMissManager.ChangeTheme;
begin

end;

constructor queryScheduleMissManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure queryScheduleMissManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryScheduleMiss,frmQueryScheduleMiss,self);
end;


function queryScheduleMissManager.getDescribe: String;
begin
  Result:='��Ʊ��ѯ--���©�������ѯ';
end;
function queryScheduleMissManager.getKey: TGUID;
begin
  Result:=StringToGUID('{55FE7C10-8D85-4717-AF37-B5C6225D3EAF}');
end;

function queryScheduleMissManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryScheduleMissManager.IsWorkState: Boolean;
begin

end;

procedure queryScheduleMissManager.Leave;
begin

end;

procedure queryScheduleMissManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
