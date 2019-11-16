unit TicketFundsCheckExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses TicketFundsCheckPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  TicketFundsCheck:TTicketFundsCheck;
  par: TFunctionItemParameters;
begin
  TicketFundsCheck:=TTicketFundsCheck.Create;
  Reg.RegisterFunctionItem(TicketFundsCheck);

{$IFDEF DEBUG}
par := TFunctionItemParameters.Create; (SysService as IMainForm)
  .CreateMenu('�������\Ʊ��Ը���', TicketFundsCheck.key, par);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
