unit PackManualMakeupPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TFrmPackManualMakeupItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmPackManualMakeup,MainFormIntf;


{ TFrmUser}

procedure TFrmPackManualMakeupItem.ChangeTheme;
begin

end;

constructor TFrmPackManualMakeupItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TFrmPackManualMakeupItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmPackManualMakeup,FrmPackManualMakeup,self);
end;
function TFrmPackManualMakeupItem.getDescribe: String;
begin
  Result:='行包结算单补录';
end;

function TFrmPackManualMakeupItem.getKey: TGUID;
begin
  Result:=StringToGUID('{2A8831D1-C851-44FB-A4F2-F6E7BAE70838}');//Ctrl+Shift+G生成
end;

function TFrmPackManualMakeupItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TFrmPackManualMakeupItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TFrmPackManualMakeupItem.Leave;
begin

end;

procedure TFrmPackManualMakeupItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
