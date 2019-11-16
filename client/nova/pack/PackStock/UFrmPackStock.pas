unit UFrmPackStock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox,
  Generics.Collections,NovaPrint;

type
  TFrmPackStock = class(TSimpleCRUDForm)
    jcdspackwaste: TjsonClientDataSet;

    jcdsResultid: TLargeintField;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResultSENDSTATIONID: TLargeintField;
    jcdsResultsendstationname: TWideStringField;
    jcdsResultTOSTATIONID: TLargeintField;
    jcdsResulttostationname: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultSCHEDULEID: TLargeintField;
    jcdsResultschedulename: TWideStringField;
    jcdsResultVEHICLEID: TLargeintField;
    jcdsResultvehiclecode: TWideStringField;
    jcdsResultdepartdate: TDateTimeField;
    jcdsResultpackno: TWideStringField;
    jcdsResultinvoiceno: TWideStringField;
    jcdsResultSELLBY: TLargeintField;
    jcdsResultsellbyname: TWideStringField;
    jcdsResultpieces: TIntegerField;
    jcdsResultvolume: TWideStringField;
    jcdsResultPACKED: TWideStringField;
    jcdsResultshipprice: TFloatField;
    jcdsResultpackfee: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResultcustodial: TFloatField;
    jcdsResulttransitfee: TFloatField;
    jcdsResultinsuredamount: TFloatField;
    jcdsResultinsurancefee: TFloatField;
    jcdsResultinsurance: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultlocation: TWideStringField;
    jcdsResultpackprice: TFloatField;
    jcdsResultsender: TWideStringField;
    jcdsResultsenderphone: TWideStringField;
    jcdsResultsenderaddress: TWideStringField;
    jcdsResultconsignee: TWideStringField;
    jcdsResultconsigneephone: TWideStringField;
    jcdsResultconsigneeaddress: TWideStringField;
    jcdsResultcertificateno: TWideStringField;
    jcdsResultvaluables: TBooleanField;
    jcdsResultPACKTTURNOVERID: TLargeintField;
    jcdsResultremak: TWideStringField;
    jcdsResultORGID: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultupdatebyname: TWideStringField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    Label1: TLabel;
    nvedtname: TNovaEdit;
    Label3: TLabel;
    nvhelptostation: TNovaHelp;
    jcdspackedvalue: TjsonClientDataSet;
    jcdcertificatetypevalue: TjsonClientDataSet;
    jcdshiptypevalue: TjsonClientDataSet;
    jcdspaymethodvalue: TjsonClientDataSet;
    jcdsResultpackedvalue: TWideStringField;
    jcdsResultCERTIFICATETYPE: TWideStringField;
    jcdsResultcertificatetypevalue: TWideStringField;
    jcdsResultSHIPTYPE: TWideStringField;
    jcdsResultshiptypevalue: TWideStringField;
    jcdsResultPAYMETHOD: TWideStringField;
    jcdsResultpaymethodvalue: TWideStringField;
    jcdsstatusvalue: TjsonClientDataSet;
    jcdsResultSTATUS: TWideStringField;
    jcdsResultstatusvalue: TWideStringField;
    nvcbborg: TNovaCheckedComboBox;
    jcdsgoodtypevalue: TjsonClientDataSet;
    jcdsResultGOODTYPE: TWideStringField;
    jcdsResultgoodtypevalue: TWideStringField;
    jcdsResultdeliveryfee: TFloatField;
    Label4: TLabel;
    nvcbbpackstatus: TNovaComboBox;
    Label5: TLabel;
    nvedtsenderphone: TNovaEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    nvcbbpaymethod: TNovaComboBox;
    nvhelpvehiclecode: TNovaHelp;
    jcdsResultischoose: TBooleanField;
    jcdspacktypevalue: TjsonClientDataSet;
    jcdsResultPACKTYPE: TWideStringField;
    jcdsResultpacktypevalue: TWideStringField;
    jcdsrevenue: TjsonClientDataSet;
    jcdsrevenueacceptpieces: TLargeintField;
    jcdsrevenueaccepttotalfee: TFloatField;
    jcdsrevenuegoodspieces: TLargeintField;
    jcdsrevenuegoodstotalfee: TFloatField;
    jcdsrevenuepkuppieces: TLargeintField;
    jcdsrevenuepkuptotalfee: TFloatField;
    jcdsResultunloadfee: TFloatField;
    jcdsResultsignby: TLargeintField;
    jcdsResultsignbyname: TWideStringField;
    jcdsResultsigntime: TDateTimeField;
    jcdsResultweight: TFloatField;
    jcdscancelPack: TjsonClientDataSet;
    lblsingbillno: TLabel;
    nvedtsingbillno: TNovaEdit;
    jcdsResultsingbillno: TWideStringField;
    tbtnpackbill: TToolButton;
    lblpackno: TLabel;
    nvedtpackno: TNovaEdit;
    nvhlpseller: TNovaHelp;
    jcdsResultbalancestatus: TWideStringField;
    jcdsbalancestatus: TjsonClientDataSet;
    jcdsResultbalancestatusname: TWideStringField;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    jcdsPackIsdepart: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtnpackbillClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    ispacksgbill, ispackrebill,isprintbynewticketno: Boolean; // �ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��
    cancelMonth, wasteMonth: Integer; // ���ٷ����ڿ���ȡ��ǩ�������졣
    billPackPrint: TNovaPrint;
    printPackValue: TDictionary<String, String>; // ���������
    multiplePacklist: TList < TDictionary < String, String >> ; // ������ݼ�
    multiplePackValueValue: TDictionary<String, String>;
    procedure printpack;
    procedure showpackbill;
    procedure PrintClink(scheduleid: int64;singbillno:string);
    procedure refreshBill; // ˢ��Ʊ��

  public
    { Public declarations }
    totaldeliveryfee: Integer;
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmPackStock: TFrmPackStock;

