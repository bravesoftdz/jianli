unit UFrmStationRouteReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmStationRouteReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStationRouteReport: TFrmStationRouteReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmStationRouteReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmStationRouteReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if (cbborg.GetCount = 0) or (cbborg.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ����������');
    exit;
  end;
  if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��!');
    exit;
  end;
  with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['orgids'] :=  cbborg.GetSelectID;
    Params.ParamValues['startdate']
            :=formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate']
            := formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    Active:= true;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(cbborg.Text) <>'' then
      log := log +',[��������]��'+cbborg.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->���˰��ߵ���ͳ�Ʊ�','��ѯ',log);

  end;
end;

end.
