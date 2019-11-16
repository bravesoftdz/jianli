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
    //发车日期
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [发车日期 ]从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBreservetime.Checked then //售票日期
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreservetime.DateTime);
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreservetime.DateTime);  //售票日期
      log := log +' ,[退票日期]从'+ DateToStr(dtpBreservetime.DateTime)+'到'+DateToStr(dtpEreservetime.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_GED_tr!returntime'] :='';
      Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then  //终点站
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= nvhelpendstation.HelpFieldValue['id'];
        log := log +', [终点站]:'+nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:= '';
      end;

      if (not (Trim(nvhelpstartstation.Text) = '')) and (nvhelpstartstation.Id>0) then  //起点站
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= nvhelpstartstation.HelpFieldValue['id'];
         log := log +', [起点站]:'+nvhelpstartstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:= '';
      end;

        if not (Trim(nvhlpschedule.Text) = '') and (nvhlpschedule.Id>0)then//班次
         begin
          Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.Id;
          log := log +', [班次号]:'+ nvhlpschedule.Text;
         end
        else
         begin
          Params.ParamValues['filter_EQL_s!id']:='';
         end;
        if chkIsallreturn.Checked then                //是否全额退票
        begin
          if not( chkIsnotallreturn.Checked ) then
          begin
            Params.ParamValues['filter_EQG_tr!charges']:='0';
            Params.ParamValues['filter_NOEQG_tr!charges']:='';
            log := log +', [全额退票]';
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
             log := log +', [差额退票]';
          end
          else
          begin
            Params.ParamValues['filter_NOEQG_tr!charges']:='';

            Params.ParamValues['filter_EQG_tr!charges']:='';
          end;
        end;
      if not Chklocal.Checked  and ChkOther.Checked  then    //异站
      begin
         Params.ParamValues['filter_EQL_tr!returnby']:=0;
         Params.ParamValues['filter_GTL_tr!returnby']:='';
         log := log+' ,[异站退票员]';
      end
      else if not ChkOther.Checked  and Chklocal.Checked then   //本站
      begin
         Params.ParamValues['filter_GTL_tr!returnby']:=0;
         Params.ParamValues['filter_EQL_tr!returnby']:='';
         log := log+',[本站退票员]';
      end
      else
      begin
         Params.ParamValues['filter_EQL_tr!returnby']:='';
         Params.ParamValues['filter_GTL_tr!returnby']:='';
      end;

    if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_r!id']:= nvhelpRoute.id;
      log := log+',[线路]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= null;
    end;

    Params.ParamValues['filter_INS_ts!orgid']:= nvckbOrgid.GetSelectID;
    log := log +', [售票机构]:'+nvckbOrgid.Text;
    Params.ParamValues['filter_EQS_ts!ticketno'] :=nvedtTicketno.Text;
    log := log +', [票号]:'+ nvedtTicketno.Text;
   //保存操作日志
    SysLog.WriteLog('综合查询->异站退本站票情况查询', '查询', '查询条件有;'+log);
    Active:=true;
    log := '';
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
  end;
end;
end.


