unit UFrmTicketReturnQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmTicketReturnQry = class(TSimpleCRUDForm)
    jcdsReturnwayname: TjsonClientDataSet;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBreservetime: TDateTimePicker;
    dtpEreservetime: TDateTimePicker;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl9: TLabel;
    nvhelpendstation: TNovaHelp;
    chkIsallreturn: TCheckBox;
    chkIsnotallreturn: TCheckBox;
    lbl8: TLabel;
    nvhelpstartstation: TNovaHelp;
    lbl4: TLabel;
    nvhelpSellby: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    nvhelpReturnby: TNovaHelp;
    lbl2: TLabel;
    chkIsnotlocal: TCheckBox;
    chkIslocal: TCheckBox;
    nvhlpschedule: TNovaHelp;
    lbl6: TLabel;
    nvcbbTickeoutlets: TNovaCheckedComboBox;
    lbl10: TLabel;
    nvcbbScheduleorg: TNovaCheckedComboBox;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    Label1: TLabel;
    NovaCkSchSubOrg: TNovaCheckedComboBox;
    Label3: TLabel;
    NvEdtBackno: TNovaEdit;
    Label4: TLabel;
    nvhelpRoute: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBreservetimeChange(Sender: TObject);
    procedure dtpEreservetimeChange(Sender: TObject);
    procedure NovaCkSchSubOrgCheckClick(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmTicketReturnQry: TfrmTicketReturnQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmTicketReturnQry.dtpBreservetimeChange(Sender: TObject);
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

procedure TfrmTicketReturnQry.dtpEreservetimeChange(Sender: TObject);
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

procedure TfrmTicketReturnQry.FormCreate(Sender: TObject);
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

  NovaCkSchSubOrg.Active:= False;
  NovaCkSchSubOrg.Active := True;
  NovaCkSchSubOrg.OnCheckClick:=nil;
  NovaCkSchSubOrg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovaCkSchSubOrg.OnCheckClick:=NovaCkSchSubOrgCheckClick;

  nvcbbScheduleorg.Active := False;
  nvcbbScheduleorg.Params.ParamValues['orgids']:=NovaCkSchSubOrg.GetSelectID;
  nvcbbScheduleorg.Active := True;
  nvcbbScheduleorg.CheckAll(true);

  dtpBreservetime.Date:=Now;
  dtpEreservetime.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsReturnwayname.Active := False;
  jcdsReturnwayname.Active := True;
  nvcbbTickeoutlets.Active:= False;
  nvcbbTickeoutlets.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmTicketReturnQry.NovachkPorgCheckClick(Sender: TObject);
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

procedure TfrmTicketReturnQry.NovaCkSchSubOrgCheckClick(Sender: TObject);
begin
  inherited;
  if NovaCkSchSubOrg.GetSelectID<>'' then
  begin
    nvcbbScheduleorg.Active := False;
    nvcbbScheduleorg.Params.ParamValues['orgids']:=NovaCkSchSubOrg.GetSelectID;
    nvcbbScheduleorg.Active := True;
    nvcbbScheduleorg.CheckAll(true);
  end;
end;

procedure TfrmTicketReturnQry.tbtnFilterClick(Sender: TObject);
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
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date) ) then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),������ѡ��');
      exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [��������] �� '+ DateToStr(dtpBreservetime.Date)+'��'+DateToStr(dtpEreservetime.Date);

    if dtpBreservetime.Checked then //��Ʊ����
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)+' 00:00:00';
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd',dtpEreservetime.Date)+' 23:59:59';  //��Ʊ����
      log := log +' ,[��Ʊ����]��'+ DateToStr(dtpBreservetime.Date)+'��'+DateToStr(dtpEreservetime.Date);
    end
    else
    begin
       Params.ParamValues['filter_GED_tr!returntime'] :='';
       Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    Params.ParamValues['filter_INS_sellorg!id']:= nvckbOrgid.GetSelectID;
    log:= log +' ,[��Ʊ����];'+ nvckbOrgid.Text;

    Params.ParamValues['filter_EQS_ts!ticketno'] :=nvedtTicketno.Text;
    log := log+' ,[Ʊ��];'+nvedtTicketno.Text;

    Params.ParamValues['filter_EQS_tr!returnvoucherno'] :=NvEdtBackno.Text;
    log := log+' ,[��Ʊƾ֤Ʊ��];'+NvEdtBackno.Text;

    Params.ParamValues['filter_INS_tr!ticketoutletsid']:= nvcbbTickeoutlets.GetSelectID;
    log:= log +' ,[��Ʊ��];'+ nvcbbTickeoutlets.Text;
    Params.ParamValues['filter_INS_scheduleorg!id']:= nvcbbScheduleorg.GetSelectID;
    log:= log +' ,[��λ���];'+ nvckbOrgid.Text;
    if  (not (Trim(nvhelpSellby.Text) = '')) and  (nvhelpSellby.Id>=0) then  //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= nvhelpSellby.HelpFieldValue['id'];
        log:= log +' ,[��ƱԱ]:'+nvhelpSellby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= '';
      end;

      if  (not (Trim(nvhelpReturnby.Text) = '')) and  (nvhelpReturnby.Id>=0) then  //��ƱԱ
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:= nvhelpReturnby.HelpFieldValue['id'];
        log:= log +' ,[��ƱԱ];'+ nvhelpReturnby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:= '';
      end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then  //�յ�վ
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= nvhelpendstation.HelpFieldValue['id'];
        log:= log +' ,]�յ�վ]:'+ nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= '';
      end;

      if (not (Trim(nvhelpstartstation.Text) = '')) and (nvhelpstartstation.Id>0) then  //���վ
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= nvhelpstartstation.HelpFieldValue['id'];
        log:= log +' ,[���վ]:'+ nvhelpstartstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= '';
      end;

      if  not (Trim(nvhlpschedule.Text)='') then
      begin
         Params.ParamValues['schedulecode']:= nvhlpschedule.Text;
         log:= log +' ,[���]:'+nvhlpschedule.Text;
      end
      else
      begin
        Params.ParamValues['schedulecode']:='';
      end;

   if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['routeid']:= nvhelpRoute.id;
      log := log+',[��·]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['routeid']:= null;
    end;

      if chkIslocal.Checked then                //�Ƿ񱾵�Ʊ
        begin
          if not( chkIsnotlocal.Checked ) then
          begin
            Params.ParamValues['filter_EQB_tr!isselfschedule']:='true';
            log:= log +' ,[��վƱ]';
          end
          else
          begin
              if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
            begin
                  Params.ParamValues['routeid']:= nvhelpRoute.id;
                  Params.ParamValues['filter_EQB_tr!isselfschedule']:='true';
            end
            else
            begin
                  Params.ParamValues['routeid']:= null;
                  Params.ParamValues['filter_EQB_tr!isselfschedule']:='';
            end;
            log := log+',[��վƱ����վƱ]';
          end;
        end
      else
      begin
        if chkIsnotlocal.Checked  then
        begin
          Params.ParamValues['filter_EQB_tr!isselfschedule']:='false';
          log:= log +' ,[��վƱ]';
        end
        else
        begin
          //
          if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
          begin
                Params.ParamValues['routeid']:= nvhelpRoute.id;
                Params.ParamValues['filter_EQB_tr!isselfschedule']:='true';
          end
          else
          begin
                Params.ParamValues['routeid']:= null;
                Params.ParamValues['filter_EQB_tr!isselfschedule']:='';
          end;
          log := log+',[��վƱ����վƱ]';
        end;
      end;

         if chkIsallreturn.Checked then                //�Ƿ�ȫ����Ʊ
        begin
          if not( chkIsnotallreturn.Checked ) then
          begin
            Params.ParamValues['filter_EQG_tr!charges']:='0';
            Params.ParamValues['filter_NOEQG_tr!charges']:='';
            log:= log +' ,[ȫ����Ʊ]';
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
             log:= log +' ,[�����Ʊ]';
          end
          else
          begin
            Params.ParamValues['filter_NOEQG_tr!charges']:='';

            Params.ParamValues['filter_EQG_tr!charges']:='';
          end;
        end;
     //���������־
    SysLog.WriteLog('�ۺϲ�ѯ->��Ʊ�����ѯ', '��ѯ', '��ѯ������;'+log);
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
