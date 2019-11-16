unit PCticketentrancePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmPCticketentrance,
UFrmPCticketentrnaceEdit;
type
 PCEntrance = class(TInterfacedObject,IFunctionItem)
    private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

  PCEntranceEdit = class(TInterfacedObject,IFunctionItem)
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

procedure PCEntrance.ChangeTheme;
begin

end;

procedure PCEntrance.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TPCticketentrance,PCticketentrance,self);
end;


function PCEntrance.getDescribe: String;
begin
  Result:='业务管理--检票电脑控制';
end;
function PCEntrance.getKey: TGUID;
begin
  Result:=StringToGUID('{9661514A-FA79-4A75-8DB6-D0F2D1BE3980}');
end;

function PCEntrance.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmPCentranceEdit.getSubFunctionList;
end;

function PCEntrance.IsWorkState: Boolean;
begin

end;

procedure PCEntrance.Leave;
begin

end;

procedure PCEntrance.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {PCcontrolEdit 编辑窗口}
procedure PCEntranceEdit.ChangeTheme;
begin

end;

procedure PCEntranceEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmPCticketentrnceEdit,frmPCentranceEdit);
end;

constructor PCEntranceEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function PCEntranceEdit.getDescribe: String;
begin
  Result:='编辑检票电脑控制';
end;

function PCEntranceEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{CCADD03B-7CE5-4E06-9DA0-06050D747E0B}');
end;

function PCEntranceEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function PCEntranceEdit.IsWorkState: Boolean;
begin

end;

procedure PCEntranceEdit.Leave;
begin

end;

procedure PCEntranceEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
