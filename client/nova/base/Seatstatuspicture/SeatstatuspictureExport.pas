unit SeatstatuspictureExport;

interface
uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses SeatstatuspicturePlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  seatstatuspictureManager: TSeatstatuspictureManager;
  i: integer;
begin
  seatstatuspictureManager := TSeatstatuspictureManager.Create;
  Reg.RegisterFunctionItem(seatstatuspictureManager);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('ҵ�����\Ĭ����λ״̬ͼƬ', seatstatuspictureManager.key, nil);
{$ENDIF}
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
