unit UFrmQueryRemoteTicketsell;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TfrmQueryRemoteTicketsell = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl5: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl1: TLabel;
    nvhelpendstation: TNovaHelp;
    wdstrngfldResultreachname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    blnfldResultisdepartinvoices: TBooleanField;
    lbl16: TLabel;
    nvhcbbTickettype: TNovaHComboBox;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl7: TLabel;
    dtpBselldate: TDateTimePicker;
    lbl14: TLabel;
    dtpEselldate: TDateTimePicker;
    jcdsPaymethod: TjsonClientDataSet;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultpaymethodname: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketstatusname: TWideStringField;
    jcdsSellway: TjsonClientDataSet;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultsellwayname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    blnfldResultislinework: TBooleanField;
    intgrfldResultcarrychildnum: TIntegerField;
    lrgntfldResultdistance: TLargeintField;
    fltfldResultfullprice: TFloatField;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultticketentrance: TWideStringField;
    wdstrngfldResultbuspark: TWideStringField;
    wdstrngfldResultsellip: TWideStringField;
    fltfldResultotherfee: TFloatField;
    dtmfldResultchecktime: TDateTimeField;
    dtmfldResultdepartinvoicestime: TDateTimeField;
    jcdsResultcomputefee: TFloatField;
    jcdsResultcoolairfee: TFloatField;
    jcdsResultadditionfee: TFloatField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultvehicletypename: TWideStringField;
    nvhlpschedule: TNovaHelp;
    jcdsResultmoreprice: TFloatField;
    jcdsResultselltime: TDateTimeField;
    nvcbbOrgid: TNovaCheckedComboBox;
    fltfldResultservicefee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultserviceprice: TFloatField;
    nvhlpDeparts: TNovaHelp;
    lbl13: TLabel;
    nvcbbticketstatus: TNovaComboBox;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultdiscountrate: TFloatField;
    jcdsResultticketoutletsname: TWideStringField;
    jcdsResultbatchno: TWideStringField;
    jcdsResulttoplimitprice: TFloatField;
    jcdsResultSEATTYPE: TWideStringField;
    jsonSeattype: TjsonClientDataSet;
    jcdsResultseattypevalue: TWideStringField;
    jcdsResultorderno: TWideStringField;
    jcdsResultchecktype: TWideStringField;
    Label4: TLabel;
    nvhelpRoute: TNovaHelp;
    jcdsResulttickettype: TWideStringField;
    blnfldResultischecked: TBooleanField;
    jcdsResultsubtotal: TFloatField;
    jcdsResulttickettypename: TWideStringField;
    jcdsResultcorgname: TWideStringField;
    Label1: TLabel;
    nvcbbcheckOrgid: TNovaCheckedComboBox;
    jcdsCheckType: TjsonClientDataSet;
    jcdsResultchecktypevalue: TWideStringField;
    Label2: TLabel;
    nvcbbsellorgid: TNovaCheckedComboBox;
    lbl3: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    jcdsResultsellorgname: TWideStringField;
    Label3: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    jcdsResultdepartdate: TDateField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);

  private
    { Private declarations }
    log: string;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  frmQueryRemoteTicketsell: TfrmQueryRemoteTicketsell;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryRemoteTicketsell.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True then
  begin
    dtpBselldate.Checked := True;
  end;
  if dtpEselldate.Checked = False then
  begin
    dtpBselldate.Checked := False;
  end;
end;

procedure TfrmQueryRemoteTicketsell.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True then
  begin
    dtpEselldate.Checked := True;
  end;
  if dtpBselldate.Checked = False then
  begin
    dtpEselldate.Checked := False;
  end;
end;