implementation

uses UFrmPackReceive, UFrmSelSchPlan, UFrmRevenue, DateUtils, UFrmOut,UFrmPackReprintbillno,
  UFrmSelSchPlan2;
{$R *.dfm}

procedure TFrmPackStock.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackStock.showpackbill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then
  begin

  end
  else
  begin

  end;

end;

procedure TFrmPackStock.FormActivate(Sender: TObject);
begin
  inherited;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackStock.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbpackstatus.Active := true;
  //nvcbbshiptype.Active := true;
  //nvcbbpaymethod.Active := true;

  cancelMonth := StrToInt(getParametervalue('8018', Sysinfo.LoginUserInfo.OrgID)
    );
  wasteMonth := StrToInt(getParametervalue('8019', Sysinfo.LoginUserInfo.OrgID)
    );

end;

procedure TFrmPackStock.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F1) then
  begin
     tbtnFilterClick(Sender);
  end
  else if (Key = VK_F2) then
  begin
     tbtnInsertClick(sender);
  end
  else if (Key = VK_F3) then
  begin
     //tbtnEditClick(sender);
  end
  else if (Key = VK_F4) then
  begin
     tbtnDeleteClick(sender);
  end
  else if (Key = VK_F5) then
  begin
     ToolButton50Click(sender);
  end
  else if (Key = VK_F6) then
  begin
     tbtnSaveClick(sender);
  end
  else if (Key = VK_F7) then
  begin
     //tbtnCancelClick(sender);
  end;
  Key:=0;

end;

procedure TFrmPackStock.FormShow(Sender: TObject);
begin
  inherited;

  jcdspackedvalue.Active := true;
  jcdcertificatetypevalue.Active := true;
  jcdshiptypevalue.Active := true;
  jcdspaymethodvalue.Active := true;
  jcdsstatusvalue.Active := true;
  jcdsgoodtypevalue.Active := true;
  jcdspacktypevalue.Active := true;
  jcdsbalancestatus.Active :=True;
  nvcbborg.Active := true;
   nvcbbpaymethod.Active := true;
end;

procedure TFrmPackStock.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(Key) = '{85CC75A6-5CD3-4A3A-95B1-CC8446C0B3D7}' then
  begin
    tbtnInsert.Visible := aEnable;
  end;

  if GUIDToString(Key) = '{E70A3BB1-439D-4AF9-998E-03683F3A8724}' then
  begin
    tbtnEdit.Visible := aEnable;
  end;

    if GUIDToString(Key) = '{768A0E0B-67C9-469B-AA03-FC42A6EAEED7}' then
  begin
    tbtnDelete.Visible := aEnable;
  end;
    if GUIDToString(Key) = '{85DCD5E8-70F6-4BF4-A12E-74E16023C12C}' then
  begin
    ToolButton50.Visible := aEnable;
  end;
    if GUIDToString(Key) = '{7FF861FF-F1D7-4127-8716-F0A50EE22AA6}' then
  begin
    tbtnSave.Visible := aEnable;
  end;
    if GUIDToString(Key) = '{B21C90E6-9947-487A-ADA6-40D7FD020E6A}' then
  begin
    tbtnCancel.Visible := aEnable;
  end;

end;

