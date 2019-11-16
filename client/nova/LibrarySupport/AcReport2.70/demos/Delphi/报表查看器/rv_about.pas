unit rv_about;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TfrmRv_about = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRv_about: TfrmRv_about;

implementation

{$R *.DFM}

procedure TfrmRv_about.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

end.
