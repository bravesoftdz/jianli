unit UFrmPresellTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmPresellTicketQry = class(TSimpleCRUDForm)
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultsellip: TWideStringField;
    dtmfldResultselltime: TDateTimeField;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl13: TLabel;
    lbl1: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    nvhelpendstation: TNovaHelp;
    nvhelpstartstation: TNovaHelp;
    nvhelpSellby: TNovaHelp;
    nvcbbticketstatus: TNovaComboBox;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    lbl3: TLabel;
    lbl17: TLabel;
    nvedtTicketno: TNovaEdit;
    lbl16: TLabel;
    nvhcbbTickettype: TNovaHComboBox;
    wdstrngfldResultticketoutlestname: TWideStringField;
    fltfldResultstationservicefee: TFloatField;
    chkIsnotlocal: TCheckBox;
    chkIslocal: TCheckBox;
    blnfldResultislocal: TBooleanField;
    wdstrngfldResultticketstatusname: TWideStringField;
    wdstrngfldResulttickettypename: TWideStringField;
    nvhlpschedule: TNovaHelp;
    nvcbbOrgid: TNovaCheckedComboBox;
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
    lbl5: TLabel;
    lbl11: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpBdepartdate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    jcdsPaymethod: TjsonClientDataSet;
    lbl12: TLabel;
    nvcbbPaymethod: TNovaComboBox;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpBdepartdateChange(Sender: TObject);
    procedure dtpEdepartdateChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmPresellTicketQry: TfrmPresellTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmPresellTicketQry.dtpBdepartdateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.dtpBselldateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.dtpEdepartdateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.dtpEselldateChange(Sender: TObject);
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

procedure TfrmPresellTicketQry.FormCreate(Sender: TObject);
begin
  inherited;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  dtpBselldate.Date:=Now;
  dtpEselldate.Date:=Now;
  dtpBdepartdate.Date:=now;
  dtpEdepartdate.Date:=now;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  nvcbbPaymethod.Active :=False;
  nvcbbPaymethod.Active :=True;
  jcdsPaymethod.Active:=False;
  jcdsPaymethod.Active:=True;
  nvcbbPaymethod.ItemIndex:=0;
end;

procedure TfrmPresellTicketQry.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmPresellTicketQry.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TfrmPresellTicketQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if nvcbbOrgid.Text = ''then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    exit;
  end;
   if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) then
  begin
    SysDialogs.ShowMessage('售票开始日期不能大于结束日期！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEselldate.Date-dtpBselldate.Date)) and  dtpBselldate.Checked
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;
   if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date))  and   dtpBdepartdate.Checked
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;
   if not ((dtpBselldate.Checked) or (dtpBdepartdate.Checked)) then
  begin
      SysDialogs.ShowMessage('至少选择一个日期段！');
    exit;
  end;

  with jcdsResult do
  begin
    Active:=False;
//    if dtpEselldate.Date > Now+1 then
//    begin
//     dtpEselldate.Datetime :=Now;
//    end;

//    Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.Datetime);
//    Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.Datetime);  //售票日期
//    log := log +'[售票日期]从'+ DateToStr(dtpBselldate.DateTime)+'到'+DateToStr(dtpEselldate.DateTime);
//
//    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBdepartdate.Datetime);
//    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEdepartdate.Datetime);
//    log := log +'[发车日期]从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);
       if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.Datetime);
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.Datetime);  //售票日期
      log := log +'[售票日期]从'+ DateToStr(dtpBselldate.DateTime)+'到'+DateToStr(dtpEselldate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_ts!selltime'] := '';
       Params.ParamValues['filter_LED_ts!selltime'] := '';
    end;
    if dtpBdepartdate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Datetime);
      Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Datetime);  //发车日期
      log := log +'[发车日期]从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_ts!departdate'] :=  '';
       Params.ParamValues['filter_LED_ts!departdate'] :=  '';
    end;
    if nvcbbPaymethod.ItemIndex >= 0 then     //支付方式
      begin
        Params.ParamValues['filter_EQS_ts!paymethod']:= nvcbbPaymethod.GetSelectCode;
      end
    else
      begin
        Params.ParamValues['filter_EQS_ts!paymethod']:='';
      end;
    if nvcbbticketstatus.ItemIndex >= 0 then     //车票状态
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:= nvcbbticketstatus.GetSelectCode;
        log := log +', [车票状态]:'+ nvcbbticketstatus.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:='';
      end;

      if nvhcbbTickettype.ItemIndex >=0 then
      begin
        Params.ParamByName('filter_EQS_ts!tickettype').Value := nvhcbbTickettype.HelpFieldValue['code'];
        log := log +', [车票类型]:'+ nvhcbbTickettype.Text;
      end
       else
        Params.ParamByName('filter_EQS_ts!tickettype').Value :='';

      if nvhelpstartstation.Id>0 then            //上车点
      begin
        Params.ParamValues['filter_EQL_ts!departstationid']:=nvhelpstartstation.Id;
        log := log +', [上车点]:'+nvhelpstartstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!departstationid']:='';
       end;

      if nvhelpendstation.Id>0 then            //到达站
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:=nvhelpendstation.Id;
        log := log +', [到达站]:'+nvhelpendstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!reachstationid']:='';
       end;

      if nvhelpSellby.Id>0 then                   //售票员
        begin
          Params.ParamValues['filter_EQL_ts!sellby']:= nvhelpSellby.HelpFieldValue['id'];
          log := log+', [售票员]:'+nvhelpSellby.Text;
        end
      else
        begin
          Params.ParamValues['filter_EQL_ts!sellby']:= '';
        end;

    if chkIsnotlocal.Checked then                //是否异站票
    begin
      if not( chkIslocal.Checked ) then
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='false';       //异站票
        log := log+', [异站票]';
      end
      else
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='';
      end;
    end
    else
    begin
      if  chkIslocal.Checked  then                                      //本站票
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='true';
        log := log+', [本站票]';
      end
      else
      begin
        Params.ParamValues['filter_EQB_ts!islocalticket']:='';
      end;
    end;

    Params.ParamValues['filter_INS_o!id']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ts!ticketno']:=  nvedtTicketno.Text;
    Params.ParamValues['filter_LIKES_s!code'] := nvhlpschedule.Text;
    log := log+', [售票机构]:' +nvcbbOrgid.Text;
    log := log+', [票号]:'+nvedtTicketno.Text;
    log := log+', [班次号]:' +nvhlpschedule.Text;
    //保存操作日志
    SysLog.WriteLog('综合查询->预售票情况查询','查询', '查询条件有;'+log);
    Active:=true;
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);

    end
end;

end.
