{------------------------------------
  ����˵����FunctionManager.bpl�����Ԫ
  �������ڣ�2011.07.01
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit FunctionManagerExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf,
  FunctionManagerPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  FunctionManager:TFunctionManager;
begin
  FunctionManager:=TFunctionManager.Create;
  Reg.RegisterFunctionItem(FunctionManager);
  {$IFDEF DEBUG}
    (SysService as IMainForm).CreateMenu('ϵͳ����\���ܹ���', FunctionManager.key, nil);
  {$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
