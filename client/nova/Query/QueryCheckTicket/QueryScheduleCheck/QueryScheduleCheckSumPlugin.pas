unit QueryScheduleCheckSumPlugin;


interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmQueryScheduleCheckSum;
type

   //班次检票汇总表
    TQryScheduleCheckSum=class(TInterfacedObject,IFunctionItem)
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

{ TQryDepartinvoinceschedule }

procedure TQryScheduleCheckSum.ChangeTheme;
begin

end;

constructor TQryScheduleCheckSum.Create;
begin
   FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TQryScheduleCheckSum.Enter(
  const parameters: TFunctionItemParameters);
begin
   Services.SysMainForm.ShowForm(TFrmQueryScheduleCheckSum,FrmQueryScheduleCheckSum,self);
end;

function TQryScheduleCheckSum.getDescribe: String;
begin
  Result:='班次检票汇总表';
end;

function TQryScheduleCheckSum.getKey: TGUID;
begin
  Result:=StringToGUID('{EE0F824C-F9EC-416E-A39F-6245361DA0A4}');
end;

function TQryScheduleCheckSum.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

function TQryScheduleCheckSum.IsWorkState: Boolean;
begin

end;

procedure TQryScheduleCheckSum.Leave;
begin

end;

procedure TQryScheduleCheckSum.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
