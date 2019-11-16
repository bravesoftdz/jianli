unit TicketSaleQryPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmTicketSaleQry,
    UFrmSaleLocalTicketQry,UFrmSaleOtherTicketQry,UFrmPresellTicketQry,UFrmTicketChangeQry,
    UFrmReserveTicketQry,UFrmTicketReturnQry,UFrmTicketCancleQry,
    UFrmQueryBilldamaged,UFrmReturnLocalQry;
type
 ticketSaleQryManager = class(TInterfacedObject,IFunctionItem)
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

 //�۱���Ʊ
    SaleLocalManager = class(TInterfacedObject,IFunctionItem)
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

  //�����Ʊ
   SaleOtherManager = class(TInterfacedObject,IFunctionItem)
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

  //Ԥ��Ʊ��ղ�ѯ
   PresellManager = class(TInterfacedObject,IFunctionItem)
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

  //��Ʊ��ǩ�����ѯ
   ticketchangeManager = class(TInterfacedObject,IFunctionItem)
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

  //��Ʊ�����ѯ
   reserveTicketManager = class(TInterfacedObject,IFunctionItem)
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

  //��Ʊ�����ѯ
   ticketReturnManager = class(TInterfacedObject,IFunctionItem)
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

    //��Ʊ�����ѯ
   ticketCancleManager = class(TInterfacedObject,IFunctionItem)
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

    //��Ʊ�Ǽ������ѯ
   queryBilldamagedManager = class(TInterfacedObject,IFunctionItem)
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

  //��վ�˱�Ʊ�����ѯ
   returnLocalManager = class(TInterfacedObject,IFunctionItem)
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

procedure ticketSaleQryManager.ChangeTheme;
begin

end;

constructor ticketSaleQryManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ticketSaleQryManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmTicketSaleQry,frmTicketSaleQry,self);
end;


function ticketSaleQryManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��Ʊ��';
end;
function ticketSaleQryManager.getKey: TGUID;
begin
  Result:=StringToGUID('{982B70E3-ED21-4931-B020-B113035BA65C}');
end;

function ticketSaleQryManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function ticketSaleQryManager.IsWorkState: Boolean;
begin

end;

procedure ticketSaleQryManager.Leave;
begin

end;

procedure ticketSaleQryManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//�۱���Ʊ
procedure SaleLocalManager.ChangeTheme;
begin

end;

constructor SaleLocalManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SaleLocalManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSaleLocalTicketQry,frmSaleLocalTicketQry,self);
end;


function SaleLocalManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��վ�۱�վ���';
end;
function SaleLocalManager.getKey: TGUID;
begin
  Result:=StringToGUID('{6CF5D113-43FF-4261-B892-41215A5C5CB7}');
end;

function SaleLocalManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function SaleLocalManager.IsWorkState: Boolean;
begin

end;

procedure SaleLocalManager.Leave;
begin

end;

procedure SaleLocalManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//�����Ʊ
procedure SaleOtherManager.ChangeTheme;
begin

end;

constructor SaleOtherManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure SaleOtherManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmSaleOtherTicketQry,frmSaleOtherTicketQry,self);
end;


function SaleOtherManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��վ����վ���';
end;
function SaleOtherManager.getKey: TGUID;
begin
  Result:=StringToGUID('{8C5C0609-4601-47E5-960C-4340D8C44BA5}');
end;

function SaleOtherManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function SaleOtherManager.IsWorkState: Boolean;
begin

end;

procedure SaleOtherManager.Leave;
begin

end;

procedure SaleOtherManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


//Ԥ��Ʊ�����ѯ
procedure PresellManager.ChangeTheme;
begin

end;

constructor PresellManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure PresellManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmPresellTicketQry,frmPresellTicketQry,self);
end;


function PresellManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--Ԥ��Ʊ�����ѯ';
end;
function PresellManager.getKey: TGUID;
begin
  Result:=StringToGUID('{2FE7C3EE-9B07-4914-9ECA-DD505A2C081F}');
end;

function PresellManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function PresellManager.IsWorkState: Boolean;
begin

end;

procedure PresellManager.Leave;
begin

end;

