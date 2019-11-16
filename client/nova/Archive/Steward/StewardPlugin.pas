unit StewardPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmSteward,
  UFrmStewardEdit;
type
 stewardManager = class(TInterfacedObject,IFunctionItem)
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

  stewardEdit = class(TInterfacedObject,IFunctionItem)
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

  {familyEdit = class(TInterfacedObject,IFunctionItem)
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

   wardpenalizeEdit = class(TInterfacedObject,IFunctionItem)
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
  end;    }
implementation

uses Services,MainFormIntf;

procedure stewardManager.ChangeTheme;
begin

end;

constructor stewardManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure stewardManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSteward,frmSteward,self);
end;


function stewardManager.getDescribe: String;
begin
  Result:='档案管理--乘务员档案管理';
end;
function stewardManager.getKey: TGUID;
begin
  Result:=StringToGUID('{01AFCC70-0DF7-4AA8-B780-72F93D0CFB34}');
end;

function stewardManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function stewardManager.IsWorkState: Boolean;
begin

end;

procedure stewardManager.Leave;
begin

end;

procedure stewardManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

      {stewardEdit 编辑窗口}
procedure stewardEdit.ChangeTheme;
begin

end;

constructor stewardEdit.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure stewardEdit.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSteward,frmSteward);
end;

function stewardEdit.getDescribe: String;
begin
  Result:='乘务员档案信息编辑';
end;

function stewardEdit.getKey: TGUID;
begin
  Result:=StringToGUID('{1C4E1F36-7D3A-4A99-BC85-67C1647D7129}');
end;

function stewardEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function stewardEdit.IsWorkState: Boolean;
begin

end;

procedure stewardEdit.Leave;
begin

end;

procedure stewardEdit.refresh(const parameters: TFunctionItemParameters);
begin

end;

//   {familyEdit 编辑窗口}
//procedure familyEdit.ChangeTheme;
//begin
//
//end;
//
//constructor familyEdit.Create;
//begin
//  FSubFunctionList:=TList<TSubfunction>.Create;
//end;
//
//procedure familyEdit.Enter(const parameters: TFunctionItemParameters);
//var subFunction:TSubFunction;
//begin
//  Services.SysMainForm.ShowForm(TfrmDriverFamily,frmDriverFamily);
//end;
//
//function familyEdit.getDescribe: String;
//begin
//  Result:='驾驶员档案信息编辑';
//end;
//
//function familyEdit.getKey: TGUID;
//begin
//  Result:=StringToGUID('{6C46C4C4-1CD7-428F-8BDB-E95860485B7F}');
//end;
//
//function familyEdit.getSubFunctionList: TList<TSubfunction>;
//begin
//  Result:=FSubFunctionList;
//end;
//
//function familyEdit.IsWorkState: Boolean;
//begin
//
//end;
//
//procedure familyEdit.Leave;
//begin
//
//end;
//
//procedure familyEdit.refresh(const parameters: TFunctionItemParameters);
//begin
//
//end;
//
//   {workEdit 编辑窗口}
//procedure workEdit.ChangeTheme;
//begin
//
//end;
//
//constructor workEdit.Create;
//begin
//  FSubFunctionList:=TList<TSubfunction>.Create;
//end;
//
//procedure workEdit.Enter(const parameters: TFunctionItemParameters);
//var subFunction:TSubFunction;
//begin
//  Services.SysMainForm.ShowForm(TfrmDriverworkexperience,frmDriverworkexperience);
//end;
//
//function workEdit.getDescribe: String;
//begin
//  Result:='驾驶员工作经历';
//end;
//
//function workEdit.getKey: TGUID;
//begin
//  Result:=StringToGUID('{AD33AB5C-F6A3-40DA-AF7C-173DDB2A7EFF}');
//end;
//
//function workEdit.getSubFunctionList: TList<TSubfunction>;
//begin
//  Result:=FSubFunctionList;
//end;
//
//function workEdit.IsWorkState: Boolean;
//begin
//
//end;
//
//procedure workEdit.Leave;
//begin
//
//end;
//
//procedure workEdit.refresh(const parameters: TFunctionItemParameters);
//begin
//
//end;
//
//
//   {wardpenalizeEdit 编辑窗口}
//procedure wardpenalizeEdit.ChangeTheme;
//begin
//
//end;
//
//constructor wardpenalizeEdit.Create;
//begin
//  FSubFunctionList:=TList<TSubfunction>.Create;
//end;
//
//procedure wardpenalizeEdit.Enter(const parameters: TFunctionItemParameters);
//var subFunction:TSubFunction;
//begin
//  Services.SysMainForm.ShowForm(TfrmDriverrewardpenalize,frmDriverrewardpenalize);
//end;
//
//function wardpenalizeEdit.getDescribe: String;
//begin
//  Result:='驾驶员奖惩记录';
//end;
//
//function wardpenalizeEdit.getKey: TGUID;
//begin
//  Result:=StringToGUID('{AF1140FB-1F90-4EF6-9213-B4FA5C35E1A9}');
//end;
//
//function wardpenalizeEdit.getSubFunctionList: TList<TSubfunction>;
//begin
//  Result:=FSubFunctionList;
//end;
//
//function wardpenalizeEdit.IsWorkState: Boolean;
//begin
//
//end;
//
//procedure wardpenalizeEdit.Leave;
//begin
//
//end;
//
//procedure wardpenalizeEdit.refresh(const parameters: TFunctionItemParameters);
//begin
//
//end;
end.
