{ ------------------------------------
  ����˵����About.bpl�����Ԫ
  �������ڣ�2011/08/10
  ���ߣ�lck
  ��Ȩ��nova
  ------------------------------------- }
unit AboutExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses AboutPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  aboutFunctionItem: TAboutFunctionItem;
begin
  aboutFunctionItem := TAboutFunctionItem.Create;
  Reg.RegisterFunctionItem(aboutFunctionItem);
{$IFDEF DEBUG}
(SysService as IMainForm)
  .CreateMenu('����\����', aboutFunctionItem.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
