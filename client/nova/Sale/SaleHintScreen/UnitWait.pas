unit UnitWait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,Inifiles,Jpeg,ShellApi, StdCtrls;
type
  TFormWait = class(TForm)
    Panel1: TPanel;
    imgbottom: TImage;
    imgtop: TImage;
    imgclient: TImage;
    lblusercode: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MyError(Sender: TObject; E:Exception) ;
    { Public declarations }
  end;

var
  FormWait: TFormWait;

  procedure ShowWaitForm;
implementation
uses UnitMyForm,Unitpause,UnitUtil;

{$R *.dfm}

procedure ShowWaitForm;
begin
   if Screen.MonitorCount<=1 then  //��ֻ��һ����ʾ����ʱ�� ��ʾ������ʾ����
   begin
     Application.Terminate; //����û�и���ʱ��ֱ�Ӳ��򿪸���

     MyForm.DefaultMonitor := dmMainForm;
     MyForm.Visible := false ;
//     MyForm.WindowState := wsMaximized ;

     FormWait.DefaultMonitor := dmMainForm;
     FormWait.Visible := true ;
//     FormWait.WindowState := wsMaximized ;

     Formpause.DefaultMonitor := dmMainForm;
     Formpause.Visible := false ;
//     Formpause.WindowState := wsMaximized ;
   end
   else       //�������ʾ����ʱ�� ��ʾ�ڵڶ���ʾ����
   begin
     MyForm.Visible := false ;
     MyForm.Left := Screen.Monitors[1].Left;
     MyForm.Top := Screen.Monitors[1].Top;
     MyForm.Width := Screen.Monitors[1].Width;
     MyForm.Height := Screen.Monitors[1].Height;

     FormWait.Visible := true;
     FormWait.Left := Screen.Monitors[1].Left;
     FormWait.Top := Screen.Monitors[1].Top;
     FormWait.Width := Screen.Monitors[1].Width;
     FormWait.Height := Screen.Monitors[1].Height;

     Formpause.Visible := false;
     Formpause.Left := Screen.Monitors[1].Left;
     Formpause.Top := Screen.Monitors[1].Top;
     Formpause.Width := Screen.Monitors[1].Width;
     Formpause.Height := Screen.Monitors[1].Height;
   end ;

   FormWait.Show;
end;

{ TFormWait }

procedure TFormWait.MyError(Sender: TObject; E: Exception);
begin
  Application.Terminate ;
end;

procedure TFormWait.FormCreate(Sender: TObject);
begin
  Application.OnException := MyError;
end;

end.
