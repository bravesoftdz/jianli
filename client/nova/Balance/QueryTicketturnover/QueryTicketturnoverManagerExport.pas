unit QueryTicketturnoverManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketturnoverManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var queryTicketturnoverManagerExport:TQueryTicketturnoverManagerExport;
begin
  queryTicketturnoverManagerExport:=TQueryTicketturnoverManagerExport.Create;
  Reg.RegisterFunctionItem(queryTicketturnoverManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�������\��ƱԱ�ɿ��ѯ',queryTicketturnoverManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