procedure TfrmQueryRemoteTicketsell.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  NovachkPorg.Active := False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick := nil;
  NovachkPorg.CheckById(True, SysInfo.LoginUserInfo.POrgID);
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(True, SysInfo.LoginUserInfo.OrgID);

  nvcbbcheckOrgid.Active := False;
  nvcbbcheckOrgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
  nvcbbcheckOrgid.Active := True;
  nvcbbcheckOrgid.CheckById(True, SysInfo.LoginUserInfo.OrgID);

  nvcbbsellorgid.Active := False;
  nvcbbsellorgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
  nvcbbsellorgid.Active := True;
  nvcbbsellorgid.CheckById(True, SysInfo.LoginUserInfo.OrgID);

  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active := True;
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  dtpBdepartdate.Date := Now;
  dtpEdepartdate.Date := Now;
  dtpBselldate.Date := Now;
  dtpEselldate.Date := Now;
  jcdsPaymethod.Active := False;
  jcdsPaymethod.Active := True;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  jcdsSellway.Active := False;
  jcdsSellway.Active := True;
  jcdsCheckType.Active := False;
  jcdsCheckType.Active := True;
  jsonSeattype.Active := False;
  jsonSeattype.Active := True;
  dtpBselldate.Checked := True;
  dtpEselldate.Checked := True;
end;

procedure TfrmQueryRemoteTicketsell.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  // if GUIDToString(Key) = '{ED973E13-5A4F-43DD-9C21-351C3A7303D2}' then
  // // 查询其它售票员的售票记录
  // begin
  // // nvhelpUserid.Visible:=aEnable;
  // // lbl6.Visible:=aEnable;
  // // nvhelpUserid.Enabled:=aEnable;
  // // if not aEnable then
  // // begin
  // // nvhelpUserid.Text:=SysInfo.LoginUserInfo.UserName;
  // // nvhelpUserid.Id:=SysInfo.LoginUserInfo.UserID;
  // // end;
  // end
end;

procedure TfrmQueryRemoteTicketsell.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID <> '' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(True);

    nvcbbcheckOrgid.Active := False;
    nvcbbcheckOrgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
    nvcbbcheckOrgid.Active := True;
    nvcbbcheckOrgid.CheckAll(True);

    nvcbbsellorgid.Active := False;
    nvcbbsellorgid.Params.ParamValues['orgids'] := NovachkPorg.GetSelectID;
    nvcbbsellorgid.Active := True;
    nvcbbsellorgid.CheckAll(True);
  end;
end;

procedure TfrmQueryRemoteTicketsell.tbtnFilterClick(Sender: TObject);

var
  num: Tdatetime;
