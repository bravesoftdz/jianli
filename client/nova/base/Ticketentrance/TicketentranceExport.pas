unit TicketentranceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses TicketentrancePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var entranceEdit:TticketentranceManager;
  par:TFunctionItemParameters;

begin
  entranceEdit:=TticketentranceManager.Create;
  Reg.RegisterFunctionItem(entranceEdit);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('ҵ�����\��Ʊ������',entranceEdit.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
