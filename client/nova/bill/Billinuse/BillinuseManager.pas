{------------------------------------
  ����˵����BillStorage.bpl�����Ԫ
  �������ڣ�2011/02/14
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit BillinuseManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillinusePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var BillinuseFunctionItem:TBillinuseFunctionItem;
begin
 BillinuseFunctionItem:=TBillinuseFunctionItem.Create;
  Reg.RegisterFunctionItem(BillinuseFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\��Ʊ��Ϣ',BillinuseFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
