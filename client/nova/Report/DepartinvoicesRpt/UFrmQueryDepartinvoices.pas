unit UFrmQueryDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryDepartinvoices = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    nvhelpUnit: TNovaHelp;
    jcdstypename: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    nvhelpVehicle: TNovaHelp;
    lbl2: TLabel;
    Label4: TLabel;
    nvcbbStatus: TNovaComboBox;
    Label9: TLabel;
    Label1: TLabel;
    nvcbbScheduletype: TNovaComboBox;
    dsDetail: TDataSource;
    jcdsDepartinvoicesDetail: TjsonClientDataSet;
    jcdsResultorgname: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultdepartdate: TDateField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultschedulecode: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultvehicletypname: TWideStringField;
    jcdsResultticketnum: TLargeintField;
    jcdsResulttotalamount: TFloatField;
    jcdsResultstationservicefee: TFloatField;
    jcdsResultprintip: TWideStringField;
    jcdsResultprintbyname: TWideStringField;
    jcdsResultprinttime: TDateTimeField;
    jcdsResultsupplyticketnum: TLargeintField;
    jcdsResultsupplyamount: TFloatField;
    jcdsResultsupplybalanceamount: TFloatField;
    wdstrngfldResultd1name: TWideStringField;
    jcdsResultd2name: TWideStringField;
    jcdsResultd3name: TWideStringField;
    jcdsResultd4name: TWideStringField;
    jcdsResults1name: TWideStringField;
    jcdsResults2name: TWideStringField;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResultworktype: TWideStringField;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultdepartstationname: TWideStringField;
    jcdsWorktkypename: TjsonClientDataSet;
    lbl7: TLabel;
    nvhelpUserid: TNovaHelp;
    nvedtTicketno: TNovaEdit;
    wdstrngfldResultdepartinvoicesno: TWideStringField;
    wdstrngfldResultworktypename: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    jcdsStatusname: TjsonClientDataSet;
    wdstrngfldResultstatusname: TWideStringField;
    lrgntfldResultseatnum: TLargeintField;
    grp3: TGroupBox;
    grp2: TGroupBox;
    dbgrdhroutestop: TNvDbgridEh;
    grp8: TGroupBox;
    nvdbgrdhWork: TNvDbgridEh;
    dsDeductdetail: TDataSource;
    jcdsDeductdetail: TjsonClientDataSet;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultothterfee: TFloatField;
    fltfldResultagentfee: TFloatField;
    fltfldResultbalanceamount: TFloatField;
    lbl8: TLabel;
    nvhlpBalanceunit: TNovaHelp;
    wdstrngfldResultbalanceunitname: TWideStringField;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    Label2: TLabel;
    cbbdepart: TNovaCheckedComboBox;
    jcdsResultmoreprice: TFloatField;
    Label3: TLabel;
    Label5: TLabel;
    DtpPrintstartdate: TDateTimePicker;
    DtpPrintenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure DtpPrintstartdateClick(Sender: TObject);
    procedure DtpPrintenddateChange(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure refreshDetail;
    procedure refreshdeductdetail;
  end;

var
  frmQueryDepartinvoices: TfrmQueryDepartinvoices;
implementation
    uses SystemInstance,SysInfoIntf,PubFn,UFrmticketsInfo;
{$R *.dfm}



procedure TfrmQueryDepartinvoices.DtpPrintstartdateClick(Sender: TObject);
begin
  inherited;
    if DtpPrintstartdate.Checked = True  then
    begin
       DtpPrintenddate.Checked := True;
    end;
   if  DtpPrintstartdate.Checked =False then
    begin
       DtpPrintenddate.Checked := False;
    end;
end;

procedure TfrmQueryDepartinvoices.DtpPrintenddateChange(Sender: TObject);
begin
  inherited;
    if DtpPrintenddate.Checked = True  then
    begin
       DtpPrintstartdate.Checked := True;
    end;
   if  DtpPrintenddate.Checked =False then
    begin
       DtpPrintstartdate.Checked := False;
    end;
end;

procedure TfrmQueryDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbStatus.Active:=False;
  nvcbbStatus.Active:=True;
  nvcbbScheduletype.Active := False;
  nvcbbScheduletype.Active := True;
  dtpBdepartdate.Date:=Now;
  dtpBdepartdate.Checked := False;
  dtpEdepartdate.Date:=Now;
  dtpEdepartdate.Checked := False;
  cbbdepart.Active := False;
  cbbdepart.Active := True;
  dtpprintstartdate.Date := now;
  DtpPrintenddate.Date :=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryDepartinvoices.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  refreshDetail;
  refreshdeductdetail
end;

procedure TfrmQueryDepartinvoices.refreshDetail;
begin
 if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jcdsDepartinvoicesDetail.Close;
    exit;
  end;
  with jcdsDepartinvoicesDetail do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_dtd!departinvoices.id']:= jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;
end;

procedure TfrmQueryDepartinvoices.refreshdeductdetail;
begin
 if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jcdsDeductdetail.Close;
    exit;
  end;
  with jcdsDeductdetail do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_ds!departinvoices.id']:= jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;
end;

procedure TfrmQueryDepartinvoices.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if Trim(cbbdepart.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择开运量单位！');
    Exit;
  end;
     jcdsResult.AfterScroll:=nil;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_s!orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_ds!departinvoicesno']:= nvedtTicketno.Text;
                                                                    //发车日期
    Params.ParamValues['filter_GED_ds!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);

    Params.ParamValues['filter_LED_ds!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if Trim(cbbdepart.Text) <> '' then                              //开运量单位
      Params.ParamValues['filter_INS_ds!printorgid'] := cbbdepart.GetSelectID
    else
      Params.ParamValues['filter_INS_ds!printorgid'] := '';

    if  (not (Trim(nvhelpUnit.Text) = '')) and  (nvhelpUnit.Id>0) then         //单位
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhelpUnit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

      if  (not (Trim(nvhlpBalanceunit.Text) = '')) and  (nvhlpBalanceunit.Id>0) then
      begin
        Params.ParamValues['filter_EQL_u2!id']:= nvhlpBalanceunit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_u2!id']:= '';
      end;

      if  (not (Trim(nvhlpschedule.Text) = '')) and  (nvhlpschedule.Id>0) then //班次号     //班次
      begin
        Params.ParamValues['filter_EQL_s!id']:= nvhlpschedule.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!id']:= '';
      end;

    if (not (Trim(nvhlproute.Text) = '')) and (nvhlproute.Id>0) then    //线路
      begin
        Params.ParamValues['filter_EQL_r!id']:= nvhlproute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_r!id']:= '';
      end;

   if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then //车辆
    begin
      Params.ParamValues['filter_EQL_v!id']:= nvhelpVehicle.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_v!id']:= '';
    end;

    if (not (Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id>0) then //打单员
    begin
      Params.ParamValues['printby']:= nvhelpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['printby']:= '';
    end;

       if nvcbbStatus.ItemIndex >= 0 then     //状态
      begin
        Params.ParamValues['filter_EQS_ds!status']:= nvcbbStatus.GetSelectCode;
      end
       else
      begin
        Params.ParamValues['filter_EQS_ds!status']:='';
      end;
       if nvcbbScheduletype.ItemIndex >= 0 then     //班次类型
      begin
        Params.ParamValues['filter_EQS_s!type']:= nvcbbScheduletype.GetSelectCode;
      end
       else
      begin
        Params.ParamValues['filter_EQS_s!type']:='';
      end;

      if DtpPrintstartdate.Checked then //打单日期
      begin
        Params.ParamValues['filter_GED_ds!printtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',DtpPrintstartdate.DateTime);
//        if formatdatetime('yyyy-mm-dd',DtpPrintstartdate.Date)
//              = formatdatetime('yyyy-mm-dd',DtpPrintenddate.Date) then
//             Params.ParamValues['filter_LED_ds!printtime'] := formatdatetime('yyyy-mm-dd',DtpPrintenddate.Date+1)
//        else
        Params.ParamValues['filter_LED_ds!printtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',DtpPrintenddate.DateTime);

        log :=' [打单日期]从'+DateToStr(DtpPrintstartdate.DateTime)+'到'+DateToStr(DtpPrintenddate.DateTime)+', ';
      end
      else
      begin
         Params.ParamValues['filter_GED_ds!printtime'] :=null;
         Params.ParamValues['filter_LED_ds!printtime'] :=null;
      end;


    Active:=true;

    log := '查询条件有：'+log+ ',[发车日期从] '+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
          +' 至 '+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     if Trim(nvckbOrgid.GetSelectID)<>'' then
      log := log+',[所属机构]：'+nvckbOrgid.Text;
    if Trim(cbbdepart.GetSelectID) <> '' then
      log := log +',[开运量单位]：'+cbbdepart.Text ;
    if nvhlproute.Id <> 0 then
      log := log +',[线路]：'+nvhlproute.Text ;
    if nvhlpschedule.Id <> 0 then
      log := log +',[班次号]：'+nvhlpschedule.Text ;
    if nvhelpUnit.Id <> 0 then
      log := log +',[车属单位]:'+nvhelpUnit.Text ;
    if nvhelpVehicle.Id <> 0 then
      log := log +',[营运车辆]:'+ nvhelpVehicle.Text;
    if nvhelpUserid.Id <> 0 then
      log := log +',[打单员]:'+ nvhelpUserid.Text;
    if Trim(nvedtTicketno.Text) <> '' then
      log := log +',[结算单号]:'+ nvedtTicketno.Text;
    if nvhlpBalanceunit.Id <> 0then
      log := log +',[结算单位]：' + nvhlpBalanceunit.Text;
     log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->班次结算情况查询','查询',log);

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
   +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    end;
    refreshDetail;
    refreshdeductdetail;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;

end;

procedure TfrmQueryDepartinvoices.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;
  FrmticketsInfo := TFrmticketsInfo.Create(self);
  with FrmticketsInfo do
  begin
   //departinvoiceid := jcdsResult.FieldByName('id').AsInteger;
      with jcdsTicketinfo do
      begin
        Active := False;
          Params.ParamValues['departinvoicesid']
                  := jcdsResult.FieldByName('id').AsInteger;

        Active := true;
      end;
    showModal;
  end;
end;

end.
