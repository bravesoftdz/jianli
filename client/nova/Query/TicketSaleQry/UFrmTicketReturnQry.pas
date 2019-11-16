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
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date) ) then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
      exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [发车日期] 从 '+ DateToStr(dtpBreservetime.Date)+'到'+DateToStr(dtpEreservetime.Date);

    if dtpBreservetime.Checked then //退票日期
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)+' 00:00:00';
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd',dtpEreservetime.Date)+' 23:59:59';  //退票日期
      log := log +' ,[退票日期]从'+ DateToStr(dtpBreservetime.Date)+'到'+DateToStr(dtpEreservetime.Date);
    end
    else
    begin
       Params.ParamValues['filter_GED_tr!returntime'] :='';
       Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    Params.ParamValues['filter_INS_sellorg!id']:= nvckbOrgid.GetSelectID;
    log:= log +' ,[售票机构];'+ nvckbOrgid.Text;

    Params.ParamValues['filter_EQS_ts!ticketno'] :=nvedtTicketno.Text;
    log := log+' ,[票号];'+nvedtTicketno.Text;

    Params.ParamValues['filter_EQS_tr!returnvoucherno'] :=NvEdtBackno.Text;
    log := log+' ,[退票凭证票号];'+NvEdtBackno.Text;

    Params.ParamValues['filter_INS_tr!ticketoutletsid']:= nvcbbTickeoutlets.GetSelectID;
    log:= log +' ,[退票点];'+ nvcbbTickeoutlets.Text;
    Params.ParamValues['filter_INS_scheduleorg!id']:= nvcbbScheduleorg.GetSelectID;
    log:= log +' ,[班次机构];'+ nvckbOrgid.Text;
    if  (not (Trim(nvhelpSellby.Text) = '')) and  (nvhelpSellby.Id>=0) then  //售票员
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= nvhelpSellby.HelpFieldValue['id'];
        log:= log +' ,[售票员]:'+nvhelpSellby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= '';
      end;

      if  (not (Trim(nvhelpReturnby.Text) = '')) and  (nvhelpReturnby.Id>=0) then  //退票员
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:= nvhelpReturnby.HelpFieldValue['id'];
        log:= log +' ,[退票员];'+ nvhelpReturnby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:= '';
      end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then  //终点站
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= nvhelpendstation.HelpFieldValue['id'];
        log:= log +' ,]终点站]:'+ nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= '';
      end;

      if (not (Trim(nvhelpstartstation.Text) = '')) and (nvhelpstartstation.Id>0) then  //起点站
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= nvhelpstartstation.HelpFieldValue['id'];
        log:= log +' ,[起点站]:'+ nvhelpstartstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= '';
      end;

      if  not (Trim(nvhlpschedule.Text)='') then
      begin
         Params.ParamValues['schedulecode']:= nvhlpschedule.Text;
         log:= log +' ,[班次]:'+nvhlpschedule.Text;
      end
      else
      begin
        Params.ParamValues['schedulecode']:='';
      end;

   if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['routeid']:= nvhelpRoute.id;
      log := log+',[线路]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['routeid']:= null;
    end;

      if chkIslocal.Checked then                //是否本地票
        begin
          if not( chkIsnotlocal.Checked ) then
          begin
            Params.ParamValues['filter_EQB_tr!isselfschedule']:='true';
            log:= log +' ,[本站票]';
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
            log := log+',[本站票和异站票]';
          end;
        end
      else
      begin
        if chkIsnotlocal.Checked  then
        begin
          Params.ParamValues['filter_EQB_tr!isselfschedule']:='false';
          log:= log +' ,[异站票]';
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
          log := log+',[本站票和异站票]';
        end;
      end;

         if chkIsallreturn.Checked then                //是否全额退票
        begin
          if not( chkIsnotallreturn.Checked ) then
          begin
            Params.ParamValues['filter_EQG_tr!charges']:='0';
            Params.ParamValues['filter_NOEQG_tr!charges']:='';
            log:= log +' ,[全额退票]';
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
             log:= log +' ,[差额退票]';
          end
          else
          begin
            Params.ParamValues['filter_NOEQG_tr!charges']:='';

            Params.ParamValues['filter_EQG_tr!charges']:='';
          end;
        end;
     //保存操作日志
    SysLog.WriteLog('综合查询->退票情况查询', '查询', '查询条件有;'+log);
    Active:=true;
    log := '';
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBreservetime.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='退票日期：'+ formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEreservetime.Date);
     end;
    end
end;

end.
