unit NotifyExport;

interface

uses Classes, SysUtils, Dialogs, RegPluginIntf, Services, UFrmNotify,
  MainFormIntf, FunctionItemIntf, UDMPublic, jsonClientDataSet;

procedure PlugInit(Reg: IRegPlugin); // ע����
procedure PlugInFinal();

var
  jscdqueryNotify: TjsonClientDataSet;

  // ж�ز��
exports PlugInit, PlugInFinal;

implementation

uses NotifyPlugin;

procedure PlugInit(Reg: IRegPlugin); // ע����
var
  notifyFunctionItem: TNotityFunctionItem;
  mm,dd,hh:string;
begin
   notifyFunctionItem := TNotityFunctionItem.Create;
   Reg.RegisterFunctionItem(notifyFunctionItem);
 { jscdqueryNotify := TjsonClientDataSet.Create(nil);
  with jscdqueryNotify do
  begin
    RemoteServer := DMPublic.jcon;
    DataSourceName := 'datalist';
    QueryAddress := 'system/queryNotify';
    Active := false;
    Active := true;
    if recordcount > 0 then
    begin

      FrmNotify := TFrmNotify.Create(nil);
      FrmNotify.Width := 260;
      FrmNotify.Height := 180;
      FrmNotify.LabUserName.Caption := fieldbyname('name').AsString+':';
      mm:=FormatDateTime('MM',fieldbyname('lastlogintime').AsDateTime);
      dd:=FormatDateTime('DD',fieldbyname('lastlogintime').AsDateTime);
      hh:=FormatDateTime('HH:MM',fieldbyname('lastlogintime').AsDateTime);
      FrmNotify.LabLoginTime.Caption := mm+'��'+dd+'��'+' '+hh;
      FrmNotify.LabInfo.Caption := fieldbyname('msg').AsString;
      FrmNotify.id := fieldbyname('id').asInteger;
      FrmNotify.Show;
    end;
  end;
    }
end;

procedure PlugInFinal(); // ж�ز��
begin

end;

initialization

finalization

end.
