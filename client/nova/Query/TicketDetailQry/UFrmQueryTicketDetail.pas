unit UFrmQueryTicketDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryTicketDetail = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl1: TLabel;
    nvhelpendstation: TNovaHelp;
    wdstrngfldResultreachname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    blnfldResultischecked: TBooleanField;
    blnfldResultisdepartinvoices: TBooleanField;
    lbl16: TLabel;
    nvhcbbTickettype: TNovaHComboBox;
    chkIsnotcheck: TCheckBox;
    chkIscheck: TCheckBox;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    blnfldResultislocal: TBooleanField;
    chkIsovertime: TCheckBox;
    chkIsnotovertime: TCheckBox;
    dtpBdepartdate: TDateTimePicker;
    lbl7: TLabel;
    dtpBselldate: TDateTimePicker;
    lbl14: TLabel;
    dtpEselldate: TDateTimePicker;
    jcdsPaymethod: TjsonClientDataSet;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultpaymethodname: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketstatusname: TWideStringField;
    jcdsSellway: TjsonClientDataSet;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultsellwayname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    blnfldResultislinework: TBooleanField;
    intgrfldResultcarrychildnum: TIntegerField;
    lrgntfldResultdistance: TLargeintField;
    fltfldResultfullprice: TFloatField;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultticketentrance: TWideStringField;
    wdstrngfldResultbuspark: TWideStringField;
    wdstrngfldResultticketoutletname: TWideStringField;
    wdstrngfldResultsellip: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResulthticketoutlesname: TWideStringField;
    wdstrngfldResulthoutletsaddress: TWideStringField;
    wdstrngfldResultcheckedname: TWideStringField;
    wdstrngfldResultcheckstationname: TWideStringField;
    wdstrngfldResultdepartinvoicesbyname: TWideStringField;
    wdstrngfldResultdepartinvoicesno: TWideStringField;
    fltfldResultotherfee: TFloatField;
    jcdsResultvehiclebrandmodelname: TWideStringField;
    dtmfldResultchecktime: TDateTimeField;
    wdstrngfldResulttickettypename: TWideStringField;
    dtmfldResultdepartinvoicestime: TDateTimeField;
    jcdsResultcomputefee: TFloatField;
    jcdsResultcoolairfee: TFloatField;
    jcdsResultadditionfee: TFloatField;
    wdstrngfldResultroutename: TWideStringField;
    blnfldResultisovertime: TBooleanField;
    wdstrngfldResultvehicletypename: TWideStringField;
    fltfldResultticketprice: TFloatField;
    fltfldResultreturnamount: TFloatField;
    wdstrngfldResultreturnbyname: TWideStringField;
    dtmfldResultreturntime: TDateTimeField;
    wdstrngfldResultreturnway: TWideStringField;
    jcdsReturnway: TjsonClientDataSet;
    wdstrngfldResultreturnwayname: TWideStringField;
    nvhlpschedule: TNovaHelp;
    jcdsResultmoreprice: TFloatField;
    jcdsResultselltime: TDateTimeField;
    nvcbbOrgid: TNovaCheckedComboBox;
    fltfldResultservicefee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultserviceprice: TFloatField;
    fltfldResultsubtotal: TFloatField;
    nvhlpDeparts: TNovaHelp;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    jcdsResultprintorgname: TWideStringField;
    jcdsResultprintname: TWideStringField;
    dtpBtaketime: TDateTimePicker;
    dtpEtaketime: TDateTimePicker;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl13: TLabel;
    nvcbbticketstatus: TNovaComboBox;
    jcdsResultcertificatetype: TWideStringField;
    jcdsCertificatetype: TjsonClientDataSet;
    jcdsResultcertificatetypevalue: TWideStringField;
    jcdsResultcertificateno: TWideStringField;
    jcdsResultmobilephone: TWideStringField;
    jcdsResultemail: TWideStringField;
    jcdsResulttaketime: TDateTimeField;
    jcdsResultlastbuytickettime: TDateTimeField;
    Label5: TLabel;
    nvedtCustomername: TNovaEdit;
    Label6: TLabel;
    nvedtCertificateno: TNovaEdit;
    Label7: TLabel;
    nvedtmobilephone: TNovaEdit;
    jcdsResultistaked: TBooleanField;
    nvcbborgprint: TNovaCheckedComboBox;
    nvhelpTicketoutlets: TNovaHelp;
    lbl4: TLabel;
    edt1: TNovaEdit;
    jcdsResultorderno: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure dtpBtaketimeChange(Sender: TObject);
    procedure dtpEtaketimeChange(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  frmQueryTicketDetail: TfrmQueryTicketDetail;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryTicketDetail.dtpBtaketimeChange(Sender: TObject);
begin
  inherited;
  if dtpBtaketime.Checked = True  then
    begin
       dtpEtaketime.Checked := True;
    end;
   if  dtpBtaketime.Checked =False then
    begin
       dtpEtaketime.Checked := False;
    end;
end;

procedure TfrmQueryTicketDetail.dtpEselldateChange(Sender: TObject);
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

procedure TfrmQueryTicketDetail.dtpEtaketimeChange(Sender: TObject);
begin
  inherited;
  if dtpEtaketime.Checked = True  then
  begin
    dtpBtaketime.Checked := True;
  end;
  if  dtpEtaketime.Checked =False then
  begin
    dtpBtaketime.Checked := False;
  end;
end;

procedure TfrmQueryTicketDetail.dtpBselldateChange(Sender: TObject);
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

procedure TfrmQueryTicketDetail.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbborgprint.Active :=False;
  nvcbborgprint.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbborgprint.Active :=True;
  nvcbborgprint.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  //nvcbbSellway.Active := False;
  //nvcbbSellway.Active:=True;
  //nvcbbPaymethod.Active := False;
  //nvcbbPaymethod.Active := True;
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  dtpBdepartdate.Date :=Now;
  dtpEdepartdate.Date :=Now;
  dtpBselldate.Date := Now ;
  dtpEselldate.Date :=Now;
  dtpBtaketime.Date := Now ;
  dtpEtaketime.Date :=Now;
  jcdsPaymethod.Active := False;
  jcdsPaymethod.Active := True;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  jcdsSellway.Active :=False;
  jcdsSellway.Active := True;
  dtpBselldate.Checked := True;
  dtpEselldate.Checked := True;
  jcdsCertificatetype.Active :=False;
  jcdsCertificatetype.Active :=True;
end;

procedure TfrmQueryTicketDetail.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{ED973E13-5A4F-43DD-9C21-351C3A7303D2}' then //��ѯ������ƱԱ����Ʊ��¼
  begin
//    nvhelpUserid.Visible:=aEnable;
//    lbl6.Visible:=aEnable;
//    nvhelpUserid.Enabled:=aEnable;
//    if not aEnable then
//    begin
//      nvhelpUserid.Text:=SysInfo.LoginUserInfo.UserName;
//      nvhelpUserid.Id:=SysInfo.LoginUserInfo.UserID;
//    end;
  end
end;

procedure TfrmQueryTicketDetail.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);

    nvcbborgprint.Active := False;
    nvcbborgprint.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbborgprint.Active := True;
    nvcbborgprint.CheckAll(true);
  end;
