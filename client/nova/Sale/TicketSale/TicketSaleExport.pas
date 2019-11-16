{------------------------------------
  ����˵����TicketSale.bpl�����Ԫ
  �������ڣ�2011.1.26
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit TicketSaleExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
  TicketSalePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  ticketSale: TSellTicketFunction;
  parameters:TFunctionItemParameters;
  printticket:TPrintTicketFunction;
begin
  ticketSale := TSellTicketFunction.Create;
  Reg.RegisterFunctionItem(ticketSale);
  printticket:=TPrintTicketFunction.Create;
  Reg.RegisterFunctionItem(printticket);
{$IFDEF DEBUG}
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='0';        //��Ʊ
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='1';        //��Ʊ
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='2';        //��Ȩ��Ʊ
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ȩ��Ʊ', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='8';        //��Ʊ
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='1670';
  (SysService as IMainForm).CreateMenu('��Ʊ����\�����ش�Ʊ', printticket.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='6';        //��Ʊ����
  (SysService as IMainForm).CreateMenu('��Ʊ����\��Ʊ����', ticketSale.key, parameters);
  parameters:=TFunctionItemParameters.Create;
  parameters.CommaText:='4';        //��ǩ
  (SysService as IMainForm).CreateMenu('��Ʊ����\��ǩ', ticketSale.key, parameters);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
