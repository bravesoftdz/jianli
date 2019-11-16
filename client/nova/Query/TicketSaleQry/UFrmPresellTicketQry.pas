unit UFrmPresellTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmPresellTicketQry = class(TSimpleCRUDForm)
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultsellip: TWideStringField;
    dtmfldResultselltime: TDateTimeField;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl13: TLabel;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvhelpendstation: TNovaHelp;
    nvhelpstartstation: TNovaHelp;
    nvhelpSellby: TNovaHelp;
    nvcbbticketstatus: TNovaComboBox;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    lbl3: TLabel;
    lbl17: TLabel;
    nvedtTicketno: TNovaEdit;
    lbl16: TLabel;
    nvhcbbTickettype: TNovaHComboBox;
    wdstrngfldResultticketoutlestname: TWideStringField;
    fltfldResultstationservicefee: TFloatField;
    chkIsnotlocal: TCheckBox;
    chkIslocal: TCheckBox;
    blnfldResultislocal: TBooleanField;
    wdstrngfldResultticketstatusname: TWideStringField;
    wdstrngfldResulttickettypename: TWideStringField;
    nvhlpschedule: TNovaHelp;
    nvcbbOrgid: TNovaCheckedComboBox;
    fltfldResultcomputefee: TFloatField;
    fltfldResultcoolairfee: TFloatField;
    fltfldResultadditionfee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultotherfee: TFloatField;
    fltfldResultmoreprice: TFloatField;
    fltfldResultsubtotal: TFloatField;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    lbl5: TLabel;
    lbl11: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpBdepartdate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    jcdsPaymethod: TjsonClientDataSet;
    lbl12: TLabel;
    nvcbbPaymethod: TNovaComboBox;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpBdepartdateChange(Sender: TObject);
    procedure dtpEdepartdateChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmPresellTicketQry: TfrmPresellTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmPresellTicketQry.dtpBdepartdateChange(Sender: TObject);
begin
  inherited;
     if dtpBdepartdate.Checked = True  then
    begin
       dtpEdepartdate.Checked := True;
    end;
   if  dtpBdepartdate.Checked =False then
    begin
       dtpEdepartdate.Checked := False;
    end;
end;

procedure TfrmPresellTicketQry.dtpBselldateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.dtpEdepartdateChange(Sender: TObject);
begin
  inherited;
     if dtpEdepartdate.Checked = True  then
    begin
       dtpBdepartdate.Checked := True;
    end;
   if  dtpEdepartdate.Checked =False then
    begin
       dtpBdepartdate.Checked := False;
    end;
end;

procedure TfrmPresellTicketQry.dtpEselldateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.FormCreate(Sender: TObject);
begin
  inherited;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  dtpBselldate.Date:=Now;
  dtpEselldate.Date:=Now;
  dtpBdepartdate.Date:=now;
  dtpEdepartdate.Date:=now;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  nvcbbPaymethod.Active :=False;
  nvcbbPaymethod.Active :=True;
  jcdsPaymethod.Active:=False;
  jcdsPaymethod.Active:=True;
  nvcbbPaymethod.ItemIndex:=0;
end;

procedure TfrmPresellTicketQry.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmPresellTicketQry.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TfrmPresellTicketQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if nvcbbOrgid.Text = ''then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
   if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) then
  begin
    SysDialogs.ShowMessage('��Ʊ��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEselldate.Date-dtpBselldate.Date)) and  dtpBselldate.Checked
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),������ѡ��');
    exit;
  end;
   if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date))  and   dtpBdepartdate.Checked
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),������ѡ��');
    exit;
  end;
   if not ((dtpBselldate.Checked) or (dtpBdepartdate.Checked)) then
  begin
      SysDialogs.ShowMessage('����ѡ��һ�����ڶΣ�');
    exit;
  end;

  with jcdsResult do
  begin
    Active:=False;
//    if dtpEselldate.Date > Now+1 then
//    begin
//     dtpEselldate.Datetime :=Now;
//    end;

//    Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.Datetime);
//    Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.Datetime);  //��Ʊ����
//    log := log +'[��Ʊ����]��'+ DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime);
//
//    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBdepartdate.Datetime);
//    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEdepartdate.Datetime);
//    log := log +'[��������]��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);
       if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.Datetime);
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.Datetime);  //��Ʊ����
      log := log +'[��Ʊ����]��'+ DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_ts!selltime'] := '';
       Params.ParamValues['filter_LED_ts!selltime'] := '';
    end;
    if dtpBdepartdate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Datetime);
      Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Datetime);  //��������
      log := log +'[��������]��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_ts!departdate'] :=  '';
       Params.ParamValues['filter_LED_ts!departdate'] :=  '';
    end;
    if nvcbbPaymethod.ItemIndex >= 0 then     //֧����ʽ
      begin
        Params.ParamValues['filter_EQS_ts!paymethod']:= nvcbbPaymethod.GetSelectCode;
      end
    else
      begin
        Params.ParamValues['filter_EQS_ts!paymethod']:='';
      end;
    if nvcbbticketstatus.ItemIndex >= 0 then     //��Ʊ״̬
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:= nvcbbticketstatus.GetSelectCode;
        log := log +', [��Ʊ״̬]:'+ nvcbbticketstatus.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:='';
      end;

      if nvhcbbTickettype.ItemIndex >=0 then
      begin
        Params.ParamByName('filter_EQS_ts!tickettype').Value := nvhcbbTickettype.HelpFieldValue['code'];
        log := log +', [��Ʊ����]:'+ nvhcbbTickettype.Text;
      end
       else
        Params.ParamByName('filter_EQS_ts!tickettype').Value :='';

      if nvhelpstartstation.Id>0 then            //�ϳ���
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:=nvhelpstartstation.Id;
        log := log +', [�ϳ���]:'+nvhelpstartstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!departstationid']:='';
       end;

      if nvhelpendstation.Id>0 then            //����վ
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:=nvhelpendstation.Id;
        log := log +', [����վ]:'+nvhelpendstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!reachstationid']:='';
       end;

      if nvhelpSellby.Id>0 then                   //��ƱԱ
        begin
          Params.ParamValues['filter_EQL_ts!sellby']:= nvhelpSellby.HelpFieldValue['id'];
          log := log+', [��ƱԱ]:'+nvhelpSellby.Text;
        end
      else
        begin
          Params.ParamValues['filter_EQL_ts!sellby']:= '';
        end;

    if chkIsnotlocal.Checked then                //�Ƿ���վƱ
    begin
      if not( chkIslocal.Checked ) then
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='false';       //��վƱ
        log := log+', [��վƱ]';
      end
      else
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='';
      end;
    end
    else
    begin
      if  chkIslocal.Checked  then                                      //��վƱ
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='true';
        log := log+', [��վƱ]';
      end
      else
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='';
      end;
    end;

    Params.ParamValues['filter_INS_o!id']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ts!ticketno']:=  nvedtTicketno.Text;
    Params.ParamValues['filter_LIKES_s!code'] := nvhlpschedule.Text;
    log := log+', [��Ʊ����]:' +nvcbbOrgid.Text;
    log := log+', [Ʊ��]:'+nvedtTicketno.Text;
    log := log+', [��κ�]:' +nvhlpschedule.Text;
    //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->Ԥ��Ʊ�����ѯ','��ѯ', '��ѯ������;'+log);
    Active:=true;
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);

    end
end;

end.
