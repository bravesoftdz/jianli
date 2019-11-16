unit UFrmQueryBalanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services, NovaPrint,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic, Generics.Collections,
  NovaHComboBox, UFrmBalaceDetail,UFrmQryBalancedetailPrint,AcReport_TLB,AcRptUtils2,
  OleServer,UFrmQryCollectdetail;

type
  TfrmQueryBalanced = class(TSimpleCRUDForm)
    jcdsSchedulestatus: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    nvcbbNovaCkbOrg: TNovaCheckedComboBox;
    dtpBalancedStart: TDateTimePicker;
    dtpBalancedEnd: TDateTimePicker;
    NovaHelpUnit: TNovaHelp;
    NovaEdtInvoicesno: TNovaEdit;
    nvhelpUserid: TNovaHelp;
    lbl8: TLabel;
    lbl4: TLabel;
    NovaEditIP: TNovaEdit;
    jscdcancelBalance: TjsonClientDataSet;
    Label1: TLabel;
    cbbStatus: TComboBox;
    jscdQryDeducts: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    lbl6: TLabel;
    nvhlpvehicle: TNovaHelp;
    jcdsisHaveDepartinvoice: TjsonClientDataSet;
    jcdsQryTotalDetail: TjsonClientDataSet;
    DataSource2: TDataSource;
    AcRptEngineTotalDeatil: TAcRptEngine;
    btn1: TToolButton;
    NovaHelpContractor: TNovaHelp;
    jcdsbalanceACPrint: TjsonClientDataSet;
    DataSource3: TDataSource;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    function StringToDateTime(ADateTimeStr: string): TDateTime;
    procedure tbtnbalancedetailClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    deductprinttype: String;
    parameter: String;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    multipleValueValue: TDictionary<String, String>;
    rpt_path:string;
    parameter4017 : Boolean;

    procedure balanceACPrint(balanceid: Int64);
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  frmQueryBalanced: TfrmQueryBalanced;

implementation

uses SystemInstance, SysInfoIntf, PubFn,DateUtils;
{$R *.dfm}

