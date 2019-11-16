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
// 本段代码演示了如何从流中装入一个模板，和将一个模板保存到另一个流中
// 为了简单，并看到效果，这里用到了文件流，看起来好像多此一举，为什么不直接LoadFrom从文件装入呢？
//其实意义是不一样的，通过流，我们可以更灵活地处理报表的模板数据，例如将报表模板保存在内存流中，或数据库中。
//ACReportEngine只支持实现了IAcNetStream接口的流对象，该类的实现在AcRptUtils单元中，名称是TAcNetStream。

  stread := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'test.apt', fmOpenRead);
  stwrite := TFileStream.Create(ExtractFilePath(ParamStr(0)) + 'testsave.apt', fmCreate);

  st := TAcNetStream.Create(stread); //创建一个AcNetStream流，并缺省连接到实际要操作的流对象 , AcNetStream只是一个代理对象。
  stread.Position := 0;
  try
    if fac.LoadFromStream(st) <> 0 then
    begin
      fac.GetLastError(n, ws);
      Showmessage(ws);
    end
    else
      fac.ShowDesigner;

    st.ConnectTo(stwrite);   //连接到要写入操作的流对象
    fac.SaveToStream(st);
  finally
    st.Free;
    stread.Free;
    stwrite.Free;
  end;
end;



end.
