unit UFrmQueryDrawVehSummary;

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
  TfrmQueryDrawVehSummary = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lblunitid: TLabel;
    NovaHelpUnits: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryDrawVehSummary: TfrmQueryDrawVehSummary;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryDrawVehSummary.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryDrawVehSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryDrawVehSummary.tbtnFilterClick(Sender: TObject);
var
  log:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//����ѡ��ʱ��bug
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
  {if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
    if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  begin
    SysDialogs.Warning('ͬ�����������������ڷ�������������!');
    Exit;
  end; }
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date+1);
    if (trim(NovaHelpUnits.Text) <> '') and (NovaHelpUnits.id > 0) then
      Params.ParamByName('filter_EQL_p!unitid').Value := NovaHelpUnits.id
    else
      Params.ParamByName('filter_EQL_p!unitid').Value := null;

    Active := True;

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '��ѯ�����У�[����]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;

    if (trim(NovaHelpUnits.Text) <> '') and (NovaHelpUnits.id > 0) then
       log := log +',������λ��'+trim(NovaHelpUnits.Text);


    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->վ��ֹ�˾��վ�������ܱ�','��ѯ',log);
  end;

end;

end.
