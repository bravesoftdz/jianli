unit QueryPackReceivePlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQueryPackReceiveItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf,UFrmQueryPackReceive;


{ TFrmUser}

procedure TQueryPackReceiveItem.ChangeTheme;
begin

end;

constructor TQueryPackReceiveItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQueryPackReceiveItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmQueryPackReceive,FrmQueryPackReceive,self);
end;
function TQueryPackReceiveItem.getDescribe: String;
begin
  Result:='行包提领营收统计';
end;

function TQueryPackReceiveItem.getKey: TGUID;
begin
  Result:=StringToGUID('{51CCB595-671D-45C6-B241-9417FE7B87E4}');//Ctrl+Shift+G生成
end;

function TQueryPackReceiveItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryPackReceiveItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQueryPackReceiveItem.Leave;
begin

end;

procedure TQueryPackReceiveItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
