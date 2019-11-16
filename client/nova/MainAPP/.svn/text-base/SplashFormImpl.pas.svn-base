{------------------------------------
  功能说明：实现ISplashForm接口(闪屏窗体接口)
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit SplashFormImpl;


interface

uses SysUtils,Messages,UFrmSplash,SplashFormIntf,Windows;

Type
  TSplashFormObj=Class(TObject,ISplashForm)
  private
    FSplashForm:TfrmSplash;
  protected
    { IInterface }
    FRefCount: Integer;
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {ISplashForm}
    procedure Show;
    procedure loading(const msg:String);
    procedure Hide;
  public
    constructor Create;
    destructor Destroy;override;
  End;
implementation

uses SysFactory;

{ TSplashFormObj }

constructor TSplashFormObj.Create;
begin
  FSplashForm:=TfrmSplash.Create(nil);

end;

destructor TSplashFormObj.Destroy;
begin
  FSplashForm.Free;
  inherited;
end;

procedure TSplashFormObj.Hide;
begin
  FSplashForm.Hide;
end;

procedure TSplashFormObj.Show;
begin
  FSplashForm.Show;
end;

function TSplashFormObj.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
    Result := 0
  else
    Result := E_NOINTERFACE;
end;

function TSplashFormObj._AddRef: Integer;
begin
  Result := InterlockedIncrement(FRefCount);
end;

function TSplashFormObj._Release: Integer;
begin
  Result := InterlockedDecrement(FRefCount);
end;

procedure TSplashFormObj.loading(const msg: String);
begin

  FSplashForm.mm_Loading.Lines.Add('   '+msg);
  //FSplashForm.mm_Loading.Perform(wm_vscroll,sb_linedown,0);
 FSplashForm.Update;
end;

//procedure Create_SplashFormObj(out anInstance: IInterface);
//begin
//  anInstance:=TSplashFormObj.Create;
//end;
//
initialization
//  TIntfFactory.Create(ISplashForm,@Create_SplashFormObj);
finalization

end.

