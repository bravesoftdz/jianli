unit InsureReturnManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses InsureReturnPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var isurerurnFunctionItem: TInsureReturnFunctionItem;
begin
 isurerurnFunctionItem:=TInsureReturnFunctionItem.Create;
  Reg.RegisterFunctionItem(isurerurnFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('��Ʊ����\�����˱���',isurerurnFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
