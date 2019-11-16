{------------------------------------
  功能说明：工厂
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit SysFactory;

interface

Uses Classes,SysUtils,FactoryIntf,Services;

Type
  TIntfCreatorFunc = procedure(out anInstance: IInterface);
  //工厂基类
  TBaseFactory=Class(TInterfacedObject,ISysFactory)
  private
  protected
    FIntfGUID:TGUID;
    {ISysFactory}
    procedure CreateInstance(const IID : TGUID; out Obj); virtual;abstract;
    procedure ReleaseInstance;virtual;abstract;
    function Supports(IID:TGUID):Boolean;virtual;
  public
    Constructor Create(Const IID:TGUID);//virtual;
    Destructor Destroy;override;
  end;

  //接口工厂
  TIntfFactory=Class(TBaseFactory)
  private
    FIntfCreatorFunc:TIntfCreatorFunc;
  protected
    procedure CreateInstance(const IID : TGUID; out Obj); override;
    procedure ReleaseInstance;override;
  public
    Constructor Create(IID:TGUID;IntfCreatorFunc:TIntfCreatorFunc);virtual;
    Destructor Destroy;override;
  end;

  //单例工厂
  TSingletonFactory=Class(TIntfFactory)
  private
    FInstance:IInterface;
  protected
    procedure CreateInstance(const IID : TGUID; out Obj); override;
    procedure ReleaseInstance;override;
  public
    Constructor Create(IID:TGUID;IntfCreatorFunc:TIntfCreatorFunc);override;
    destructor Destroy; override;
  end;
  //实例工厂
  TObjFactory=Class(TBaseFactory)
  private
    FOwnsObj:Boolean;
    FInstance:TObject;
    FRefIntf:IInterface;
  protected
    procedure CreateInstance(const IID : TGUID; out Obj); override;
    procedure ReleaseInstance;override;
  public
    Constructor Create(IID:TGUID;Instance:TObject;OwnsObj:Boolean=False);
    Destructor Destroy;override;
  end;
  
implementation

const Err_IntfExists='接口%s已存在，不能重复注册！';
      Err_IntfNotSupport='对象不支持%s接口！';
{ TBaseFactory }

constructor TBaseFactory.Create(const IID: TGUID);
begin
  if FactoryManager.Exists(IID) then
    Raise Exception.CreateFmt(Err_IntfExists,[GUIDToString(IID)]);

  FIntfGUID:=IID;
  FactoryManager.RegisterFactory(Self);
end;

destructor TBaseFactory.Destroy;
begin

  inherited;
end;

function TBaseFactory.Supports(IID: TGUID): Boolean;
begin
  Result:=IsEqualGUID(IID,FIntfGUID);
end;

{ TIntfFactory }

constructor TIntfFactory.Create(IID: TGUID; IntfCreatorFunc:TIntfCreatorFunc);
begin
  self.FIntfCreatorFunc:=IntfCreatorFunc;
  Inherited Create(IID);
end;

procedure TIntfFactory.CreateInstance(const IID: TGUID; out Obj);
var tmpIntf:IInterface;
begin
  self.FIntfCreatorFunc(tmpIntf);
  tmpIntf.QueryInterface(IID,Obj);
end;

destructor TIntfFactory.Destroy;
begin

  inherited;
end;

procedure TIntfFactory.ReleaseInstance;
begin

end;

{ TSingletonFactory }

constructor TSingletonFactory.Create(IID: TGUID;
  IntfCreatorFunc:TIntfCreatorFunc);
begin
  FInstance:=nil;
  inherited Create(IID,IntfCreatorFunc);
end;

procedure TSingletonFactory.CreateInstance(const IID: TGUID;out Obj);
begin
  if FInstance=nil then
    Inherited Createinstance(IID,FInstance);
    
  if FInstance.QueryInterface(IID,Obj)<>S_OK then
    Raise Exception.CreateFmt(Err_IntfNotSupport,[GUIDToString(IID)]);
end;

destructor TSingletonFactory.Destroy;
begin
  FInstance:=nil;
  inherited;
end;

procedure TSingletonFactory.ReleaseInstance;
begin
  FInstance:=nil;//释放
end;

{ TObjFactory }

constructor TObjFactory.Create(IID: TGUID; Instance: TObject;OwnsObj:Boolean);
begin
  if not Instance.GetInterface(IID,FRefIntf) then
    Raise Exception.CreateFmt('对象%s未实现%s接口！',[Instance.ClassName,GUIDToString(IID)]);
    
  if (Instance is TInterfacedObject) then
    Raise Exception.Create('不要用TObjFactory注册TInterfacedObject及其子类实现的接口！');

  FOwnsObj:=OwnsObj;
  FInstance:=Instance;
  Inherited Create(IID);
end;

procedure TObjFactory.CreateInstance(const IID: TGUID;out Obj);
begin
  IInterface(Obj):=FRefIntf;
end;

destructor TObjFactory.Destroy;
begin

  inherited;
end;

procedure TObjFactory.ReleaseInstance;
begin
  inherited;
  FRefIntf:=nil;
  if FOwnsObj then
    FreeAndNil(FInstance);
end;

end.
