{------------------------------------
  ����˵����Billtype.bpl�����Ԫ
  �������ڣ�2011/02/15
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit BillinventoryManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinventoryPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var BillinventoryFunctionItem:TBillinventoryFunctionItem;
begin
 BillinventoryFunctionItem:=TBillinventoryFunctionItem.Create;
  Reg.RegisterFunctionItem(BillinventoryFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\������',BillinventoryFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
