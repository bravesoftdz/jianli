{------------------------------------
  ����˵����onecard.bpl�����Ԫ
  �������ڣ�2012.12.06
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit onecardExport;

interface

uses Classes, SysUtils, RegPluginIntf, Services, MainFormIntf, FunctionItemIntf,
     onecardPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal(); // ж�ز��

exports PlugInit, PlugInFinal;

implementation

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  parameters:TFunctionItemParameters;
  onecardfunction:TOneCardFunction;
  oneCardFunctionReturn:TOneCardFunctionReturn;
begin
  onecardfunction:=TOneCardFunction.Create;
  Reg.RegisterFunctionItem(onecardfunction);
  oneCardFunctionReturn:=TOneCardFunctionReturn.Create;
  Reg.RegisterFunctionItem(oneCardFunctionReturn);
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
