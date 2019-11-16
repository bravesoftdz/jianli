unit DWardpenalizePlugin;
interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TDWardpenalizemanager=class(TInterfacedObject,IFunctionItem)
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

uses Services,UFrmDWardpenalize,MainFormIntf;


{ TFrmUser}

procedure TDWardpenalizemanager.ChangeTheme;
begin

end;

constructor TDWardpenalizemanager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TDWardpenalizemanager.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TfrmWardpenalize,frmWardpenalize,self);
end;
function TDWardpenalizemanager.getDescribe: String;
begin
  Result:='º› ª‘±Ω±≥Õ–≈œ¢';
end;

function TDWardpenalizemanager.getKey: TGUID;
begin
  Result:=StringToGUID('{42260015-4010-438B-8064-AAFEBCB342D6}');
end;

function TDWardpenalizemanager.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDWardpenalizemanager.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TDWardpenalizemanager.Leave;
begin

end;

procedure TDWardpenalizemanager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
