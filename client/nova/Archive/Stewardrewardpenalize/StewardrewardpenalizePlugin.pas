unit StewardrewardpenalizePlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmStewardrewardpenalizeEdit,UFrmStewardrewardpenalize;
type
 SrewardpenalizeManager = class(TInterfacedObject,IFunctionItem)
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

  SrewardpenalizeEdit = class(TInterfacedObject,IFunctionItem)
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

procedure SrewardpenalizeManager.ChangeTheme;
begin

end;

constructor SrewardpenalizeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SrewardpenalizeManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmStewardrewardpenalize,frmStewardrewardpenalize,self);
end;


function SrewardpenalizeManager.getDescribe: String;
begin
  Result:='档案管理--乘务员奖惩记录管理';
end;
function SrewardpenalizeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{E23E9176-CE06-4F2F-A5DF-C0397B75AC4E}');
end;

function SrewardpenalizeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function SrewardpenalizeManager.IsWorkState: Boolean;
begin

end;

procedure SrewardpenalizeManager.Leave;
begin

end;

procedure SrewardpenalizeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {编辑窗口}
procedure SrewardpenalizeEdit.ChangeTheme;
begin

end;

constructor SrewardpenalizeEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SrewardpenalizeEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmStewardrewardpenalize,frmStewardrewardpenalize);
end;

function SrewardpenalizeEdit.getDescribe: String;
begin
  Result:='乘务员奖惩信息编辑';
end;

function SrewardpenalizeEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{4BA84D0D-9730-448E-A2AC-7677C48AE583}');
end;

function SrewardpenalizeEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function SrewardpenalizeEdit.IsWorkState: Boolean;
begin

end;

procedure SrewardpenalizeEdit.Leave;
begin

end;

procedure SrewardpenalizeEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
