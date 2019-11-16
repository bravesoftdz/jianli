unit QueryPackDetailsExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryPackDetailsPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var QueryPackDetailsPluginItem: TQueryPackDetailsPluginItem;
//   roleListItem:TRoleFunctionItem;
begin
 QueryPackDetailsPluginItem:=TQueryPackDetailsPluginItem.Create;
  Reg.RegisterFunctionItem(QueryPackDetailsPluginItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�а���ѯ\ǰ̨��ϸ',QueryPackDetailsPluginItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
