unit UFrmRouteSaleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaEdit, NovaHelp;

type
  TFrmRouteSaleReport = class(TSimpleCRUDForm)
    Label10: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    Label2: TLabel;
    chkgroup: TCheckBox;
    lbl4: TLabel;
    nvhlpseller: TNovaHelp;
    chkStation: TCheckBox;
    chkRoute: TCheckBox;
    nvcbbType: TNovaCheckedComboBox;
    lblRun: TLabel;
    chkworkways: TCheckBox;
    lblworkways: TLabel;
    nvcbbworkways: TNovaCheckedComboBox;
    lblstation: TLabel;
    nvhelpstation: TNovaHelp;
    lblroute: TLabel;
    nvhelpRoute: TNovaHelp;
    chkCode: TCheckBox;
    lblcode: TLabel;
    nvhlpschedule: TNovaHelp;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    nvhlpTicketoutlets: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure chkgroupClick(Sender: TObject);
    procedure chkStationClick(Sender: TObject);
    procedure chkworkwaysClick(Sender: TObject);
    procedure chkRouteClick(Sender: TObject);
    procedure chkCodeClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmRouteSaleReport: TFrmRouteSaleReport;

implementation

uses PubFn, Services;
{$R *.dfm}

// ���ð�οؼ������� ���־ 2015��12��28�� 11:40:48
procedure TFrmRouteSaleReport.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if CheckBox1.Checked then
  begin
    nvhlpTicketoutlets.Enabled := True;
    nvhlpTicketoutlets.Visible := True;
    Label3.Visible := True;
  end
  else
  begin
    nvhlpTicketoutlets.Enabled := False;
    nvhlpTicketoutlets.Clear;
  end;
end;

procedure TFrmRouteSaleReport.chkCodeClick(Sender: TObject);
begin
  inherited;
  if chkCode.Checked then
  begin
    nvhlpschedule.Enabled := True;
    nvhlpschedule.Visible := True;
    lblcode.Visible := True;
  end
  else
  begin
    nvhlpschedule.Enabled := False;
  end;
end;

procedure TFrmRouteSaleReport.chkgroupClick(Sender: TObject);
begin
  inherited;
  if chkgroup.Checked then
  begin
    nvhlpseller.Enabled := True;
    nvhlpseller.Visible := True;
    lbl4.Visible := True;
  end
  else
  begin
    nvhlpseller.Enabled := False;
  end;
end;

procedure TFrmRouteSaleReport.chkRouteClick(Sender: TObject);
begin
  inherited;
  if chkRoute.Checked then
  begin
    nvhelpRoute.Enabled := True;
    nvhelpRoute.Visible := True;
    lblroute.Visible := True;
  end
  else
  begin
    nvhelpRoute.Enabled := False;
  end;
end;

procedure TFrmRouteSaleReport.chkStationClick(Sender: TObject);
begin
  inherited;
  if chkStation.Checked then
  begin
    // chkgroup.Checked := False;
    // nvhlpseller.Enabled := False;
    // nvhlpseller.Visible := False;
    // lbl4.Visible := False;
    nvhelpstation.Enabled := True;
    nvhelpstation.Visible := True;
    lblstation.Visible := True;
  end
  else
  begin
    nvhelpstation.Enabled := False;
  end;

end;

procedure TFrmRouteSaleReport.chkworkwaysClick(Sender: TObject);
begin
  inherited;
  if chkworkways.Checked then
  begin
    nvcbbworkways.Enabled := True;
    nvcbbworkways.Visible := True;
    lblworkways.Visible := True;
  end
  else
  begin
    nvcbbworkways.Enabled := False;
  end;
end;

procedure TFrmRouteSaleReport.FormCreate(Sender: TObject);
begin
  inherited;
  nvhelpRoute.Enabled := False;
  nvhelpstation.Enabled := False;
  nvhlpschedule.Enabled := False;
  nvcbbworkways.Enabled := False;
  nvhlpseller.Enabled := False;
  nvhlpTicketoutlets.Enabled := False;
end;

