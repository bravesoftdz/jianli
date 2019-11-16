{------------------------------------
  ����˵�������ܷ���ӿ�
  �������ڣ�2010/11/25
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit FunctionItemIntf;

interface
uses Classes,Generics.Collections,SysUtils,Generics.Defaults;
type
  TFunctionItemParameters= Tstringlist;
  TSubfunction = class(TObject)
    key:TGUID;
    describe:String;
  public
    constructor Create(key:TGUID;describe:String='');overload;
    constructor Create(key:string;describe:String='');overload;
  end;
  TSubfunctionPermission = class(TSubfunction)
    enable:Boolean;
  public
    constructor Create(key:TGUID;enable:Boolean=True;describe:String='');overload;
    constructor Create(key:string;enable:Boolean=True;describe:String='');overload;
  end;
  TFunctionPermission=class(TObject)
    key:TGUID;
    parameter:TFunctionItemParameters;
    menuname:String;
    describe:string;
    enable:Boolean;
    FsubFunctionPermissionList:TObjectList<TSubfunctionPermission>;
  public
    constructor Create(key:TGUID;parameter:TFunctionItemParameters;menuname:string;enable:Boolean=True;describe:String='');overload;
    constructor Create(key:string;parameter:TFunctionItemParameters;menuname:string;enable:Boolean=True;describe:String='');overload;
    constructor destory();overload;
    procedure addorsetSubFunction(key:String;enable:boolean;describe:string='');overload;
    procedure addorsetSubFunction(key:TGUID;enable:boolean;describe:string='');overload;
    property subFunctionPermissionList:TObjectList<TSubfunctionPermission> read FsubFunctionPermissionList;
  end;

  //���������
  IFunctionItem=Interface
    ['{5FDE6E9B-0D0A-479F-884B-D3E82841A929}']
    //��ڷ���
    procedure Enter(const parameters:TFunctionItemParameters);
    //���ڷ���
    procedure Leave;
    //ˢ�·���
    Procedure refresh(const parameters:TFunctionItemParameters);
    //����ı�֪ͨ
    procedure ChangeTheme;
    //����״̬
    function IsWorkState:Boolean;
    //���ܱ�ʶ ʹ��GUID��ΪΨһ��ʶ
    function getKey:TGUID;
    //�ڲ������б�����Ȩ�޿���
    function getSubFunctionList:TList<TSubfunction>;
    //��������
    function getDescribe:String;
    property key:TGUID read getKey;
  End;

  IFunctionMgr=interface
  ['{A25F04F6-9587-4060-B837-D1632ACBCDC0}']
    procedure registerFunctionPermission(packagename,functionGUID:String;parameter:TFunctionItemParameters;enable:boolean=true;menuname:String='';describe:string='');
    procedure registerSubFunctionPermission(packagename,functionGUID:String;parameter:TFunctionItemParameters;subFunctionGUID:String;enable:boolean=true;menuname:String='';describe:string='');
    function getFunctionPermission(functionitem:IFunctionItem;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    function getFunctionPermission(functionkey:String;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    function getFunctionPermission(functionkey:TGUID;parameter:TFunctionItemParameters):TFunctionPermission;overload;
    procedure exec(guid:TGUID;parameters:TFunctionItemParameters);
  end;

implementation

type
  TSubfunctionComparer<T> = class(TComparer<TSubfunctionPermission>)
    function Compare(const Left, Right: TSubfunctionPermission): Integer; override;
  end;

{ TSubfunction }

constructor TSubfunction.Create(key: TGUID;describe:String='');
begin
  self.key:=key;
  self.describe:=describe;
end;

constructor TSubfunction.Create(key:String;describe:String='');
var _key:TGUID;
begin
  _key:=stringtoguid(key);
  create(_key,describe);
end;

{ TSubfunctionPermission }

constructor TSubfunctionPermission.Create(key: TGUID;enable:Boolean=True;describe:String='');
begin
  inherited create(key,describe);
  self.enable:=enable;
end;

constructor TSubfunctionPermission.Create(key:String;enable:Boolean=True;describe:String='');
var _key:TGUID;
begin
  _key:=stringtoguid(key);
  create(_key,enable,describe);
end;

{ TFunctionItem }
constructor TFunctionPermission.Create(key: TGUID; parameter:TFunctionItemParameters;menuname:string;enable:Boolean=True;describe:String='');
begin
  FsubFunctionPermissionList:=TObjectList<TSubfunctionPermission>.create(TSubfunctionComparer<TSubfunctionPermission>.Create,true);
  self.key:=key;
  self.describe:=describe;
  self.enable:=enable;
  self.parameter:=parameter;
  self.menuname:=menuname;
end;

constructor TFunctionPermission.Create(key:string; parameter:TFunctionItemParameters;menuname:string;enable:Boolean=True;describe:String='');
var _key:TGUID;
begin
  _key:=stringtoguid(key);
  create(_key,parameter,menuname,enable,describe);
end;

constructor TFunctionPermission.destory;
begin
  FsubFunctionPermissionList.Clear;
  freeandnil(FsubFunctionPermissionList);
end;

procedure TFunctionPermission.addorsetSubFunction(key:String;enable:boolean;describe:string='');
var _key:TGUID;
begin
  _key:=stringtoguid(key);
  addorsetSubFunction(_key,enable,describe);
end;

procedure TFunctionPermission.addorsetSubFunction(key:TGUID;enable:boolean;describe:string='');
var _subFuntion:TSubfunctionPermission;
    _index:integer;
begin
  _subFuntion:=TSubfunctionPermission.Create(key,enable,describe);
  if FsubFunctionPermissionList.Contains(_subFuntion) then
  begin
    _index:=FsubFunctionPermissionList.IndexOf(_subFuntion);
    with FsubFunctionPermissionList.Items[_index] do
    begin
      describe:=_subFuntion.describe;
      enable:=_subFuntion.enable;
    end;
    _subFuntion.Free;
  end
  else
  begin
    FsubFunctionPermissionList.Add(_subFuntion);
  end;
end;

{TSubfunctionComparer}
function TSubfunctionComparer<T>.Compare(const Left, Right: TSubfunctionPermission): Integer;
begin
  result:=-1;
  if GUIDToString(left.key)=GUIDToString(right.key) then
  begin
    result:=0;
  end;
end;

end.
