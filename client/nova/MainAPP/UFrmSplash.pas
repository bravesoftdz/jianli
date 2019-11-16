{------------------------------------
  功能说明：欢迎窗口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit UFrmSplash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, jpeg, GIFImg, pngimage;

type
  TfrmSplash = class(TForm)
    lab_ver: TLabel;
    lab_Title: TLabel;
    mm_Loading: TMemo;
    Image1: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

end.
