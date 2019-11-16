unit UFrmSelSchPlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaHComboBox, NovaComboBox, NovaEdit, NovaHelp, DBGridEhGrouping,
  NovaCheckedComboBox, UDMPublic, NovaPrint, Generics.Collections;

type
  TFrmSelSchPlan = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lblstation: TLabel;
    dtpstartdate: TDateTimePicker;
    nvhlpVehicle: TNovaHelp;
    jcdsupdatepackschedule: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    tmGetCurInvoinNo: TTimer;
    jscdQrySch: TjsonClientDataSet;
    lblpackno: TLabel;
    nvedtpackno: TNovaEdit;
    GroupBox3: TGroupBox;
    NvDbgridEh2: TNvDbgridEh;
    Panel3: TPanel;
    GroupBox4: TGroupBox;
    DataSource1: TDataSource;
    jscdquerystockSendPack: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    nvhlpScheduleHelp: TNovaHelp;
    procedure FormShow(Sender: TObject);

    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnCloseClick(Sender: TObject);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvhlpVehicleIdChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure showPackInfo(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dtpstartdateChange(Sender: TObject);
    procedure jscdQrySchAfterScroll(DataSet: TDataSet);
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
    scheduleid, vehiclereportid, flag_pack, schedule: string;
    packids, stationids, packnos: string;
    departdate: TDateTime;
    piecesnums: Integer;
    totalfeemoney: Double;
    sendstation: String;
    sendstationname: String;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    multipleValueValue: TDictionary<String, String>;
    packno1: String;
    property operationid: Integer read Foperationid;
  end;

var
  FrmSelSchPlan: TFrmSelSchPlan;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSelSchPlan.refreshBill();
begin
  { if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
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
    end; }

end;

procedure TFrmSelSchPlan.showPackInfo(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  begin
    // if key = 13 then tbtnFilterClick(Sender);
    if Key = 13 then
      tbtnInsertClick(Sender);
  end;
end;

procedure TFrmSelSchPlan.Button1Click(Sender: TObject);
begin
  inherited;
  begin
    SysDialogs.ShowMessage('对不起，该功能尚待开发！');
    exit;
  end;
end;

procedure TFrmSelSchPlan.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  // with nvhlpVehicle do
  // begin
  nvhlpVehicle.Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
    dtpstartdate.Date);
  // // nvhlpVehicle.Params.ParamValues['param'] := nvhlpVehicle.Text.NullAsStringValue;
  // end;
  nvhlpScheduleHelp.Params.ParamValues['departdate'] := formatdatetime
    ('yyyy-mm-dd', dtpstartdate.Date);
end;

procedure TFrmSelSchPlan.FormClose(Sender: TObject; var Action: TCloseAction);
begin

   if Assigned(printValue) then
    printValue.Free;
    if Assigned(multiplelist) then
    multiplelist.Free;
    tmGetCurInvoinNo.Enabled := false;
    inherited;
  // FrmSelSchPlan.Close;
end;

procedure TFrmSelSchPlan.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.datetime := now();
  dtpstartdateChange(Sender);
  // 设置打开签发界面的光标位置：车辆位置
  nvhlpVehicle.SetFocus;
  // dbgrdhResult.GridUser := sysInfo.LoginUserInfo.UserID;
  // nvedtpackno.Text:=packno1;
  // refreshBill;
  // tbtnFilterClick(Sender);
  // tmGetCurInvoinNo.Enabled := true;
end;

procedure TFrmSelSchPlan.jscdQrySchAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jscdquerystockSendPack do
  begin
    Active := false;

    schedule := jscdQrySch.FieldByName('schedule').AsString;
    vehiclereportid := jscdQrySch.FieldByName('vehiclereportid').AsString;
    // 签发给计划班次
    if (schedule <> '') and (vehiclereportid = '') then
    begin
      flag_pack := 'isSchedule';
      Params.ParamValues['vehiclereportid'] := '0';     //签发给计划班次后台并不使用该参数
      Params.ParamValues['scheduleid'] := schedule;
    end;
    // 签发给报道车辆
    if (vehiclereportid <> '') then
    begin
      flag_pack := 'isVehicle';
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['scheduleid'] := '0';     // 签发给报道车辆后台并不使用该参数
    end;
    Params.ParamValues['flag_pack'] := flag_pack;
    Active := True;
  end;
end;

procedure TFrmSelSchPlan.nvhlpVehicleIdChange(Sender: TObject);
begin
  inherited;
  // with nvhlpVehicle do
  // begin
  nvhlpVehicle.Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
    dtpstartdate.Date);
  // end;
end;

procedure TFrmSelSchPlan.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  // self.ModalResult := mrNo;
  self.ModalResult := mrOk;
end;

procedure TFrmSelSchPlan.tbtnFilterClick(Sender: TObject);
var
  planid: int64;
