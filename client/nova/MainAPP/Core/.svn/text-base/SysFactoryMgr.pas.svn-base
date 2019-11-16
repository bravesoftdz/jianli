{------------------------------------
  功能说明：工厂管理
  创建日期：2010/04/20
  作者：WZW
  版权：WZW
-------------------------------------}
unit SysFactoryMgr;

interface

uses SysUtils,Classes,FactoryIntf,SvcInfoIntf,SystemInstance,FactoryManagerIntf;

Type
  TSysFactoryList = class(TInterfaceList,ISysFactoryList) //TInterfaceList,
  private
  protected

  public
    function GetItems(Index: integer): ISysFactory;//override;
    function Add(aFactory: ISysFactory): integer;
    function IndexOfIID(const IID:TGUID):Integer;
    function GetFactory(const IID: TGUID): ISysFactory;
    function FindFactory(const IID:TGUID): ISysFactory;
    function count:Integer;
    property Items[Index: integer]: ISysFactory read GetItems; default;
  end;

  TSysFactoryManager=Class(TInterfacedObject,IFactoryManagerIntf)
  private
    FSysFactoryList:TSysFactoryList;
  protected
  public
    procedure RegisterFactory(aIntfFactory:ISysFactory);
    procedure UnRegisterFactory(aIntfFactory:ISysFactory); overload;
    procedure UnRegisterFactory(IID:TGUID); overload;
    procedure ReleaseInstances;
    function FindFactory(const IID:TGUID): ISysFactory;
//    property FactoryList:TSysFactoryList Read FSysFactoryList;
    function FactoryList:ISysFactoryList;
    function Exists(const IID:TGUID):Boolean;

    Constructor Create;
    Destructor Destroy;override;
  end;

  //注册接口异常类
  ERegistryIntfException=Class(Exception);

implementation

{ TSysFactoryList }
  var _FFactoryManager:TSysFactoryManager;

function TSysFactoryList.Add(aFactory: ISysFactory): integer;
begin
  Result := inherited Add(aFactory);
end;

function TSysFactoryList.count: Integer;
begin
  result:=inherited count;
end;

function TSysFactoryList.FindFactory(const IID: TGUID): ISysFactory;
var
  idx:integer;
begin
  result := nil;
  idx:=self.IndexOfIID(IID);
  if idx<>-1 then
    Result:=Items[idx];
end;

function TSysFactoryList.GetFactory(const IID: TGUID): ISysFactory;
begin
  Result := FindFactory(IID);
  if not Assigned(result) then
    Raise Exception.CreateFmt('未找到%s接口！',[GUIDToString(IID)]);
end;

function TSysFactoryList.GetItems(Index: integer): ISysFactory;
begin
  Result := inherited Items[Index] as ISysFactory
end;

function TSysFactoryList.IndexOfIID(const IID: TGUID): Integer;
var
  i:integer;
begin
  result := -1;
  for i := 0 to (Count - 1) do
  begin
    if Items[i].Supports(IID) then
    begin
      result := i;
      Break;
    end;
  end;
end;

{ TSysFactoryManager }

constructor TSysFactoryManager.Create;
begin
  FSysFactoryList:=TSysFactoryList.Create;
end;

destructor TSysFactoryManager.Destroy;
begin
  FSysFactoryList.Free;
  inherited;
end;

function TSysFactoryManager.Exists(const IID: TGUID): Boolean;
begin
  Result:=FSysFactoryList.IndexOfIID(IID)<>-1;
end;

function TSysFactoryManager.FactoryList: ISysFactoryList;
begin
  Result:= FSysFactoryList;
end;

function TSysFactoryManager.FindFactory(const IID: TGUID): ISysFactory;
begin
  Result:=FSysFactoryList.FindFactory(IID);
end;

procedure TSysFactoryManager.RegisterFactory(aIntfFactory: ISysFactory);
begin
  FSysFactoryList.Add(aIntfFactory);
end;

procedure TSysFactoryManager.ReleaseInstances;
var i:Integer;
begin
  for i:=0 to FSysFactoryList.Count-1 do
    FSysFactoryList.Items[i].ReleaseInstance;
end;

procedure TSysFactoryManager.UnRegisterFactory(aIntfFactory: ISysFactory);
begin
  if Assigned(aIntfFactory) then
  begin
    aIntfFactory.ReleaseInstance;
    FSysFactoryList.Remove(aIntfFactory);
  end;
end;

procedure TSysFactoryManager.UnRegisterFactory(IID: TGUID);
begin
  self.UnRegisterFactory(FSysFactoryList.GetFactory(IID));
end;

procedure FreeAndNil(var Obj);
var
  Temp: TSysFactoryManager;
begin
  Temp := TSysFactoryManager(Obj);
  Pointer(Obj) := nil;
  Temp.Free;
end;

initialization
  FFactoryManager:=TSysFactoryManager.Create;
  _FFactoryManager:=TSysFactoryManager.Create;
finalization
  FreeAndNil(_FFactoryManager);
  FreeAndNil(FFactoryManager);
end.
