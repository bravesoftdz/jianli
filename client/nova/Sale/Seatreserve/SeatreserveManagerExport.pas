unit SeatreserveManagerExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses SeatreserveManagerPlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var seatreserveManagerExport: TSeatreserveManagerExport;
begin
  seatreserveManagerExport:=TSeatreserveManagerExport.Create;
  Reg.RegisterFunctionItem(seatreserveManagerExport);
{$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('��Ʊ����\��Ʊ��λ��Ϣ',seatreserveManagerExport.key,nil);
{$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
