unit TicketStaticsQueryExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketStaticsQueryPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  staticsticket: TStaticsTicketFunction;
  parameters:TFunctionItemParameters;
begin
  staticsticket := TStaticsTicketFunction.Create;
  Reg.RegisterFunctionItem(staticsticket);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('�������\�������\Ӫ��ͳ�Ʋ�ѯ', staticsticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
