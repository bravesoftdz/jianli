unit CardissueManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses CardissueManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var cardissueManagerExport:TCardissueManagerExport;
begin
  cardissueManagerExport:=TCardissueManagerExport.Create;
  Reg.RegisterFunctionItem(cardissueManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('ҵ�����\������¼',cardissueManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
