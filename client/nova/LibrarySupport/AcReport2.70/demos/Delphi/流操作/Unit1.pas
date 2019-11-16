unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AcReport_TLB, StdCtrls, AxCtrls, ActiveX;

type

  TForm1 = class(TForm)
    btnStream: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnStreamClick(Sender: TObject);
  private
    { Private declarations }
    fac: TAcRptEngine;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses AcRptUtils;

{$R *.dfm}
{$R XPStyle.RES}

procedure TForm1.FormCreate(Sender: TObject);
begin
  fac := TAcRptEngine.Create(nil);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fac.Free;
end;




procedure TForm1.btnStreamClick(Sender: TObject);
var
  st: TAcNetStream;
  stread, stwrite: TStream;
  n: integer;
  ws: WideString;
begin
// ���δ�����ʾ����δ�����װ��һ��ģ�壬�ͽ�һ��ģ�屣�浽��һ������
// Ϊ�˼򵥣�������Ч���������õ����ļ�����������������һ�٣�Ϊʲô��ֱ��LoadFrom���ļ�װ���أ�
//��ʵ�����ǲ�һ���ģ�ͨ���������ǿ��Ը����ش������ģ�����ݣ����罫����ģ�屣�����ڴ����У������ݿ��С�
//ACReportEngineֻ֧��ʵ����IAcNetStream�ӿڵ������󣬸����ʵ����AcRptUtils��Ԫ�У�������TAcNetStream��

  stread := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'test.apt', fmOpenRead);
  stwrite := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'testsave.apt', fmCreate);

  st := TAcNetStream.Create(stread); //����һ��AcNetStream������ȱʡ���ӵ�ʵ��Ҫ������������ , AcNetStreamֻ��һ���������
  stread.Position := 0;
  try
    if fac.LoadFromStream(st) <> 0 then
    begin
      fac.GetLastError(n, ws);
      Showmessage(ws);
    end
    else
      fac.ShowDesigner;

    st.ConnectTo(stwrite);   //���ӵ�Ҫд�������������
    fac.SaveToStream(st);
  finally
    st.Free;
    stread.Free;
    stwrite.Free;
  end;
end;



end.
