{------------------------------------
  ����˵����TicketQuery.bpl�����Ԫ
  �������ڣ�2011.6.29
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit TicketQueryExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketQueryPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  TicketQuery: TTicketQueryFunction;
begin
  TicketQuery := TTicketQueryFunction.Create;
  Reg.RegisterFunctionItem(TicketQuery);
{$IFDEF DEBUG}
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ��ѯ', TicketQuery.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