procedure TFrmPackStock.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ((cancelMonth = 0) and (jcdsResult.FieldByName('status').AsString = '1')) then
      begin
         tbtnSave.Enabled:=True;
      end
  else
  begin
    tbtnSave.Enabled:=False;
  end;
end;

procedure TFrmPackStock.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackStock.tbtnDeleteClick(Sender: TObject);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
  inherited;
 { if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ���Ϣ������') then
    begin
      Exit;
    end;

    with jcdspackwaste do
    begin

      Active := false;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('���а���ǩ�����޷�������');
        Exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('���а��Ѵ����޷�������');
        Exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '3' then
      begin
        SysDialogs.ShowInfo('���а��ѷ���,�޷��ٴη�����');
        Exit;
      end;

      if jcdsResult.FieldByName('createby').AsString = '0' then
      begin
        SysDialogs.ShowInfo('������������,�޷�������');
        Exit;
      end;

      Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['pack.status'] := '3';

      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        tbtnFilter.Click;
      end;
    end;
    // jcdsResult.Delete;
    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ���ϵļ�¼��');
  end; }

  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 0 then
    Exit;
  if jcdsResult.FieldByName('status').Value <> '1' then
  begin
    SysDialogs.Warning('���а�û��ǩ�������ܲ���');
    Exit;
  end;
  if not checkBillno('BalanceBill') then
    Exit;
  try
    printPackValue := TDictionary<String, String>.Create;
    if not Assigned(billPackPrint) then
    begin
      billPackPrint := TNovaPrint.Create(self,
//        TNovaPrint.GetTicketModelName('������㵥', '������㵥'));
        TNovaPrint.GetTicketModelName('�а�ǩ����', '������㵥'));
    end;
    with jcdsQryPackItems do
    begin

      Active := false;

      Params.ParamValues['startdate'] := jcdsResult.FieldByName('departdate').AsString;

      Params.ParamValues['enddate'] := jcdsResult.FieldByName('departdate').AsString;

      Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('scheduleid').AsString;

      Params.ParamValues['isbukai'] := '1';
      Params.ParamValues['isreprint'] := '0';

      Params.ParamValues['filter_GED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_LED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := jcdsResult.FieldByName('scheduleid').AsString;;

      Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

      Active := true;

      if RecordCount < 1 then
      begin
        //SysDialogs.ShowMessage('�ð��û���а�ǩ��!');
        exit;
      end;

      multiplePacklist := TList < TDictionary < String, String >> .Create;
      while not Eof do
      begin
        sendstationname := FieldByName('sendstationname').AsString; // ����վ
        piecesnums := piecesnums + FieldByName('pieces').AsInteger; // �а��ܼ���
        totalfeemoney := totalfeemoney + FieldByName('totalfee').AsFloat; // �ܽ��
        balancetotalfeemoney := balancetotalfeemoney + FieldByName('balancefeecountmoney').AsFloat; //�����ܽ��
        multiplePackValueValue := TDictionary<String, String>.Create;
        multiplePackValueValue.Add('tostationvalue',
          FieldByName('tostationname').AsString); // ��վ
        multiplePackValueValue.Add('pieces', FieldByName('pieces').AsString);
        // ����
        multiplePackValueValue.Add('totalfeemoney',
          FieldByName('totalfee').AsString); // ���
        multiplePackValueValue.Add('packno', FieldByName('packno').AsString);
        // �а����˵���

        multiplePackValueValue.Add('balancefeecountmoney',
          FieldByName('balancefeecountmoney').AsString); // ������
        multiplePacklist.Add(multiplePackValueValue);
        next;
      end;

    // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�

      printPackValue.Clear;

      with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;;
          Params.ParamValues['filter_LED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := jcdsResult.FieldByName('scheduleid').AsString;;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          Execute;

        end;

      if getParametervalue('8088', Sysinfo.LoginUserInfo.OrgID) = '1' then
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']); // ǩ������

        with Sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('BalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill']) + 1),
              length(curBillNo.Items['BalanceBill'])));
          curBillNum.AddOrSetValue('BalanceBill',
            curBillNum.Items['BalanceBill'] - 1);
        end;
        refreshBill;

      end
      else
      begin
        printPackValue.Add('singbillno', ''); // ǩ������
      end;
      printPackValue.Add('fillopen','����');
      printPackValue.Add('departdate',Params.ParamValues['packStockVo.departdate']); // ��������
      // ����ʱ��
      printPackValue.Add('departtime', Params.ParamValues['packStockVo.departtime']);
      printPackValue.Add('schedulevalue', Params.ParamValues['packStockVo.code']); // ���
      printPackValue.Add('vehiclevalue', Params.ParamValues['packStockVo.vehicleno']);
      // ���ƺ�
      printPackValue.Add('drivername', Params.ParamValues['packStockVo.drivername']);
      // ��ʻԱ
      printPackValue.Add('unitname', Params.ParamValues['packStockVo.unitname']); // Ӫ�˵�λ
      printPackValue.Add('sellbyname', Sysinfo.LoginUserInfo.UserName); // ǩ����
      printPackValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss',
          now));
      // ǩ��ʱ��
      printPackValue.Add('sendstation', sendstationname); // ǩ��վ

      printPackValue.Add('piecesnums', inttostr(piecesnums)); // �а�����
      printPackValue.Add('totalfeecountmoney', floattostr(totalfeemoney));// �ܽ��
      printPackValue.Add('balancetotalfeecountmoney', floattostr(balancetotalfeemoney));// �����ܽ��

    end;
    billPackPrint.MultipleValue := multiplePacklist;

    billPackPrint.SingleValue := printPackValue;
    billPackPrint.Print;


  finally

  end;




