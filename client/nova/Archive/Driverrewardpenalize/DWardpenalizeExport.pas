unit DWardpenalizeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DWardpenalizePlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var manager:TDWardpenalizemanager;
  par:TFunctionItemParameters;
begin
  manager:=TDWardpenalizemanager.Create;
  Reg.RegisterFunctionItem(manager);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��������\��ʻԱ���ͼ�¼',manager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
