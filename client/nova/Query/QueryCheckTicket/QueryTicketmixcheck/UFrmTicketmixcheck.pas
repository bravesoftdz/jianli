unit UFrmTicketmixcheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmTicketmixcheck = class(TSimpleCRUDForm)
    lbl4: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    lblroute: TLabel;
    nvhlproute: TNovaHelp;
    lbl17: TLabel;
    lbl2: TLabel;
    edtTicketno: TNovaEdit;
    lbl9: TLabel;
    nvhlpendstation: TNovaHelp;
    nvcbbOrgid: TNovaCheckedComboBox;
    nvhlpschedule: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketmixcheck: TFrmTicketmixcheck;

implementation
   uses Services,PubFn;
{$R *.dfm}

procedure TFrmTicketmixcheck.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbOrgid.Active := false;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date:=Now;
  dtpenddate.Date :=Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmTicketmixcheck.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
   if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_tm!olddepartdate_OR_tm!newdepartdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_tm!olddepartdate_OR_tm!newdepartdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
      Params.ParamValues['filter_EQS_tm!ticketno']:=  edtTicketno.Text;

      if nvcbbOrgid.ItemIndex >=0 then
      begin
        Params.ParamByName('filter_EQL_nrt!id_OR_ort!id').Value := nvcbbOrgid.GetSelectID;
      end else
      begin
        Params.ParamByName('filter_EQL_nrt!id_OR_ort!id').Value := '';
      end;
      if Trim(nvhlproute.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_nrt!id_OR_ort!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_nrt!id_OR_ort!id'] := nvhlproute.Id;
      end;

      if  (not (Trim(nvhlpSchedule.Text) = '')) and  (nvhlpSchedule.Id>0) then      //���
      begin
        Params.ParamValues['filter_LIKES_os!code_OR_ns!code']:= nvhlpSchedule.Text
      end
    else
      begin
        Params.ParamValues['filter_LIKES_os!code_OR_ns!code']:= '';
      end;

    if (Trim(nvhlpendstation.Text)<>'') then                        //��վ
    begin
    Params.ParamValues['filter_EQL_est!id_OR_oest!id']:= nvhlpendstation.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['filter_EQL_est!id_OR_oest!id']:= '';
    end;

    Active := true;

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[��������]��'+nvcbbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log  := log +',[��·]:'+nvhlpRoute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log +',[���]��'+nvhlpschedule.Text;
    if nvhlpendstation.Id <>0 then
      log := log +',[����վ]:'+nvhlpendstation.Text;
    if Trim(edtTicketno.Text) <> '' then
      log := log +',[Ʊ��]��'+edtTicketno.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->����ѯ','��ѯ',log);

  end;
end;

end.
