unit NotifyPlugin;

interface
uses SysUtils,Classes,FunctionItemIntf,Generics.Collections, UDMPublic, jsonClientDataSet,Forms;

Type
  TNotityFunctionItem=class(TInterfacedObject,IFunctionItem)
  private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;
  var
    jscdqueryNotify: TjsonClientDataSet;
implementation
uses Services,MainFormIntf,UFrmNotify;
{ TNotityFunctionItem }

procedure TNotityFunctionItem.ChangeTheme;
begin

end;

constructor TNotityFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

procedure TNotityFunctionItem.Enter(const parameters: TFunctionItemParameters);
var
  mm,dd,hh:string;
begin

  jscdqueryNotify := TjsonClientDataSet.Create(nil);
  with jscdqueryNotify do
  begin
    RemoteServer := DMPublic.jcon;
    DataSourceName := 'datalist';
    QueryAddress := 'system/queryNotify';
    Active := false;
    Active := true;
    if recordcount > 0 then
    begin
      if (FrmNotify=nil) then
      begin
          FrmNotify := TFrmNotify.Create(nil);
          FrmNotify.Width := 260;
          FrmNotify.Height := 180;
          FrmNotify.LabUserName.Caption := fieldbyname('name').AsString+':';
          mm:=FormatDateTime('MM',fieldbyname('lastlogintime').AsDateTime);
          dd:=FormatDateTime('DD',fieldbyname('lastlogintime').AsDateTime);
          hh:=FormatDateTime('HH:MM',fieldbyname('lastlogintime').AsDateTime);
          FrmNotify.LabLoginTime.Caption := mm+'月'+dd+'日'+' '+hh;
          FrmNotify.LabInfo.Caption := fieldbyname('msg').AsString;
          FrmNotify.id := fieldbyname('id').asInteger;
          FrmNotify.Show;
      end
      else if not FrmNotify.Showing then
      begin
          FrmNotify.Show;
      end;

      FrmNotify.left := Screen.Width - 280;
      FrmNotify.Top := screen.Height - 220;
  //  Label3.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  Label2.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  Label1.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  LabLoginTime.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  LabUserName.OnMouseEnter:= pnlEditBoxMouseEnter;
      FrmNotify.LabUserName.Top:=FrmNotify.Label2.Top;
  //  mp1.Rewind;
//      FrmNotify.mp1.FileName=App
      FrmNotify.mp1.Open;
      FrmNotify.mp1.Play;
      if (FrmNotify.mp1.Position=FrmNotify.mp1.Length)  then
      begin
       FrmNotify.mp1.AutoRewind:=true;
       FrmNotify.mp1.Notify:=true;
      end;

    end
    else if (RecordCount = 0) and (FrmNotify<>nil) then
      begin
          FrmNotify.Close;
      end;

end;


  //Services.SysMainForm.ShowForm(FrmNotify);
end;

function TNotityFunctionItem.getDescribe: String;
begin
  Result:='系统提示信息';
end;

function TNotityFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{8A2730E9-F70F-40F6-BEF4-0B0FED44E3BE}');
end;

function TNotityFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TNotityFunctionItem.IsWorkState: Boolean;
begin

end;

procedure TNotityFunctionItem.Leave;
begin

end;

procedure TNotityFunctionItem.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