procedure TfrmQueryBalanced.tbtnbalancedetailClick(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;

  baid := jcdsResult.FieldByName('id').AsString;
  FrmQryCollectdetail:=TFrmQryCollectdetail.Create(Self);
  with FrmQryCollectdetail do
  begin

    with jcdsResultdetail do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := baid;
      Active := True;
    end;
     ShowModal;
  end;
end;

procedure TfrmQueryBalanced.btn1Click(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  baid := jcdsResult.FieldByName('id').AsString;
  FrmQryCollectdetail:= TFrmQryCollectdetail.Create(self);
  with FrmQryCollectdetail do
  begin
    caption := '结算单明细信息';
    with jcdsResultdetail do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := baid;
      Active := True;
    end;
    ShowModal;
  end;
end;

procedure TfrmQueryBalanced.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbNovaCkbOrg.Active := False;
  nvcbbNovaCkbOrg.Active := True;
//  NovaHelpUnit.Active:=false;
//  NovaHelpUnit.Active:=true;
  dtpBalancedStart.Date := Now;
  dtpBalancedEnd.Date := Now;
  AcRptEngineTotalDeatil := TAcRptEngine.Create(nil);
//  rpt_path := ExtractFilePath(ParamStr(0)) + '\reports\';
  rpt_path := ExtractFilePath(ParamStr(0));
  parameter4017:= getParametervalue('4017', SysInfo.LoginUserInfo.OrgID) = '1';
end;

procedure TfrmQueryBalanced.FormShow(Sender: TObject);
var
  balancetype: string;
  isHaveDepart: integer;
begin
  inherited;
  parameter := getParametervalue('4005', SysInfo.LoginUserInfo.OrgID);
  balancetype := getParametervalue('4008', SysInfo.LoginUserInfo.OrgID);
  deductprinttype := getParametervalue('4012', SysInfo.LoginUserInfo.OrgID);
  if balancetype = '0' then
  begin
    dbgrdhResult.Columns[17].Visible := False;
    dbgrdhResult.Columns[16].Title.caption := '违规罚款';
  end
  else
  begin
    dbgrdhResult.Columns[17].Visible := True;
    dbgrdhResult.Columns[16].Title.caption := '暂扣金额';
  end;
  with jcdsisHaveDepartinvoice do
  begin
    Active := False;
    Active := True;
    if RecordCount>0 then
    begin
       isHaveDepart := FieldByName('isHaveDepart').AsInteger;
       if isHaveDepart=1 then
       begin
           tbtnSave.Visible:=true;
           tbtnCancel.Visible:=true;
       end
       else
       begin
           tbtnSave.Visible:=false;
           tbtnCancel.Visible:=false;
       end;

    end
    else
    begin
       tbtnSave.Visible:=false;
       tbtnCancel.Visible:=false;
    end;
  end;
  dbgrdhResult.GridUser := Sysinfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryBalanced.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  // 补打
  if GUIDToString(Key) = '{2894E405-46C9-4D0D-A2EF-FAB7FF57DB16}' then //
  begin
    tbtnInsert.Visible := aEnable;
  end;
  // 注销
  if GUIDToString(Key) = '{98EFEEED-5C79-48B0-966D-AB0A5645CDE3}' then //
  begin
    tbtnDelete.Visible := aEnable;
  end;
  // 路单明细
  if GUIDToString(Key) = '{D6261953-A6D0-4B47-BB44-D08B87A2356D}' then //
  begin
    tbtnSave.Visible := aEnable;
  end;
  // 路单明细打印
  if GUIDToString(Key) = '{9D9DDDA1-FCCF-4862-9BB5-4CDE85B26A1B}' then //
  begin
    tbtnCancel.Visible := aEnable;
  end;

end;

procedure TfrmQueryBalanced.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  // 查询扣费明细
  with jscdQryDeducts do
  begin
    Active := False;
    Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsString;
    Active := True;
    if recordcount = 0 then
      jscdQryDeducts.Close;
  end;
end;

procedure TfrmQueryBalanced.tbtnCancelClick(Sender: TObject);
var
 ADataset: TDataset;
 actualbalanceprice : string;
 totaldeductfee : Currency;
begin
   if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('该结算通知单已经注销！');
    exit;
  end;
  totaldeductfee := 0;
  with jcdsQryTotalDetail do
  begin
    Active := false;
     Params.ParamValues['balanceid'] :=jcdsResult.FieldByName('id').AsLargeInt;
    Active := true;
    if RecordCount>0 then
    begin
       ADataset:=DataSource2.DataSet;
       AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');
       AcRptEngineTotalDeatil.SetReportFile(rpt_path+'departdetail.apt');
       AcRptEngineTotalDeatil.AddGlobalVariable('fromdepart', FormatDateTime
      ('yyyy-mm-dd', jcdsResult.FieldByName('departstartdate').AsDateTime));
       AcRptEngineTotalDeatil.AddGlobalVariable('todepart', FormatDateTime
      ('yyyy-mm-dd', jcdsResult.FieldByName('departenddate').AsDateTime));
       AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', jcdsResult.FieldByName('balanceno').AsString);
       if jcdsResult.FieldByName('balanceobject').AsString = '0' then
       begin
          AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', jcdsResult.FieldByName('objectname').AsString);
      end
      else
      begin
         AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', jcdsResult.FieldByName('vehicleno').AsString);
      end;

       AcRptEngineTotalDeatil.AddGlobalVariable('invoincenum', jcdsResult.FieldByName('invoicesnum').AsString);
       with jscdQryDeducts do
      begin
        Active := False;
        Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsLargeInt;
        Active := True;
        if recordcount > 0 then
        begin
          first;
          while (not eof) do
          begin
             totaldeductfee := totaldeductfee + StrToCurr(FieldByName('deductmoney').AsString);
            next;
          end;
        end;
      end;

       AcRptEngineTotalDeatil.AddGlobalVariable('deductfee', totaldeductfee);

       AcRptEngineTotalDeatil.AddGlobalVariable('balancedate',jcdsResult.FieldByName('balancemonth').AsString);
     AcRptEngineTotalDeatil.AddGlobalVariable('actualbalancepriceDaxie', moneyToChinaStr(StrToCurr(jcdsResult.FieldByName('balancemoney').AsString)));
     AcRptEngineTotalDeatil.AddGlobalVariable('actualbalanceprice', jcdsResult.FieldByName('balancemoney').AsString);
      AcRptEngineTotalDeatil.AddGlobalVariable('strroutename', jcdsResult.FieldByName('routename').AsString);

//       AcRptEngineTotalDeatil.ShowDesigner;  //开发模式
       AcRptEngineTotalDeatil.Preview;     //预览模式
    end;

  end;

end;

procedure TfrmQueryBalanced.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult,strdate: String;
  curid,daylimit,betweenday: Int64;
  startdate,enddate:TDateTime;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.recordcount = 0) then
  begin
    exit;
  end;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('该结算通知单已经注销！');
    exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要注销该结算通知单吗？') then
    exit;
  //增加参数4016 控制可以注销的时间限制
  if (getParametervalue('4016', SysInfo.LoginUserInfo.OrgID)<>'0') then
  begin
    daylimit:= strtoint(getParametervalue('4016', SysInfo.LoginUserInfo.OrgID));
    strdate := jcdsResult.FieldByName('balancemonth').AsString+' '+jcdsResult.FieldByName('balancetime').AsString;
    startdate:= Self.StringToDateTime(strdate);
    enddate:=Self.StringToDateTime(FormatDateTime('yyyy-mm-dd hh:mm:ss',Now));
    betweenday:= DaysBetween(startdate, enddate);
    if daylimit<>0 then
    begin
      if (betweenday>daylimit) then
      begin
        SysDialogs.ShowMessage('只能注销'+inttostr(daylimit)+'天内的结算单！');
         exit;
      end;
    end;
  end;

  try
    with jscdcancelBalance do
    begin
      Active := False;
      curid := jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamValues['balanceid'] := curid;
      Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end
      else
        SysDialogs.Warning(sResult);
    end;
  except
    on E: exception do
    begin
      screen.Cursor := crDefault;
      SysLog.WriteErr('注销结账单数据失败：' + E.Message);
    end;
  end;
end;

procedure TfrmQueryBalanced.tbtnEditClick(Sender: TObject);
var
  baid: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  baid := jcdsResult.FieldByName('id').AsString;
  frmBalaceDetail := TfrmBalaceDetail.Create(self);
  with frmBalaceDetail do
  begin
    caption := '结算单明细信息';
    with jcdsResultdetial do
    begin
      Active := False;
      Params.ParamValues['filter_EQL_ds!balance.id'] := baid;
      Active := True;
    end;
    ShowModal;
  end;
end;

procedure TfrmQueryBalanced.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpBalancedStart.Date)>FormatDateTime('yyyymmdd',
     dtpBalancedEnd.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期!');
      exit;
    end;

  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := False;
    if nvcbbNovaCkbOrg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_o!id'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_o!id'] := nvcbbNovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_GED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedStart.DateTime);
    Params.ParamValues['filter_LED_b!balancetime'] := formatdatetime
      ('yyyy-mm-dd', dtpBalancedEnd.DateTime) + ' 23:59:59';
    Params.ParamValues['filter_LIKES_b!balanceip'] := NovaEditIP.Text;
    Params.ParamValues['filter_EQS_b!balanceno'] := NovaEdtInvoicesno.Text;
    //新增结算车辆  李电志  2015年8月12日 10:37:40
    if nvhlpvehicle.Id <> 0 then
    begin
      Params.ParamValues['filter_LIKES_b!vehicleno'] := nvhlpvehicle.Text;
    end
    else
    begin
      Params.ParamValues['filter_LIKES_b!vehicleno'] := '';
    end;

    if (not(Trim(NovaHelpUnit.Text) = '')) and (NovaHelpUnit.Id > 0) then
    // 单位
    begin
      Params.ParamValues['filter_EQL_b!objectid'] := NovaHelpUnit.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_b!objectid'] := '';
    end;

