unit VehicleparkExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses VehicleparkPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var vehicleparkEdit:vehiclepark;
  par:TFunctionItemParameters;

begin
  vehicleparkEdit:=vehiclepark.Create;
  Reg.RegisterFunctionItem(vehicleparkEdit);

{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  par.CommaText:='12,ab';
  (SysService as  IMainForm).CreateMenu('ҵ�����\�ϳ���λ����',vehicleparkEdit.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
