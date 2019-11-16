unit DWardpenalizeExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ

exports
  PlugInit,
  PlugInFinal;
implementation
  uses DWardpenalizePlugin;
procedure PlugInit(Reg:IRegPlugin);//×¢²á²å¼þ
var manager:TDWardpenalizemanager;
  par:TFunctionItemParameters;
begin
  manager:=TDWardpenalizemanager.Create;
  Reg.RegisterFunctionItem(manager);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('µµ°¸¹ÜÀí\¼ÝÊ»Ô±½±³Í¼ÇÂ¼',manager.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //Ð¶ÔØ²å¼þ
begin

end;

initialization

finalization

end.
