unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ACReport_TLB, StdCtrls;
//在uses 列表中加入 ACReport_TLB  单元


type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FRptEngine: TAcRptEngine; //定义报表引擎成员变量
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
  //创建报表引擎对象,如果写成 TAcRptEngine.Create(nil)，则必须在退出程序时执行 FRptEngine.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FRptEngine.ShowDesigner;
end;

end.
