unit EachTickeIncomeSumRptPlugin;



interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmEachTickeIncomeSumRpt;
type

//各站互售互退营收汇总表
 EachTickeIncomeSumRptManager = class(TInterfacedObject,IFunctionItem)
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

procedure EachTickeIncomeSumRptManager.ChangeTheme;
begin

end;

constructor EachTickeIncomeSumRptManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure EachTickeIncomeSumRptManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmEachTickeIncomeSumRpt,frmEachTickeIncomeSumRpt,self);
end;


function EachTickeIncomeSumRptManager.getDescribe: String;
begin
  Result:='各站互售互退营收汇总表';
end;
function EachTickeIncomeSumRptManager.getKey: TGUID;
begin
  Result:=StringToGUID('{A9CDA190-EDA1-4B2F-8AD8-236A316D956C}');
end;

function EachTickeIncomeSumRptManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function EachTickeIncomeSumRptManager.IsWorkState: Boolean;
begin

end;

procedure EachTickeIncomeSumRptManager.Leave;
begin

end;

procedure EachTickeIncomeSumRptManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
