{------------------------------------
  ����˵����TakeTicket.bpl�����Ԫ
  �������ڣ�2011.10.15
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit TakeTicketExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TakeTicketPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  parameters:TFunctionItemParameters;
  printticket:TTakeTicketFunction;
begin
  printticket:=TTakeTicketFunction.Create;
  Reg.RegisterFunctionItem(printticket);
{$IFDEF DEBUG}
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('��Ʊ����\����ƱȡƱ', printticket.key, parameters);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
