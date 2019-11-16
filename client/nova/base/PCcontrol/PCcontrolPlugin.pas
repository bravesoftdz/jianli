unit PCcontrolPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmPCcontrol,UFrmPCcontrolEdit;
type
 PCcontrols = class(TInterfacedObject,IFunctionItem)
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

  PCcontrolEdit = class(TInterfacedObject,IFunctionItem)
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

procedure PCcontrols.ChangeTheme;
begin

end;

procedure PCcontrols.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmPCcontrol,frmPCcontrol,self);
end;

constructor PCcontrolEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

function PCcontrols.getDescribe: String;
begin
  Result:='业务管理--售票电脑可售班次控制';
end;
function PCcontrols.getKey: TGUID;
begin
  Result:=StringToGUID('{E37B89E0-5F37-4F29-BE72-417F15F088D0}');
end;

function PCcontrols.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=frmPCcontrolEdit.getSubFunctionList;
end;

function PCcontrols.IsWorkState: Boolean;
begin

end;

procedure PCcontrols.Leave;
begin

end;

procedure PCcontrols.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {PCcontrolEdit 编辑窗口}
procedure PCcontrolEdit.ChangeTheme;
begin

end;

procedure PCcontrolEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmPCcontrolEdit,frmPCcontrolEdit,self);
end;

function PCcontrolEdit.getDescribe: String;
begin
  Result:='编辑售票电脑可售班次信息';
end;

function PCcontrolEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{F24F6E22-93C9-4E29-AF69-F9110121D36B}');
end;

function PCcontrolEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function PCcontrolEdit.IsWorkState: Boolean;
begin

end;

procedure PCcontrolEdit.Leave;
begin

end;

procedure PCcontrolEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
