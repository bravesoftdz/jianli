unit UFrmUpgradelog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,Services,
  PrnDbgeh, NovaEdit, NovaHelp, NovaComboBox, NvPrnDbgeh, NvDbgridEh,
  NovaCheckedComboBox, NovaHComboBox, OleCtrls, SHDocVw;

type
  TfrmUpgradelog = class(TSimpleCRUDForm)
    edtContent: TNovaEdit;
    lblIp: TLabel;
    pnl1: TPanel;
    grp3: TGroupBox;
    spl1: TSplitter;
    jcdsContext: TjsonClientDataSet;
    dsEntrance: TDataSource;
    chkNeed: TCheckBox;
    chkNotNeed: TCheckBox;
    edtVersion: TNovaEdit;
    lbl1: TLabel;
    lblBegintimes: TLabel;
    lblEndtimes: TLabel;
    dtpEnddate: TDateTimePicker;
    dtpEndtime: TDateTimePicker;
    dtpBegintime: TDateTimePicker;
    dtpBegindate: TDateTimePicker;
    wdstrngfldContextcontext: TWideStringField;
    wb1: TWebBrowser;
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure sethtml(const WebBrowser:TWebBrowser;const Html: string);
    procedure wb1DocumentComplete(ASender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
  private
    { Private declarations }
    context: string;
  public
    { Public declarations }
    isactive : Boolean;
    procedure refresh;

  end;

var
  frmUpgradelog: TfrmUpgradelog;

implementation
  uses  PubFn, UDMPublic,mshtml,ActiveX;

{$R *.dfm}

procedure TfrmUpgradelog.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBegindate.Date := Now;
  dtpEnddate.Date:= Now;
end;

procedure TfrmUpgradelog.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
 if dsResult.DataSet.RecordCount<1 then
 begin
   jcdsContext.Close;
 end;

end;

procedure TfrmUpgradelog.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
   refresh
end;

procedure TfrmUpgradelog.refresh;
 var
    StrStream:TStringStream;
    SetNoteStr: string;


begin
  with jcdsContext do
  begin
    Active:=False;
//    Params.ParamValues['filter_EQS_t!orgid']:=jcdsResult.FieldByName('orgid').AsString;
    Params.ParamValues['id']:=jcdsResult.FieldByName('id').AsString;
    Active:=True;

    if RecordCount > 0 then
    begin
      Wb1.Navigate('about:blank');
      context := FieldByName('upgradecontext').AsString;
    end
    else
    begin
      Wb1.Navigate('about:blank');
      context := '';
    end;

  end;
end;

procedure TfrmUpgradelog.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
   if FormatDateTime('yyyymmdd', dtpBegindate.Date) > FormatDateTime('yyyymmdd',
    dtpEnddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
   if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEnddate.Date-dtpBegindate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
   with jcdsResult do
   begin
      Active := False;
      Params.ParamByName('filter_LIKES_ul!version').Value := edtVersion.Text;  //nvHcbbOrgNovaCbbOrg.HelpFieldValue['id'];
      Params.ParamByName('filter_LIKES_ul!upgradecontext').Value := edtContent.Text;
      Params.ParamValues['filter_GED_ul!upgradetime'] :=
        formatdatetime('yyyy-mm-dd',dtpBegindate.Date)+' '+ formatdatetime('hh:mm:ss',dtpBegintime.Time);
      Params.ParamValues['filter_LED_ul!upgradetime'] :=
        formatdatetime('yyyy-mm-dd',dtpEnddate.Date)+' '+formatdatetime('hh:mm:ss',dtpEndtime.Time);

    if not chkNeed.Checked  and chkNotNeed.Checked  then    //是否需要弹窗提示
      begin
         Params.ParamValues['filter_EQB_ul!needpopup']:='false';
      end
    else if  (chkNeed.Checked ) and (not chkNotNeed.Checked )then
      begin
         Params.ParamValues['filter_EQB_ul!needpopup']:='true';
      end
    else
      begin
         Params.ParamValues['filter_EQB_ul!needpopup']:='';
      end;
      Active :=True;
   end;
   refresh;
   jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

//在WebBrowser加载html页面完成后,在页面顶端插入HTML代码
procedure TfrmUpgradelog.wb1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
  var  WebDoc: HTMLDocument;
  WebBody: HTMLBody;
begin
  inherited;
  WebDoc := wb1.Document as HTMLDocument;
  WebBody := WebDoc.body as HTMLBody;
  WebBody.insertAdjacentHTML('BeforeEnd', context);

end;

procedure TfrmUpgradelog.sethtml(const WebBrowser:TWebBrowser;const Html:string);
var
ppDisp: IDispatch;
PersistStreamInit: IPersistStreamInit;
StreamAdapter: IStream;
stringStream:TStringStream;
begin
  WebBrowser.Navigate('about:blank');
  if WebBrowser.Document.QueryInterface(IPersistStreamInit,PersistStreamInit)=S_OK then
  begin
    if PersistStreamInit.InitNew=S_OK then
    begin

      stringStream:=TStringStream.Create(Html);
    StreamAdapter:=TStreamAdapter.Create(stringStream,soOwned);
    PersistStreamInit.InitNew;
    PersistStreamInit.Load(StreamAdapter);
  end;
  end;
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

