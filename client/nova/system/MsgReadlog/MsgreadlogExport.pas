{------------------------------------
  功能说明：Msgreadlog.bpl输出单元
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit MsgreadlogExport;

interface

uses SysUtils,MainFormIntf,RegPluginIntf,Services,
jsonClientDataSet,db;

procedure PlugInit(Reg:IRegPlugin);//注册插件
procedure PlugInFinal(); //卸载插件

exports
  PlugInit,
  PlugInFinal;

implementation
uses MsgreadlogPlugin , UDMPublic;
procedure PlugInit(Reg:IRegPlugin);//注册插件
var
 msgFunction:TMsgFunction;

  nResult: integer;
  sResult: string;
  jcdsLogout: TjsonClientDataSet;
begin
  jcdsLogout := TjsonClientDataSet.Create(nil);
  jcdsLogout.Params.CreateParam(ftString, 'msg', ptOutput);
  jcdsLogout.Params.CreateParam(ftBCD, 'flag', ptOutput);
  jcdsLogout.RemoteServer := UDMPublic.DMPublic.jcon;
  jcdsLogout.SaveAddress := 'system/isneedRead';
  //查找是否有需要提示的升级记录
  with jcdsLogout do
  begin
      close;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
          //注册功能
          msgFunction:=tmsgFunction.Create;
      end
      else

  end;
  Reg.RegisterFunctionItem(msgFunction);
{$IFDEF DEBUG}
  SysMainForm.CreateMenu('日志读取记录', msgFunction.key, nil);
{$ENDIF}

end;

procedure PlugInFinal(); //卸载插件
begin

end;

initialization

finalization

end.

