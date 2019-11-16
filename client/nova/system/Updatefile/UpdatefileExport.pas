unit UpdatefileExport;


interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation
uses UpdatefilePlugin,UpdatefileImpl;
procedure PlugInit(Reg:IRegPlugin);//ע����
var
 updatefileFunction:TUpdatefileFunction;
 updatefile:TUpdatefile;
begin
  updatefile:=TUpdatefile.Create;
  updatefile.updatefile;
   //ע�Ṧ��
  updatefileFunction:=TUpdatefileFunction.Create;
  reg.RegisterFunctionItem(updatefileFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('ϵͳ����\��������', updatefileFunction.key, nil);
{$ENDIF}

end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.

