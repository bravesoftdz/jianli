unit UFrmQueryScheduleMiss;

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
  TfrmQueryScheduleMiss = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    jcdsStatusname: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl13: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    lbl7: TLabel;
    nvedtTicketno: TNovaEdit;
    chkIsLine: TCheckBox;
    chkIsnotLine: TCheckBox;
    chkIsOver: TCheckBox;
    chkIsNotOver: TCheckBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    chkIsnotcheck: TCheckBox;
    chkIscheck: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     log : string;
  public
    { Public declarations }
  end;

var
  frmQueryScheduleMiss: TfrmQueryScheduleMiss;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryScheduleMiss.FormCreate(Sender: TObject);
begin
  inherited;

  nvckbOrgid.Active := False;
  nvckbOrgid.Active := true;
  nvckbOrgid.CheckById(true, sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date := Now;
  // dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  // dtpEdepartdate.Checked := False;
end;

procedure TfrmQueryScheduleMiss.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime
    ('yyyymmdd', dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpEdepartdate.Date - dtpBdepartdate.Date) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    // Params.ParamValues['filter_INS_o!id']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['filter_INS_o!id'] := nvckbOrgid.GetSelectID;
    log := '班次机构'+nvckbOrgid.Text+',';
    if Trim(nvedtTicketno.Text)<>'' then
    begin
      Params.ParamValues['filter_EQS_ts!ticketno'] := Trim(nvedtTicketno.Text);
      log := log +'，票号'+ Trim(nvedtTicketno.Text)
    end
    else
    Params.ParamValues['filter_EQS_ts!ticketno'] := '';

                                       //发车日期
    Params.ParamValues['filter_GED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.Date);
      log := log+' 发车日期从'+DateToStr(dtpBdepartdate.DateTime)+
            '到'+DateToStr(dtpEdepartdate.DateTime)+', ';
   
    if (not(Trim(nvhlpschedule.Text) = '')) and (nvhlpschedule.Id > 0) then
    // 班次
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.HelpFieldValue
        ['id'];
        log := log+'班次号:'+nvhlpschedule.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end;

    if (not(Trim(nvhelpTicketoutlets.Text) = '')) and
      (nvhelpTicketoutlets.Id > 0) then // 售票点
    begin
      Params.ParamValues['filter_EQL_tos!id'] :=
        nvhelpTicketoutlets.HelpFieldValue['id'];
        log := log+'售票点:'+nvhelpTicketoutlets.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_tos!id'] := '';
    end;

    if (not(Trim(nvhlproute.Text) = '')) and (nvhlproute.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.HelpFieldValue['id'];
      log := log+'线路:'+nvhlproute.Text+',';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end;

   { if (not(Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id > 0) then
    begin
      Params.ParamValues['filter_EQL_v!id'] := nvhelpVehicle.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end;  }

    if chkIsnotLine.Checked then // 是否流水班
    begin
      if not(chkIsLine.Checked) then
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := 'true';
        log := log+'流水般,';
      end
      else
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := '';
      end;
    end
    else
    begin
      if chkIsLine.Checked then
      begin
        Params.ParamValues['filter_EQB_sp!islinework'] := 'false';
        log := log+'非流水班,';
      end;
    end;

    if chkIsNotOver.Checked then // 是否加班
    begin
      if not(chkIsOver.Checked) then
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := 'true';
        log := log+'加班班次,';
      end
      else
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := '';
      end;
    end
    else
    begin
      if chkIsOver.Checked then
      begin
        Params.ParamValues['filter_EQB_sp!isovertime'] := 'false';
        log := log+'正班,';
      end;
    end;

    if not chkIsnotcheck.Checked  and chkIscheck.Checked  then    //是否已检
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:='true';
         log := log+'车票已检,';
      end
      else if not chkIscheck.Checked  and chkIsnotcheck.Checked then
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:='false';
         log := log+'车票未检,';
      end
      else
      begin
         Params.ParamValues['filter_EQB_ts!ischecked']:=null;
      end;
    Active := true;
    //保存操作日志
    SysLog.WriteLog('班次漏乘情况查询', '综合查询', '查询条件有;'+log);
    log := '';
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '发车日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpBdepartdate.Date) + ' 至' + FormatDateTime
      ('yyyy-mm-dd', dtpEdepartdate.Date);
  end
end;

end.
