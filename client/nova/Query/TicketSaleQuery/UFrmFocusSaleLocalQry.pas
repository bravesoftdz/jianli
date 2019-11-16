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
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if Trim(nvckbOrgid.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    Exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);  //发车日期
    log := log +' [发车日期] 从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBselldate.DateTime);
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEselldate.DateTime);  //售票日期
      log := log +' ,[售票日期]从'+ DateToStr(dtpBselldate.DateTime)+'到'+DateToStr(dtpEselldate.DateTime);
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
      log := log +' ,[退票日期]从'+ DateToStr(dtpBreturnDate.DateTime)+'到'+DateToStr(dtpEreturnDate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_tr!returntime'] :='';
       Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    Params.ParamValues['filter_INS_ts!orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_INS_org!id']:= SysInfo.LoginUserInfo.OrgID;
     log := log +' ,[班次机构]:'+ nvckbOrgid.Text;
    if nvcbbticketstatus.ItemIndex >= 0 then     //车票状态
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:= nvcbbticketstatus.GetSelectCode;
        log := log +' ,[车票状态]:'+nvcbbticketstatus.Text;
      end
       else
      begin
        Params.ParamValues['filter_EQS_ts!ticketstatus']:='';
      end;

    if nvhelpTicketoutlets.Id>0 then            //售票点
      begin
        Params.ParamValues['filter_EQL_ts!ticketoutletsid']:=nvhelpTicketoutlets.Id;
         log := log +' ,[售票点]:' +nvhelpTicketoutlets.Text;
      end
    else
      begin
       Params.ParamValues['filter_EQL_ts!ticketoutletsid']:='';
      end;


     if nvhelpReturnsation.Id>0 then            //退票点
      begin
        Params.ParamValues['filter_EQL_tr!ticketoutletsid']:=nvhelpReturnsation.Id;
        log := log +' ,[退票点]:' +nvhelpReturnsation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_tr!ticketoutletsid']:='';
       end;

       if nvhelpReturnby.Id>0 then            //退票员
      begin
        Params.ParamValues['filter_EQL_tr!returnby']:=nvhelpReturnby.Id;
         log := log +' ,[退票员]:'+nvhelpReturnby.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_tr!returnby']:='';
       end;

       if nvhelpendstation.Id>0 then            //到达站
      begin
        Params.ParamValues['filter_EQL_ts!reachstationid']:=nvhelpendstation.Id;
        log := log +' ,[到达站]:'+nvhelpendstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_ts!reachstationid']:='';
       end;
    //保存操作日志
    SysLog.WriteLog('综合查询->集中式异站售本站票情况查询', '查询', '查询条件有;'+log);
    Active:=true;
    log := '';
       dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBselldate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
     end;
  end;
end;
end.
