{------------------------------------
  ����˵����station.bpl�����Ԫ
  �������ڣ�2011/01/22
  ���ߣ���ΰ
  ��Ȩ��nova
-------------------------------------}
unit StationManager;

interface
uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses StationPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var stationFunctionItem: TStationFunctionItem;
//   roleListItem:TRoleFunctionItem;
begin
 stationFunctionItem:=TStationFunctionItem.Create;
  Reg.RegisterFunctionItem(stationFunctionItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('ҵ�����\վ�����',stationFunctionItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
