unit TicketUseDetailExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketUseDetailPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  TicketUseDetailFunctionitem: TTicketUseDetailFunction;
  parameters:TFunctionItemParameters;
begin
  TicketUseDetailFunctionitem := TTicketUseDetailFunction.Create;
  Reg.RegisterFunctionItem(TicketUseDetailFunctionitem);

{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('�������\Ʊ�ݱ���\Ʊ��ʹ����ϸ��', TicketUseDetailFunctionitem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
