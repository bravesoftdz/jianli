{------------------------------------
  功能说明：实现IProgressForm 接口(等待窗口)
  创建日期：2008.12.12
  作者：WZW
  版权：WZW
-------------------------------------}
unit ProgressFormImpl;

interface

uses SysUtils,Forms,ProgressFormIntf,ProgressForm,MainFormIntf;

Type
  TProgressFormObj=Class(TInterfacedObject,IProgressForm)
  private
    FProgressForm:Tfrm_ProgressForm;
    procedure CreateForm;
  protected
    {IProgressForm}
    procedure ShowMsg(const MsgStr:String);
    procedure progress(const Max,Position:Integer);
    procedure Hide;
  public
    constructor Create;
    destructor Destroy;override;
  End;

implementation

uses SysFactory;

{ TProgressFormObj }

constructor TProgressFormObj.Create;
begin
  FProgressForm:=nil;
end;

procedure TProgressFormObj.CreateForm;
begin
  if FProgressForm=nil then
  begin
    FProgressForm:=Tfrm_ProgressForm.Create(nil);
  end;
  FProgressForm.Show;
end;

destructor TProgressFormObj.Destroy;
begin
  if assigned(FProgressForm) then
    FProgressForm.Free;
  inherited;
end;

procedure TProgressFormObj.Hide;
begin
  if assigned(FProgressForm) then
  begin
    //FMainFormIntf.EnableExit;//允许退出程序
    FProgressForm.Hide;
    FProgressForm.Free;
    FProgressForm:=nil;
  end;
end;

procedure TProgressFormObj.progress(const Max, Position: Integer);
begin
  CreateForm;
  FProgressForm.ProgressBar.Visible:=True;
  FProgressForm.ProgressBar.Max:=Max;
  FProgressForm.ProgressBar.Position:=Position;
  //application.ProcessMessages;
end;

procedure TProgressFormObj.ShowMsg(const MsgStr: String);
begin
  CreateForm;
  FProgressForm.pal_Msg.Caption:=MsgStr;
  //FProgressForm.pal_Msg.Repaint;
  application.ProcessMessages;
end;

procedure Create_ProgressFormObj(out anInstance: IInterface);
begin
  anInstance:=TProgressFormObj.Create;
end;

initialization
  TIntfFactory.Create(IProgressForm,@Create_ProgressFormObj);
finalization

end.

