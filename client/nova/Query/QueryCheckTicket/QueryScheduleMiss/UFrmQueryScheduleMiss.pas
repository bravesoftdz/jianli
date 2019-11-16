unit UFrmQueryScheduleMiss;

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
  TfrmQueryScheduleMiss = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    jcdsStatusname: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl13: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    lbl7: TLabel;
    nvedtTicketno: TNovaEdit;
    chkIsLine: TCheckBox;
    chkIsnotLine: TCheckBox;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    chkIsnotcheck: TCheckBox;
    chkIscheck: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     log : string;
  public
    { Public declarations }
  end;

var
  frmQueryScheduleMiss: TfrmQueryScheduleMiss;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryScheduleMiss.FormCreate(Sender: TObject);
begin
  inherited;

  nvckbOrgid.Active := False;
  nvckbOrgid.Active := true;
  nvckbOrgid.CheckById(true, sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date := Now;
  // dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  // dtpEdepartdate.Checked := False;
end;

procedure TfrmQueryScheduleMiss.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime
    ('yyyymmdd', dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpEdepartdate.Date - dtpBdepartdate.Date) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    // Params.ParamValues['filter_INS_o!id']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['filter_INS_o!id'] := nvckbOrgid.GetSelectID;
    log := '��λ���'+nvckbOrgid.Text+',';
    if Trim(nvedtTicketno.Text)<>'' then
    begin
      Params.ParamValues['filter_EQS_ts!ticketno'] := Trim(nvedtTicketno.Text);
      log := log +'��Ʊ��'+ Trim(nvedtTicketno.Text)
    end
    else
    Params.ParamValues['filter_EQS_ts!ticketno'] := '';

                                       //��������
    Params.ParamValues['filter_GED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.Date);
      log := log+' �������ڴ�'+DateToStr(dtpBdepartdate.DateTime)+
            '��'+DateToStr(dtpEdepartdate.DateTime)+', ';
   
    if (not(Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id > 0) then
    // ���
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.HelpFieldValue
        ['id'];
        log := log+'��κ�:'+nvhlpschedule.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhelpTicketoutlets.Text) = '')) and
      (nvhelpTicketoutlets.Id > 0) then // ��Ʊ��
    begin
      Params.ParamValues['filter_EQL_tos!id'] :=
        nvhelpTicketoutlets.HelpFieldValue['id'];
        log := log+'��Ʊ��:'+nvhelpTicketoutlets.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_tos!id'] := '';
    end;

    if (not(Trim(nvhlproute.Text) = '')) and (nvhlproute.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.HelpFieldValue['id'];
      log := log+'��·:'+nvhlproute.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

   { if (not(Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhelpVehicle.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end;  }

    if chkIsnotLine.Checked then // �Ƿ���ˮ��
    begin
      if not(chkIsLine.Checked) then
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := 'true';
        log := log+'��ˮ��,';
      end
      else
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := '';
      end;
    end
    else
    begin
      if chkIsLine.Checked then
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := 'false';
        log := log+'����ˮ��,';
      end;
    end;

    if chkIsNotOver.Checked then // �Ƿ�Ӱ�
    begin
      if not(chkIsOver.Checked) then
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := 'true';
        log := log+'�Ӱ���,';
      end
      else
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := '';
      end;
    end
    else
    begin
      if chkIsOver.Checked then
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := 'false';
        log := log+'����,';
      end;
    end;

    if not chkIsnotcheck.Checked  and chkIscheck.Checked  then    //�Ƿ��Ѽ�
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:='true';
         log := log+'��Ʊ�Ѽ�,';
      end
      else if not chkIscheck.Checked  and chkIsnotcheck.Checked then
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:='false';
         log := log+'��Ʊδ��,';
      end
      else
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:=null;
      end;
    Active := true;
    //���������־
    SysLog.WriteLog('���©�������ѯ', '�ۺϲ�ѯ', '��ѯ������;'+log);
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '�������ڣ�' + FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.Date) + ' ��' + FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.Date);
  end
end;

end.
