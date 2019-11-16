unit UFrmReserveTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmReserveTicketQry = class(TSimpleCRUDForm)
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsSellstatus: TjsonClientDataSet;
    intgrfldResultseatno: TIntegerField;
    fltfldResultfullprice: TFloatField;
    wdstrngfldResultreserveip: TWideStringField;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBreservetime: TDateTimePicker;
    dtpEreservetime: TDateTimePicker;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultticketoutletsname: TWideStringField;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultremarks: TWideStringField;
    wdstrngfldResulttickettypename1: TWideStringField;
    lbl9: TLabel;
    nvhelpendstation: TNovaHelp;
    lbl2: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    chkIsautocancel: TCheckBox;
    chkIsnotautocancel: TCheckBox;
    lbl6: TLabel;
    nvhelpCustomer: TNovaHelp;
    fltfldResultserviceprice: TFloatField;
    blnfldResultisautocancel: TBooleanField;
    dtmfldResultautocanceltime: TDateTimeField;
    dtmfldResultreservetime: TDateTimeField;
    wdstrngfldResultreserveway: TWideStringField;
    dtmfldResultcanceltime: TDateTimeField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultreservebyname: TWideStringField;
    wdstrngfldResultcencelbyname: TWideStringField;
    intgrfldResultcarrychildnum: TIntegerField;
    jcdsReserveway: TjsonClientDataSet;
    wdstrngfldResultsellstate: TWideStringField;
    wdstrngfldResultsellstatename: TWideStringField;
    wdstrngfldResultreservewayname: TWideStringField;
    lbl13: TLabel;
    lbl16: TLabel;
    nvcbbway: TNovaComboBox;
    nvcbbticketstatus: TNovaComboBox;
    nvhlpschedule: TNovaHelp;
    jcdsResultcertificateno: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBreservetimeChange(Sender: TObject);
    procedure dtpEreservetimeChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmReserveTicketQry: TfrmReserveTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmReserveTicketQry.dtpBreservetimeChange(Sender: TObject);
begin
  inherited;
   if dtpBreservetime.Checked = True  then
    begin
       dtpEreservetime.Checked := True;
    end;
   if  dtpBreservetime.Checked =False then
    begin
       dtpEreservetime.Checked := False;
    end;
end;

procedure TfrmReserveTicketQry.dtpEreservetimeChange(Sender: TObject);
begin
  inherited;
    if dtpEreservetime.Checked = True  then
    begin
       dtpBreservetime.Checked := True;
    end;
   if  dtpEreservetime.Checked =False then
    begin
       dtpBreservetime.Checked := False;
    end;
end;

procedure TfrmReserveTicketQry.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBreservetime.Date:=Now;
  dtpEreservetime.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsSellstatus.Active := False;
  jcdsSellstatus.Active := True;
  jcdsReserveway.Active := False;
  jcdsReserveway.Active := True;
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  nvcbbway.Active := False;
  nvcbbway.Active:= True;
 // dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmReserveTicketQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
   if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )
    or (FormatDateTime('yyyymmdd', dtpBreservetime.Date) > FormatDateTime('yyyymmdd',
    dtpEreservetime.Date) )then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),������ѡ��');
    exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    //��������
    Params.ParamValues['filter_GED_sr!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_sr!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [�������� ]��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBreservetime.Checked then //��Ʊ����
    begin
     Params.ParamValues['filter_GED_sr!reservetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreservetime.DateTime);
     Params.ParamValues['filter_LED_sr!reservetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreservetime.DateTime);  //��Ʊ����
     log := log +', [��Ʊ����]��'+ DateToStr(dtpBreservetime.DateTime)+'��'+DateToStr(dtpEreservetime.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_sr!reservetime'] :='';
      Params.ParamValues['filter_LED_sr!reservetime'] :='';
    end;

    Params.ParamValues['filter_INS_sr!orgid']:= nvckbOrgid.GetSelectID;
    log := log +', [��λ���]:'+ nvckbOrgid.Text;

    if (not (Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id>0) then                   //���
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
        log:= log +', [���]:'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then //�յ�վ
      begin
        Params.ParamValues['filter_EQL_str!id']:= nvhelpendstation.HelpFieldValue['id'];
        log := log +', [����վ]:'+nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_str!id']:= '';
      end;

    if  (not (Trim(nvhelpCustomer.Text) = '')) and  (nvhelpCustomer.Id>0) then  //�˿���
      begin
        Params.ParamValues['filter_EQL_ct!id']:= nvhelpCustomer.HelpFieldValue['id'];
        log := log +', [�˿���]:'+ nvhelpCustomer.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ct!id']:= '';
      end;

    if (not (Trim(nvhelpTicketoutlets.Text) = '')) and (nvhelpTicketoutlets.Id>0) then  //��Ʊ��
      begin
        Params.ParamValues['filter_EQL_tos!id']:= nvhelpTicketoutlets.HelpFieldValue['id'];
        log := log +', [��Ʊ��]:' +nvhelpTicketoutlets.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_tos!id']:= '';
      end;

      if chkIsnotautocancel.Checked then                //�Ƿ��Զ�ȡ��
        begin
          if not( chkIsautocancel.Checked ) then
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='false';
            log := log +', [�ֶ�ȡ��]'
          end
          else
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='';
          end;
        end
        else
        begin
          if chkIsautocancel.Checked  then
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='true';
            log := log +', [�Զ�ȡ��]'
          end
          else
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='';
          end;
        end;

        if nvcbbticketstatus.ItemIndex >= 0 then     //״̬
      begin
        Params.ParamValues['filter_EQS_sr!sellstate']:= nvcbbticketstatus.GetSelectCode;
        log := log +', [��Ʊ״̬]:' +nvcbbticketstatus.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_sr!sellstate']:='';
      end;

      if nvcbbway.ItemIndex >= 0 then     //;��
      begin
        Params.ParamValues['filter_EQS_sr!reserveway']:= nvcbbway.GetSelectCode;
        log := log +', [��Ʊ·��]:'+nvcbbway.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_sr!reserveway']:='';
      end;
   //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->��Ʊ�����ѯ','��ѯ',  '��ѯ������;'+log);
    Active:=true;
    log := '';
        dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBreservetime.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEreservetime.Date);
     end;
    end
end;

end.

