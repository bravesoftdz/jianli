unit PublicQryPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmPublicQry;

Type
   TPublicQryFunctionItem=class(TInterfacedObject,IFunctionItem)
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


{ TFrmUser}

procedure TPublicQryFunctionItem.ChangeTheme;
begin

end;

constructor TPublicQryFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TPublicQryFunctionItem.Enter(const parameters: TFunctionItemParameters);
var
  ip:string;
begin
  try
     ip:=Copy(Services.SysInfo.serverURL,0,Length(Services.SysInfo.serverURL)-9);

     FrmPublicQry := TFrmPublicQry.Create(ip+parameters.Text);
//     FrmPublicQry.url := ip+parameters.Text;
     Services.SysMainForm.ShowForm(FrmPublicQry);

  except on E:exception do
    SysDialogs.ShowMessage(e.ToString);
  end;

  //Services.SysMainForm.ShowForm(TFrmDeductItem, FrmDeductItem,self);
end;
function TPublicQryFunctionItem.getDescribe: String;
begin
  Result:='公共查询模块';
end;

function TPublicQryFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{272AF9DD-A82C-4357-8BEB-31460DAE10D3}');//Ctrl+Shift+G生成
end;

function TPublicQryFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TPublicQryFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TPublicQryFunctionItem.Leave;
begin

end;

procedure TPublicQryFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
