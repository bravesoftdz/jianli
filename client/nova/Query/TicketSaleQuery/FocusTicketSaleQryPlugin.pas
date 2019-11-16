unit FocusTicketSaleQryPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmFocusSaleLocalQry,
  UFrmFocusSaleOtherQry;
type

 //����ʽ�۱���Ʊ
    TFocusSaleLocalManager = class(TInterfacedObject,IFunctionItem)
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

  //����ʽ�����Ʊ
   TFocusSaleOtherManager = class(TInterfacedObject,IFunctionItem)
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

//�۱���Ʊ
procedure TFocusSaleLocalManager.ChangeTheme;
begin

end;

constructor TFocusSaleLocalManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TFocusSaleLocalManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmFocusSalelocalQry, FrmFocusSalelocalQry,self);
end;


function TFocusSaleLocalManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--����ʽ��վ�۱�վ���';
end;
function TFocusSaleLocalManager.getKey: TGUID;
begin
  Result:=StringToGUID('{4CC20274-7318-4178-B6A8-4F48B87C0D09}');
end;

function TFocusSaleLocalManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFocusSaleLocalManager.IsWorkState: Boolean;
begin

end;

procedure TFocusSaleLocalManager.Leave;
begin

end;

procedure TFocusSaleLocalManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//�����Ʊ
procedure TFocusSaleOtherManager.ChangeTheme;
begin

end;

constructor TFocusSaleOtherManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TFocusSaleOtherManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TFrmFocusSaleOtherQry,FrmFocusSaleOtherQry,self);
end;


function TFocusSaleOtherManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--����ʽ��վ����վ���';
end;
function TFocusSaleOtherManager.getKey: TGUID;
begin
  Result:=StringToGUID('{ECC89BAF-7D0B-4333-9D27-FF81D2EDD3E7}');
end;

function TFocusSaleOtherManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TFocusSaleOtherManager.IsWorkState: Boolean;
begin

end;

procedure TFocusSaleOtherManager.Leave;
begin

end;

procedure TFocusSaleOtherManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
