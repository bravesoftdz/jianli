{------------------------------------
  ����˵����Billtype.bpl�����Ԫ
  �������ڣ�2011/02/15
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit BillAmountDestroyExport;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses BillAmountDestroyPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var BillAmountDestroyFunctionItem:TBillAmountDestroyFunctionItem;
begin
 BillAmountDestroyFunctionItem:=TBillAmountDestroyFunctionItem.Create;
  Reg.RegisterFunctionItem(BillAmountDestroyFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\Ʊ�ݽ�����',BillAmountDestroyFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
