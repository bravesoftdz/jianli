{------------------------------------
  功能说明：User.bpl包插件对象
  创建日期：2010.12.02
  作者：蒋伟
  版权：nova
-------------------------------------}
unit UserPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TUserFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmUser,MainFormIntf;


{ TFrmUser}

procedure TUserFunctionItem.ChangeTheme;
begin

end;

constructor TUserFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TUserFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmUser,FrmUser,self);
end;
function TUserFunctionItem.getDescribe: String;
begin
  Result:='用户信息';
end;

function TUserFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{08A83651-5ED0-4082-A581-1A1BE4202FDB}');
end;

function TUserFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TUserFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TUserFunctionItem.Leave;
begin

end;

procedure TUserFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
