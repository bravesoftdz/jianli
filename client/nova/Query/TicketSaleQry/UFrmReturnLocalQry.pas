unit UFrmReturnLocalQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmReturnLocalQry = class(TSimpleCRUDForm)
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsReturnwayname: TjsonClientDataSet;
    intgrfldResultseatno: TIntegerField;
    fltfldResultticketprice: TFloatField;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBreservetime: TDateTimePicker;
    dtpEreservetime: TDateTimePicker;
    wdstrngfldResultorgname: TWideStringField;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    nvhelpendstation: TNovaHelp;
    chkIsallreturn: TCheckBox;
    chkIsnotallreturn: TCheckBox;
    nvhelpstartstation: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    wdstrngfldResultticketno: TWideStringField;
    wdstrngfldResultreturnvoucherno: TWideStringField;
    dtmfldResultreturntime: TDateTimeField;
    wdstrngfldResultreturnip: TWideStringField;
    wdstrngfldResultreturnway: TWideStringField;
    fltfldResultcharges: TFloatField;
    wdstrngfldResultreturnbyname: TWideStringField;
    wdstrngfldResultreturnbycode: TWideStringField;
    wdstrngfldResultsellbyname: TWideStringField;
    fltfldResultreturnamount: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultticketreturnname: TWideStringField;
    jcdsResultselltime: TDateTimeField;
    strngfldResultreturnwayname: TStringField;
    wdstrngfldResultremarks: TWideStringField;
    nvhlpschedule: TNovaHelp;
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
    lbl8: TLabel;
    lbl9: TLabel;
    wdstrngfldResultreturnorgname: TWideStringField;
    ChkLocal: TCheckBox;
    ChkOther: TCheckBox;
    Label4: TLabel;
    nvhelpRoute: TNovaHelp;
    jcdsResultroutename: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBreservetimeChange(Sender: TObject);
    procedure dtpEreservetimeChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmReturnLocalQry: TfrmReturnLocalQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmReturnLocalQry.dtpEreservetimeChange(Sender: TObject);
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

procedure TfrmReturnLocalQry.dtpBreservetimeChange(Sender: TObject);
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

procedure TfrmReturnLocalQry.FormCreate(Sender: TObject);
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
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBreservetime.Date:=Now;
  dtpEreservetime.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsReturnwayname.Active := False;
  jcdsReturnwayname.Active := True;
  dtpBreservetime.Checked := True;
  dtpEreservetime.Checked := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmReturnLocalQry.NovachkPorgCheckClick(Sender: TObject);
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

procedure TfrmReturnLocalQry.tbtnFilterClick(Sender: TObject);
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
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [�������� ]��'+ DateToStr(dtpBdepartdate.DateTime)+'��'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBreservetime.Checked then //��Ʊ����
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreservetime.DateTime);
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreservetime.DateTime);  //��Ʊ����
      log := log +' ,[��Ʊ����]��'+ DateToStr(dtpBreservetime.DateTime)+'��'+DateToStr(dtpEreservetime.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :='';
      Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then  //�յ�վ
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= nvhelpendstation.HelpFieldValue['id'];
        log := log +', [�յ�վ]:'+nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= '';
      end;

      if (not (Trim(nvhelpstartstation.Text) = '')) and (nvhelpstartstation.Id>0) then  //���վ
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= nvhelpstartstation.HelpFieldValue['id'];
         log := log +', [���վ]:'+nvhelpstartstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= '';
      end;

        if not (Trim(nvhlpschedule.Text) = '') and (nvhlpschedule.Id>0)then//���
         begin
          Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.Id;
          log := log +', [��κ�]:'+ nvhlpschedule.Text;
         end
        else
         begin
          Params.ParamValues['filter_EQL_s!id']:='';
         end;
        if chkIsallreturn.Checked then                //�Ƿ�ȫ����Ʊ
        begin
          if not( chkIsnotallreturn.Checked ) then
          begin
            Params.ParamValues['filter_EQG_tr!charges']:='0';
            Params.ParamValues['filter_NOEQG_tr!charges']:='';
            log := log +', [ȫ����Ʊ]';
          end
          else
          begin
            Params.ParamValues['filter_EQG_tr!charges']:='';
            Params.ParamValues['filter_NOEQG_tr!charges']:='';
          end;
        end
        else
        begin
          if chkIsnotallreturn.Checked  then
          begin
            Params.ParamValues['filter_NOEQG_tr!charges']:='0';
             Params.ParamValues['filter_EQG_tr!charges']:='';
             log := log +', [�����Ʊ]';
          end
          else
          begin
            Params.ParamValues['filter_NOEQG_tr!charges']:='';

            Params.ParamValues['filter_EQG_tr!charges']:='';
          end;
        end;
      if not Chklocal.Checked  and ChkOther.Checked  then    //��վ
      begin
         Params.ParamValues['filter_EQL_tr!returnby']:=0;
         Params.ParamValues['filter_GTL_tr!returnby']:='';
         log := log+' ,[��վ��ƱԱ]';
      end
      else if not ChkOther.Checked  and Chklocal.Checked then   //��վ
      begin
         Params.ParamValues['filter_GTL_tr!returnby']:=0;
         Params.ParamValues['filter_EQL_tr!returnby']:='';
         log := log+',[��վ��ƱԱ]';
      end
      else
      begin
         Params.ParamValues['filter_EQL_tr!returnby']:='';
         Params.ParamValues['filter_GTL_tr!returnby']:='';
      end;

    if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_r!id']:= nvhelpRoute.id;
      log := log+',[��·]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= null;
    end;

    Params.ParamValues['filter_INS_ts!orgid']:= nvckbOrgid.GetSelectID;
    log := log +', [��Ʊ����]:'+nvckbOrgid.Text;
    Params.ParamValues['filter_EQS_ts!ticketno'] :=nvedtTicketno.Text;
    log := log +', [Ʊ��]:'+ nvedtTicketno.Text;
   //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->��վ�˱�վƱ�����ѯ', '��ѯ', '��ѯ������;'+log);
    Active:=true;
    log := '';
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
  end;
end;
end.


