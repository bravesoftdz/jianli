unit UFrmSelSchPlan2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaHComboBox, NovaComboBox, NovaEdit, NovaHelp, DBGridEhGrouping,
  NovaCheckedComboBox, UDMPublic, NovaPrint, Generics.Collections;

type
  TFrmSelSchPlan2 = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lblstation: TLabel;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    nvhlproute: TNovaHelp;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    nvhlpunit: TNovaHelp;
    jcdsupdateBillinuse: TjsonClientDataSet;
    GroupBox3: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    tmGetCurInvoinNo: TTimer;
    jcdsupdatepackschedule: TjsonClientDataSet;
    nvhlpScheduleHelp: TNovaHelp;
    nvhlpVehicle: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure nvhlprouteIdChange(Sender: TObject);

    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnCloseClick(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure nvhlpScheduleHelpChange(Sender: TObject);
    procedure nvhlpVehicleChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;
    log: string;
    parameter: string;
    procedure PrintClink;
    procedure UpdatePackbill;
    procedure refreshBill();
  public
    { Public declarations }
    packids, stationids, packnos: string;
    departdate: TDateTime;
    piecesnums: Integer;
    totalfeemoney: Double;
    sendstation: String;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    multipleValueValue: TDictionary<String, String>;
    property operationid: Integer read Foperationid;
  end;

var
  FrmSelSchPlan2: TFrmSelSchPlan2;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSelSchPlan2.refreshBill();
begin
  if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    if sysInfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
      and sysInfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
      (sysInfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
    begin
      lbpackbill.Caption := sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill'];
      lbbillnum.Caption := IntToStr
        (sysInfo.LoginUserInfo.curBillNum.Items['PackSgBill']);
    end
    else
    begin
      lbpackbill.Caption := '';
      lbbillnum.Caption := '0';
    end;
    GroupBox3.Visible := true;
  end
  else
  begin
    GroupBox3.Visible := false;
  end;

end;

procedure TFrmSelSchPlan2.dtpstartdateChange(Sender: TObject);
begin
  inherited;

    nvhlpVehicle.Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
  nvhlpScheduleHelp.Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
end;

procedure TFrmSelSchPlan2.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  if Assigned(printValue) then
    printValue.Free;
  if Assigned(multiplelist) then
    multiplelist.Free;
  tmGetCurInvoinNo.Enabled := false;
  inherited;
  // FrmSelSchPlan.Close;
end;

procedure TFrmSelSchPlan2.FormShow(Sender: TObject);
begin
  inherited;
  nvhlproute.SetFocus;
  // dbgrdhResult.GridUser := sysInfo.LoginUserInfo.UserID;
  refreshBill;
  tbtnFilterClick(Sender);
  // tmGetCurInvoinNo.Enabled := true;
end;

procedure TFrmSelSchPlan2.nvhlprouteIdChange(Sender: TObject);
begin
  parameter := getParametervalue('2018', sysInfo.LoginUserInfo.OrgID);
  if parameter = '1' then
  begin
    tbtnFilterClick(Sender);
    self.nvhlproute.SelectAll;
  end;
end;

procedure TFrmSelSchPlan2.nvhlpScheduleHelpChange(Sender: TObject);
begin
  inherited;
nvhlpScheduleHelp.Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
end;

procedure TFrmSelSchPlan2.nvhlpVehicleChange(Sender: TObject);
begin
  inherited;
   nvhlpVehicle.Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
end;

procedure TFrmSelSchPlan2.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmSelSchPlan2.tbtnFilterClick(Sender: TObject);
var
  planid: int64;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQD_sp!departdate'] := formatdatetime
      ('yyyy-MM-dd', dtpstartdate.DateTime);
    Params.ParamValues['departdate'] := formatdatetime('yyyy-MM-dd',
      dtpstartdate.DateTime);
    Params.ParamValues['filter_EQL_ss!departstationid'] :=
      sysInfo.LoginUserInfo.StationID;
    // 班次
    if nvhlpScheduleHelp.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_sp!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_sp!id'] := nvhlpScheduleHelp.Id;
    end;
    // 线路
    if nvhlproute.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_r!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;
    // 报道车辆
    if nvhlpVehicle.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_vr!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_vr!id'] := nvhlpVehicle.Id;
    end;
    // 营运单位
    if nvhlpunit.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_u!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhlpunit.Id;
    end;

    Active := true;

  end;
end;

procedure TFrmSelSchPlan2.tbtnInsertClick(Sender: TObject);
var
  i: Integer;
  scheduleid, vehicleid, flag_pack: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  with jcdsResult do
  begin
    i := 0;

    if (FieldByName('status').AsString = '报停') then
    begin
      SysDialogs.ShowMessage('该班次已经停班，不能进行签发！');
      exit;
    end;

    if (FieldByName('status').AsString = '被并') then
    begin
      SysDialogs.ShowMessage('该班次已经被并，不能进行签发！');
      exit;
    end;

    if FieldByName('isdeparted').AsBoolean then
    begin
      SysDialogs.ShowInfo('该班次已经发班，不能进行签发！');
      exit;
    end;

    if formatdatetime('yyyyMMdd', FieldByName('departdate').AsDateTime)
      < formatdatetime('yyyyMMdd', Now) then
    begin
      SysDialogs.Warning('已过发车日期不允许签发！');
      exit;
    end;

    scheduleid := FieldByName('schedule').AsString;
    vehicleid := FieldByName('vehiclereportid').AsString;
    // end;
  end;
  //
  with jcdsupdatepackschedule do
  begin
    Active := false;
    Params.ParamValues['packid'] := jcdsResult.FieldByName('packid').AsString;
    Params.ParamValues['pknos'] := packnos;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-MM-dd',
      jcdsResult.FieldByName('departdate').AsDateTime);
    Params.ParamValues['routeid'] := jcdsResult.FieldByName('routeid').AsString;
    // 签发给报道车辆
    if (vehicleid <> '')  then
    begin
      flag_pack := 'isVehicle';
      Params.ParamValues['vehicleid'] := vehicleid;
      Params.ParamValues['scheduleid'] := '0';        //签发给报道车辆后台并不使用该参数
    end;
    // 签发给计划班次
    if ((scheduleid <> '') and (vehicleid ='') ) then
    begin
      flag_pack := 'isSchedule';
      Params.ParamValues['vehicleid'] :='0';         //签发给计划班次后台并不使用该参数
      Params.ParamValues['scheduleid'] := scheduleid;
    end;
    Params.ParamValues['flag_pack'] := flag_pack;

    // Params.ParamValues['scheduleid'] := scheduleid;
    tbtnInsert.Enabled := false;
    Execute;
    tbtnInsert.Enabled := true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
     try
//       // tbtnInsert.Enabled := false;
//        log := '行包签发：机构=' + sysInfo.LoginUserInfo.OrgName;
////        if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
////        begin
////          log := log + ',签发票号=' + sysInfo.LoginUserInfo.curBillNo.Items
////            ['PackSgBill'];
////        end;
//        log := log + ',签发人=' + sysInfo.LoginUserInfo.UserName + ',班次=' +
//          jcdsResult.FieldByName('code').AsString + ',车牌号码=' +
//          jcdsResult.FieldByName('vehicleno')
//          .AsString + ',驾驶员=' + jcdsResult.FieldByName('drivername')
//          .AsString + ',营运单位=' + jcdsResult.FieldByName('unitname')
//          .AsString + ',行包件数=' + IntToStr(piecesnums) + ',总金额=' + FloatToStr
//          (totalfeemoney) + ',签发时间=' + formatdatetime('yyyy-MM-dd HH:mm:ss',
//          Now) + ',托运单号=' + packnos;
//
//        SysLog.WriteLog('行包管理->行包库存', '行包签发', log);
//        tbtnFilterClick(Sender);//新增
//        if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
//        begin
//          PrintClink;
//          UpdatePackbill;
//        end;
        log := '行包签发：机构=' + sysInfo.LoginUserInfo.OrgName;
        log := log + ',签发人=' + sysInfo.LoginUserInfo.UserName + ',班次=' +
          jcdsResult.FieldByName('code').AsString + ',车牌号码=' +
          jcdsResult.FieldByName('vehicleno').AsString;

        SysLog.WriteLog('行包管理->行包库存', '行包签发', log);
        tbtnFilterClick(Sender);
           //签发成功后，打印签发单
           if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
           begin
             PrintClink;
             UpdatePackbill;
           end;
           // 签发成功后，打印签发单
     finally
           Foperationid := 0;
           self.ModalResult := mrOk;
           // FrmSelSchPlan.Close;
     end;

    end;
  end;
end;

   procedure TFrmSelSchPlan2.tmGetCurInvoinNoTimer(Sender: TObject);
   begin
     inherited;
     refreshBill;
   end;

   procedure TFrmSelSchPlan2.PrintClink();

   begin
     try
       printValue := TDictionary<String, String>.Create;
       billPrint := TNovaPrint.Create(self,
         TNovaPrint.GetTicketModelName('行包签发单',
           '行包签发单1'));

    // 签发单号、发车日期、班次号、车牌号码、驾驶员、营运单位、行包件数、总金额，

    with jcdsResult do
    begin
      printValue.Clear;
      printValue.Add('singbillno',
        sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill']); // 签发单号
      printValue.Add('departdate', formatdatetime('yyyy-MM-dd',
          FieldByName('departdate').AsDateTime)); // 发车日期
      // 发车时间
      printValue.Add('departtime', FieldByName('departtime').AsString);
      printValue.Add('schedulevalue', FieldByName('code').AsString); // 班次
      printValue.Add('vehiclevalue', FieldByName('vehicleno').AsString);
      // 车牌号
      printValue.Add('drivername', FieldByName('name1').AsString); // 驾驶员
      printValue.Add('unitname', FieldByName('unitname').AsString); // 营运单位
      printValue.Add('piecesnums', IntToStr(piecesnums)); // 行包件数
      printValue.Add('totalfeecountmoney', FloatToStr(totalfeemoney)); // 总金额
      printValue.Add('sellbyname', sysInfo.LoginUserInfo.UserName); // 签发人
      printValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss', Now));
      // 签发时间
      printValue.Add('sendstation', sendstation); // 签发站
      { printValue.Add('sendstationvalue', sendstationvalue);//发货站
        printValue.Add('tostationvalue', tostationvalue);//目的地
        printValue.Add('goodname', name);//货物名称



        printValue.Add('packno', packno);//行包单号
        printValue.Add('invoiceno', invoiceno);//发票号
        printValue.Add('sellbyname', sellbyname);//受理人
        printValue.Add('pieces', pieces);//件数
        printValue.Add('weight', weight);//重量
        printValue.Add('volume', volume);//体积
        printValue.Add('packaed', packaed);//包装（纸箱、塑料袋、无）
        printValue.Add('shippricemoney', shippricemoney);//托运费
        printValue.Add('packfeemoney', packfeemoney);//包装费
        printValue.Add('handfeemoney', handfeemoney);//装卸费
        printValue.Add('deliveryfeemoney', deliveryfeemoney);//送货费
        //printValue.Add('custodialmoney', custodialmoney);//保管费
        printValue.Add('transitfeemoney', transitfeemoney);//中转费
        printValue.Add('insuredamountmoney', insuredamountmoney);//保价金额
        printValue.Add('insurancefeemoney', insurancefeemoney);//保价费
        printValue.Add('insurancemoney', insurancemoney);//保险费
        printValue.Add('otherfeemoney', otherfeemoney);//其他费用
        printValue.Add('totalfeemoney', totalfeemoney);//合计金额
        //printValue.Add('location', location);//存放位置
        printValue.Add('packpricemoney', packpricemoney);//代收货款
        printValue.Add('sender', sender);//托运人
        printValue.Add('senderphone', senderphone);//托运人电话
        printValue.Add('senderaddress', senderaddress);//托运人地址
        printValue.Add('consignee', consignee);//收货人
        printValue.Add('consigneephone', consigneephone);//收货人电话
        printValue.Add('consigneeaddress', consigneeaddress);//收货人地址
        printValue.Add('certificatetype', certificatetype);//证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
        printValue.Add('certificateno', certificateno);//证件号码
        printValue.Add('shiptype', shiptype);//托运方式（随车自提、收获人提领）取数据字典
        printValue.Add('paymethod', paymethod);//付款方式（现付、提付）取数据字典
        printValue.Add('valuables', valuables);//是否贵重物品
        printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));//打印时间
        printValue.Add('remarks', remarks);//货物描述
        multiplelist := TList < TDictionary < String, String >> .Create;
        while (not eof) do
        begin
        multipleValueValue := TDictionary<String, String>.Create;
        multipleValueValue.Add('deductname', FieldByName('name').AsString);
        multipleValueValue.Add('deductfee',
        FieldByName('deductmoney').AsString);
        multiplelist.Add(multipleValueValue);
        // if FieldByName('isticketpriceitem').AsBoolean then
        // ticketitemsum := ticketitemsum + FieldByName('deductmoney').AsFloat;
        next;
        end; }
    end;

    billPrint.MultipleValue := multiplelist;

    billPrint.SingleValue := printValue;
    billPrint.Print;
  finally

  end;
end;

procedure TFrmSelSchPlan2.UpdatePackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with sysInfo.LoginUserInfo do
  begin

    billinusenextform := IntToStr
      (strtoint64(sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill']));
    billinusenextno := IntToStr
      (strtoint64(sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill'])
        + 1);

    curBillNo.AddOrSetValue('PackSgBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackSgBill'])));
    curBillNum.AddOrSetValue('PackSgBill', curBillNum.Items['PackSgBill'] - 1);

    if curBillNum.Items['PackSgBill'] > 0 then
      billinusestatus := '1'
    else
      billinusestatus := '2';

  end;

  with jcdsupdateBillinuse do
  begin
    Active := false;
    Params.ParamValues['billinusestatus'] := billinusestatus;
    Params.ParamValues['billinusenextno'] := billinusenextno;
    Params.ParamValues['billinusenextform'] := billinusenextform;
    Params.ParamValues['billtypecode'] := 'PackSgBill';
    Execute;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;

    if Params.ParamValues['flag'] = -1 then
    begin

    end;

  end;
end;

end.