begin
  inherited;
  nvcbbOrgid.SetFocus;
  if (nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '') then
  begin
    SysDialogs.ShowMessage('请选择发车机构机构！');
    nvcbbOrgid.SetFocus;
    exit;
  end;
  { if (nvcbbcheckOrgid.GetCount = 0) or (nvcbbcheckOrgid.Text = '') then
    begin
    SysDialogs.ShowMessage('请选择检票机构！');
    nvcbbcheckOrgid.SetFocus;
    exit;
    end;
    }
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd',
      dtpBselldate.Date) > FormatDateTime('yyyymmdd', dtpEselldate.Date)) then
  begin
    SysDialogs.ShowMessage('售票开始日期不能大于结束日期！');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime
      ('yyyymmdd', dtpEdepartdate.Date)) then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', SysInfo.LoginUserInfo.OrgID)) <= trunc
      (dtpEdepartdate.Date - dtpBdepartdate.Date)) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数(' + getParametervalue('0006',
        SysInfo.LoginUserInfo.OrgID) + '),请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    log := '查询条件有：';
    if (Trim(nvedtTicketno.Text) = '') and (Trim(nvhlpschedule.Text) = '') and
      (Trim(nvhelpRoute.Text) = '') and (Trim(nvhlpDeparts.Text) = '') and
      (Trim(nvhelpendstation.Text) = '') and (nvhcbbTickettype.ItemIndex < 0)
      and (nvcbbticketstatus.GetSelectID <= 0)

      then
    begin
      if (FormatDateTime('yyyy-mm-dd', dtpBdepartdate.Date) <> FormatDateTime
          ('yyyy-mm-dd', dtpEdepartdate.Date)) then
      begin
        if (not dtpBselldate.Checked) or ((FormatDateTime('yyyy-mm-dd',
              dtpBselldate.Date) <> FormatDateTime('yyyy-mm-dd',
              dtpEselldate.Date))) then
        begin
          ShowMessage('没有输入查询条件，只查询一天的数据');
          exit;
        end;
      end;
    end;
    Params.ParamValues['filter_GED_rt!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_rt!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.Date);
    log := ' [发车日期]从' + DateToStr(dtpBdepartdate.DateTime) + '到' + DateToStr
      (dtpEdepartdate.DateTime) + ', ';

    if dtpBselldate.Checked then // 售票日期
    begin

      Params.ParamValues['filter_GED_rt!selltime'] := FormatDateTime
        ('yyyy-mm-dd', dtpBselldate.DateTime);
      Params.ParamValues['filter_LED_rt!selltime'] := FormatDateTime
        ('yyyy-mm-dd', dtpEselldate.DateTime + 1);
      log := ' [售票日期]从' + DateToStr(dtpBselldate.DateTime) + '到' + DateToStr
        (dtpEselldate.DateTime) + ', ';
    end
    else
    begin
      Params.ParamValues['filter_GED_rt!selltime'] := null;
      Params.ParamValues['filter_LED_rt!selltime'] := null;
    end;

    if not(Trim(nvhlpschedule.Text) = '') then // 班次
    begin
      Params.ParamValues['filter_EQS_rt!schedulecode'] := nvhlpschedule.Text;
      log := log + ',[班次号]:' + nvhlpschedule.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_rt!schedulecode'] := null;
    end;

    if (nvhelpRoute.Id >0) then // or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhelpRoute.id;
      log := log + ',[线路]:' + nvhelpRoute.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := null;
    end;

    if not(Trim(nvedtTicketno.Text) = '') then // 票号
    begin
      Params.ParamValues['filter_EQS_rt!ticketno'] := nvedtTicketno.Text;
      log := log + ',[票号]:' + nvedtTicketno.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_rt!ticketno'] := null;
    end;

    if (Trim(nvhlpDeparts.Text) <> '') then // or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_rt!departstationid'] := nvhlpDeparts.id;
      log := log + ',[发车站]:' + nvhlpDeparts.Text;
    end
    else
      Params.ParamValues['filter_EQL_rt!departstationid'] := '';

    if (Trim(nvhelpendstation.Text) <> '') then // or (nvhelpendstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_rt!reachstationid'] := nvhelpendstation.id;
      // HelpFieldValue['id'];
      log := log + ',[到达站]:' + nvhelpendstation.Text;
    end
    else
      Params.ParamValues['filter_EQL_rt!reachstationid'] := '';

    if nvcbbticketstatus.ItemIndex >= 0 then
    begin
      Params.ParamValues['filter_EQS_rt!ticketstatus'] :=
        nvcbbticketstatus.GetSelectCode;
      log := log + ',[车票状态]:' + nvcbbticketstatus.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_rt!ticketstatus'] := null;
    end;

    if nvhcbbTickettype.ItemIndex >= 0 then
    begin
      Params.ParamByName('filter_EQS_rt!tickettype').Value :=
        nvhcbbTickettype.HelpFieldValue['code'];
      log := log + ',[车票类型]:' + nvhcbbTickettype.Text;
    end
    else
      Params.ParamByName('filter_EQS_rt!tickettype').Value := null;

    if (Trim(nvhelpRoute.Text) <> '') then // or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhelpRoute.id;
      log := log + ',[线路]:' + nvhelpRoute.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := null;
    end;
    Params.ParamValues['filter_INS_rt!departorgid'] := nvcbbOrgid.GetSelectID;
    if (nvcbbcheckOrgid.GetCount = 0) or (nvcbbcheckOrgid.Text = '') then
      Params.ParamValues['filter_INS_rt!checkorgid'] := ''
    else
      Params.ParamValues['filter_INS_rt!checkorgid'] :=
        nvcbbcheckOrgid.GetSelectID;

    if (nvcbbsellorgid.GetCount = 0) or (nvcbbsellorgid.Text = '') then
      Params.ParamValues['filter_INS_rt!ticketsellorgid'] := ''
    else
      Params.ParamValues['filter_INS_rt!ticketsellorgid'] :=
        nvcbbsellorgid.GetSelectID;

    Active := True;
    log := log + ',[发车机构]:' + nvcbbOrgid.Text + ',检票机构:' + nvcbbcheckOrgid.Text;
    // 保存操作日志
    log := log + '。[查询结果]:返回 ' + inttostr(RecordCount) + ' 条记录！';
    SysLog.WriteLog('综合查询->远程检票查询', '查询', log);
  end;

end;

end.
