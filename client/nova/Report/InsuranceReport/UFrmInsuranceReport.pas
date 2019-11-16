unit UFrmInsuranceReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmInsuranceReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    sellOrgid: TNovaCheckedComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    nvhelpUserid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsuranceReport: TFrmInsuranceReport;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmInsuranceReport.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True  then
    begin
       dtpEselldate.Checked := True;
    end;
   if  dtpBselldate.Checked =False then
    begin
       dtpEselldate.Checked := False;
    end;
end;

procedure TFrmInsuranceReport.dtpenddateChange(Sender: TObject);
begin
  inherited;
  dtpEselldate.DateTime := dtpenddate.DateTime + 31;
end;

procedure TFrmInsuranceReport.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True  then
  begin
     dtpBselldate.Checked := True;
  end;
 if  dtpEselldate.Checked =False then
  begin
     dtpBselldate.Checked := False;
  end;
end;

procedure TFrmInsuranceReport.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  dtpBselldate.DateTime := dtpstartdate.DateTime - 31;
end;

procedure TFrmInsuranceReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dtpBselldate.DateTime := dtpstartdate.DateTime - 31;
  dtpEselldate.DateTime := dtpenddate.DateTime + 31;
  sellOrgid.Active := False;
  sellOrgid.Active := True;
end;

procedure TFrmInsuranceReport.tbtnFilterClick(Sender: TObject);
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
      Params.ParamValues['filter_INS_i!orgid'] := sellOrgid.GetSelectID;
      Params.ParamValues['orgids'] := sellOrgid.GetSelectID;
      Params.ParamValues['filter_GED_i!selltime'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01';
      Params.ParamValues['filter_LED_i!selltime'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59';
      Params.ParamValues['begindate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01';
      Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59';
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpBselldate.Date);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
      Params.ParamValues['departbegindate'] := FormatDateTime('yyyy-mm-dd',dtpBselldate.Date);
      Params.ParamValues['departenddate'] := FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
      if Trim(nvhelpRoute.Text) = '' then
        Params.ParamValues['routeid'] := ''
      else
        params.ParamValues['routeid'] := nvhelpRoute.Id;
      if Trim(nvhelpUserid.text) = '' then
      begin
        params.ParamValues['filter_EQL_i!sellby'] := '';
        params.ParamValues['returnOrcanceluserid'] := '';
      end
      else
      begin
        params.ParamValues['filter_EQL_i!sellby'] := nvhelpUserid.Id;
        params.ParamValues['returnOrcanceluserid'] := nvhelpUserid.Id;
      end;
    Active := True;

    log := '��ѯ�����У�[��Ʊ����]�� '+ FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01'
      +'��'+FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59'
      +',[��������] ��'+FormatDateTime('yyyy-mm-dd',dtpBselldate.Date)
      +'��'+ FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
    if Trim(sellOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+sellOrgid.Text;
    if nvhelpRoute.Id <> 0 then
      log := log +',[��·]��'+nvhelpRoute.Text;
    if nvhelpUserid.Id <>0 then
      log := log +',[��ƱԱ]:'+nvhelpUserid.Text;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��ƱԱ��������ͳ��','��ѯ',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
  end;
end;

end.
