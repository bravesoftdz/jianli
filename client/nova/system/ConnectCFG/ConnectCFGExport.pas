{------------------------------------
  ����˵����ConnectCFG.bpl�����Ԫ
  �������ڣ�2010/11/24
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit ConnectCFGExport;

interface
uses SysUtils,MainFormIntf,RegPluginIntf;
procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

procedure PlugInit(Reg:IRegPlugin);//ע����
begin
   //ע�Ṧ��
   reg.RegisterFunctionItem(nil);
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.

