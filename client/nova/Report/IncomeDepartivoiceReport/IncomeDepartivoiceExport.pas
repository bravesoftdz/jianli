unit IncomeDepartivoiceExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses incomeDepartivoicePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var incomeDepartivoice:incomeDepartivoiceManager;
  par:TFunctionItemParameters;

begin
  incomeDepartivoice := incomeDepartivoiceManager.Create;
  Reg.RegisterFunctionItem(incomeDepartivoice);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('Ӫ������ͳ�Ʊ�',incomeDepartivoice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
