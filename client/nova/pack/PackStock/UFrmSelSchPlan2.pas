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
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
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
    // ���
    if nvhlpScheduleHelp.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_sp!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_sp!id'] := nvhlpScheduleHelp.Id;
    end;
    // ��·
    if nvhlproute.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_r!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;
    // ��������
    if nvhlpVehicle.Id <= 0 then
    begin
      Params.ParamValues['filter_EQL_vr!id'] := ' ';
    end
    else
    begin
      Params.ParamValues['filter_EQL_vr!id'] := nvhlpVehicle.Id;
    end;
    // Ӫ�˵�λ
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

    if (FieldByName('status').AsString = '��ͣ') then
    begin
      SysDialogs.ShowMessage('�ð���Ѿ�ͣ�࣬���ܽ���ǩ����');
      exit;
    end;

    if (FieldByName('status').AsString = '����') then
    begin
      SysDialogs.ShowMessage('�ð���Ѿ����������ܽ���ǩ����');
      exit;
    end;

    if FieldByName('isdeparted').AsBoolean then
    begin
      SysDialogs.ShowInfo('�ð���Ѿ����࣬���ܽ���ǩ����');
      exit;
    end;

    if formatdatetime('yyyyMMdd', FieldByName('departdate').AsDateTime)
      < formatdatetime('yyyyMMdd', Now) then
    begin
      SysDialogs.Warning('�ѹ��������ڲ�����ǩ����');
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
    // ǩ������������
    if (vehicleid <> '')  then
    begin
      flag_pack := 'isVehicle';
      Params.ParamValues['vehicleid'] := vehicleid;
      Params.ParamValues['scheduleid'] := '0';        //ǩ��������������̨����ʹ�øò���
    end;
    // ǩ�����ƻ����
    if ((scheduleid <> '') and (vehicleid ='') ) then
    begin
      flag_pack := 'isSchedule';
      Params.ParamValues['vehicleid'] :='0';         //ǩ�����ƻ���κ�̨����ʹ�øò���
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
//        log := '�а�ǩ��������=' + sysInfo.LoginUserInfo.OrgName;
////        if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
////        begin
////          log := log + ',ǩ��Ʊ��=' + sysInfo.LoginUserInfo.curBillNo.Items
////            ['PackSgBill'];
////        end;
//        log := log + ',ǩ����=' + sysInfo.LoginUserInfo.UserName + ',���=' +
//          jcdsResult.FieldByName('code').AsString + ',���ƺ���=' +
//          jcdsResult.FieldByName('vehicleno')
//          .AsString + ',��ʻԱ=' + jcdsResult.FieldByName('drivername')
//          .AsString + ',Ӫ�˵�λ=' + jcdsResult.FieldByName('unitname')
//          .AsString + ',�а�����=' + IntToStr(piecesnums) + ',�ܽ��=' + FloatToStr
//          (totalfeemoney) + ',ǩ��ʱ��=' + formatdatetime('yyyy-MM-dd HH:mm:ss',
//          Now) + ',���˵���=' + packnos;
//
//        SysLog.WriteLog('�а�����->�а����', '�а�ǩ��', log);
//        tbtnFilterClick(Sender);//����
//        if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
//        begin
//          PrintClink;
//          UpdatePackbill;
//        end;
        log := '�а�ǩ��������=' + sysInfo.LoginUserInfo.OrgName;
        log := log + ',ǩ����=' + sysInfo.LoginUserInfo.UserName + ',���=' +
          jcdsResult.FieldByName('code').AsString + ',���ƺ���=' +
          jcdsResult.FieldByName('vehicleno').AsString;

        SysLog.WriteLog('�а�����->�а����', '�а�ǩ��', log);
        tbtnFilterClick(Sender);
           //ǩ���ɹ��󣬴�ӡǩ����
           if getParametervalue('8006', sysInfo.LoginUserInfo.OrgID) = '1' then
           begin
             PrintClink;
             UpdatePackbill;
           end;
           // ǩ���ɹ��󣬴�ӡǩ����
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
         TNovaPrint.GetTicketModelName('�а�ǩ����',
           '�а�ǩ����1'));

    // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�

    with jcdsResult do
    begin
      printValue.Clear;
      printValue.Add('singbillno',
        sysInfo.LoginUserInfo.curBillNo.Items['PackSgBill']); // ǩ������
      printValue.Add('departdate', formatdatetime('yyyy-MM-dd',
          FieldByName('departdate').AsDateTime)); // ��������
      // ����ʱ��
      printValue.Add('departtime', FieldByName('departtime').AsString);
      printValue.Add('schedulevalue', FieldByName('code').AsString); // ���
      printValue.Add('vehiclevalue', FieldByName('vehicleno').AsString);
      // ���ƺ�
      printValue.Add('drivername', FieldByName('name1').AsString); // ��ʻԱ
      printValue.Add('unitname', FieldByName('unitname').AsString); // Ӫ�˵�λ
      printValue.Add('piecesnums', IntToStr(piecesnums)); // �а�����
      printValue.Add('totalfeecountmoney', FloatToStr(totalfeemoney)); // �ܽ��
      printValue.Add('sellbyname', sysInfo.LoginUserInfo.UserName); // ǩ����
      printValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss', Now));
      // ǩ��ʱ��
      printValue.Add('sendstation', sendstation); // ǩ��վ
      { printValue.Add('sendstationvalue', sendstationvalue);//����վ
        printValue.Add('tostationvalue', tostationvalue);//Ŀ�ĵ�
        printValue.Add('goodname', name);//��������



        printValue.Add('packno', packno);//�а�����
        printValue.Add('invoiceno', invoiceno);//��Ʊ��
        printValue.Add('sellbyname', sellbyname);//������
        printValue.Add('pieces', pieces);//����
        printValue.Add('weight', weight);//����
        printValue.Add('volume', volume);//���
        printValue.Add('packaed', packaed);//��װ��ֽ�䡢���ϴ����ޣ�
        printValue.Add('shippricemoney', shippricemoney);//���˷�
        printValue.Add('packfeemoney', packfeemoney);//��װ��
        printValue.Add('handfeemoney', handfeemoney);//װж��
        printValue.Add('deliveryfeemoney', deliveryfeemoney);//�ͻ���
        //printValue.Add('custodialmoney', custodialmoney);//���ܷ�
        printValue.Add('transitfeemoney', transitfeemoney);//��ת��
        printValue.Add('insuredamountmoney', insuredamountmoney);//���۽��
        printValue.Add('insurancefeemoney', insurancefeemoney);//���۷�
        printValue.Add('insurancemoney', insurancemoney);//���շ�
        printValue.Add('otherfeemoney', otherfeemoney);//��������
        printValue.Add('totalfeemoney', totalfeemoney);//�ϼƽ��
        //printValue.Add('location', location);//���λ��
        printValue.Add('packpricemoney', packpricemoney);//���ջ���
        printValue.Add('sender', sender);//������
        printValue.Add('senderphone', senderphone);//�����˵绰
        printValue.Add('senderaddress', senderaddress);//�����˵�ַ
        printValue.Add('consignee', consignee);//�ջ���
        printValue.Add('consigneephone', consigneephone);//�ջ��˵绰
        printValue.Add('consigneeaddress', consigneeaddress);//�ջ��˵�ַ
        printValue.Add('certificatetype', certificatetype);//֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
        printValue.Add('certificateno', certificateno);//֤������
        printValue.Add('shiptype', shiptype);//���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
        printValue.Add('paymethod', paymethod);//���ʽ���ָ����Ḷ��ȡ�����ֵ�
        printValue.Add('valuables', valuables);//�Ƿ������Ʒ
        printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));//��ӡʱ��
        printValue.Add('remarks', remarks);//��������
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
