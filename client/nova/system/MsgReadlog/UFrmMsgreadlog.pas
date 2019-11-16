unit UFrmMsgreadlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, StdCtrls, Buttons, LoginUser, ExtCtrls, DB,
  DBClient, jsonClientDataSet, UDMPublic, GIFImg, Generics.Collections,
  USimpleEditForm, jpeg, inifiles, Constant, ImgList,ShellAPI, OleCtrls, SHDocVw;

type

  TfrmMsgreadlog = class(TSimpleEditForm)
    jcdsUpgradereadlog: TjsonClientDataSet;
    lblBegintimes: TLabel;
    lbl1: TLabel;
    lblUpgradetime: TLabel;
    lblVersion: TLabel;
    lbl2: TLabel;
    jcdsSaveMsgreadlog: TjsonClientDataSet;
    lblType: TLabel;
    wbtext: TWebBrowser;
    btn1: TBitBtn;
    procedure wbtextDocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    context : string;
  public
    { Public declarations }
    msgid:string;
  end;

var
  frmMsgreadlog: TfrmMsgreadlog;



implementation

uses SysInfoIntf, services, FunctionItemIntf, pubfn,mshtml,ActiveX;

{$R *.dfm}



procedure TfrmMsgreadlog.btn1Click(Sender: TObject);
begin
  inherited;
    with  jcdsSaveMsgreadlog do
  begin
    Close;
    Params.ParamByName('msgreadlog.msgtype').Value := 0;//0：系统升级日志
    Params.ParamByName('msgreadlog.userid').Value :=Sysinfo.LoginUserInfo.UserID;
    Params.ParamByName('msgreadlog.msgid').Value := msgid;
    Params.ParamByName('msgreadlog.readtime').Value := Now;
    Execute;
  end;
  Self.Close;
end;

procedure TfrmMsgreadlog.FormShow(Sender: TObject);
begin
  inherited;
   with jcdsUpgradereadlog do
  begin
    Active := False;
    Active :=True;
    msgid := FieldByName('id').AsString;
    lblVersion.Caption:= FieldByName('version').AsString;
    lblUpgradetime.Caption:= FieldByName('upgradetime').AsString;
    lblType.Caption:=  FieldByName('msgtypename').AsString;
    context := FieldByName('upgradecontext').AsString;
  end;
  wbtext.Navigate('about:blank');
end;

procedure TfrmMsgreadlog.wbtextDocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
  var  WebDoc: HTMLDocument;
  WebBody: HTMLBody;
begin
  inherited;
  WebDoc := wbtext.Document as HTMLDocument;
  WebBody := WebDoc.body as HTMLBody;
  WebBody.insertAdjacentHTML('BeforeEnd', context);
end;

//终止化 TWebBrowser
Initialization
OleInitialize(nil);
finalization
try
  OleUninitialize;
except
end;

end.
