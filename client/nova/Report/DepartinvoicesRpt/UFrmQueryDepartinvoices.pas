unit UFrmQueryDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryDepartinvoices = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    nvhelpUnit: TNovaHelp;
    jcdstypename: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    nvhelpVehicle: TNovaHelp;
    lbl2: TLabel;
    Label4: TLabel;
    nvcbbStatus: TNovaComboBox;
    Label9: TLabel;
    Label1: TLabel;
    nvcbbScheduletype: TNovaComboBox;
    dsDetail: TDataSource;
    jcdsDepartinvoicesDetail: TjsonClientDataSet;
    jcdsResultorgname: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultdepartdate: TDateField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultschedulecode: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultvehicletypname: TWideStringField;
    jcdsResultticketnum: TLargeintField;
    jcdsResulttotalamount: TFloatField;
    jcdsResultstationservicefee: TFloatField;
    jcdsResultprintip: TWideStringField;
    jcdsResultprintbyname: TWideStringField;
    jcdsResultprinttime: TDateTimeField;
    jcdsResultsupplyticketnum: TLargeintField;
    jcdsResultsupplyamount: TFloatField;
    jcdsResultsupplybalanceamount: TFloatField;
    wdstrngfldResultd1name: TWideStringField;
    jcdsResultd2name: TWideStringField;
    jcdsResultd3name: TWideStringField;
    jcdsResultd4name: TWideStringField;
    jcdsResults1name: TWideStringField;
    jcdsResults2name: TWideStringField;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResultworktype: TWideStringField;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultdepartstationname: TWideStringField;
    jcdsWorktkypename: TjsonClientDataSet;
    lbl7: TLabel;
    nvhelpUserid: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    wdstrngfldResultdepartinvoicesno: TWideStringField;
    wdstrngfldResultworktypename: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    jcdsStatusname: TjsonClientDataSet;
    wdstrngfldResultstatusname: TWideStringField;
    lrgntfldResultseatnum: TLargeintField;
    grp3: TGroupBox;
    grp2: TGroupBox;
    dbgrdhroutestop: TNvDbgridEh;
    grp8: TGroupBox;
    nvdbgrdhWork: TNvDbgridEh;
    dsDeductdetail: TDataSource;
    jcdsDeductdetail: TjsonClientDataSet;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultothterfee: TFloatField;
    fltfldResultagentfee: TFloatField;
    fltfldResultbalanceamount: TFloatField;
    lbl8: TLabel;
    nvhlpBalanceunit: TNovaHelp;
    wdstrngfldResultbalanceunitname: TWideStringField;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    Label2: TLabel;
    cbbdepart: TNovaCheckedComboBox;
    jcdsResultmoreprice: TFloatField;
    Label3: TLabel;
    Label5: TLabel;
    DtpPrintstartdate: TDateTimePicker;
    DtpPrintenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure DtpPrintstartdateClick(Sender: TObject);
    procedure DtpPrintenddateChange(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure refreshDetail;
    procedure refreshdeductdetail;
  end;

var
  frmQueryDepartinvoices: TfrmQueryDepartinvoices;
implementation
    uses SystemInstance,SysInfoIntf,PubFn,UFrmticketsInfo;
{$R *.dfm}



procedure TfrmQueryDepartinvoices.DtpPrintstartdateClick(Sender: TObject);
begin
  inherited;
    if DtpPrintstartdate.Checked = True  then
    begin
       DtpPrintenddate.Checked := True;
    end;
   if  DtpPrintstartdate.Checked =False then
    begin
       DtpPrintenddate.Checked := False;
    end;
end;

procedure TfrmQueryDepartinvoices.DtpPrintenddateChange(Sender: TObject);
begin
  inherited;
    if DtpPrintenddate.Checked = True  then
    begin
       DtpPrintstartdate.Checked := True;
    end;
   if  DtpPrintenddate.Checked =False then
    begin
       DtpPrintstartdate.Checked := False;
    end;
end;

procedure TfrmQueryDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbStatus.Active:=False;
  nvcbbStatus.Active:=True;
  nvcbbScheduletype.Active := False;
  nvcbbScheduletype.Active := True;
  dtpBdepartdate.Date:=Now;
  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date:=Now;
  dtpEdepartdate.Checked := False;
  cbbdepart.Active := False;
  cbbdepart.Active := True;
  dtpprintstartdate.Date := now;
  DtpPrintenddate.Date :=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryDepartinvoices.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  refreshDetail;
  refreshdeductdetail
end;

procedure TfrmQueryDepartinvoices.refreshDetail;
begin
 if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jcdsDepartinvoicesDetail.Close;
    exit;
  end;
  with jcdsDepartinvoicesDetail do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_dtd!departinvoices.id']:= jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;
end;

procedure TfrmQueryDepartinvoices.refreshdeductdetail;
begin
 if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jcdsDeductdetail.Close;
    exit;
  end;
  with jcdsDeductdetail do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_ds!departinvoices.id']:= jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;
end;

procedure TfrmQueryDepartinvoices.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  if Trim(cbbdepart.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��������λ��');
    Exit;
  end;
     jcdsResult.AfterScroll:=nil;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_s!orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ds!departinvoicesno']:= nvedtTicketno.Text;
                                                                    //��������
    Params.ParamValues['filter_GED_ds!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_ds!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(cbbdepart.Text) <> '' then                              //��������λ
      Params.ParamValues['filter_INS_ds!printorgid'] := cbbdepart.GetSelectID
    else
      Params.ParamValues['filter_INS_ds!printorgid'] := '';

    if  (not (Trim(nvhelpUnit.Text) = '')) and  (nvhelpUnit.Id>0) then         //��λ
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhelpUnit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

      if  (not (Trim(nvhlpBalanceunit.Text) = '')) and  (nvhlpBalanceunit.Id>0) then
      begin
        Params.ParamValues['filter_EQL_u2!id']:= nvhlpBalanceunit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u2!id']:= '';
      end;

      if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then //��κ�     //���
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhlproute.Text) = '')) and (nvhlproute.Id>0) then    //��·
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlproute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

   if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then //����
    begin
      Params.ParamValues['filter_EQL_v!id']:= nvhelpVehicle.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_v!id']:= '';
    end;

    if (not (Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id>0) then //��Ա
    begin
      Params.ParamValues['printby']:= nvhelpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['printby']:= '';
    end;

       if nvcbbStatus.ItemIndex >= 0 then     //״̬
      begin
        Params.ParamValues['filter_EQS_ds!status']:= nvcbbStatus.GetSelectCode;
      end
       else
      begin
        Params.ParamValues['filter_EQS_ds!status']:='';
      end;
       if nvcbbScheduletype.ItemIndex >= 0 then     //�������
      begin
        Params.ParamValues['filter_EQS_s!type']:= nvcbbScheduletype.GetSelectCode;
      end
       else
      begin
        Params.ParamValues['filter_EQS_s!type']:='';
      end;

      if DtpPrintstartdate.Checked then //������
      begin
        Params.ParamValues['filter_GED_ds!printtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',DtpPrintstartdate.DateTime);
//        if formatdatetime('yyyy-mm-dd',DtpPrintstartdate.Date)
//              = formatdatetime('yyyy-mm-dd',DtpPrintenddate.Date) then
//             Params.ParamValues['filter_LED_ds!printtime'] := formatdatetime('yyyy-mm-dd',DtpPrintenddate.Date+1)
//        else
        Params.ParamValues['filter_LED_ds!printtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',DtpPrintenddate.DateTime);

        log :=' [������]��'+DateToStr(DtpPrintstartdate.DateTime)+'��'+DateToStr(DtpPrintenddate.DateTime)+', ';
      end
      else
      begin
         Params.ParamValues['filter_GED_ds!printtime'] :=null;
         Params.ParamValues['filter_LED_ds!printtime'] :=null;
      end;


    Active:=true;

    log := '��ѯ�����У�'+log+ ',[�������ڴ�] '+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
          +' �� '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     if Trim(nvckbOrgid.GetSelectID)<>'' then
      log := log+',[��������]��'+nvckbOrgid.Text;
    if Trim(cbbdepart.GetSelectID) <> '' then
      log := log +',[��������λ]��'+cbbdepart.Text ;
    if nvhlproute.Id <> 0 then
      log := log +',[��·]��'+nvhlproute.Text ;
    if nvhlpschedule.Id <> 0 then
      log := log +',[��κ�]��'+nvhlpschedule.Text ;
    if nvhelpUnit.Id <> 0 then
      log := log +',[������λ]:'+nvhelpUnit.Text ;
    if nvhelpVehicle.Id <> 0 then
      log := log +',[Ӫ�˳���]:'+ nvhelpVehicle.Text;
    if nvhelpUserid.Id <> 0 then
      log := log +',[��Ա]:'+ nvhelpUserid.Text;
    if Trim(nvedtTicketno.Text) <> '' then
      log := log +',[���㵥��]:'+ nvedtTicketno.Text;
    if nvhlpBalanceunit.Id <> 0then
      log := log +',[���㵥λ]��' + nvhlpBalanceunit.Text;
     log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��ν��������ѯ','��ѯ',log);

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    end;
    refreshDetail;
    refreshdeductdetail;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;

end;

procedure TfrmQueryDepartinvoices.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;
  FrmticketsInfo := TFrmticketsInfo.Create(self);
  with FrmticketsInfo do
  begin
   //departinvoiceid := jcdsResult.FieldByName('id').AsInteger;
      with jcdsTicketinfo do
      begin
        Active := False;
          Params.ParamValues['departinvoicesid']
                  := jcdsResult.FieldByName('id').AsInteger;

        Active := true;
      end;
    showModal;
  end;
end;

end.
