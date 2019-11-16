{------------------------------------
  功能说明：关于窗口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit UFrmAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,uBaseForm, jpeg, ExtCtrls, GIFImg, DB, DBClient,
  jsonClientDataSet;

type
  TFrmAbout = class(TBaseForm)
    btn_close: TBitBtn;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    jcdsresult: TjsonClientDataSet;
    Label4: TLabel;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    Class procedure Execute;
  end;

var
  FrmAbout: TFrmAbout;

implementation

{$R *.dfm}

{ TFrm_About }

class procedure TFrmAbout.Execute;
begin
  FrmAbout:=TFrmAbout.Create(nil,nil);
  FrmAbout.ShowModal;
  FrmAbout.Free;
end;

procedure TFrmAbout.FormCreate(Sender: TObject);
var
  clientversion : TextFile;
  s:String;
  begin
    inherited;
    jcdsresult.Active := False;
    jcdsresult.Active := true;
    Label5.Caption := jcdsresult.FieldByName('versionnum').AsString;
    AssignFile(clientversion,'version.txt');
    Reset(clientversion);
    read(clientversion,s);
    Label3.Caption := s;
    CloseFile(clientversion);
  end;

end.
