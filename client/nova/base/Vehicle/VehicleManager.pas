{------------------------------------
  ����˵����Vehicle.bpl�����Ԫ
  �������ڣ�2011/01/22
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit VehicleManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses VehiclePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleFunctionItem:TVehicleFunctionItem;
begin
 vehicleFunctionItem:=TVehicleFunctionItem.Create;
  Reg.RegisterFunctionItem(vehicleFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ҵ�����\��������',vehicleFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
