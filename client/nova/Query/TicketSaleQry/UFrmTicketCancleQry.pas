unit UFrmTicketCancleQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmTicketCancleQry = class(TSimpleCRUDForm)
    jcdsCancelwayname: TjsonClientDataSet;
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
    lbl8: TLabel;
    nvhelpstartstation: TNovaHelp;
    lbl4: TLabel;
    nvhelpSellby: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    nvhelpCancelby: TNovaHelp;
    lbl2: TLabel;
    chkIsnotlocal: TCheckBox;
    chkIslocal: TCheckBox;
    lbl6: TLabel;
    wdstrngfldResultcancelstationname: TWideStringField;
    dtmfldResultcanceltime: TDateTimeField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResulttickettypename: TWideStringField;
    fltfldResultstationservicefee: TFloatField;
    wdstrngfldResultsellbyname: TWideStringField;
    wdstrngfldResultsellbycode: TWideStringField;
    dtmfldResultselltime1: TDateTimeField;
    wdstrngfldResultcancelbycode: TWideStringField;
    wdstrngfldResultcancelbyname: TWideStringField;
    wdstrngfldResultcancelip: TWideStringField;
    jcdsResultremarks: TWideStringField;
    jcdsResultschedulecode: TWideStringField;
    jcdsResultislocal: TBooleanField;
    jcdsResultcancelway: TWideStringField;
    jcdsResultticketprice: TFloatField;
    wdstrngfldResultcancelwayname: TWideStringField;
    nvhlpschedule: TNovaHelp;
    nvcbbOrgid: TNovaCheckedComboBox;
    fltfldResultcomputefee: TFloatField;
    fltfldResultcoolairfee: TFloatField;
    fltfldResultadditionfee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultotherfee: TFloatField;
    fltfldResultsubtotal: TFloatField;
    fltfldResultmoreprice: TFloatField;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
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
  frmTicketCancleQry: TfrmTicketCancleQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmTicketCancleQry.dtpBreservetimeChange(Sender: TObject);
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


procedure TfrmTicketCancleQry.dtpEreservetimeChange(Sender: TObject);
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

procedure TfrmTicketCancleQry.FormCreate(Sender: TObject);
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


  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBreservetime.Date:=Now;
  dtpEreservetime.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsCancelwayname.Active := False;
  jcdsCancelwayname.Active := True;
//  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmTicketCancleQry.NovachkPorgCheckClick(Sender: TObject);
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

procedure TfrmTicketCancleQry.tbtnFilterClick(Sender: TObject);
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
  if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
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
    log := log +' [发车日期] 从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);

    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_INS_co!id']:= nvcbbOrgid.GetSelectID;
     log := log +' ,[班次机构];'+ nvckbOrgid.Text+' ,废票机构'+nvcbbOrgid.Text;

    if dtpBreservetime.Checked then //废票日期
    begin
      Params.ParamValues['filter_GED_tc!canceltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreservetime.DateTime);
      Params.ParamValues['filter_LED_tc!canceltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreservetime.DateTime);  //废票日期
      log := log +' ,[废票日期] 从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_GED_tc!canceltime'] :='';
      Params.ParamValues['filter_LED_tc!canceltime'] :='';
    end;



    if  (not (Trim(nvhelpSellby.Text) = '')) and  (nvhelpSellby.Id>0)
    or ((nvhelpSellby.Id=0) and (Trim(nvhelpSellby.Text)='异站用户'))
     then  //售票员
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= nvhelpSellby.HelpFieldValue['id'];
        log := log + ' ,[售票员];' + nvhelpSellby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_sellby!id']:= '';
      end;

    if  (not (Trim(nvhelpCancelby.Text) = '')) and  (nvhelpCancelby.Id>0)
      or ((nvhelpCancelby.Id=0) and (Trim(nvhelpCancelby.Text)='异站用户'))
    then  //废票员
      begin
        Params.ParamValues['filter_EQL_cancelby!id']:= nvhelpCancelby.HelpFieldValue['id'];
        log := log + ' ,[废票员];' + nvhelpCancelby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_cancelby!id']:= '';
      end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then  //终点站
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= nvhelpendstation.HelpFieldValue['id'];
        log := log + ' ,[终点站];' + nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= '';
      end;

      if (not (Trim(nvhelpstartstation.Text) = '')) and (nvhelpstartstation.Id>0) then  //起点站
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= nvhelpstartstation.HelpFieldValue['id'];
        log := log + ' ,[起点站];' +nvhelpstartstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= '';
      end;

      if chkIslocal.Checked then                //是否本地票
        begin
          if not( chkIsnotlocal.Checked ) then
          begin
            Params.ParamValues['filter_EQB_tc!isselfschedule']:='true';
            log := log + ' ,[本站票]';
          end
          else
          begin
            Params.ParamValues['filter_EQB_tc!isselfschedule']:='';
          end;
        end
        else
        begin
          if chkIsnotlocal.Checked  then
          begin
            Params.ParamValues['filter_EQB_tc!isselfschedule']:='false';
            log := log + ' ,]异站票]';
          end
          else
          begin
            Params.ParamValues['filter_EQB_tc!isselfschedule']:='';
          end;
        end;

    if not (Trim(nvhlpschedule.Text) = '') then      //班次
      begin
        Params.ParamValues['filter_LIKES_s!code']:= nvhlpschedule.Text;
        log := log + ',[班次];' + nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['filter_LIKES_s!code']:= '';
      end;

    Params.ParamValues['filter_EQS_ts!ticketno'] :=nvedtTicketno.Text;
    log := log + ',[票号];' + nvedtTicketno.Text;
    //保存操作日志
    SysLog.WriteLog('综合查询->废票情况查询', '查询', '查询条件有;'+log);
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
      dbgrdhResult.PrintInfo.PageTopRight:='废票日期：'+ formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEreservetime.Date);
     end;
    end
end;

end.

