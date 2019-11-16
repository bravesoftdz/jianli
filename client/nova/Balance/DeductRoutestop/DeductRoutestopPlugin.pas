unit DeductRoutestopPlugin;


interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,UFrmDeductRoutestop;

Type
{------------------------------------
  功能说明：线路停靠点扣费管理功能
-------------------------------------}
  TDeductRoutestop=class(TInterfacedObject,IFunctionItem)
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

{ TDeductRoutestop }

procedure TDeductRoutestop.ChangeTheme;
begin

end;

constructor TDeductRoutestop.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TDeductRoutestop.Enter(const parameters: TFunctionItemParameters);
begin
  Services.SysMainForm.ShowForm(TFrmDeductRoutestop,FrmDeductRoutestop,Self);
end;

function TDeductRoutestop.getDescribe: String;
begin
  Result:='线路停靠点扣费管理';
end;

function TDeductRoutestop.getKey: TGUID;
begin
  Result:=StringToGUID('{577C3AC7-610F-4307-9B01-F7ADA8675332}');
end;

function TDeductRoutestop.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TDeductRoutestop.IsWorkState: Boolean;
begin

end;

procedure TDeductRoutestop.Leave;
begin

end;

procedure TDeductRoutestop.refresh(const parameters: TFunctionItemParameters);
begin

end;

end.
