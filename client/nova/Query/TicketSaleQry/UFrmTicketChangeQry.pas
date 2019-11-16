unit UFrmTicketChangeQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmTicketChangeQry = class(TSimpleCRUDForm)
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultoldschedulecode: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResulttickettype: TWideStringField;
    wdstrngfldResultoldticketno: TWideStringField;
    dtfldResultolddepartdate: TDateField;
    wdstrngfldResultolddeparttime: TWideStringField;
    intgrfldResultoldseatno: TIntegerField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultchangeip: TWideStringField;
    lbl6: TLabel;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    nvhelpSellby: TNovaHelp;
    dtpBchangedate: TDateTimePicker;
    dtpEchangedate: TDateTimePicker;
    wdstrngfldResultorgname: TWideStringField;
    lbl17: TLabel;
    nvedtTicketno: TNovaEdit;
    wdstrngfldResultchangeticketoutlets: TWideStringField;
    fltfldResultstationservicefee: TFloatField;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl2: TLabel;
    nvedtOldTicketno: TNovaEdit;
    lbl3: TLabel;
    nvhelpChangeby: TNovaHelp;
    lbl4: TLabel;
    wdstrngfldResultnewschedulecode: TWideStringField;
    wdstrngfldResultnewticketno: TWideStringField;
    dtfldResultnewdepartdate: TDateField;
    wdstrngfldResultnewdeparttime: TWideStringField;
    intgrfldResultnewseatno: TIntegerField;
    dtmfldResultchangetime: TDateTimeField;
    wdstrngfldResultremarks: TWideStringField;
    wdstrngfldResultchangebyname: TWideStringField;
    wdstrngfldResulttickettypename1: TWideStringField;
    nvhlpschedule: TNovaHelp;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    fltfldResultservicefee: TFloatField;
    nvcbbTickeoutlets: TNovaCheckedComboBox;
    lbl8: TLabel;
    jcdsResultchangeticketno: TWideStringField;
    Label1: TLabel;
    changeticketno: TNovaEdit;
    lbl12: TLabel;
    nvcbbPaymethod: TNovaComboBox;
    jcdsPaymethod: TjsonClientDataSet;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBchangedateChange(Sender: TObject);
    procedure dtpEchangedateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmTicketChangeQry: TfrmTicketChangeQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmTicketChangeQry.dtpBchangedateChange(Sender: TObject);
begin
  inherited;
  if dtpBchangedate.Checked = True  then
  begin
     dtpEchangedate.Checked := True;
  end;
  if  dtpBchangedate.Checked =False then
  begin
      dtpEchangedate.Checked := False;
  end;
end;

procedure TfrmTicketChangeQry.dtpEchangedateChange(Sender: TObject);
begin
  inherited;
   if dtpEchangedate.Checked = True  then
    begin
       dtpBchangedate.Checked := True;
    end;
   if  dtpEchangedate.Checked =False then
    begin
       dtpBchangedate.Checked := False;
    end;
end;

procedure TfrmTicketChangeQry.FormCreate(Sender: TObject);
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
  dtpBchangedate.Date:=Now;
  dtpEchangedate.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  nvcbbTickeoutlets.Active:= False;
  nvcbbTickeoutlets.Active := True;
  jcdsPaymethod.Active:=false;
  jcdsPaymethod.Active:=true;
  nvcbbPaymethod.Active:=false;
  nvcbbPaymethod.Active:=true;
  nvcbbPaymethod.ItemIndex:=0;
end;

procedure TfrmTicketChangeQry.NovachkPorgCheckClick(Sender: TObject);
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

procedure TfrmTicketChangeQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )
    or (FormatDateTime('yyyymmdd', dtpBchangedate.Date) > FormatDateTime('yyyymmdd',
    dtpEchangedate.Date) )then
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
    Params.ParamValues['filter_GED_ots!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ots!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [��������] ��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBchangedate.Checked then
    begin
      Params.ParamValues['filter_GED_c!changetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBchangedate.DateTime);
      Params.ParamValues['filter_LED_c!changetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEchangedate.DateTime);  //��Ʊ����
      log := log +' [��ǩ����]��'+ DateToStr(dtpBchangedate.DateTime)+'��'+DateToStr(dtpEchangedate.DateTime)
    end
    else
    begin
      Params.ParamValues['filter_GED_c!changetime'] := '';
      Params.ParamValues['filter_LED_c!changetime'] := '';
    end;

    if nvcbbPaymethod.ItemIndex >= 0 then     //֧����ʽ
      begin
        Params.ParamValues['filter_EQS_nts!paymethod']:= nvcbbPaymethod.GetSelectCode;
      end
    else
      begin
        Params.ParamValues['filter_EQS_nts!paymethod']:='';
      end;

    Params.ParamValues['filter_INS_ots!orgid']:= nvckbOrgid.GetSelectID;
    log := log +' ,[����] '+nvckbOrgid.Text;

    if nvhelpSellby.Id>0 then                   //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_ots!sellby']:= nvhelpSellby.HelpFieldValue['id'];
        log := log +' ,[��ƱԱ];'+nvhelpSellby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ots!sellby']:= '';
      end;

    Params.ParamValues['filter_INS_ct!id']:= nvcbbTickeoutlets.GetSelectID;
    log:= log +' ,[��ǩ��];'+ nvcbbTickeoutlets.Text;

    if nvhelpChangeby.Id>0 then                   //��ǩ��
      begin
        Params.ParamValues['filter_EQL_c!changeby']:= nvhelpChangeby.HelpFieldValue['id'];
        log := log +' ,[��ǩ��];'+nvhelpChangeby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_c!changeby']:= '';
      end;

    if nvhlpschedule.Id>0 then                   //ԭ���
      begin
        Params.ParamValues['filter_EQL_os!id']:= nvhlpschedule.HelpFieldValue['id'];
        log := log +' ,[ԭ���];'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_os!id']:= '';
      end;
    Params.ParamValues['filter_EQS_c!changeticketno']:= changeticketno.text;
    Params.ParamValues['filter_EQS_nts!ticketno']:= nvedtTicketno.Text;
    log := log +' ,[��Ʊ��];'+nvedtTicketno.Text;
    Params.ParamValues['filter_EQS_ots!ticketno']:=  nvedtOldTicketno.Text;
    log := log +' ,[ԭƱ��];'+nvedtOldTicketno.Text;

    //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->��Ʊ��ǩ��ѯ', '��ѯ', '��ѯ������;'+log);
    Active:=true;
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBchangedate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='��ǩ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBchangedate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEchangedate.Date);
     end;
    end
end;

end.

