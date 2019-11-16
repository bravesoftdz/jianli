unit UFrmSaleOtherTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmSaleOtherTicketQry = class(TSimpleCRUDForm)
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketstatusname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultsellip: TWideStringField;
    dtmfldResultselltime: TDateTimeField;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpEdepartdate: TDateTimePicker;
    nvckbOrgid: TNovaCheckedComboBox;
    nvhelpendstation: TNovaHelp;
    nvhelpstartstation: TNovaHelp;
    nvhlpSellby: TNovaHelp;
    nvcbbticketstatus: TNovaComboBox;
    dtpBdepartdate: TDateTimePicker;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    lbl2: TLabel;
    lbl4: TLabel;
    dtpBreturnDate: TDateTimePicker;
    dtpEreturnDate: TDateTimePicker;
    lbl10: TLabel;
    lbl15: TLabel;
    nvhlpReturnby: TNovaHelp;
    nvhelpReturnsation: TNovaHelp;
    wdstrngfldResultreturnsationname: TWideStringField;
    wdstrngfldResultreturnbyname: TWideStringField;
    dtmfldResultreturntime: TDateTimeField;
    wdstrngfldResultreturnip: TWideStringField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    fltfldResultcomputefee: TFloatField;
    fltfldResultcoolairfee: TFloatField;
    fltfldResultadditionfee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultotherfee: TFloatField;
    fltfldResultmoreprice: TFloatField;
    fltfldResultsubtotal: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    fltfldResultcharges: TFloatField;
    NovachkPorg: TNovaCheckedComboBox;
    Label1: TLabel;
    jcdsResultsellorgname: TWideStringField;
    jcdsResultticketoutletsname: TWideStringField;
    jcdsResultorderno: TWideStringField;
    jcdsResultfullprice: TFloatField;
    jcdsTickettype: TjsonClientDataSet;
    jcdsResulttickettype: TWideStringField;
    jcdsResulttickettypename: TWideStringField;
    jcdsreturnway: TjsonClientDataSet;
    jcdsResultreturnway: TWideStringField;
    jcdsResultreturnwayname: TWideStringField;
    jcdssellway: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jcdsResultsellway: TWideStringField;
    jcdsResultsellwayname: TWideStringField;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    jcdsResultdistance: TLargeintField;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpBreturnDateChange(Sender: TObject);
    procedure dtpEreturnDateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure dtpBdepartdateChange(Sender: TObject);
    procedure dtpEdepartdateChange(Sender: TObject);
  private
    { Private declarations }
    log: string;
  public
    { Public declarations }
  end;

var
  frmSaleOtherTicketQry: TfrmSaleOtherTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmSaleOtherTicketQry.dtpEdepartdateChange(Sender: TObject);
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

procedure TfrmSaleOtherTicketQry.dtpEreturnDateChange(Sender: TObject);
begin
  inherited;
   if dtpEreturnDate.Checked = True  then
    begin
       dtpBreturnDate.Checked := True;
    end;
   if  dtpEreturnDate.Checked =False then
    begin
       dtpBreturnDate.Checked := False;
    end;
end;

procedure TfrmSaleOtherTicketQry.dtpEselldateChange(Sender: TObject);
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

procedure TfrmSaleOtherTicketQry.dtpBdepartdateChange(Sender: TObject);
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

procedure TfrmSaleOtherTicketQry.dtpBreturnDateChange(Sender: TObject);
begin
  inherited;
  if dtpBreturnDate.Checked = True  then
    begin
       dtpEreturnDate.Checked := True;
    end;
   if  dtpBreturnDate.Checked =False then
    begin
       dtpEreturnDate.Checked := False;
    end;
end;

procedure TfrmSaleOtherTicketQry.dtpBselldateChange(Sender: TObject);
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