end;

procedure TFrmPackStock.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  // nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvcbborg.SetFocus;
    Exit;
  end;
  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_p!orgid'] := nvcbborg.GetSelectID;

    Params.ParamValues['filter_EQS_p!packtype'] := '0';
    Params.ParamValues['filter_GED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime + 1);

    if nvhelptostation.id > 0 then
      Params.ParamValues['filter_EQL_p!tostationid'] := nvhelptostation.id
    else
      Params.ParamValues['filter_EQL_p!tostationid'] := '';

    Params.ParamValues['filter_LIKES_p!sender_OR_p!consignee'] := Trim(nvedtname.Text);

    Params.ParamValues['filter_LIKES_p!singbillno'] := Trim(nvedtsingbillno.Text);

    Params.ParamValues['filter_LIKES_p!packno'] := Trim(nvedtpackno.Text);

    Params.ParamValues['filter_LIKES_p!senderphone_OR_p!consigneephone'] := Trim
      (nvedtsenderphone.Text);

    if nvhlpseller.id > 0 then
      Params.ParamValues['filter_EQL_p!sellby'] := nvhlpseller.id
    else
      Params.ParamValues['filter_EQL_p!sellby'] := '';

    if nvhelpvehiclecode.id > 0 then
      Params.ParamValues['filter_EQL_p!vehicleid'] := nvhelpvehiclecode.id
    else
      Params.ParamValues['filter_EQL_p!vehicleid'] := '';

  {  if nvcbbshiptype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!shiptype'] := ''
    else
      Params.ParamValues['filter_EQS_p!shiptype'] :=
        nvcbbshiptype.GetSelectCode;     }

    if nvcbbpaymethod.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!paymethod'] := ''
    else
      Params.ParamValues['filter_EQS_p!paymethod'] :=
        nvcbbpaymethod.GetSelectCode;

    if nvcbbpackstatus.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!status'] := ''
    else
      Params.ParamValues['filter_EQS_p!status'] :=
        nvcbbpackstatus.GetSelectCode;

    //jcdsResult.AfterScroll := nil;

    Active := true;

  end;
end;

procedure TFrmPackStock.tbtnInsertClick(Sender: TObject);
var
  i, id: Integer;
  pids, sids,pknos: string;
  departdate: string;
  departtime: TDatetime;
  sendstationid,tostationid: string;
  piecescount: Integer;
  totalfeecountmoney: Double;
  sendstationname,templtename: string;
  isclose: Boolean;

  multiplelists: TList < TDictionary < String, String >> ; // ������ݼ�
  multipleValueValue: TDictionary<String, String>;
begin
  inherited;
  if getParametervalue('8006', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    if not Assigned(billPackPrint) then
    begin
      templtename := TNovaPrint.GetTicketModelName('�а�ǩ����', '������㵥');
      billPackPrint := TNovaPrint.Create(self, templtename);

      //TNovaPrint.Create(self,
//        TNovaPrint.GetTicketModelName('������㵥', '������㵥'));
       // TNovaPrint.GetTicketModelName('�а�ǩ����', '������㵥'));

    end;
    if ((ispacksgbill = true) and (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] = 0)) then
    begin
      if (initBillNo('PackSgBill')) then
      begin
        if (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] = 0) then
        begin
          SysDialogs.Warning('����ǰ�ĵ��������꣬��������ȡ��Ʊ��');
          Exit;
          // result := false;
        end
        else
          showpackbill();
        // result := true;

      end;
    end
    else
    begin
      if not checkBillno('PackSgBill') then
      begin
        SysDialogs.ShowInfo('δ���а�ǩ����Ʊ��,�޷�ǩ����');
        ispacksgbill := false;
        Exit;
      end
      else
      begin
        ispacksgbill := true;
      end;
    end;

    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackSgBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackSgBill') and
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackSgBill'] > 0) then
    begin

    end
    else
    begin
      SysDialogs.ShowInfo('δ���а�ǩ����Ʊ��,�޷�ǩ����');
      Exit;
    end;
  end;

  if  (dsResult.DataSet.Active) and  (dsResult.DataSet.RecordCount>0) then
  begin
    i := 0;
    if not Assigned(billPackPrint) then
    begin
      templtename := TNovaPrint.GetTicketModelName('�а�ǩ����', '������㵥');
      billPackPrint := TNovaPrint.Create(self, templtename);
    end;
    with jcdsResult do
    begin
      DisableControls;
      try
        First;

      multiplelists := TList < TDictionary < String, String >> .Create;
      while not eof do
      begin

        if FieldByName('ischoose').AsBoolean then
        begin
          if tostationid <> '' then
          begin
            if tostationid <> FieldByName('tostationid').AsString then
            begin
              SysDialogs.ShowMessage('ֻ�ܶ�ͬһ��Ŀ�ĵص��а���������ǩ����');
              Exit;
            end;
          end
          else
          begin
          tostationid := FieldByName('tostationid').AsString;
          end;



          if (Sysinfo.LoginUserInfo.StationID <> FieldByName('SENDSTATIONID')
              .AsInteger) and (Sysinfo.LoginUserInfo.OrgID <> FieldByName
              ('orgid').AsInteger) then
          begin
            SysDialogs.ShowInfo('ֻ�ܶԱ�վ����а�����ǩ��������');
            Exit;
          end;

          if sendstationid <> '' then
          begin
            if sendstationid <> FieldByName('sendstationid').AsString then
            begin
              SysDialogs.ShowMessage('ֻ�ܶ�ͬһ������վ���а���������ǩ����');
              Exit;
            end;
          end
          else
            sendstationid := FieldByName('sendstationid').AsString;

          if FieldByName('packtype').AsString <> '0' then
          begin
            SysDialogs.ShowMessage('���������а����ܽ���ǩ����');
            Exit;
          end;

          if ((FieldByName('status').AsString <> '0') and
              (FieldByName('packtype').AsString = '0')) then
          begin
            SysDialogs.ShowMessage('���ڿ��״̬���а�����ǩ����');
            Exit;
          end;

          if departdate <> '' then
          begin
            if FormatDateTime('yyyy-MM-dd',
              FieldByName('departdate').AsDateTime) <> departdate then
            begin
              SysDialogs.ShowMessage('ѡ����а��������ڲ���ͬһ�죡');
              Exit;
            end;
          end
          else
            departdate := FormatDateTime('yyyy-MM-dd',
              FieldByName('departdate').AsDateTime);

          departtime := FieldByName('departdate').AsDateTime;

          if i <> 0 then
          begin
            pids := pids + ',' + FieldByName('id').AsString;
            sids := sids + ',' + FieldByName('TOSTATIONID').AsString;
            pknos := pknos + ',' + FieldByName('packno').AsString;

          end
          else
          begin
            pids := FieldByName('id').AsString;
            sids := FieldByName('TOSTATIONID').AsString;
            pknos := FieldByName('packno').AsString;
            id := FieldByName('id').AsInteger; // û�����ô���ֻ����������
          end;

          i := i + 1;
          sendstationname := FieldByName('sendstationname').AsString; // ����վ
          piecescount := piecescount + FieldByName('pieces').AsInteger; // �ܼ���
          totalfeecountmoney := totalfeecountmoney + FieldByName('totalfee')
            .AsInteger; // �ܽ��
          // ���ݼ�
          multipleValueValue := TDictionary<String, String>.Create;
          multipleValueValue.Add('packno', FieldByName('packno').AsString);
          // ���˵���
          multipleValueValue.Add('sender', FieldByName('sender').AsString);
          // ������
          multipleValueValue.Add('senderphone',
            FieldByName('senderphone').AsString); // �����˵绰
          multipleValueValue.Add('tostationvalue',
            FieldByName('tostationname').AsString); // ��վ
          multipleValueValue.Add('consignee',
            FieldByName('consignee').AsString); // �ջ���
          multipleValueValue.Add('consigneephone',
            FieldByName('consigneephone').AsString); // �ջ��˵绰
          multipleValueValue.Add('pieces', FieldByName('pieces').AsString);
          // ����
          multipleValueValue.Add('totalfeemoney',
            FieldByName('totalfee').AsString); // ���
          multipleValueValue.Add('shippricemoney',
            FieldByName('shipprice').AsString); // ���˷�
          multipleValueValue.Add('packfeemoney',
            FieldByName('packfee').AsString); // ��װ��
          multipleValueValue.Add('handfeemoney',
            FieldByName('handfee').AsString); // װж��
          multipleValueValue.Add('deliveryfeemoney',
            FieldByName('deliveryfee').AsString); // �ͻ���
          multipleValueValue.Add('transitfeemoney',
            FieldByName('transitfee').AsString); // ��ת��
          multipleValueValue.Add('insuredamountmoney',
            FieldByName('insuredamount').AsString); // ������ֵ
          multipleValueValue.Add('insurancefeemoney',
            FieldByName('insurancefee').AsString); // ���۷�
          multipleValueValue.Add('insurancemoney',
            FieldByName('insurance').AsString); // ���շ�
          multipleValueValue.Add('otherfeemoney',
            FieldByName('otherfee').AsString); // ��������
          multipleValueValue.Add('packpricemoney',
            FieldByName('packprice').AsString); // ���ջ���
          multiplelists.Add(multipleValueValue);
