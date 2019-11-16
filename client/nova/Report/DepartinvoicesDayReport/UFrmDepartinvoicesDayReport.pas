unit UFrmDepartinvoicesDayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox;

type
  TFrmDepartinvoicesDayReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    chkbytime: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicesDayReport: TFrmDepartinvoicesDayReport;

implementation

uses Services;
{$R *.dfm}

procedure TFrmDepartinvoicesDayReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmDepartinvoicesDayReport.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
    if DataSet.RecordCount>0 then
  begin
      if chkbytime.Checked then
      begin
        dbgrdhResult.Columns[2].Visible :=true;
      end
      else
      begin
        dbgrdhResult.Columns[2].Visible := false;
      end;
  end;
end;

procedure TFrmDepartinvoicesDayReport.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if chkbytime.Checked then
       Params.ParamValues['isbytime'] := true
    else
       Params.ParamValues['isbytime'] := false;

    Active := True;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[�������]��'+nvckbOrgid.Text;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->������ʡ���ؿ�������ͳ�Ʊ�','��ѯ',log);

  end;
end;

end.