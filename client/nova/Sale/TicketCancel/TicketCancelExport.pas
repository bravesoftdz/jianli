{------------------------------------
  ����˵����TicketCancel.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit TicketCancelExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketCancelPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  cancelticket: TCancelTicketFunction;
  parameters:TFunctionItemParameters;
begin
  cancelticket := TCancelTicketFunction.Create;
  Reg.RegisterFunctionItem(cancelticket);

{$IFDEF DEBUG}
//  parameters:=TCancelTicketFunction.Create;
//  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ', cancelticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
