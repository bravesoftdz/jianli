{------------------------------------
  ����˵����TicketReturn.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit TicketReturnExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketReturnPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  returnticket: TReturnTicketFunction;
  parameters:TFunctionItemParameters;
begin
  returnticket := TReturnTicketFunction.Create;
  Reg.RegisterFunctionItem(returnticket);

{$IFDEF DEBUG}
//  parameters:=TReturnTicketFunction.Create;
//  parameters.CommaText:='0';
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ', returnticket.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
