unit QuerySchTicketpriceManager;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySchTicketpricePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var querySchTicketprice:querySchTicketpriceItem;
  par:TFunctionItemParameters;

begin
  querySchTicketprice:=querySchTicketpriceItem.Create;
  Reg.RegisterFunctionItem(querySchTicketprice);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('վ��ֹ�˾������Ʊ��������ܱ�',querySchTicketprice.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
