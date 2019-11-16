unit BillupmoneyExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

uses BillupmoneyPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
// var paramManager:TparamManager;
var billupmoney: TBillupmoneyPlugin;

begin
  billupmoney := TBillupmoneyPlugin.Create;
  Reg.RegisterFunctionItem(billupmoney);

  {$IFDEF DEBUG}
  (SysService as  IMainForm).CreateMenu('Ʊ�ݹ���\����Ʊ�ɿ�',billupmoney.key,nil);
  {$ENDIF}

end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