procedure TFrmRouteSaleReport.FormShow(Sender: TObject);
begin
  inherited;
  NovaChkSaleOrg.Active := False;
  NovaChkSaleOrg.Active := True;
  NovaChkSaleOrg.CheckById(True, sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.DateTime := now;
  dtpenddate.DateTime := now;
  nvcbbType.Active := False;
  nvcbbType.Active := True;
  nvcbbworkways.Active := False;
  nvcbbworkways.Active := True;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
end;

procedure TFrmRouteSaleReport.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  // �Ƿ��кϼƹ���
  if GUIDToString(Key) = '{DC6EB4CB-5523-4CCC-ACFB-478F7C5DADBE}' then
  begin
    if not aEnable then
    begin
      dbgrdhResult.SumList.Active := False;
    end;
  end;

  // �Ƿ�����ƱԱ����Ȩ��
  if GUIDToString(Key) = '{922A1A84-EC2D-4F49-A87D-AE8E4F47024A}' then
  begin
    chkgroup.Visible := aEnable;
    lbl4.Visible := aEnable;
    nvhlpseller.Visible := aEnable;
  end
end;

procedure TFrmRouteSaleReport.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount > 0 then
  begin
    if chkRoute.Checked then
      dbgrdhResult.Columns[0].Visible := True
    else
      dbgrdhResult.Columns[0].Visible := False;

    if chkStation.Checked then
      dbgrdhResult.Columns[1].Visible := True
    else
      dbgrdhResult.Columns[1].Visible := False;

    if chkgroup.Checked then
      dbgrdhResult.Columns[2].Visible := True
    else
      dbgrdhResult.Columns[2].Visible := False;
    if chkworkways.Checked then
      dbgrdhResult.Columns[4].Visible := True
    else
      dbgrdhResult.Columns[4].Visible := False;
    if chkCode.Checked then
      dbgrdhResult.Columns[5].Visible := True
    else
      dbgrdhResult.Columns[5].Visible := False;
    if CheckBox1.Checked then
      dbgrdhResult.Columns[3].Visible := True
    else
      dbgrdhResult.Columns[3].Visible := False;
  end;
end;

procedure TFrmRouteSaleReport.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
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
  if not(chkgroup.Checked) and not(chkStation.Checked) and not
    (chkRoute.Checked) and not(CheckBox1.Checked) and not(chkworkways.Checked)
    and not(chkCode.Checked) then
  begin
    SysDialogs.Warning('������ѡ��һ�ַ��鷽ʽ��');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaChkSaleOrg.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;
    if chkgroup.Checked then
      Params.ParamValues['issellgroup'] := True
    else
      Params.ParamValues['issellgroup'] := False;
    if CheckBox1.Checked then
      Params.ParamValues['isticketoutletsgroup'] := True
    else
      Params.ParamValues['isticketoutletsgroup'] := False;

    if chkRoute.Checked then
      Params.ParamValues['isroutegroup'] := True
    else
      Params.ParamValues['isroutegroup'] := False;
    if chkStation.Checked then
      Params.ParamValues['isstationgroup'] := True
    else
      Params.ParamValues['isstationgroup'] := False;
    if chkworkways.Checked then
      Params.ParamValues['isworkwaysgroup'] := True
    else
      Params.ParamValues['isworkwaysgroup'] := False;
    if chkCode.Checked then // ���Ӱ���η���  ���־  2015��12��28�� 15:03:14
      Params.ParamValues['iscodegroup'] := True
    else
      Params.ParamValues['iscodegroup'] := False;

    if chkRoute.Checked then
    begin
      if Trim(nvhelpRoute.Text) = '' then
        Params.ParamValues['routeid'] := ''
      else if nvhelpRoute.Id > 0 then
        Params.ParamValues['routeid'] := nvhelpRoute.Id
      else
        Params.ParamValues['routeid'] := '';
    end
    else
    begin
      Params.ParamValues['routeid'] := '';
    end;

    if chkStation.Checked then
    begin
      if Trim(nvhelpstation.Text) = '' then
        Params.ParamValues['stationid'] := ''
      else if nvhelpstation.Id > 0 then
        Params.ParamValues['stationid'] := nvhelpstation.Id
      else
        Params.ParamValues['stationid'] := '';
    end
    else
    begin
      Params.ParamValues['stationid'] := '';
    end;

    if chkworkways.Checked then
    begin
      if nvcbbworkways.GetSelectID = '' then
        Params.ParamValues['workways'] := ''
      else
        Params.ParamValues['workways'] := nvcbbworkways.GetSelectID;
    end
    else
    begin
      Params.ParamValues['workways'] := '';
    end;

    if chkgroup.Checked then
    begin
      if Trim(nvhlpseller.Text) = '' then
        Params.ParamValues['seller'] := ''
      else if nvhlpseller.Id > 0 then
        Params.ParamValues['seller'] := nvhlpseller.Id
      else
        Params.ParamValues['seller'] := '';
    end
    else
    begin
      Params.ParamValues['seller'] := '';
    end;
    Params.ParamValues['districttype'] := nvcbbType.GetSelectID;

    // ����η��� ���־ 2015��12��29�� 10:05:18
    if chkCode.Checked then
    begin
      if Trim(nvhlpschedule.Text) = '' then
        Params.ParamValues['scheduleid'] := ''
      else if nvhlpschedule.Id > 0 then
        Params.ParamValues['scheduleid'] := nvhlpschedule.Id
      else
        Params.ParamValues['scheduleid'] := '';
    end
    else
    begin
      Params.ParamValues['scheduleid'] := '';
    end;

    //����Ʊ�����
    if CheckBox1.Checked then
    begin
      if (Trim(nvhlpTicketoutlets.Text) <> '') and (nvhlpTicketoutlets.Id > 0) then
      begin
        Params.ParamValues['ticketoutletsid'] := nvhlpTicketoutlets.Id
      end
      else
      begin
        Params.ParamValues['ticketoutletsid'] := ''
      end;
    end
    else
    begin
      Params.ParamValues['ticketoutletsid'] := '';
    end;

    dbgrdhResult.PrintInfo.PageTopRight := '��Ʊ���ڣ�' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' ��' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);
    Active := True;

    log := '��ѯ�����У�[��Ʊ����]�� ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' �� ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date);
    if Trim(NovaChkSaleOrg.Text) <> '' then
      log := log + ',[��Ʊ����]��' + NovaChkSaleOrg.Text;
    if nvhlpseller.Id <> 0 then
      log := log + ',[��ƱԱ]:' + nvhlpseller.Text;
    if Trim(nvcbbType.Text) <> '' then
      log := log + ',[��������]:' + nvcbbType.Text;
    if chkRoute.Checked then
      log := log + ',[����·����]';
    if chkStation.Checked then
      log := log + ',[��ͣ�������]';
    if chkgroup.Checked then
      log := log + ',[����ƱԱ����]';
    log := log + ' ��[��ѯ���]:���� ' + inttostr(RecordCount) + ' ����¼��';
    SysLog.WriteLog('����ͳ��->��·��Ʊͳ�Ʊ�', '��ѯ', log);

  end;
end;

end.
