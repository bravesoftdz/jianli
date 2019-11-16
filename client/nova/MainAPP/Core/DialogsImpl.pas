{------------------------------------
  功能说明：实现IMessageBox接口
  创建日期：2008/11/20
  作者：wzw
  版权：wzw
-------------------------------------}
unit DialogsImpl;

interface

uses SysUtils,Forms,Windows,Dialogs,DialogIntf;

Type
  TDialogs=Class(TInterfacedObject,IDialog)
  private
  protected
    {IMessageBox}
    procedure ShowMessage(const APrompt:String);
    procedure ShowMessageFmt(const APrompt:string;const Args: array of const);
    procedure ShowInfo(const APrompt:string);
    procedure ShowError(const APrompt:string);overload;
    procedure ShowError(E:Exception);overload;
    procedure ShowErrorFmt(const APrompt:string;const Args: array of const);
    procedure Warning(const APrompt:String);
    function  Confirm(const ACaption,APrompt:string):Boolean;
    function  Ask(const ACaption,APrompt:string):Boolean;
    function  InputBox(const ACaption,APrompt:string;var Value:string):Boolean;
  public
    Destructor Destroy;override;
  End;

implementation

uses SysFactory;

{ TMessageBox }

function TDialogs.InputBox(const ACaption, APrompt: string;
  var Value: string): Boolean;
begin
  Result:=InputQuery(aCaption,APrompt,Value);
end;

function TDialogs.Ask(const ACaption, APrompt: string): Boolean;
begin
  Result:=application.MessageBox(pchar(APrompt),pchar(ACaption),MB_YESNO+MB_ICONQUESTION)=IDYES;
end;

function TDialogs.Confirm(const ACaption, APrompt: string): Boolean;
begin
  Result:=application.MessageBox(pchar(APrompt),pchar(ACaption),MB_OKCANCEL+MB_ICONQUESTION)=IDOK;
end;

procedure TDialogs.ShowError(E: Exception);
begin
  self.ShowError(E.Message);
end;

procedure TDialogs.ShowError(const APrompt: string);
begin
  application.MessageBox(pchar(APrompt),'错误',MB_ICONERROR);
end;

procedure TDialogs.ShowErrorFmt(const APrompt: string;
  const Args: array of const);
begin
  self.ShowError(format(APrompt,Args));
end;

procedure TDialogs.ShowInfo(const APrompt: string);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title),MB_ICONINFORMATION);
end;

procedure TDialogs.ShowMessage(const APrompt: String);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title));
end;

procedure TDialogs.ShowMessageFmt(const APrompt: string;
  const Args: array of const);
begin
  self.ShowMessage(format(APrompt,Args));
end;

procedure TDialogs.Warning(const APrompt: String);
begin
  application.MessageBox(pchar(APrompt),pchar(application.Title),MB_ICONWARNING);
end;

destructor TDialogs.Destroy;
begin
  inherited;
end;

procedure Create_DialogObj(out anInstance: IInterface);
begin
  anInstance:=TDialogs.Create;
end;

initialization
  TIntfFactory.Create(IDialog,@Create_DialogObj);
finalization

end.
