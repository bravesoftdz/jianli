unit QryFullSeatSchedulePlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,
UFrmFullSeatSchedule;
type

  //������������ѯ
   fullSeatScheduleManager = class(TInterfacedObject,IFunctionItem)
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

//������������ѯ

procedure fullSeatScheduleManager.ChangeTheme;
begin

end;

constructor fullSeatScheduleManager.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure fullSeatScheduleManager.Enter(const parameters: TFunctionItemParameters);
var subFunction:TSubFunction;
begin
  Services.SysMainForm.ShowForm(TfrmFullSeatSchedule,frmFullSeatSchedule,self);
end;


function fullSeatScheduleManager.getDescribe: String;
begin
  Result:='��Ʊ��ѯ--������������ѯ';
end;
function fullSeatScheduleManager.getKey: TGUID;
begin
  Result:=StringToGUID('{065DDA79-C53B-4783-979B-881C0A6C384D}');
end;

function fullSeatScheduleManager.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function fullSeatScheduleManager.IsWorkState: Boolean;
begin

end;

procedure fullSeatScheduleManager.Leave;
begin

end;

procedure fullSeatScheduleManager.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
