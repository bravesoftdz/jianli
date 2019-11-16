unit SellerTaskReportExport;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SellerTaskReportPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var SellerTaskReportFunctionItem:TSellerTaskReportFunctionItem;
begin
 SellerTaskReportFunctionItem:=TSellerTaskReportFunctionItem.Create;
  Reg.RegisterFunctionItem(SellerTaskReportFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('��Ʊ����\��ƱԱ�����',SellerTaskReportFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
