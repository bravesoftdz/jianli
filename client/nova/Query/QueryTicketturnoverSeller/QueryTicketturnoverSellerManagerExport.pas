unit QueryTicketturnoverSellerManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QueryTicketturnoverSellerManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var sellerManagerExport:TQueryTicketturnoverSellerManagerExport;
begin
  sellerManagerExport:=TQueryTicketturnoverSellerManagerExport.Create;
  Reg.RegisterFunctionItem(sellerManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('�ۺϲ�ѯ\�����ѯ\��ƱԱ��������',sellerManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