begin
  inherited;
  with jscdQrySch do
  begin
    Active := false;
    Params.ParamValues['filter_EQD_sp!departdate'] := formatdatetime
      ('yyyy-MM-dd', dtpstartdate.datetime);
    Params.ParamValues['departdate'] := formatdatetime('yyyy-MM-dd',
      dtpstartdate.datetime);
    // 报道车辆
    if (nvhlpVehicle.Text = '') then
    begin
      Params.ParamValues['filter_EQL_vr!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_vr!id'] := nvhlpVehicle.HelpFieldValue
        ['id'];
    end;
    // 计划班次
    if (nvhlpScheduleHelp.Text = '') then
    begin
      Params.ParamValues['filter_EQL_sp!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_sp!id'] := nvhlpScheduleHelp.HelpFieldValue
        ['id'];
    end;
    Active := True;
  end;
end;

procedure TFrmSelSchPlan.tbtnInsertClick(Sender: TObject);
begin
  inherited;

  if nvedtpackno.Text = '' then
  begin
    SysDialogs.ShowMessage('请输入行包单号！');
    exit;
  end;

  with jcdsupdatepackschedule do
  begin
    Active := false;
    Params.ParamValues['packno'] := nvedtpackno.Text;
    vehiclereportid := jscdQrySch.FieldByName('vehiclereportid').AsString;
    scheduleid := jscdQrySch.FieldByName('scheduleid').AsString;  //实为scheduleplanid
    Params.ParamValues['departdate'] := formatdatetime('yyyy-MM-dd',
      jscdQrySch.FieldByName('departdate').AsDateTime);
    // 签发给报道车辆
    if (vehiclereportid <> '') then
    begin
      flag_pack := 'isVehicle';
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['scheduleid'] := '0';      // 签发给报道车辆后台并不使用该参数
    end;
    // 签发给计划班次
    if (scheduleid <> '') and (vehiclereportid = '') then
    begin
      flag_pack := 'isSchedule';
      schedule := jscdQrySch.FieldByName('schedule').AsString;    //  scheduleid
      Params.ParamValues['vehiclereportid'] := '0';    //签发给计划班次后台并不使用该参数
      Params.ParamValues['scheduleid'] := schedule;
    end;
    Params.ParamValues['flag_pack'] := flag_pack;
    Execute;

    SysDialogs.ShowMessage(Params.ParamValues['msg']);

    if Params.ParamValues['flag'] = 1 then
    begin
      try
        // tbtnInsert.Enabled := false;
        log := '行包签发：机构=' + sysInfo.LoginUserInfo.OrgName;
        { if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
          begin
          log := log + ',签发票号=' + sysInfo.LoginUserInfo.curBillNo.Items
          ['PackSgBill'];
          end; }
        log := log + ',签发人=' + sysInfo.LoginUserInfo.UserName + ',班次=' +
          jscdQrySch.FieldByName('code').AsString + ',车牌号码=' +
          jscdQrySch.FieldByName('vehicleno').AsString;

        SysLog.WriteLog('行包管理->行包库存', '行包签发', log);

        tbtnFilterClick(Sender);
        {
          if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
          begin
          //PrintClink();
          //UpdatePackbill();
          end;
          }

           //签发成功后，打印签发单
           if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
          begin
           PrintClink;
          UpdatePackbill;
          end;
           //签发成功后，打印签发单
      finally
        //

        nvedtpackno.Text := '';
        nvedtpackno.SetFocus;


      end;

    end
    else
      nvedtpackno.SetFocus;
  end;
end;

procedure TFrmSelSchPlan.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmSelSchPlan.PrintClink();

begin
  try
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('行包签发单',
        '行包签发单1'));

    // 签发单号、发车日期、班次号、车牌号码、驾驶员、营运单位、行包件数、总金额，

    with jscdQrySch do
    begin
      printValue.Clear;
      printValue.Add('singbillno',
        sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill']); // 签发单号
      printValue.Add('departdate', formatdatetime('yyyy-MM-dd',
          FieldByName('departdate').AsDateTime)); // 发车日期
      // 发车时间
      printValue.Add('departtime', FieldByName('departtime').AsString);
      printValue.Add('schedulevalue', FieldByName('code').AsString); // 班次
      printValue.Add('vehiclevalue', FieldByName('vehicleno').AsString);    // 车牌号
      printValue.Add('unitname', FieldByName('unitname').AsString); // 营运单位
      printValue.Add('piecesnums', IntToStr(piecesnums)); // 行包件数
      printValue.Add('totalfeecountmoney', FloatToStr(totalfeemoney)); // 总金额
      printValue.Add('sellbyname', sysInfo.LoginUserInfo.UserName); // 签发人
      printValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss', now));
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

procedure TFrmSelSchPlan.UpdatePackbill();
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
