unit QryCheckWorkMonthExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QryCheckWorkMonthPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QryCheckWorkMonthPluginItem: TQryCheckWorkMonthPluginItem;
//   roleListItem:TRoleFunctionItem;
begin
 QryCheckWorkMonthPluginItem:=TQryCheckWorkMonthPluginItem.Create;
  Reg.RegisterFunctionItem(QryCheckWorkMonthPluginItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\��Ʊ��ѯ\��Ʊ�����±�',QryCheckWorkMonthPluginItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
