{------------------------------------
  ����˵����Billtype.bpl�����Ԫ
  �������ڣ�2011/02/15
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit BilltypeManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BilltypePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var BilltypeFunctionItem:TBilltypeFunctionItem;
begin
 BilltypeFunctionItem:=TBilltypeFunctionItem.Create;
  Reg.RegisterFunctionItem(BilltypeFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\Ʊ������',BilltypeFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
