unit OutstationupmoneyPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TOutstationupmoneyItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmOutstationupmoney,MainFormIntf;


{ TFrmUser}

procedure TOutstationupmoneyItem.ChangeTheme;
begin

end;

constructor TOutstationupmoneyItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TOutstationupmoneyItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmOutstationupmoney,FrmOutstationupmoney,self);
end;
function TOutstationupmoneyItem.getDescribe: String;
begin
  Result:='外站缴款单';
end;

function TOutstationupmoneyItem.getKey: TGUID;
begin
  Result:=StringToGUID('{6101474A-079C-4706-B9F0-9E6C48920450}');//Ctrl+Shift+G生成
end;

function TOutstationupmoneyItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TOutstationupmoneyItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TOutstationupmoneyItem.Leave;
begin

end;

procedure TOutstationupmoneyItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