//          billPackPrint.MultipleValue := multiplelists;
//
//          billPackPrint.Print;
        end;
        Next;
      end;
      finally
        EnableControls;

      end;
      {if i < 1 then
      begin
        SysDialogs.ShowMessage('�빴ѡ��Ҫ����ǩ�����а���');
        Exit;
      end; }
    end;


  end;
  if i < 1 then
  begin
    FrmSelSchPlan := TFrmSelSchPlan.Create(self);
    try
      with FrmSelSchPlan do
      begin
      //
          packids := pids;
          stationids := sids;
          departdate := departtime;
          dtpstartdate.DateTime := departtime;
          piecesnums := piecescount;
          totalfeemoney := totalfeecountmoney;
          sendstation := sendstationname;
          multiplelist := multiplelists;
          packnos:=pknos;
      //
        if SysMainForm.showFormModal(FrmSelSchPlan, false) = mrOk then
        begin
            FrmPackStock.tbtnFilterClick(self);
        end;
      end;
    finally
      begin
          FreeAndNil(FrmSelSchPlan);
      end;

    end;
  end
  else
  begin
      FrmSelSchPlan2 := TFrmSelSchPlan2.Create(self);
      try
        with FrmSelSchPlan2 do
        begin
          packids := pids;
          stationids := sids;
          departdate := departtime;
          dtpstartdate.DateTime := departtime;
          piecesnums := piecescount;
          totalfeemoney := totalfeecountmoney;
          sendstation := sendstationname;
          multiplelist := multiplelists;
          packnos:=pknos;
         // SysDialogs.ShowMessage('----pknos---: '+pknos);

          //isclose := true;
          if SysMainForm.showFormModal(FrmSelSchPlan2, false) = mrok then
          begin
            FrmPackStock.tbtnFilterClick(self);
          end;
        end;
      finally
        begin
          //FreeAndNil(FrmSelSchPlan2);
          // FrmSelSchPlan.Free;
          // if Assigned(multiplelists) then
          // multiplelists.Free;
          // FrmSelSchPlan.Close;
        end;
      end;

  end;