procedure TfrmSaleOtherTicketQry.FormCreate(Sender: TObject);
begin
  inherited;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvckbOrgid.Active := False;
  nvckbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckAll(true);
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  dtpBdepartdate.Date :=Now;
  dtpEdepartdate.Date :=Now;
  dtpBreturnDate.Date:=Now;
  dtpEreturnDate.Date:=Now;
  dtpEreturnDate.Checked:=False;
  dtpBreturnDate.Checked :=False;
  dtpBselldate.Date:=Now;
  dtpEselldate.Date:=Now;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmSaleOtherTicketQry.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvckbOrgid.Active := False;
    nvckbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvckbOrgid.Active := True;
    nvckbOrgid.CheckAll(true);
  end;
end;

procedure TfrmSaleOtherTicketQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (not dtpBdepartdate.Checked) and (not dtpBselldate.Checked)  then
  begin
    SysDialogs.ShowMessage('��ѡ��Ҫ��ѯ����Ʊ���ڶλ򷢳����ڶΣ�');
    exit;
  end;
  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )
    or (FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) )
    or (FormatDateTime('yyyymmdd', dtpBreturnDate.Date) > FormatDateTime('yyyymmdd',
    dtpEreturnDate.Date) )then
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
  if Trim(nvckbOrgid.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ���λ�����');
    Exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    if dtpBdepartdate.Checked then
    begin
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);  //��������
    log := log +' [��������] ��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);
    end
    else
    begin
    Params.ParamValues['filter_GED_ts!departdate'] :=  '';
    Params.ParamValues['filter_LED_ts!departdate'] :=  '';
    end;
    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.DateTime)+'00:00:00';
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.DateTime)+'23:59:59';  //��Ʊ����
      log := log +' [��Ʊ����]��'+ DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime);
     end
    else
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :='';
      Params.ParamValues['filter_LED_ts!selltime'] :='';
    end;

    if dtpEreturnDate.Checked then
    begin
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreturnDate.DateTime)+'00:00:00';  //��Ʊ����
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreturnDate.DateTime)+'23:59:59';
      log := log +' ,[��Ʊ����]��'+ DateToStr(dtpBreturnDate.DateTime)+'��'+DateToStr(dtpEreturnDate.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_LED_tr!returntime'] :='';
      Params.ParamValues['filter_GED_tr!returntime'] :='';
    end;

    Params.ParamValues['scheduleorgid']:= nvckbOrgid.GetSelectID;
    log := log +' ,[��λ���]:'+ nvckbOrgid.Text;

    if nvcbbticketstatus.ItemIndex >= 0 then     //��Ʊ״̬
    begin
       Params.ParamValues['filter_EQS_ts!ticketstatus']:= nvcbbticketstatus.GetSelectCode;
       log := log +' ,[��Ʊ״̬]:'+nvcbbticketstatus.Text;
    end
    else
    begin
       Params.ParamValues['filter_EQS_ts!ticketstatus']:='';
    end;

     if nvhelpReturnsation.Id>0 then            //��Ʊ��
      begin
        Params.ParamValues['filter_EQL_tr!ticketoutletsid']:=nvhelpReturnsation.Id;
        log := log +' ,[��Ʊ��]:' +nvhelpReturnsation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_tr!ticketoutletsid']:='';
       end;

        if nvhlpSellby.Id>0 then            //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_ts!sellby']:=nvhlpSellby.Id;
        log := log +' ,[��ƱԱ]:'+ nvhlpSellby.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!sellby']:='';
       end;

       if nvhlpReturnby.Id>0 then            //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:=nvhlpReturnby.Id;
        log := log +' ,[��ƱԱ]:'+nvhlpReturnby.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_tr!returnby']:='';
       end;

       if nvhelpstartstation.Id>0 then            //�ϳ���
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:=nvhelpstartstation.Id;
        log := log +' ,[�ϳ���]:'+nvhelpstartstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!departstationid']:='';
       end;

        if nvhelpendstation.Id>0 then            //�³���
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:=nvhelpendstation.Id;
        log := log +' ,[����վ]:'+nvhelpendstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!reachstationid']:='';
       end;
    //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->��վ����վƱ�����ѯ', '��ѯ', '��ѯ������;'+log);
    try
    Active:=true;
    except on e:Exception do
      ShowMessage(e.Message);
    end;
    log := '';
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBselldate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
     end;
    end

  end;

end.