//    if (not(Trim(NovaHelpContractor.Text) = '')) and (NovaHelpContractor.Id > 0) then // 承包者
//    begin
//      Params.ParamValues['filter_EQL_co!id'] := NovaHelpContractor.HelpFieldValue['id'];
//    end
//    else
//    begin
//      Params.ParamValues['filter_EQL_co!id'] := '';
//    end;

    if (not(Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id > 0) then
    // 结帐人
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpUserid.HelpFieldValue
        ['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    if self.cbbStatus.ItemIndex = 1 then
      Params.ParamValues['filter_EQS_b!status'] := '0'
    else if cbbStatus.ItemIndex = 2 then
      Params.ParamValues['filter_EQS_b!status'] := '1'
    else
      Params.ParamValues['filter_EQS_b!status'] := null;
    Active := True;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
    if jcdsResult.recordcount > 0 then
      jcdsResultAfterScroll(nil)
    else
      jscdQryDeducts.Close;
    log := '查询条件有：[结账日期]从 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.Date) + ' 至 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.Date);
    if Trim(nvcbbNovaCkbOrg.Text) <> '' then
      log := log + ',[所属机构]：' + nvcbbNovaCkbOrg.Text;
    if Trim(NovaEdtInvoicesno.Text) <> '' then
      log := log + ',[结算单号]:' + NovaEdtInvoicesno.Text;
    if Trim(NovaEditIP.Text) <> '' then
      log := log + ',[IP]:' + NovaEditIP.Text;
    if Trim(nvhelpUserid.Text) <> '' then
      log := log + ',[结账人]：' + nvhelpUserid.Text;
    if Trim(NovaHelpUnit.Text) <> '' then
      log := log + ',[车属单位]：' + NovaHelpUnit.Text;
    if Trim(NovaHelpContractor.Text) <> '' then
      log := log + ',[承包者]：' + NovaHelpContractor.Text;

    log := log + '。[查询结果]:返回 ' + inttostr(recordcount) + ' 条记录！';
    SysLog.WriteLog('结算管理->已结算查询', '查询', log);
  end;end;procedure TfrmQueryBalanced.balanceACPrint(balanceid: Int64);var
  ADataset1: TDataSet;
begin
  inherited;
  with jcdsbalanceACPrint do
  begin
     Active := false;
     Params.ParamValues['balanceid'] := balanceid;
     Active := true;
//    if RecordCount>0 then
//    begin
     ADataset1:=DataSource3.DataSet;
     AddCommonDatasetToAcReport(ADataset1,AcRptEngineTotalDeatil,'detail');
     AcRptEngineTotalDeatil.SetReportFile(rpt_path+'BalanceACPrint.apt');
     AcRptEngineTotalDeatil.AddGlobalVariable('stationname',  SysInfo.LoginUserInfo.ticketoutletsname);  // 车站简称
     AcRptEngineTotalDeatil.AddGlobalVariable('stationfullname', SysInfo.LoginUserInfo.OrgName + '客运收入结算汇总单');  //车站全名
     AcRptEngineTotalDeatil.AddGlobalVariable('qryfromdate', formatdatetime('yyyy-mm-dd', dtpBalancedStart.DateTime)); //查询开始时间
     AcRptEngineTotalDeatil.AddGlobalVariable('qrytodate', formatdatetime('yyyy-mm-dd', dtpBalancedEnd.DateTime));     //查询结束时间
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit',jcdsResult.FieldByName('objectname').AsString); // 结算单位
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);  //打单人
     //结算金额              floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide))
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamount', jcdsResult.FieldByName('dibalanceablemoney').AsString);
     //结算单张数
     AcRptEngineTotalDeatil.AddGlobalVariable('depcount', jcdsResult.FieldByName('invoicesnum').AsString);
     //客运代理费                                                   floattostr(strtofloat(NovaEdtagentfee.Text) * divide)
     AcRptEngineTotalDeatil.AddGlobalVariable('agentfee', floattostr(jcdsResult.FieldByName('diagentfee').asfloat*jcdsResult.FieldByName('divide').asFloat));
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno',jcdsResult.FieldByName('balanceno').AsString );
//         AcRptEngineTotalDeatil.ShowDesigner;  //开发模式
     AcRptEngineTotalDeatil.Preview;     //预览模式