end;

procedure TfrmQueryTicketDetail.tbtnFilterClick(Sender: TObject);
var
 num:Tdatetime;
begin
  inherited;
  NovachkPorg.SetFocus;
   if (nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) )then
  begin
    SysDialogs.ShowMessage('��Ʊ��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  if dtpBtaketime.Checked and (FormatDateTime('yyyymmdd', dtpBtaketime.Date) > FormatDateTime('yyyymmdd',
    dtpEtaketime.Date) )then
  begin
    SysDialogs.ShowMessage('ȡƱ��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    log := '��ѯ�����У�';
    if (Trim(nvedtTicketno.Text) = '') and (Trim(nvhlpschedule.Text) = '')
       and (Trim(nvhelpRoute.Text)='') and (Trim(nvhlpDeparts.Text)='')
//       and (Trim(nvhelpendstation.Text)='')  and (Trim(nvhelpUserid.Text)='')
//       and (Trim(nvhlpReturnby.Text) = '')
       and (Trim(nvedtTicketno.Text)='')
       and (nvcbbticketstatus.GetSelectCode <> '1') and (nvcbbticketstatus.GetSelectCode <> '2')//��Ʊ����Ʊ

    then
    begin
      if (formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date) <>
            formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date)) then
      begin
        if (not dtpBselldate.Checked) or ((formatdatetime('yyyy-mm-dd',dtpBselldate.Date) <>
            formatdatetime('yyyy-mm-dd',dtpEselldate.Date))) then
        begin
          Showmessage('û�������ѯ������ֻ��ѯһ�������');
          exit;
        end;
      end;
    end;
      Params.ParamValues['qp.departSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
      Params.ParamValues['qp.departEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
      log := ' [��������]��'+DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime)+', ';

    if dtpBselldate.Checked then //��Ʊ����
    begin

      Params.ParamValues['qp.sellSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime);
      Params.ParamValues['qp.sellEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEselldate.DateTime);
      log :=' [��Ʊ����]��'+DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime)+', ';
    end
    else
    begin
       Params.ParamValues['qp.sellSdate'] :=null;
       Params.ParamValues['qp.sellEdate'] :=null;
    end;

    if dtpBtaketime.Checked then //ȡƱ����
    begin

      Params.ParamValues['qp.taketimeSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBtaketime.DateTime);
      Params.ParamValues['qp.taketimeEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEtaketime.DateTime);
      log :=' [ȡƱ����]��'+DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime)+', ';
    end
    else
    begin
       Params.ParamValues['qp.taketimeSdate'] :=null;
       Params.ParamValues['qp.taketimeEdate'] :=null;
    end;


    if not (Trim(nvhlpschedule.Text) = '') then      //���
      begin
        Params.ParamValues['qp.schcode']:= nvhlpschedule.Text;
        log := log +',[��κ�]:'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['qp.schcode']:=null;
      end;

    if not (Trim(nvedtTicketno.Text) = '') then      //Ʊ��
      begin
        Params.ParamValues['qp.ticketno']:= nvedtTicketno.Text;
        log := log+ ',[Ʊ��]:'+nvedtTicketno.Text;
      end
    else
      begin
        Params.ParamValues['qp.ticketno']:=null;
      end;


    if not (Trim(edt1.Text) = '') then      //������
      begin
        Params.ParamValues['qp.orderno']:= edt1.Text;
        log := log+ ',[Ʊ��]:'+edt1.Text;
      end
    else
      begin
        Params.ParamValues['qp.orderno']:=null;
      end;

    if (Trim(nvhlpDeparts.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.departstationid']:= nvhlpDeparts.id;
      log := log +',[����վ]:'+ nvhlpDeparts.Text;
    end
    else
      Params.ParamValues['qp.departstationid']:= '';

    if (Trim(nvhelpendstation.Text)<>'') then //or (nvhelpendstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.reachstationid']:= nvhelpendstation.id;//HelpFieldValue['id'];
      log := log+',[����վ]:'+nvhelpendstation.Text;
    end
    else
    Params.ParamValues['qp.reachstationid']:='';

//    if (not nvhelpUserid.Enabled) or (not nvhelpUserid.Visible) then   //��ƱԱ
//    begin
//      Params.ParamValues['qp.sellby']:= SysInfo.LoginUserInfo.UserID;
//      log := log+',[��ƱԱ]:'+  nvhelpUserid.Text;
//    end
//    else if (nvhelpUserid.Id>0) or ((nvhelpUserid.Id=0) and (Trim(nvhelpUserid.Text)='��վ�û�')) then
//    begin
//      Params.ParamValues['qp.sellby']:= nvhelpUserid.id;
//      log := log+',[��ƱԱ]:'+  nvhelpUserid.Text;
//    end
//    else if Trim(nvhelpUserid.Text)<>'' then
//       Params.ParamValues['qp.sellby']:='';

//    if not (Trim(nvhlpReturnby.Text) = '') and (nvhlpReturnby.Id>=0) then      //��ƱԱ
//    begin
//      Params.ParamValues['qp.returnby']:= nvhlpReturnby.Id;//HelpFieldValue['id'];
//      log := log+',[��ƱԱ]:'+  nvhlpReturnby.Text;
//    end;
     if nvcbbticketstatus.ItemIndex >= 0 then
      begin
        Params.ParamValues['qp.ticketstatus']:= nvcbbticketstatus.GetSelectCode;
        log := log+',[��Ʊ״̬]:'+  nvcbbticketstatus.Text;
      end
       else
      begin
        Params.ParamValues['qp.ticketstatus']:=null;
      end;

//      if nvcbbSellway.ItemIndex >= 0 then
//      begin
//        Params.ParamValues['qp.sellway']:= nvcbbSellway.GetSelectCode;
//        log := log+',[��Ʊ��ʽ]:'+nvcbbSellway.Text;
//      end
//       else
//      begin
//        Params.ParamValues['qp.sellway']:=null;
//      end;

//      if nvcbbPaymethod.ItemIndex >= 0 then
//      begin
//        Params.ParamValues['qp.paymethod']:= nvcbbPaymethod.GetSelectCode;
//        log := log+ ',[֧����ʽ]:'+  nvcbbPaymethod.Text;
//      end
//       else
//      begin
//        Params.ParamValues['qp.paymethod']:='';
//      end;

      if nvhcbbTickettype.ItemIndex >=0 then
      begin
        Params.ParamByName('qp.tickettype').Value := nvhcbbTickettype.HelpFieldValue['code'];
        log := log+',[��Ʊ����]:'+ nvhcbbTickettype.Text;
      end
       else
        Params.ParamByName('qp.tickettype').Value :=null;

      if nvcbborgprint.Text<>'' then            //ȡƱ��
      begin
        Params.ParamValues['qp.printorgids']:=nvcbborgprint.GetSelectID;
        log := log+ '[ȡƱ��]:'+nvcbborgprint.Text;
      end
      else
      begin
         Params.ParamValues['qp.ticketoutletsid']:='';
      end;
      Params.ParamValues['qp.customername']:=trim(nvedtCustomername.Text);
      log := log+ '[�˿�����]:'+nvedtCustomername.Text;
      Params.ParamValues['qp.certificateno']:=trim(nvedtCertificateno.Text);
      log := log+ '[֤������]:'+nvedtCertificateno.Text;
      Params.ParamValues['qp.mobilephone']:=trim(nvedtmobilephone.Text);
      log := log+ '[��ϵ�绰]:'+nvedtmobilephone.Text;

//    if not chkIsnotline.Checked  and chkIsline.Checked  then    //�Ƿ���ˮ��
//      begin
//         Params.ParamValues['qp.islinework']:=1;
//         log := log+' ,[��ˮ��]';
//      end
//      else if not chkIsline.Checked  and chkIsnotline.Checked then
//      begin
//         Params.ParamValues['qp.islinework']:=0;
//         log := log+',[����ˮ��]';
//      end
//      else
//      begin
//         Params.ParamValues['qp.islinework']:=null;
//      end;

       if not chkIsnotcheck.Checked  and chkIscheck.Checked  then    //�Ƿ��Ѽ�
      begin
         Params.ParamValues['qp.ischecked']:='1';
         log := log+',[��Ʊ�Ѽ�]';
      end
      else if not chkIscheck.Checked  and chkIsnotcheck.Checked then
      begin
         Params.ParamValues['qp.ischecked']:='0';
         log := log+',[��Ʊδ��]';
      end
      else
      begin
         Params.ParamValues['qp.ischecked']:=null;
      end;

      if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //�Ƿ�Ӱ���
      begin
         Params.ParamValues['qp.isovertime']:='1';
         log := log+',[�Ӱ�]';
      end
      else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
      begin
         Params.ParamValues['qp.isovertime']:='0';
         log := log+',[����]';
      end
      else
      begin
         Params.ParamValues['qp.isovertime']:=null;
      end;

//     if not chkIsnotlocal.Checked  and chkIslocal.Checked  then    //�Ƿ���վƱ
//      begin
//         Params.ParamValues['qp.islocalticket']:='1';
//         log := log+',[��վƱ]';
//      end
//      else if not chkIslocal.Checked  and chkIsnotlocal.Checked then
//      begin
//         Params.ParamValues['qp.islocalticket']:='0';
//         //Params.ParamValues['isovertime']:='';
//         //Params.ParamValues['ischecked']:='';
//         log := log+',[��վƱ]';
//      end
//      else
//      begin
//         Params.ParamValues['qp.islocalticket']:=null;
//      end;

    if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.routeid']:= nvhelpRoute.id;
      Params.ParamValues['qp.islocalticket']:='1';
      log := log+',[��·]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['qp.routeid']:= null;
    end;
    Params.ParamValues['qp.saleorgids']:= nvcbbOrgid.GetSelectID;
    Active:=true;
    log := log+',[��Ʊ����]:'+ nvcbbOrgid.Text;
    //���������־
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->����Ʊ��ϸ��ѯ', '��ѯ', log);
  end;

end;

end.
