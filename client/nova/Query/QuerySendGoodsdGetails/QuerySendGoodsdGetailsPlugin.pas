unit QuerySendGoodsdGetailsPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TFrmQuerySendGoodsdGetailsItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQuerySendGoodsd,MainFormIntf;


{ TFrmUser}

procedure TFrmQuerySendGoodsdGetailsItem.ChangeTheme;
begin

end;

constructor TFrmQuerySendGoodsdGetailsItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TFrmQuerySendGoodsdGetailsItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQuerySendGoodsd,FrmQuerySendGoodsd,self);
end;
function TFrmQuerySendGoodsdGetailsItem.getDescribe: String;
begin
  Result:='发货明细查询';
end;

function TFrmQuerySendGoodsdGetailsItem.getKey: TGUID;
begin
  Result:=StringToGUID('{03256AAC-2FB9-4A12-993C-29D4C971DC04}');//Ctrl+Shift+G生成
end;

function TFrmQuerySendGoodsdGetailsItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TFrmQuerySendGoodsdGetailsItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TFrmQuerySendGoodsdGetailsItem.Leave;
begin

end;

procedure TFrmQuerySendGoodsdGetailsItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
