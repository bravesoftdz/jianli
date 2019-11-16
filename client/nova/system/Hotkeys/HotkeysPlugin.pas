{ ------------------------------------
  功能说明：Hotkeys.bpl功能对象
  创建日期：2011.7.13
  作者：ice
  版权：nova
  ------------------------------------- }
unit HotkeysPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UFrmHotkeys;

Type
{------------------------------------
  功能说明：快捷键设置功能
-------------------------------------}
  THotkeysManager=class(TInterfacedObject,IFunctionItem)
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

{ THotkeysManager }

procedure THotkeysManager.ChangeTheme;
begin

end;

constructor THotkeysManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure THotkeysManager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmHotkeys,FrmHotkeys,Self);
end;

function THotkeysManager.getDescribe: String;
begin
  Result:='快捷键设置';
end;

function THotkeysManager.getKey: TGUID;
begin
  Result:=StringToGUID('{42DCB2C1-48E1-4085-9D47-3537B1E98C0A}');
end;

function THotkeysManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function THotkeysManager.IsWorkState: Boolean;
begin

end;

procedure THotkeysManager.Leave;
begin

end;

procedure THotkeysManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