//    end;
  end;

  ModalResult := mrok;

end;
procedure TfrmQueryBalanced.tbtnInsertClick(Sender: TObject);
var
  balanceid: Int64;
  deductifee,deductifee1, ticketitemsum, divide, stationfee, otherfee, agentfee,
    invoicesamount, ditotalmoney, returnmoney, packmoney, packprice,
    additionfee, dideductmoney, packdeduct, totalincome, actdeduct,totalprice,
    dibalanceablemoney, dibalancemoney, ticketincome, leavebalancemoney,
    balancemoney, nottickeitemdeduct,noItemAndagentdeduct,
     rentmoney, rentprice, rentdeduct, debit,
    preupmoney, lost, lateforfeit, deratemoney, ticketitemagentfeesum: Double;
  vehicleno, itemcode: String;
begin
  inherited;
  // showmessage(currtostr(NvDbgridEh1.SumList.SumCollection.Items[0].SumValue));
  // showmessage(currtostr(NvDbgridEh1.SumList.SumCollection.Items[1].SumValue));
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('该结算通知单已经注销！');
    exit;
  end;

  try
    balanceid := jcdsResult.FieldByName('id').AsLargeInt;
    if parameter4017 then
    begin
      balanceACPrint(balanceid);
    end
    else
    begin
      if not Assigned(printValue) then
        printValue := TDictionary<String, String>.Create
      else
        printValue.Clear;
      if not Assigned(billPrint) then
        billPrint := TNovaPrint.Create(self,
          TNovaPrint.GetTicketModelName('结算通知单', '结算通知单'));
      divide := jcdsResult.FieldByName('divide').asFloat;
      ticketitemsum := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('distationservicefee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee').asFloat;
      printValue.Add('invoincenum',
        jcdsResult.FieldByName('invoicesnum').AsString);
      // 票价分项、客运代理费扣费
      printValue.Add('ticketitemsum', floattostr(ticketitemsum * (1 - divide)));
      if jcdsResult.FieldByName('balanceobject').AsString = '0' then
      begin
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('objectname').AsString);
      end
      else
      begin
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('vehicleno').AsString);
      end;
      printValue.Add('balanceno', jcdsResult.FieldByName('balanceno').AsString);
      vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
      if length(vehicleno) > 15 then
        // 7*5+4
        vehicleno := copy(vehicleno, 0, 15) + '等';
      printValue.Add('vehicleno', vehicleno); //jcdsResult.FieldByName('balancemonth').asDatetime
      printValue.Add('balancedate', jcdsResult.FieldByName('balancemonth').AsString);

      printValue.Add('ditotalnum', jcdsResult.FieldByName('ditotalnum').AsString);
      // 总票款金额
      ditotalmoney := jcdsResult.FieldByName('ditotalmoney').asFloat;
      printValue.Add('ditotalmoney', floattostr(ditotalmoney * (1 - divide)));

      // 站务费
      stationfee := jcdsResult.FieldByName('distationservicefee').asFloat;
      printValue.Add('stationfee', floattostr(stationfee * (1 - divide)));

      printValue.Add('nostationfeetotalmoney',floattostr(ditotalmoney-stationfee));
      // 其他扣费
      otherfee := jcdsResult.FieldByName('diotherpredeductifee').asFloat;
      printValue.Add('otherfee', floattostr(otherfee * (1 - divide)));
      // 客运代理费
      agentfee := jcdsResult.FieldByName('diagentfee').asFloat;
      printValue.Add('agentfee', floattostr(agentfee * (1 - divide)));
      ticketitemagentfeesum := ticketitemsum + agentfee;
      printValue.Add('ticketitemagentfeesum', floattostr(ticketitemagentfeesum));
      invoicesamount := ditotalmoney - stationfee - jcdsResult.FieldByName
        ('fueladditionfee').asFloat - otherfee;
      // '票款-票价分项',0,'invoicesamount'
      printValue.Add('invoicesamount', floattostr(invoicesamount * (1 - divide)));

      returnmoney := jcdsResult.FieldByName('returnmoney').asFloat;
      printValue.Add('returnmoney', floattostr(returnmoney));

      packmoney := jcdsResult.FieldByName('packmoney').asFloat;
      printValue.Add('packmoney', floattostr(packmoney));
      packprice := jcdsResult.FieldByName('packprice').asFloat;
      printValue.Add('packprice', floattostr(packprice));
      packdeduct := packprice - packmoney;

      // 行包代理费',0,'packdeduct
      printValue.Add('packdeduct', floattostr(packdeduct));

      // 包车营收
      rentmoney := jcdsResult.FieldByName('rentmoney').asFloat;
      printValue.Add('rentmoney', floattostr(rentmoney));
      // 包车应结
      rentprice := jcdsResult.FieldByName('rentprice').asFloat;
      printValue.Add('rentprice', floattostr(rentprice));
      rentdeduct := rentmoney - rentprice;
      // 包车代理费',0,'rentdeduct
      printValue.Add('rentdeduct', floattostr(rentdeduct));

      lost := jcdsResult.FieldByName('lost').asFloat;
      preupmoney := jcdsResult.FieldByName('preupmoney').asFloat;
      // 营收小计',0,'totalincome =票款-票价分项-agentfee+行包金额+回程结算金额
      totalincome := invoicesamount * (1 - divide) -agentfee-
        + preupmoney - lost + returnmoney + packprice + rentmoney;
      printValue.Add('totalincome', floattostr(totalincome));
      // 站务附加费
      additionfee := jcdsResult.FieldByName('additionfee').asFloat;
      printValue.Add('additionfee', floattostr(additionfee * (1 - divide)));

      // 手工扣费
      dideductmoney := jcdsResult.FieldByName('dideductmoney').asFloat;
      printValue.Add('dideductmoney', floattostr(dideductmoney));

      deductifee := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('distationservicefee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
      // 总扣费=中手工输入扣费不参与分成
      printValue.Add('deductifee',
        floattostr(deductifee * (1 - divide) + dideductmoney + packdeduct +
            rentdeduct));
      totalprice:=ditotalmoney+packprice  +rentmoney;
      printValue.Add('totalprice', floattostr(totalprice * (1 - divide))); //总收入
      actdeduct:=deductifee * (1 - divide) + dideductmoney
                +packdeduct+rentdeduct;
      printValue.Add('actdeduct', floattostr(actdeduct * (1 - divide))); //实扣金额
      // 总可结算金额=运量的结算金额(1-分成)=总结算金额*(1-分成)
      // =票款金额-站务费-燃油费-其它扣费-客运代理费* (1-分成)
      dibalanceablemoney := jcdsResult.FieldByName('dibalanceablemoney').asFloat *
        (1 - divide);
      printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

      // dibalancemoney 应结金额 = 总可结算金额-手工扣费
      // dibalancemoney := dibalanceablemoney - dideductmoney;
      dibalancemoney := jcdsResult.FieldByName('dibalancemoney').asFloat;
      printValue.Add('dibalancemoney', floattostr(dibalancemoney));
      debit := jcdsResult.FieldByName('debit').asFloat;
      // 除票价分项外扣费
      nottickeitemdeduct := jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
      lateforfeit := jcdsResult.FieldByName('lateforfeit').asFloat;
      nottickeitemdeduct := nottickeitemdeduct * (1 - divide)
        + lateforfeit + dideductmoney + packdeduct + rentdeduct + debit;
      printValue.Add('nottickeitemdeduct', floattostr(nottickeitemdeduct));
      // 除票价分项外客运代理费外的扣费     noItemAndagentdeduct
      printValue.Add('noItemAndagentdeduct',currtostr(nottickeitemdeduct - agentfee));
      // 结算营收= 应结金额 +\- 其他结算信息 -站务附加费*（1-客运代理费比例）*（1-分成比例）
      ticketincome := jcdsResult.FieldByName('ticketincome').asFloat;
      printValue.Add('ticketincome', floattostr(ticketincome));

      // 剩余应结金额 =结算营收+行包应得
      leavebalancemoney := ticketincome + packmoney;
      printValue.Add('leavebalancemoney', floattostr(leavebalancemoney));
      deratemoney := jcdsResult.FieldByName('deratemoney').asFloat;
      // balancemoney := jcdsResult.FieldByName('balancemoney').asFloat;
      balancemoney := totalincome - nottickeitemdeduct + deratemoney;
      // 实结金额 = 剩余应结金额
  //    printValue.Add('balancemoney', currtostr(balancemoney));
      printValue.Add('balancemoney', jcdsResult.FieldByName('balancemoney').AsString);
      // 减免金额
      printValue.Add('deratemoney', floattostr(deratemoney));
      printValue.Add('routename', jcdsResult.FieldByName('routename').AsString);
      printValue.Add('vipscoremoney',
        jcdsResult.FieldByName('vipscoremoney').AsString);
      printValue.Add('preupmoney', jcdsResult.FieldByName('preupmoney').AsString);
      printValue.Add('lateforfeit',
        jcdsResult.FieldByName('lateforfeit').AsString);
      printValue.Add('lostforfeit',
        jcdsResult.FieldByName('lostforfeit').AsString);
      printValue.Add('lastlost', jcdsResult.FieldByName('lastlost').AsString);
      printValue.Add('lost', jcdsResult.FieldByName('lost').AsString);
      printValue.Add('remarks', jcdsResult.FieldByName('remarks').AsString);
      printValue.Add('departstartdate',
        jcdsResult.FieldByName('departstartdate').AsString);
      printValue.Add('departenddate',
        jcdsResult.FieldByName('departenddate').AsString);
      printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('debit', jcdsResult.FieldByName('debit').AsString);
      printValue.Add('backmoney', jcdsResult.FieldByName('backmoney').AsString);

       deductifee1 := jcdsResult.FieldByName('fueladditionfee')
        .asFloat + jcdsResult.FieldByName('diagentfee')
        .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
        .asFloat + jcdsResult.FieldByName('additionfee').asFloat;

      //货运代理费
      printValue.Add('hydlffee', jcdsResult.FieldByName('goodsagent').AsString);
      //本月上交
      printValue.Add('bysj', jcdsResult.FieldByName('bysj').AsString);
      //上月欠交
      printValue.Add('syqj', jcdsResult.FieldByName('syqj').AsString);
      //总扣费1 =  原总扣费基础去掉站务费
      printValue.Add('deductifee1',
        floattostr(deductifee1 * (1 - divide) + dideductmoney + packdeduct +
            rentdeduct));

      // ticketitemsum:=0;
      // 查询扣费明细
      if deductprinttype = '0' then
      begin
        with jscdQryDeducts do
        begin
          if Active and (recordcount > 0) then
          begin
            first;
            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            while (not eof) do
            begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('deductname', FieldByName('name').AsString);
              multipleValueValue.Add('deductfee',
                FieldByName('deductmoney').AsString);
              multiplelist.Add(multipleValueValue);
              next;
            end;
            billPrint.MultipleValue := multiplelist;
          end;
          billPrint.SingleValue := printValue;
          billPrint.Print;
        end;
      end
      else
      begin
        with jscdQryDeducts do
        begin
          Active := False;
          Params.ParamValues['balanceid'] := balanceid;
          Active := True;
          if recordcount > 0 then
          begin
            first;
            while (not eof) do
            begin
              itemcode := FieldByName('code').AsString;
              printValue.Add(itemcode, FieldByName('deductmoney').AsString);
              next;
            end;
          end;
        end;
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;
      if divide > 0 then
      begin
        printValue.Clear;
        printValue.Add('invoincenum',
          jcdsResult.FieldByName('invoicesnum').AsString);
        // 票价分项、客运代理费扣费
        printValue.Add('ticketitemsum', floattostr(ticketitemsum * divide));
        printValue.Add('balanceunit',
          jcdsResult.FieldByName('dividename').AsString);
        printValue.Add('balanceno', jcdsResult.FieldByName('balanceno').AsString);
        printValue.Add('vehicleno', jcdsResult.FieldByName('vehicleno').AsString);
        printValue.Add('balancedate', formatdatetime('yyyy-mm-dd',
            jcdsResult.FieldByName('balancetime').AsDateTime));

        printValue.Add('ditotalnum',
          jcdsResult.FieldByName('ditotalnum').AsString);
        // 总票款金额
        ditotalmoney := jcdsResult.FieldByName('ditotalmoney').asFloat;
        printValue.Add('ditotalmoney', floattostr(ditotalmoney * divide));

        // 站务费
        stationfee := jcdsResult.FieldByName('distationservicefee').asFloat;
        printValue.Add('stationfee', floattostr(stationfee * divide));
        // 其他扣费
        otherfee := jcdsResult.FieldByName('diotherpredeductifee').asFloat;
        printValue.Add('otherfee', floattostr(otherfee * divide));
        // 客运代理费
        agentfee := jcdsResult.FieldByName('diagentfee').asFloat;
        printValue.Add('agentfee', floattostr(agentfee * divide));
        printValue.Add('ticketitemagentfeesum',
          floattostr(ticketitemsum * divide + agentfee * divide));
        invoicesamount := ditotalmoney - stationfee - jcdsResult.FieldByName
          ('fueladditionfee').asFloat - otherfee;
        // '票款-票价分项',0,'invoicesamount'
        printValue.Add('invoicesamount', floattostr(invoicesamount * divide));

        returnmoney := 0;
        printValue.Add('returnmoney', floattostr(returnmoney));

        packmoney := 0;
        printValue.Add('packmoney', floattostr(packmoney));
        packprice := 0;
        printValue.Add('packprice', floattostr(packprice));

        packdeduct := packprice - packmoney;
        // 行包代理费',0,'packdeduct
        printValue.Add('packdeduct', floattostr(packdeduct));

        // 包车营收
        rentmoney := 0;
        printValue.Add('rentmoney', floattostr(rentmoney));
        // 包车应结
        rentprice := 0;
        printValue.Add('rentprice', floattostr(rentprice));
        rentdeduct := rentmoney - rentprice;
        // 包车代理费',0,'rentdeduct
        printValue.Add('rentdeduct', floattostr(rentdeduct));

        // 营收小计',0,'totalincome =票款-票价分项+行包金额+回程结算金额
        totalincome := invoicesamount * divide + returnmoney + packprice;
        printValue.Add('totalincome', floattostr(totalincome));

        // 站务附加费
        additionfee := jcdsResult.FieldByName('additionfee').asFloat;
        printValue.Add('additionfee', floattostr(additionfee * divide));

        // 手工扣费
        dideductmoney := NvDbgridEh1.SumList.SumCollection.Items[1].SumValue;
        printValue.Add('dideductmoney', floattostr(dideductmoney));

        deductifee := jcdsResult.FieldByName('fueladditionfee')
          .asFloat + jcdsResult.FieldByName('diagentfee')
          .asFloat + jcdsResult.FieldByName('distationservicefee')
          .asFloat + jcdsResult.FieldByName('diotherpredeductifee')
          .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
        // 总扣费=中手工输入扣费不参与分成
        printValue.Add('deductifee',
          floattostr(deductifee * divide + dideductmoney));
        // 除票价分项外扣费
        nottickeitemdeduct := jcdsResult.FieldByName('diagentfee')
          .asFloat + jcdsResult.FieldByName('additionfee').asFloat;
        nottickeitemdeduct := nottickeitemdeduct * divide + dideductmoney;
        // 除票价分项外扣费
        printValue.Add('nottickeitemdeduct', floattostr(nottickeitemdeduct));

        // 总可结算金额=运量的结算金额(1-分成)=总结算金额*(1-分成)
        // =票款金额-站务费-燃油费-其它扣费-客运代理费* (1-分成)
        dibalanceablemoney := jcdsResult.FieldByName('dibalanceablemoney')
          .asFloat * divide;
        printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

        // dibalancemoney 应结金额 = 总可结算金额-手工扣费
        // dibalancemoney := dibalanceablemoney - dideductmoney;
        dibalancemoney := jcdsResult.FieldByName('dibalancemoney').asFloat;
        printValue.Add('dibalancemoney', floattostr(dibalancemoney));

        // 结算营收= 应结金额 +\- 其他结算信息 -站务附加费*（1-客运代理费比例）*（1-分成比例）
        ticketincome := jcdsResult.FieldByName('ticketincome').asFloat;
        printValue.Add('ticketincome', floattostr(ticketincome));
        packmoney := 0;
        // 剩余应结金额 =结算营收+行包应得
        leavebalancemoney := ticketincome + packmoney;
        printValue.Add('leavebalancemoney', floattostr(leavebalancemoney));

        // balancemoney := jcdsResult.FieldByName('balancemoney').asFloat;
        balancemoney := totalincome - nottickeitemdeduct;
        // 实结金额 = 剩余应结金额
        printValue.Add('balancemoney', floattostr(balancemoney));

        printValue.Add('routename', jcdsResult.FieldByName('routename').AsString);
        printValue.Add('vipscoremoney', '0');
        printValue.Add('preupmoney', '0');
        printValue.Add('lateforfeit', '0');
        printValue.Add('lostforfeit', '0');
        printValue.Add('lastlost', '0');
        printValue.Add('lost', '0');
        printValue.Add('remarks', jcdsResult.FieldByName('remarks').AsString);
        printValue.Add('departstartdate',
          jcdsResult.FieldByName('departstartdate').AsString);
        printValue.Add('departenddate',
          jcdsResult.FieldByName('departenddate').AsString);
        printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);

        with jscdQryDeducts do
        begin
          if Active and (recordcount > 0) then
          begin
            first;
            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            while (not eof) do
            begin
              multipleValueValue := TDictionary<String, String>.Create;
              multipleValueValue.Add('deductname', FieldByName('name').AsString);
              multipleValueValue.Add('deductfee',
                FieldByName('divdedeductmoney').AsString);
              multiplelist.Add(multipleValueValue);
              next;
            end;
            billPrint.MultipleValue := multiplelist;
          end;
        end;
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;
    end;

  except
    on E: exception do
    begin
      SysLog.WriteErr('打印结帐单失败：' + E.Message);
    end;
  end;

