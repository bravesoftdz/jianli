{------------------------------------
  功能说明：About.bpl输出单元
  创建日期：2011/08/10
  作者：lck
  版权：nova
-------------------------------------}
unit AboutPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
  TAboutFunctionItem=class(TInterfacedObject,IFunctionItem)
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

uses Services,MainFormIntf,UFrmAbout;


{ TSystemManager }

procedure TAboutFunctionItem.ChangeTheme;
begin

end;

constructor TAboutFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TAboutFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
  FrmAbout:=TFrmAbout.Create(nil,self);
  Services.SysMainForm.showFormModal(FrmAbout);
end;

function TAboutFunctionItem.getDescribe: String;
begin
  Result:='显于本软件的关于信息';
end;

function TAboutFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{BEF59B44-781A-4403-AEB8-DCDCC377B2E0}');
end;

function TAboutFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
//
end;

function TAboutFunctionItem.IsWorkState: Boolean;
begin

end;

procedure TAboutFunctionItem.Leave;
begin

end;

procedure TAboutFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;


end.