procedure PresellManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//��Ʊ��ǩ�����ѯ
procedure ticketchangeManager.ChangeTheme;
begin

end;

constructor ticketchangeManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ticketchangeManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmTicketChangeQry,frmTicketChangeQry,self);
end;


function ticketchangeManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��ǩ�����ѯ';
end;
function ticketchangeManager.getKey: TGUID;
begin
  Result:=StringToGUID('{62A3C55E-7A12-494D-B473-D662CC50C945}');
end;

function ticketchangeManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function ticketchangeManager.IsWorkState: Boolean;
begin

end;

procedure ticketchangeManager.Leave;
begin

end;

procedure ticketchangeManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//��Ʊ�����ѯ
procedure reserveTicketManager.ChangeTheme;
begin

end;

constructor reserveTicketManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure reserveTicketManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmReserveTicketQry,frmReserveTicketQry,self);
end;


function reserveTicketManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��Ʊ�����ѯ';
end;
function reserveTicketManager.getKey: TGUID;
begin
  Result:=StringToGUID('{943379D6-B02E-4475-A76F-ECD70811F537}');
end;

function reserveTicketManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function reserveTicketManager.IsWorkState: Boolean;
begin

end;

procedure reserveTicketManager.Leave;
begin

end;

procedure reserveTicketManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//��Ʊ�����ѯ
procedure ticketReturnManager.ChangeTheme;
begin

end;

constructor ticketReturnManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ticketReturnManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmTicketReturnQry,frmTicketReturnQry,self);
end;


function ticketReturnManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��Ʊ�����ѯ';
end;
function ticketReturnManager.getKey: TGUID;
begin
  Result:=StringToGUID('{08B3A000-9E55-428A-B621-F0F98F21ECC5}');
end;

function ticketReturnManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function ticketReturnManager.IsWorkState: Boolean;
begin

end;

procedure ticketReturnManager.Leave;
begin

end;

procedure ticketReturnManager.refresh(const parameters: TFunctionItemParameters);
begin

end;

//��Ʊ�����ѯ
procedure ticketCancleManager.ChangeTheme;
begin

end;

constructor ticketCancleManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure ticketCancleManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmTicketCancleQry,frmTicketCancleQry,self);
end;


function ticketCancleManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��Ʊ�����ѯ';
end;
function ticketCancleManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D2979EF9-4790-481A-A808-6DBB8D678806}');
end;

function ticketCancleManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function ticketCancleManager.IsWorkState: Boolean;
begin

end;

procedure ticketCancleManager.Leave;
begin

end;

procedure ticketCancleManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


//��Ʊ�Ǽ������ѯ
procedure queryBilldamagedManager.ChangeTheme;
begin

end;
constructor queryBilldamagedManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;
procedure queryBilldamagedManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmQueryBilldamaged,frmQueryBilldamaged,self);
end;
function queryBilldamagedManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��Ʊ�Ǽǲ�ѯ';
end;
function queryBilldamagedManager.getKey: TGUID;
begin
  Result:=StringToGUID('{D9E97ABB-6653-4FF8-96EE-07D309FC8621}');
end;

function queryBilldamagedManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function queryBilldamagedManager.IsWorkState: Boolean;
begin

end;

procedure queryBilldamagedManager.Leave;
begin

end;

procedure queryBilldamagedManager.refresh(const parameters: TFunctionItemParameters);
begin

end;


//��վ�˱�վƱ��ѯ
procedure returnLocalManager.ChangeTheme;
begin

end;

constructor returnLocalManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure returnLocalManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmReturnLocalQry,frmReturnLocalQry,self);
end;


function returnLocalManager.getDescribe: String;
begin
  Result:='�ۺϲ�ѯ--��վ�˱�վƱ��ѯ';
end;
function returnLocalManager.getKey: TGUID;
begin
  Result:=StringToGUID('{9E9022D5-35CA-4FE7-A2C3-6A09BAAC399A}');
end;

function returnLocalManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function returnLocalManager.IsWorkState: Boolean;
begin

end;

procedure returnLocalManager.Leave;
begin

end;

procedure returnLocalManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
