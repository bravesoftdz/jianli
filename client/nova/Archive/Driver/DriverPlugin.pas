unit DriverPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmDriver,UFrmDriverFamilyEidt,
  UFrmDriverEdit,UFrmDriverworkexperienceEdt;
type
 driverManager = class(TInterfacedObject,IFunctionItem)
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

  driverEdit = class(TInterfacedObject,IFunctionItem)
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

  familyEdit = class(TInterfacedObject,IFunctionItem)
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

  workEdit = class(TInterfacedObject,IFunctionItem)
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

procedure driverManager.ChangeTheme;
begin

end;

constructor driverManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure driverManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmDriver,frmDriver,self);
end;


function driverManager.getDescribe: String;
begin
  Result:='档案管理--驾驶员档案管理';
end;
function driverManager.getKey: TGUID;
begin
  Result:=StringToGUID('{F86A3583-4CB9-4E66-8354-E8315ECC3D6B}');
end;

function driverManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function driverManager.IsWorkState: Boolean;
begin

end;

procedure driverManager.Leave;
begin

end;

procedure driverManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {driverEdit 编辑窗口}
procedure driverEdit.ChangeTheme;
begin

end;

constructor driverEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure driverEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmDriver,frmDriver);
end;

function driverEdit.getDescribe: String;
begin
  Result:='驾驶员档案信息编辑';
end;

function driverEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{4C87052A-48D2-40EA-8D96-14BBDC846BF5}');
end;

function driverEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function driverEdit.IsWorkState: Boolean;
begin

end;

procedure driverEdit.Leave;
begin

end;

procedure driverEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;

   {familyEdit 编辑窗口}
procedure familyEdit.ChangeTheme;
begin

end;

constructor familyEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure familyEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmDriver,frmDriver);
end;

function familyEdit.getDescribe: String;
begin
  Result:='驾驶员档案信息编辑';
end;

function familyEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{6C46C4C4-1CD7-428F-8BDB-E95860485B7F}');
end;

function familyEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function familyEdit.IsWorkState: Boolean;
begin

end;

procedure familyEdit.Leave;
begin

end;

procedure familyEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;

   {workEdit 编辑窗口}
procedure workEdit.ChangeTheme;
begin

end;

constructor workEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure workEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmDriverworkexperience,frmDriverworkexperience);
end;

function workEdit.getDescribe: String;
begin
  Result:='驾驶员工作经历';
end;

function workEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{AD33AB5C-F6A3-40DA-AF7C-173DDB2A7EFF}');
end;

function workEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function workEdit.IsWorkState: Boolean;
begin

end;

procedure workEdit.Leave;
begin

end;

procedure workEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
