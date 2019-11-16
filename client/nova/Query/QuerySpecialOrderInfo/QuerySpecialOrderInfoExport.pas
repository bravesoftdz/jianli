unit QuerySpecialOrderInfoExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses QuerySpecialOrderInfoPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var QuerySpecialOrderInfo:QuerySpecialOrderInfoManager;
  par:TFunctionItemParameters;

begin
  QuerySpecialOrderInfo:=QuerySpecialOrderInfoManager.Create;
  Reg.RegisterFunctionItem(QuerySpecialOrderInfo);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���Ȳ�ѯ\ͣ���������ѯ',QuerySpecialOrderInfo.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
