unit UFrmPublicQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw,Services, ComCtrls, ToolWin, Menus, ImgList,cefvcl,
  cefgui,ceflib, ComObj,ExtCtrls;

type
  TFrmPublicQry = class(TForm)
    PageControl1: TPageControl;
    Chromium1: TChromium;
    SaveDialog: TSaveDialog;
    Timer1: TTimer;


    procedure FormShow(Sender: TObject);
    procedure Chromium1GetDownloadHandler(Sender: TObject; const browser: ICefBrowser; const mimeType, fileName: ustring; contentLength: Int64; var handler: ICefDownloadHandler; out Result: Boolean);
    procedure printPreview(var priviewurl:String);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
    FLoading: Boolean;
    printurl:string;
  public
    url : string;
    { Public declarations }
    constructor Create(url: String);
  end;

  TCefStreamDownloadHandler = class(TCefDownloadHandlerOwn)
  private
    FStream: TStream;
    FOwned: Boolean;
  protected
    function ReceivedData(data: Pointer; DataSize: Integer): Integer; override;
    procedure Complete; override;
  public
    constructor Create(stream: TStream; Owned: Boolean); reintroduce;
    destructor Destroy; override;
  end;

var
  FrmPublicQry: TFrmPublicQry;

implementation

{$R *.dfm}

procedure TFrmPublicQry.Chromium1GetDownloadHandler(Sender: TObject;
  const browser: ICefBrowser; const mimeType, fileName: ustring;
  contentLength: Int64; var handler: ICefDownloadHandler; out Result: Boolean);
var
  printdir :String;
  storeexceldir:String;
  ExcelApplication :variant;
begin
  if(Pos('_print',fileName)>0)then
    begin
      printdir:=ExtractFilePath(application.ExeName);
      if not DirectoryExists(printdir+'excel_temp')then
        begin
          CreateDir(printdir+'excel_temp');
        end;
      printurl:=printdir+'excel_temp\'+ fileName;
      showmessage('提示：准备打印...');
      handler := TCefStreamDownloadHandler.Create(TFileStream.Create(printurl, fmCreate), true);
      Result := True;
      Timer1.Enabled:=true;
    end
  else
    begin
      SaveDialog.FileName := fileName;
      if SaveDialog.Execute then
        handler := TCefStreamDownloadHandler.Create(
          TFileStream.Create(SaveDialog.FileName, fmCreate), true);
      Result := True;
    end;
end;

procedure TFrmPublicQry.printPreview(var priviewurl:String);
var
  ExcelApp :variant;
begin
  ExcelApp := CreateOleObject( 'Excel.Application' );
  ExcelApp.Visible := True;
  ExcelApp.WorkBooks.Open(priviewurl);
  ExcelApp.WorkSheets[1].Activate;
  ExcelApp.ActiveSheet.PrintPreview;
  ExcelApp.WorkBooks.Close;
  ExcelApp.Quit;
end;

procedure TFrmPublicQry.Timer1Timer(Sender: TObject);
begin
  printPreview(printurl);
  Timer1.Enabled:=False;
end;



constructor TFrmPublicQry.Create(url: string);
begin
   self.url := url;
   inherited Create(nil);
end;

procedure TFrmPublicQry.FormShow(Sender: TObject);
begin
   try
      Chromium1.Load(url);
   except on E:exception do
      showMessage(e.tostring);
   end;
end;

{ TCefStreamDownloadHandler }

procedure TCefStreamDownloadHandler.Complete;
begin
//  FrmPublicQry.StatusBar.SimpleText := 'Download complete';
end;

constructor TCefStreamDownloadHandler.Create(stream: TStream; Owned: Boolean);
begin
  inherited Create;
  FStream := stream;
  FOwned := Owned;
end;

destructor TCefStreamDownloadHandler.Destroy;
begin
  if FOwned then
    FStream.Free;
  inherited;
end;

function TCefStreamDownloadHandler.ReceivedData(data: Pointer;
  DataSize: Integer): Integer;
begin
  Result := FStream.Write(data^, DataSize);
//  FrmPublicQry.StatusBar.SimpleText := 'Downloading ... ' + IntToStr(FStream.Position div 1000) + ' Kb';
end;

end.
