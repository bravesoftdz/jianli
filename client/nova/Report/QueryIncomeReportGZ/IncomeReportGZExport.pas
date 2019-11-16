unit IncomeReportGZExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses IncomeReportGZPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var GZ:GZManagers;
  par:TFunctionItemParameters;

begin
  GZ:=GZManagers.Create;
  Reg.RegisterFunctionItem(GZ);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('���񱨱�\��λӪ��ͳ�Ʊ�-����',
            GZ.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
