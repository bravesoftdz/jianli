{------------------------------------
  ����˵����BillStorage.bpl�����Ԫ
  �������ڣ�2011/02/14
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit BillStorageManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillStoragePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var BillStorageFunctionItem:TBillStorageFunctionItem;
begin
 BillStorageFunctionItem:=TBillStorageFunctionItem.Create;
  Reg.RegisterFunctionItem(BillStorageFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\Ʊ������',BillStorageFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
