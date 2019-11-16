unit UFrmBillinuseReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmBillinuseReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlprecipients: TNovaHelp;
    chkcount: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillinuseReport: TFrmBillinuseReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmBillinuseReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
end;

procedure TFrmBillinuseReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamByName('startdate').Value := formatdatetime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamByName('enddate').Value := formatdatetime('yyyy-mm-dd', dtpenddate.DateTime);
      if Trim(nvhlprecipients.Text) = '' then
        Params.ParamByName('recipients').Value := ''
      else
        Params.ParamByName('recipients').Value := nvhlprecipients.Id;
      if chkcount.Checked then
        Params.ParamByName('status').Value := '2'
      else
        Params.ParamByName('status').Value := '';
      dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������' + SysInfo.LoginUserInfo.OrgName;
      dbgrdhResult.PrintInfo.PageTopRight:='ʹ��Ʊ֤���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active := True;

    log := '[ʹ��Ʊ֤����]��'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if nvhlprecipients.Id <> 0 then
      log := log +',[��ƱԱ]��'+nvhlprecipients.Text;
    if chkcount.Checked then
      log := log +',[δ����]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->��ƱԱƱ֤ʹ�����','��ѯ',log);

  end;
end;

end.
