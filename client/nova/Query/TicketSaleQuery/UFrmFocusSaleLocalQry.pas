unit UFrmFocusSaleLocalQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TFrmFocusSalelocalQry = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl5: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    nvhelpendstation: TNovaHelp;
    nvcbbticketstatus: TNovaComboBox;
    nvhelpTicketoutlets: TNovaHelp;
    dtpBdepartdate: TDateTimePicker;
    lbl7: TLabel;
    dtpBselldate: TDateTimePicker;
    lbl14: TLabel;
    dtpEselldate: TDateTimePicker;
    jcdsTicketstatus: TjsonClientDataSet;
    lbl2: TLabel;
    lbl4: TLabel;
    dtpBreturnDate: TDateTimePicker;
    dtpEreturnDate: TDateTimePicker;
    lbl10: TLabel;
    lbl15: TLabel;
    nvhelpReturnby: TNovaHelp;
    nvhelpReturnsation: TNovaHelp;
    wdstrngfldResultsellip: TWideStringField;
    dtmfldResultselltime: TDateTimeField;
    wdstrngfldResultbuspark: TWideStringField;
    fltfldResultprice: TFloatField;
    fltfldResultfullprice1: TFloatField;
    lrgntfldResultdistance1: TLargeintField;
    blnfldResultislinework1: TBooleanField;
    wdstrngfldResultticketentrance1: TWideStringField;
    dtfldResultdepartdate1: TDateField;
    intgrfldResultseatno1: TIntegerField;
    wdstrngfldResultticketno1: TWideStringField;
    wdstrngfldResultticketstatus1: TWideStringField;
    wdstrngfldResulttickettype: TWideStringField;
    fltfldResultstationservicefee1: TFloatField;
    blnfldResultischecked1: TBooleanField;
    dtmfldResultchecktime1: TDateTimeField;
    wdstrngfldResultcheckedname1: TWideStringField;
    wdstrngfldResultcheckstationname1: TWideStringField;
    wdstrngfldResultsellname1: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultschedulecode1: TWideStringField;
    wdstrngfldResulttickettypename1: TWideStringField;
    wdstrngfldResultagentname: TWideStringField;
    fltfldResultcharges: TFloatField;
    wdstrngfldResultreturnip: TWideStringField;
    wdstrngfldResultticketoutletname1: TWideStringField;
    wdstrngfldResultreturnsationname: TWideStringField;
    wdstrngfldResultreturnbyname: TWideStringField;
    dtmfldResultreturntime: TDateTimeField;
    wdstrngfldResultvehicletypename1: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultticketstatusname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpBreturnDateChange(Sender: TObject);
    procedure dtpEreturnDateChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  FrmFocusSalelocalQry: TFrmFocusSalelocalQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TFrmFocusSalelocalQry.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  dtpBdepartdate.Date :=Now;
  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date :=Now;
  dtpEdepartdate.Checked:=False;
  dtpBselldate.Date := Now;
  dtpEselldate.Date :=Now;
  dtpBreturnDate.Date := Now;
  dtpEreturnDate.Date := Now;
  dtpBreturnDate.Date := Now;
  dtpEreturnDate.Date :=Now;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  dtpEreturnDate.Checked:=False;
  dtpBreturnDate.Checked:=False;
end;

procedure TFrmFocusSalelocalQry.dtpEselldateChange(Sender: TObject);
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

procedure TFrmFocusSalelocalQry.dtpBreturnDateChange(Sender: TObject);
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

procedure TFrmFocusSalelocalQry.dtpEreturnDateChange(Sender: TObject);
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

procedure TFrmFocusSalelocalQry.dtpBselldateChange(Sender: TObject);
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

procedure TFrmFocusSalelocalQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
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
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  if Trim(nvckbOrgid.Text) = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    Exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);  //��������
    log := log +' [��������] ��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.DateTime);
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.DateTime);  //��Ʊ����
      log := log +' ,[��Ʊ����]��'+ DateToStr(dtpBselldate.DateTime)+'��'+DateToStr(dtpEselldate.DateTime);
     end
    else
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :='';
      Params.ParamValues['filter_LED_ts!selltime'] :='';
    end;

    if dtpEreturnDate.Checked then
    begin
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreturnDate.DateTime)+'00:00:00';
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreturnDate.DateTime)+'23:59:59';
      log := log +' ,[��Ʊ����]��'+ DateToStr(dtpBreturnDate.DateTime)+'��'+DateToStr(dtpEreturnDate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_tr!returntime'] :='';
       Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    Params.ParamValues['filter_INS_ts!orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_INS_org!id']:= SysInfo.LoginUserInfo.OrgID;
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

    if nvhelpTicketoutlets.Id>0 then            //��Ʊ��
      begin
        Params.ParamValues['filter_EQL_ts!ticketoutletsid']:=nvhelpTicketoutlets.Id;
         log := log +' ,[��Ʊ��]:' +nvhelpTicketoutlets.Text;
      end
    else
      begin
       Params.ParamValues['filter_EQL_ts!ticketoutletsid']:='';
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

       if nvhelpReturnby.Id>0 then            //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:=nvhelpReturnby.Id;
         log := log +' ,[��ƱԱ]:'+nvhelpReturnby.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_tr!returnby']:='';
       end;

       if nvhelpendstation.Id>0 then            //����վ
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:=nvhelpendstation.Id;
        log := log +' ,[����վ]:'+nvhelpendstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!reachstationid']:='';
       end;
    //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->����ʽ��վ�۱�վƱ�����ѯ', '��ѯ', '��ѯ������;'+log);
    Active:=true;
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
  end;
end;
end.
