unit UFrmExplorer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cefvcl, OleCtrls, SHDocVw;

type
  TFrmExplorer = class(TForm)
//    Chromium1: TChromium;
    Chromium1: TWebBrowser;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExplorer: TFrmExplorer;

implementation

{$R *.dfm}

procedure TFrmExplorer.FormCreate(Sender: TObject);
begin
  Chromium1.Navigate('http://localhost:9000/NvBusWeb/ui/dynamiclist?formkey=1');
  Chromium1.Visible := true;
end;

end.
