unit Unitpause;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,Inifiles,Jpeg,ShellApi, StdCtrls;
type
  TFormpause = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure MyError(Sender: TObject; E:Exception) ;
    { Public declarations }
  end;

var
  Formpause: TFormpause;

  procedure FrmmainShow;
implementation
uses UnitMyForm,UnitWait,UnitUtil;

{$R *.dfm}

procedure FrmmainShow;
var
  hWndClose: HWnd;// �洢ָ�����ⲿӦ�ó��򴰿ھ��
  str: String;// �洢ָ�����ⲿӦ�ó���Ĵ�����
begin
   str := '���������Ϣ����ϵͳ';
   hWndClose := FindWindow(nil, PChar(str));  //���ݴ���������Ҫ���ھ��
   if hWndClose <> 0 then  //���ҳɹ�,��ʾ��ǰ��
   begin
       SetForeGroundWindow(hWndClose);
   end;
end;



{ TFormpause }

procedure TFormpause.MyError(Sender: TObject; E: Exception);
begin
  Application.Terminate ;
end;

procedure TFormpause.FormCreate(Sender: TObject);
begin
  Application.OnException := MyError;
end;

procedure TFormpause.FormShow(Sender: TObject);
begin
  Label5.Caption:= GetSystemDatetime;
  Timer1.Enabled:=true;
end;

procedure TFormpause.Timer1Timer(Sender: TObject);
begin
  Label5.Caption:= GetSystemDatetime;
end;

end.
