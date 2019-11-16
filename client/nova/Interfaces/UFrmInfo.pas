unit UFrmInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm,  ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, OleCtrls, SHDocVw,mshtml;

type
  TFrmInfo = class(TSimpleEditForm)
    jscdQryFunInfo: TjsonClientDataSet;
    grp3: TGroupBox;
    wb1: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure wb1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    context:string;
  public
    { Public declarations }
     key:string;
  end;

var
  FrmInfo: TFrmInfo;

implementation
uses UDMPublic;
{$R *.dfm}

procedure TFrmInfo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = vk_escape) then
    Close;
end;

procedure TFrmInfo.FormShow(Sender: TObject);
begin
  inherited;
  self.Width:=700;
  with jscdQryFunInfo do
  begin
    close;
    Params.ParamValues['key']:=key;
    open;
    if RecordCount > 0 then
    begin
      Wb1.Navigate('about:blank');
      context := FieldByName('instruction').AsString;
    end
    else
    begin
      Wb1.Navigate('about:blank');
      context := '';
    end;
  end;
end;

procedure TFrmInfo.wb1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
  var URL: OleVariant);
var  WebDoc: HTMLDocument;
  WebBody: HTMLBody;
begin
  inherited;
  WebDoc := wb1.Document as HTMLDocument;
  WebBody := WebDoc.body as HTMLBody;
  WebBody.insertAdjacentHTML('BeforeEnd', context);
end;

end.