end;

procedure TFrmPackStock.tbtnpackbillClick(Sender: TObject);
begin
  inherited;
  if not checkBillno('BalanceBill') then
    exit;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (jcdsResult.FieldByName('schedulecode').AsString='')  then
  begin
    SysDialogs.Warning('���а���δǩ����');
    exit;
  end;

  if not SysDialogs.Confirm('��ʾ��Ϣ', 'ȷ�Ͻ����ش������') then
  begin
    exit;
  end;

  FrmPackReprintbillno := TFrmPackReprintbillno.Create(self);
  try
  with FrmPackReprintbillno do
  begin
    if SysMainForm.showFormModal(FrmPackReprintbillno, false) = mrok then
    begin
      if isprintbynewbillno=1 then
      begin
          isprintbynewticketno:=false;
      end
      else if isprintbynewbillno=2 then
      begin
          isprintbynewticketno:=true;
      end
      else
      begin
           exit;
      end;
    end;
  end;
  finally
    FreeAndNil(FrmPackReprintbillno);
  end;

  PrintClink(jcdsResult.FieldByName('scheduleid').AsLargeInt,jcdsResult.FieldByName('singbillno').AsString);

end;

procedure TFrmPackStock.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;

  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ��а�ȡ��ǩ����') then
    begin
      Exit;
    end;
    with jcdsResult do
    begin
      if FieldByName('packtype').AsString <> '0' then
      begin
        SysDialogs.ShowMessage('���������а����ܽ���ȡ��ǩ��������');
        Exit;
      end;

      if ((FieldByName('status').AsString <> '1') and
          (FieldByName('packtype').AsString = '0')) then
      begin
        SysDialogs.ShowMessage('ֻ�ܶ���ǩ�����а�����ȡ��ǩ��������');
        Exit;
      end;

      if FieldByName('balancestatus').AsString = '1' then
      begin
        SysDialogs.ShowMessage('�а��Ѿ����㣬����ȡ��ǩ����');
        Exit;
      end;

      if Sysinfo.LoginUserInfo.StationID <> FieldByName('SENDSTATIONID')
        .AsInteger then
      begin
        SysDialogs.ShowInfo('ֻ�ܶԱ�վ�����ǩ���а�����ȡ��ǩ��������');
        Exit;
      end;
