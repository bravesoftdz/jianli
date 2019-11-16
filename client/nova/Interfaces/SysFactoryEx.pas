{------------------------------------
  ����˵������չ����
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit SysFactoryEx;

interface

Uses Classes,SysUtils,FactoryIntf,Services;

Type
  TIntfCreatorFunc = procedure(out anInstance: IInterface);
  //����
  TBaseFactoryEx=Class(TInterfacedObject,ISysFactory)
  private
    FIIDList:TStrings;
  protected
    {ISysFactory}
    procedure CreateInstance(const IID : TGUID; out Obj);virtual;
    procedure ReleaseInstance;virtual;
    function Supports(IID:TGUID):Boolean;virtual;
  public
    Constructor Create(Const IIDs:Array of TGUID);
    Destructor Destroy;override;
  end;

  TObjFactoryEx=Class(TBaseFactoryEx)
  private
    FOwnsObj:Boolean;
    FInstance:TObject;
  protected
    {ISysFactory}
    procedure CreateInstance(const IID : TGUID; out Obj);override;
    procedure ReleaseInstance;override;
  public
    Constructor Create(Const IIDs:Array of TGUID;Instance:TObject;OwnsObj:Boolean=False);
    Destructor Destroy;override;
  end;

  TSingletonFactoryEx=Class(TBaseFactoryEx)
  private
    FIntfCreatorFunc: TIntfCreatorFunc;
    FInstance:IInterface;
  protected
    procedure CreateInstance(const IID : TGUID; out Obj); override;
    procedure ReleaseInstance;override;
  public
    Constructor Create(IIDs:Array of TGUID;IntfCreatorFunc:TIntfCreatorFunc);
    destructor Destroy; override;
  end;

implementation

const Err_IntfExists='�ӿ�%s�Ѵ��ڣ������ظ�ע�ᣡ';
      Err_IntfNotSupport='����֧��%s�ӿڣ�';
{ TBaseFactoryEx }

constructor TBaseFactoryEx.Create(const IIDs: array of TGUID);
var i:Integer;
begin
  FIIDList:=TStringList.Create;
  
  for i:=low(IIDs) to high(IIDs) do
  begin
    if FactoryManager.Exists(IIDs[i]) then
      Raise Exception.CreateFmt(Err_IntfExists,[GUIDToString(IIDs[i])]);
      
    FIIDList.Add(GUIDToString(IIDs[i]));
  end;
  FactoryManager.RegisterFactory(self);
end;

procedure TBaseFactoryEx.CreateInstance(const IID: TGUID; out Obj);
begin

end;

destructor TBaseFactoryEx.Destroy;
begin
  FIIDList.Free;
  inherited;
end;

procedure TBaseFactoryEx.ReleaseInstance;
begin

end;

function TBaseFactoryEx.Supports(IID: TGUID): Boolean;
begin
  Result:=FIIDList.IndexOf(GUIDToString(IID))<>-1;
end;

{ TObjFactoryEx }

constructor TObjFactoryEx.Create(const IIDs: array of TGUID;
  Instance: TObject;OwnsObj:Boolean);
begin
  if Instance=nil then exit;
  if (Instance is TInterfacedObject) then
    Raise Exception.Create('��Ҫ��TObjFactoryExע��TInterfacedObject��������ʵ�ֵĽӿڣ�');
  if length(IIDs)=0 then
    Raise Exception.Create('TObjFactoryExע�����IIDs����Ϊ�գ�');

  FOwnsObj:=OwnsObj;
  self.FInstance:=Instance;
  Inherited Create(IIDs);
end;

procedure TObjFactoryEx.CreateInstance(const IID: TGUID; out Obj);
begin
  if not FInstance.GetInterface(IID,Obj) then
    Raise Exception.CreateFmt('��֧�ֽӿ�%s��',[GUIDToString(IID)]);
end;

destructor TObjFactoryEx.Destroy;
begin

  inherited;
end;

procedure TObjFactoryEx.ReleaseInstance;
begin
  inherited;
  if FOwnsObj then
    FreeAndNil(self.FInstance);
end;

{ TSingletonFactoryEx }

constructor TSingletonFactoryEx.Create(IIDs: array of TGUID;
  IntfCreatorFunc: TIntfCreatorFunc);
begin
  if length(IIDs)=0 then
    Raise Exception.Create('TSingletonFactoryExע�����IIDs����Ϊ�գ�');

  FInstance:=nil;
  FIntfCreatorFunc:=IntfCreatorFunc;
  Inherited Create(IIDs);
end;

procedure TSingletonFactoryEx.CreateInstance(const IID: TGUID; out Obj);
begin
  if FInstance=nil then
    FIntfCreatorFunc(FInstance);

  if FInstance.QueryInterface(IID,Obj)<>S_OK then
    Raise Exception.CreateFmt(Err_IntfNotSupport,[GUIDToString(IID)]);
end;

destructor TSingletonFactoryEx.Destroy;
begin
  FInstance:=nil;
  inherited;
end;

procedure TSingletonFactoryEx.ReleaseInstance;
begin
  inherited;
  FInstance:=nil;
end;

end.
