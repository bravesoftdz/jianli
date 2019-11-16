unit EachTickeIncomeSumRptExport;


interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf,FunctionItemIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;
implementation
  uses EachTickeIncomeSumRptPlugin;
procedure PlugInit(Reg:IRegPlugin);//ע����
var eachTickeIncomeSumRpt:EachTickeIncomeSumRptManager;
  par:TFunctionItemParameters;

begin
  eachTickeIncomeSumRpt:=EachTickeIncomeSumRptManager.Create;
  Reg.RegisterFunctionItem(eachTickeIncomeSumRpt);


{$IFDEF DEBUG}
  par:=TFunctionItemParameters.Create;
  (SysService as  IMainForm).CreateMenu('��վ���ۻ���Ӫ�ջ��ܱ�',eachTickeIncomeSumRpt.key,par);
{$ENDIF}
end;
procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