//       if cancelMonth = 0 then
//       begin
//         SysDialogs.ShowMessage('�а����ܽ���ȡ��ǩ��������');
//        Exit;
//       end

       //else
       if (cancelMonth <> 0) and (StrToFloat(FormatDateTime('yyyyMMddHHmm',
            Now())) - StrToFloat(FormatDateTime('yyyyMMddHHmm',
            FieldByName('updatetime').AsDateTime)) > cancelMonth) then
      begin
        SysDialogs.ShowMessage('ֻ�ܶ���ǩ����' + IntToStr(cancelMonth)
            + '�����ڵ��а�����ȡ��ǩ��������');
        Exit;
      end;

    end;

    with jcdsPackIsdepart do
    begin
         Active := false;
         Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
         Active := true;
         if RecordCount>0 then
         begin
            SysDialogs.ShowMessage('�а��ѷ��࣬����ȡ��ǩ����');
            Exit;
         end;
    end;

    with jcdscancelPack do
    begin
      Active := false;
      Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['pack.packtype'] := jcdsResult.FieldByName('packtype')
        .AsString;
      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫȡ��ǩ�����а���');
  end;
end;

procedure TFrmPackStock.ToolButton50Click(Sender: TObject);
begin
  inherited;

  FrmRevenue := TFrmRevenue.Create(self);
  try
    with FrmRevenue do
    begin
      if SysMainForm.showFormModal(FrmRevenue, false) = mrOk then
      begin
        tbtnFilter.Click;
      end;
    end;
  finally
    FreeAndNil(FrmRevenue);
  end;
end;

procedure TFrmPackStock.ToolButton51Click(Sender: TObject);
var
  deliveryfeeperkg, selectRows: Integer;
  packids: String;

begin
  inherited;
  packids := '';
  totaldeliveryfee := 0;
  selectRows := 0;
  with jcdsResult do
{$REGION 'Inner if Region'}
  begin
    if (Active = true) and (RecNo > 0) then
    begin
      First;
      while (not eof) do
      begin
        if FieldByName('ischoose').AsBoolean then
        begin
          selectRows := selectRows + 1;
          if (FieldByName('packtype').AsString <> '1') then
          begin
            SysDialogs.ShowMessage('ֻ�ܶԵ������а����г��������');
            Exit;
          end;
          if (FieldByName('status').AsString <> '0') then
          begin
            SysDialogs.ShowMessage('���ڿ��״̬���а����ܳ��⣡');
            Exit;
          end;
          packids := packids + FieldByName('id').AsString + ',';
        end;
        Next;
      end;
    end;
    if selectRows <= 0 then
    begin
      Exit;
    end;
  end;
{$ENDREGION}

  FrmOutEdit := TFrmOutEdit.Create(self);
  try
    with FrmOutEdit do
    begin
      curpackids:=packids;
      if SysMainForm.showFormModal(FrmOutEdit, false) = mrOk then
      begin
        tbtnFilter.Click;
      end;
    end;
  finally
    FreeAndNil(FrmOutEdit);
  end;
end;

procedure TFrmPackStock.printpack();
begin

end;

