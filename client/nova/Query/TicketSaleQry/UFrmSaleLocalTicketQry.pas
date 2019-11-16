unit UFrmSaleLocalTicketQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmSaleLocalTicketQry = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl5: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    dtpEdepartdate: TDateTimePicker;
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
    lbl6: TLabel;
    nvcbbSchOrgs: TNovaCheckedComboBox;
    lbl8: TLabel;
    nvhlpstartstation: TNovaHelp;
    blnfldResultisdepartinvoices: TBooleanField;
    edtTicketno: TNovaEdit;
    lbl17: TLabel;
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
    Label4: TLabel;
    nvhelpRoute: TNovaHelp;
    jcdsResultroutename: TWideStringField;
    ChkAllOrg: TCheckBox;
    jcdssellway: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jcdsResultcurrorgname: TWideStringField;
    jcdsResultorderno: TWideStringField;
    jcdsResultreturnway: TWideStringField;
    jcdsreturnway: TjsonClientDataSet;
    jcdsResultreturnwayname: TWideStringField;
    jcdsResultistaked: TWideStringField;
    jcdsResultsellway: TWideStringField;
    jcdsResultsellwayname: TWideStringField;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    jcdsResulttaketime: TWideStringField;
    jcdsResultolddepartdate: TDateField;
    CheckBox1: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpBreturnDateChange(Sender: TObject);
    procedure dtpEreturnDateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure ChkAllOrgClick(Sender: TObject);
    procedure dtpBdepartdateChange(Sender: TObject);
    procedure dtpEdepartdateChange(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmSaleLocalTicketQry: TfrmSaleLocalTicketQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmSaleLocalTicketQry.FormCreate(Sender: TObject);
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
  nvcbbSchOrgs.Active:=false;
  nvcbbSchOrgs.Active:=true;
  nvcbbSchOrgs.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmSaleLocalTicketQry.NovachkPorgCheckClick(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.dtpEselldateChange(Sender: TObject);
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


procedure TfrmSaleLocalTicketQry.ChkAllOrgClick(Sender: TObject);
begin
  inherited;
  if ChkAllOrg.Checked then
  begin
    nvckbOrgid.CheckAll(true);
  end
  else
  begin
    nvckbOrgid.CheckAll(false);
  end;
end;

procedure TfrmSaleLocalTicketQry.dtpBdepartdateChange(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.dtpBreturnDateChange(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.dtpEdepartdateChange(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.dtpEreturnDateChange(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.dtpBselldateChange(Sender: TObject);
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

procedure TfrmSaleLocalTicketQry.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    nvckbOrgid.SetFocus;
    exit;
  end;
    if nvcbbSchOrgs.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('请选择班次机构！');
    nvcbbSchOrgs.SetFocus;
    exit;
  end;
  if (not dtpBdepartdate.Checked) and (not dtpBselldate.Checked)  then
  begin
    SysDialogs.ShowMessage('请选择要查询的售票日期段或发车日期段！');
    exit;
  end;
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
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;



  with jcdsResult do
  begin
    Active:=False;
    if dtpBdepartdate.Checked then
    begin

      Params.ParamValues['qp.departSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)+' 00:00:00';
      Params.ParamValues['qp.departEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date)+' 23:59:59';
      Params.ParamValues['qp.isolddate'] := CheckBox1.Checked;
      log := log +' [发车日期] 从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);
    end
    else
    begin
      Params.ParamValues['qp.isolddate'] :=  false;
      Params.ParamValues['qp.departSdate'] :=  '';
      Params.ParamValues['qp.departEdate'] :=  '';
    end;
    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd ',dtpBselldate.DateTime)+' 00:00:00';
      Params.ParamValues['filter_LED_ts!selltime'] :=  formatdatetime('yyyy-mm-dd ',dtpEselldate.DateTime)+' 23:59:59';  //售票日期
      log := log +' ,[售票日期]从'+ DateToStr(dtpBselldate.DateTime)+'到'+DateToStr(dtpEselldate.DateTime);
     end
    else
    begin
      Params.ParamValues['filter_GED_ts!selltime'] :='';
      Params.ParamValues['filter_LED_ts!selltime'] :='';
    end;

    if dtpEreturnDate.Checked then
    begin
      Params.ParamValues['filter_LED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEreturnDate.DateTime)+' 00:00:00';
      Params.ParamValues['filter_GED_tr!returntime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBreturnDate.DateTime)+' 23:59:59';
      log := log +' ,[退票日期]从'+ DateToStr(dtpBreturnDate.DateTime)+'到'+DateToStr(dtpEreturnDate.DateTime);
    end
    else
    begin
       Params.ParamValues['filter_GED_tr!returntime'] :='';
       Params.ParamValues['filter_LED_tr!returntime'] :='';
    end;

    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;
     log := log +' ,[售票机构]:'+ nvckbOrgid.Text;

    Params.ParamValues['filter_INS_scheduleorg!id'] := nvcbbSchOrgs.GetSelectID;
    log := log +' ,[班次机构]:'+ nvcbbSchOrgs.Text;

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

       if trim(nvhelpReturnby.Text)<>''  then            //退票员
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

      if nvhlpstartstation.Id>0 then            //上车点
      begin
        Params.ParamValues['filter_EQL_sd!id']:=nvhlpstartstation.Id;
        log := log +' ,[上车点]:'+nvhlpstartstation.Text;
      end
      else
      begin
       Params.ParamValues['filter_EQL_sd!id']:='';
      end;

    if not (Trim(edtTicketno.Text) = '') then      //票号
      begin
        Params.ParamValues['filter_EQS_ts!ticketno']:= edtTicketno.Text;
        log := log+ ',[票号]:'+edtTicketno.Text+', ';
      end
    else
      begin
        Params.ParamValues['filter_EQS_ts!ticketno']:= '';
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

    //保存操作日志
    SysLog.WriteLog('综合查询->异站售本站票情况查询', '查询', '查询条件有;'+log);
    try
    Active:=true;
  except on e:Exception do
    ShowMessage(e.Message);
  end;
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