end;

procedure TfrmQueryBalanced.tbtnSaveClick(Sender: TObject);
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;
  frmQryBanlancedetailPrint:=TFrmQryBanlancedetailPrint.Create(Self);
  with frmQryBanlancedetailPrint do
  begin

    with jcdsResultdetailPrint do
    begin
      Active := False;
      Params.ParamValues['balanceid'] := jcdsResult.FieldByName('id').AsString;
      Active := True;
    end;
     ShowModal;
  end;
end;

// 将字符串格式"yyyy-mm-dd hh:mm:ss" 转换为日期时间格式
function TfrmQueryBalanced.StringToDateTime(ADateTimeStr: string): TDateTime;
var
  AFormatSettings: TFormatSettings;
  ShortDateFormat, ShortTimeFormat: string;
  DateSeparator, TimeSeparator: char;
begin
  ShortDateFormat := 'yyyy-MM-dd';
  DateSeparator := '-';
  ShortTimeFormat := 'HH:mm:ss';
  TimeSeparator := ':';
  AFormatSettings.ShortDateFormat := ShortDateFormat;
  AFormatSettings.DateSeparator := DateSeparator;
  AFormatSettings.ShortTimeFormat := ShortTimeFormat;
  AFormatSettings.TimeSeparator := TimeSeparator;
  Result := StrToDateTime(ADateTimeStr, AFormatSettings);
end;

end.