procedure TFrmPackStock.PrintClink(scheduleid: int64;singbillno:string);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
   try
    printPackValue := TDictionary<String, String>.Create;
    if not Assigned(billPackPrint) then
    begin
      billPackPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('������㵥', '������㵥'));
    end;
    with jcdsQryPackItems do
    begin

      Active := false;

      Params.ParamValues['startdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['enddate'] := jcdsResult.FieldByName('departdate').AsString;

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '0';

      Params.ParamValues['filter_GED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_LED_ss!departdate'] := jcdsResult.FieldByName('departdate').AsString;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

      if isprintbynewticketno then //�º��ش�
      begin
          Params.ParamValues['departinvoicesno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
      end
      else
      begin
         Params.ParamValues['departinvoicesno'] := singbillno+'ԭ���ش�';
      end;


      Active := true;

      if RecordCount < 1 then
      begin
        //SysDialogs.ShowMessage('�ð��û���а�ǩ��!')
        exit;
      end;

      multiplePacklist := TList < TDictionary < String, String >> .Create;
      while not Eof do
      begin
        sendstationname := FieldByName('sendstationname').AsString; // ����վ
        piecesnums := piecesnums + FieldByName('pieces').AsInteger; // �а��ܼ���
        totalfeemoney := totalfeemoney + FieldByName('totalfee').AsFloat; // �ܽ��
        balancetotalfeemoney := balancetotalfeemoney + FieldByName('balancefeecountmoney').AsFloat; //�����ܽ��
        multiplePackValueValue := TDictionary<String, String>.Create;
        multiplePackValueValue.Add('tostationvalue',
          FieldByName('tostationname').AsString); // ��վ
        multiplePackValueValue.Add('pieces', FieldByName('pieces').AsString);
        // ����
        multiplePackValueValue.Add('totalfeemoney',
          FieldByName('totalfee').AsString); // ���
        multiplePackValueValue.Add('packno', FieldByName('packno').AsString);
        // �а����˵���

        multiplePackValueValue.Add('balancefeecountmoney',
          FieldByName('balancefeecountmoney').AsString); // ������
        multiplePacklist.Add(multiplePackValueValue);
        next;
      end;

    // ǩ�����š��������ڡ���κš����ƺ��롢��ʻԱ��Ӫ�˵�λ���а��������ܽ�

      printPackValue.Clear;

      if isprintbynewticketno then     //�º��ش�
      begin
        printPackValue.Add('singbillno',
          Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill']);

        with jcdsUpdatepack do
        begin

          Active := false;

          Params.ParamValues['filter_GED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_LED_p!departdate'] := jcdsResult.FieldByName('departdate').AsString;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

          Params.ParamValues['singbillno'] :=
            Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];

          Execute;

        end;

        with Sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('BalanceBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill']) + 1),
              length(curBillNo.Items['BalanceBill'])));
          curBillNum.AddOrSetValue('BalanceBill',
            curBillNum.Items['BalanceBill'] - 1);
        end;
        refreshBill;

      end
      else
      begin
        printPackValue.Add('singbillno',singbillno); // ԭ���ش�
      end;

      printPackValue.Add('fillopen','�ش�');
      printPackValue.Add('departdate',Params.ParamValues['packStockVo.departdate']); // ��������
      // ����ʱ��
      printPackValue.Add('departtime', Params.ParamValues['packStockVo.departtime']);
      printPackValue.Add('schedulevalue', Params.ParamValues['packStockVo.code']); // ���
      printPackValue.Add('vehiclevalue', Params.ParamValues['packStockVo.vehicleno']);
      // ���ƺ�
      printPackValue.Add('drivername', Params.ParamValues['packStockVo.drivername']);
      // ��ʻԱ
      printPackValue.Add('unitname', Params.ParamValues['packStockVo.unitname']); // Ӫ�˵�λ
      printPackValue.Add('sellbyname', Sysinfo.LoginUserInfo.UserName); // ǩ����
      printPackValue.Add('printdate', formatdatetime('yyyy-MM-dd HH:mm:ss',
          now));
      // ǩ��ʱ��
      printPackValue.Add('sendstation', sendstationname); // ǩ��վ

      printPackValue.Add('piecesnums', inttostr(piecesnums)); // �а�����
      printPackValue.Add('totalfeecountmoney', floattostr(totalfeemoney));// �ܽ��
      printPackValue.Add('balancetotalfeecountmoney', floattostr(balancetotalfeemoney));// �����ܽ��

    end;
    billPackPrint.MultipleValue := multiplePacklist;

    billPackPrint.SingleValue := printPackValue;
    billPackPrint.Print;

  finally

  end;
end;

procedure TFrmPackStock.refreshBill;
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (SysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin

  end
  else
  begin
    SysDialogs.Warning('�����ý��㵥�ţ�');
  end;
end;

end.
