{------------------------------------
  ����˵����ticketoutlet.bpl�����Ԫ
  �������ڣ�2011/01/22
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit TickettypeManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses TickettypePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var tickettypeFunctionItem: TTickettypeFunctionItem;
begin
 tickettypeFunctionItem:=TTickettypeFunctionItem.Create;
  Reg.RegisterFunctionItem(tickettypeFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ҵ�����\Ʊ������',tickettypeFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
