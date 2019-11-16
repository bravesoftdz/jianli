unit UFrmLogInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmLogInfo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Memo1: TMemo;
    bbtnClose: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogInfo: TFrmLogInfo;

implementation

{$R *.dfm}

end.
