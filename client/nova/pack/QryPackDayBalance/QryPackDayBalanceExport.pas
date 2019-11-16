unit QryPackDayBalanceExport;

interface

uses Classes,SysUtils,RegPluginIntf,Services,MainFormIntf;

procedure PlugInit(Reg:IRegPlugin);//ע����
procedure PlugInFinal(); //ж�ز��

exports
  PlugInit,
  PlugInFinal;

implementation

uses QryPackDayBalancePlugin;

procedure PlugInit(Reg:IRegPlugin);//ע����
var FrmQryPackDayBalanceItem: TFrmQryPackDayBalanceItem;
//   roleListItem:TRoleFunctionItem;
begin
 FrmQryPackDayBalanceItem:=TFrmQryPackDayBalanceItem.Create;
  Reg.RegisterFunctionItem(FrmQryPackDayBalanceItem);
   {$IFDEF DEBUG}

  (SysService as  IMainForm).CreateMenu('�а�����\�а��ս����',FrmQryPackDayBalanceItem.key,nil);

  {$ENDIF}
end;

procedure PlugInFinal(); //ж�ز��
begin

end;

initialization

finalization

end.
