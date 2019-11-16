unit UFrmQueryBusinessDataSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
    TfrmQueryBusinessDataSummary = class(TSimpleCRUDForm)lbl1: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    chkBylatter: TCheckBox;
    chkBynormal: TCheckBox;
    nvckbOrgid: TNovaCheckedComboBox;
    jcdsResultorgname: TWideStringField;
    jcdsResultschnum1: TFloatField;
    jcdsResultschnumComp: TFloatField;
    jcdsResultschnumPercent: TWideStringField;
    jcdsResultticketnum: TFloatField;
    jcdsResultticketnum1: TFloatField;
    jcdsResultticketnumComp: TFloatField;
    jcdsResultticketnumPercent: TWideStringField;
    jcdsResulttotalamount: TFloatField;
    jcdsResulttotalamount1: TFloatField;
    jcdsResulttotalamountComp: TFloatField;
    jcdsResulttotalamountPercent: TWideStringField;
    jcdsResultpeopledistance: TFloatField;
    jcdsResultpeopledistance1: TFloatField;
    jcdsResultpeopledistanceComp: TFloatField;
    jcdsResultpeopledistancePercent: TWideStringField;
    jcdsResultrate: TWideStringField;
    jcdsResultrate1: TWideStringField;
    jcdsResultrateComp: TWideStringField;
    jcdsResultratePercent: TWideStringField;
    jcdsResultsellincome: TFloatField;
    jcdsResultsellincome1: TFloatField;
    jcdsResultsellincomeComp: TFloatField;
    jcdsResultsellincomePercent: TWideStringField;
    jcdsResultschnum: TFloatField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
    // procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid: String;
    { Public declarations }
  end;

var
  frmQueryBusinessDataSummary: TfrmQueryBusinessDataSummary;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryBusinessDataSummary.dtpComEndChange(Sender: TObject);
begin
  if not(dtpComEnd.Date = dtpComStar.Date + dtpenddate.Date -
      dtpstartdate.Date) then
  begin
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
  end;
end;

procedure TfrmQueryBusinessDataSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
end;

procedure TfrmQueryBusinessDataSummary.dtpenddateChange(Sender: TObject);
begin
  // if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  // begin
  // dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
  // end;

end;

// procedure TfrmQueryBusinessDataSummary.dtpstartdateChange(Sender: TObject);
// begin
// inherited;
// if dtpstartdate.Checked then
// dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
// end;

procedure TfrmQueryBusinessDataSummary.FormCreate(Sender: TObject);
var
  columntitle: TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  chkBylatter.Checked := True;
  chkBynormal.Checked := True;
end;

procedure TfrmQueryBusinessDataSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBusinessDataSummary.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  nvckbOrgid.SetFocus; // ����ѡ��ʱ��bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpenddate.Date - dtpstartdate.Date) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
    begin
    SysDialogs.Warning('ͬ�����������������ڷ�������������!');
    Exit;
    end; }
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    // if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    // end
    // else
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= '';
    // end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpComEnd.Date);



    Active := True;
   
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' ͬ�����ڣ�'+ formatdatetime('yyyy-mm-dd',dtpComStar.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpComEnd.Date);

     log := '��ѯ�����У�[��������]�� ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' �� ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date)
      + '[ͬ������] �� ' + FormatDateTime('yyyy-mm-dd', dtpComStar.Date)
      + ' �� ' + FormatDateTime('yyyy-mm-dd', dtpComEnd.Date);
    if Trim(nvckbOrgid.Text) <> '' then
      log := log + ',[����]��' + nvckbOrgid.Text;


    log := log + ' ��[��ѯ���]:���� ' + inttostr(recordcount) + ' ����¼��';
    SysLog.WriteLog('����ͳ��->վ��ֹ�˾վ��ҵ������������ܱ�', '��ѯ', log);
  end;

end;

end.
