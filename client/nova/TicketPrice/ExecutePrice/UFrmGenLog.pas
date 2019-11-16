unit UFrmGenLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmGenLog = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmGenLog: TFrmGenLog;

implementation

{$R *.dfm}

end.
