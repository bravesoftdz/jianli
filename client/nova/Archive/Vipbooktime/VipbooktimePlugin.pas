unit VipbooktimePlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type

  VipbooktimeMS=class(TInterfacedObject,IFunctionItem)
  private
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
  uses Services, MainFormIntf, UFrmVipbooktime;

{ SysMenuManager }

procedure VipbooktimeMS.ChangeTheme;
begin

end;

constructor VipbooktimeMS.Create;
begin
end;

procedure VipbooktimeMS.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmVipbooktime,FrmVipbooktime,self);
end;

function VipbooktimeMS.getDescribe: String;
begin
  Result:='会员订票时间设置';
end;

function VipbooktimeMS.getKey: TGUID;
begin
  Result:=StringToGUID('{1B94536F-545C-42BA-904B-F67C1D73C069}');
end;

function VipbooktimeMS.getSubFunctionList: TList<TSubfunction>;
begin

end;

function VipbooktimeMS.IsWorkState: Boolean;
begin
  Result:=True;
end;

procedure VipbooktimeMS.Leave;
begin

end;

procedure VipbooktimeMS.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
