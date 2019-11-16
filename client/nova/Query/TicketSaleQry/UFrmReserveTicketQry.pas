unit UFrmReserveTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmReserveTicketQry = class(TSimpleCRUDForm)
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsSellstatus: TjsonClientDataSet;
    intgrfldResultseatno: TIntegerField;
    fltfldResultfullprice: TFloatField;
    wdstrngfldResultreserveip: TWideStringField;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpBreservetime: TDateTimePicker;
    dtpEreservetime: TDateTimePicker;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultticketoutletsname: TWideStringField;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultremarks: TWideStringField;
    wdstrngfldResulttickettypename1: TWideStringField;
    lbl9: TLabel;
    nvhelpendstation: TNovaHelp;
    lbl2: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    chkIsautocancel: TCheckBox;
    chkIsnotautocancel: TCheckBox;
    lbl6: TLabel;
    nvhelpCustomer: TNovaHelp;
    fltfldResultserviceprice: TFloatField;
    blnfldResultisautocancel: TBooleanField;
    dtmfldResultautocanceltime: TDateTimeField;
    dtmfldResultreservetime: TDateTimeField;
    wdstrngfldResultreserveway: TWideStringField;
    dtmfldResultcanceltime: TDateTimeField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultreservebyname: TWideStringField;
    wdstrngfldResultcencelbyname: TWideStringField;
    intgrfldResultcarrychildnum: TIntegerField;
    jcdsReserveway: TjsonClientDataSet;
    wdstrngfldResultsellstate: TWideStringField;
    wdstrngfldResultsellstatename: TWideStringField;
    wdstrngfldResultreservewayname: TWideStringField;
    lbl13: TLabel;
    lbl16: TLabel;
    nvcbbway: TNovaComboBox;
    nvcbbticketstatus: TNovaComboBox;
    nvhlpschedule: TNovaHelp;
    jcdsResultcertificateno: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBreservetimeChange(Sender: TObject);
    procedure dtpEreservetimeChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmReserveTicketQry: TfrmReserveTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmReserveTicketQry.dtpBreservetimeChange(Sender: TObject);
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

procedure TfrmReserveTicketQry.dtpEreservetimeChange(Sender: TObject);
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

procedure TfrmReserveTicketQry.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBreservetime.Date:=Now;
  dtpEreservetime.Date:=Now;
  dtpBdepartdate.Date:=Now;
  dtpEdepartdate.Date:=Now;
  jcdsSellstatus.Active := False;
  jcdsSellstatus.Active := True;
  jcdsReserveway.Active := False;
  jcdsReserveway.Active := True;
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  nvcbbway.Active := False;
  nvcbbway.Active:= True;
 // dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmReserveTicketQry.tbtnFilterClick(Sender: TObject);
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
    Params.ParamValues['filter_GED_sr!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_sr!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [发车日期 ]从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBreservetime.Checked then //售票日期
    begin
     Params.ParamValues['filter_GED_sr!reservetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreservetime.DateTime);
     Params.ParamValues['filter_LED_sr!reservetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreservetime.DateTime);  //售票日期
     log := log +', [售票日期]从'+ DateToStr(dtpBreservetime.DateTime)+'到'+DateToStr(dtpEreservetime.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_sr!reservetime'] :='';
      Params.ParamValues['filter_LED_sr!reservetime'] :='';
    end;

    Params.ParamValues['filter_INS_sr!orgid']:= nvckbOrgid.GetSelectID;
    log := log +', [班次机构]:'+ nvckbOrgid.Text;

    if (not (Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id>0) then                   //班次
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
        log:= log +', [班次]:'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhelpendstation.Text) = '')) and (nvhelpendstation.Id>0) then //终点站
      begin
        Params.ParamValues['filter_EQL_str!id']:= nvhelpendstation.HelpFieldValue['id'];
        log := log +', [到达站]:'+nvhelpendstation.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_str!id']:= '';
      end;

    if  (not (Trim(nvhelpCustomer.Text) = '')) and  (nvhelpCustomer.Id>0) then  //顾客名
      begin
        Params.ParamValues['filter_EQL_ct!id']:= nvhelpCustomer.HelpFieldValue['id'];
        log := log +', [顾客名]:'+ nvhelpCustomer.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ct!id']:= '';
      end;

    if (not (Trim(nvhelpTicketoutlets.Text) = '')) and (nvhelpTicketoutlets.Id>0) then  //留票点
      begin
        Params.ParamValues['filter_EQL_tos!id']:= nvhelpTicketoutlets.HelpFieldValue['id'];
        log := log +', [售票点]:' +nvhelpTicketoutlets.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_tos!id']:= '';
      end;

      if chkIsnotautocancel.Checked then                //是否自动取消
        begin
          if not( chkIsautocancel.Checked ) then
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='false';
            log := log +', [手动取消]'
          end
          else
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='';
          end;
        end
        else
        begin
          if chkIsautocancel.Checked  then
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='true';
            log := log +', [自动取消]'
          end
          else
          begin
            Params.ParamValues['filter_EQB_sr!isautocancel']:='';
          end;
        end;

        if nvcbbticketstatus.ItemIndex >= 0 then     //状态
      begin
        Params.ParamValues['filter_EQS_sr!sellstate']:= nvcbbticketstatus.GetSelectCode;
        log := log +', [售票状态]:' +nvcbbticketstatus.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_sr!sellstate']:='';
      end;

      if nvcbbway.ItemIndex >= 0 then     //途径
      begin
        Params.ParamValues['filter_EQS_sr!reserveway']:= nvcbbway.GetSelectCode;
        log := log +', [留票路径]:'+nvcbbway.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_sr!reserveway']:='';
      end;
   //保存操作日志
    SysLog.WriteLog('综合查询->留票情况查询','查询',  '查询条件有;'+log);
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
      dbgrdhResult.PrintInfo.PageTopRight:='留票日期：'+ formatdatetime('yyyy-mm-dd',dtpBreservetime.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEreservetime.Date);
     end;
    end
end;

end.

