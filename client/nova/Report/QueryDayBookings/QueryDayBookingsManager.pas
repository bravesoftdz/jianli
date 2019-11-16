unit QueryDayBookingsManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QueryDayBookingsPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var queryDayBookings:queryDayBookingsItem;
  par:TFunctionItemParameters;

begin
  queryDayBookings:=queryDayBookingsItem.Create;
  Reg.RegisterFunctionItem(queryDayBookings);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Ԥ��Ʊ�ձ���',queryDayBookings.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
