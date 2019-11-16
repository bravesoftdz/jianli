unit QueryPackDetailsPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TQueryPackDetailsPluginItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmQueryPackDetails,MainFormIntf;


{ TFrmUser}

procedure TQueryPackDetailsPluginItem.ChangeTheme;
begin

end;

constructor TQueryPackDetailsPluginItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TQueryPackDetailsPluginItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TfrmQueryPackDetails,frmQueryPackDetails,self);
end;
function TQueryPackDetailsPluginItem.getDescribe: String;
begin
  Result:='前台明细';
end;

function TQueryPackDetailsPluginItem.getKey: TGUID;
begin
  Result:=StringToGUID('{F7812D63-B29C-44EB-AD29-939A74B1E351}');//Ctrl+Shift+G生成
end;

function TQueryPackDetailsPluginItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TQueryPackDetailsPluginItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TQueryPackDetailsPluginItem.Leave;
begin

end;

procedure TQueryPackDetailsPluginItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
