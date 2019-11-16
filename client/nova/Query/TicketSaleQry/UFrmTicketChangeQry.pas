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
    Params.ParamValues['filter_GED_ots!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ots!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    log := log +' [发车日期] 从'+ DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime);

    if dtpBchangedate.Checked then
    begin
      Params.ParamValues['filter_GED_c!changetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpBchangedate.DateTime);
      Params.ParamValues['filter_LED_c!changetime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEchangedate.DateTime);  //售票日期
      log := log +' [改签日期]从'+ DateToStr(dtpBchangedate.DateTime)+'到'+DateToStr(dtpEchangedate.DateTime)
    end
    else
    begin
      Params.ParamValues['filter_GED_c!changetime'] := '';
      Params.ParamValues['filter_LED_c!changetime'] := '';
    end;

    if nvcbbPaymethod.ItemIndex >= 0 then     //支付方式
      begin
        Params.ParamValues['filter_EQS_nts!paymethod']:= nvcbbPaymethod.GetSelectCode;
      end
    else
      begin
        Params.ParamValues['filter_EQS_nts!paymethod']:='';
      end;

    Params.ParamValues['filter_INS_ots!orgid']:= nvckbOrgid.GetSelectID;
    log := log +' ,[机构] '+nvckbOrgid.Text;

    if nvhelpSellby.Id>0 then                   //售票员
      begin
        Params.ParamValues['filter_EQL_ots!sellby']:= nvhelpSellby.HelpFieldValue['id'];
        log := log +' ,[售票员];'+nvhelpSellby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_ots!sellby']:= '';
      end;

    Params.ParamValues['filter_INS_ct!id']:= nvcbbTickeoutlets.GetSelectID;
    log:= log +' ,[改签点];'+ nvcbbTickeoutlets.Text;

    if nvhelpChangeby.Id>0 then                   //改签人
      begin
        Params.ParamValues['filter_EQL_c!changeby']:= nvhelpChangeby.HelpFieldValue['id'];
        log := log +' ,[改签人];'+nvhelpChangeby.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_c!changeby']:= '';
      end;

    if nvhlpschedule.Id>0 then                   //原班次
      begin
        Params.ParamValues['filter_EQL_os!id']:= nvhlpschedule.HelpFieldValue['id'];
        log := log +' ,[原班次];'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_os!id']:= '';
      end;
    Params.ParamValues['filter_EQS_c!changeticketno']:= changeticketno.text;
    Params.ParamValues['filter_EQS_nts!ticketno']:= nvedtTicketno.Text;
    log := log +' ,[新票号];'+nvedtTicketno.Text;
    Params.ParamValues['filter_EQS_ots!ticketno']:=  nvedtOldTicketno.Text;
    log := log +' ,[原票号];'+nvedtOldTicketno.Text;

    //保存操作日志
    SysLog.WriteLog('综合查询->车票改签查询', '查询', '查询条件有;'+log);
    Active:=true;
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBchangedate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='改签日期：'+ formatdatetime('yyyy-mm-dd',dtpBchangedate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEchangedate.Date);
     end;
    end
end;

end.

