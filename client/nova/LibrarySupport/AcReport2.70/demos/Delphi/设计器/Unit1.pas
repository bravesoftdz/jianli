unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACReport_TLB, StdCtrls;
//��uses �б��м��� ACReport_TLB  ��Ԫ


type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FRptEngine: TAcRptEngine; //���屨�������Ա����
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R XpStyle.RES}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FRptEngine := TAcRptEngine.Create(Self);
  //���������������,���д�� TAcRptEngine.Create(nil)����������˳�����ʱִ�� FRptEngine.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FRptEngine.ShowDesigner;
end;

end.
