unit UFrmPackDepartinvoicesEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet,Generics.Collections, NovaPrint;

type
  TFrmPackDepartinvoicesEdit = class(TSimpleEditForm)
    lbl5: TLabel;
    edtstartdate: TNovaEdit;
    lbl2: TLabel;
    edtvehicletype: TNovaEdit;
    lbl3: TLabel;
    edtstartstation: TNovaEdit;
    lbl4: TLabel;
    edtendstation: TNovaEdit;
    Label1: TLabel;
    edtunit: TNovaEdit;
    Label2: TLabel;
    edtplanvehicle: TNovaEdit;
    lbl1: TLabel;
    edtschedule: TNovaEdit;
    lbl6: TLabel;
    edtstarttime: TNovaEdit;
    lbl7: TLabel;
    lbl9: TLabel;
    edtyeschecked: TNovaEdit;
    lbl10: TLabel;
    edtnochecked: TNovaEdit;
    jcdsFindPackDepNum: TjsonClientDataSet;
    dsResult: TDataSource;
    jcdsQryPackItems: TjsonClientDataSet;
    jcdsUpdatepack: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log: String;
    billPackPrint: TNovaPrint;
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printPackValue: TDictionary<String, String>; // ���������
    multiplePacklist: TList < TDictionary < String, String >> ; // ������ݼ�
    multiplePackValueValue: TDictionary<String, String>;
    procedure refreshBill; // ˢ��Ʊ��

  public
    { Public declarations }
    sign: Boolean;
    scheduleplanid, reportvehicleid, isdepartinvoices,scheduleid,
      templtename: string;
    vehicleno, brandname, typename, routename, balanceunitname, checkedname,
      departtime, departstation, endstation, code, unitname, d1name, d2name, d3name,
      d4name, s1name, seatnum, distance, departdate: string;
    vehicleid, newdepartinvoicesid,departinvoicesid: Int64;
  end;

var
  FrmPackDepartinvoicesEdit: TFrmPackDepartinvoicesEdit;

implementation
uses Services,PubFn;
{$R *.dfm}

procedure TFrmPackDepartinvoicesEdit.bbtnSaveClick(Sender: TObject);
var
  piecesnums: integer;
  totalfeemoney,balancetotalfeemoney: double;
  sendstationname: string;
begin
  inherited;
  if (edtnochecked.Text = '') or (StrToInt(edtnochecked.Text) = 0) then
  begin
    SysDialogs.ShowMessage('û��δ�����������ˣ����ý��в�����');
    Exit;
  end;
  if not checkBillno('BalanceBill') then
    Exit;
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

      Params.ParamValues['startdate'] := edtstartdate.Text;

      Params.ParamValues['enddate'] := edtstartdate.Text;

      Params.ParamValues['scheduleid'] := scheduleid;

      Params.ParamValues['isbukai'] := '1';
      Params.ParamValues['isreprint'] := '0';

      Params.ParamValues['filter_GED_ss!departdate'] := edtstartdate.Text;
      Params.ParamValues['filter_LED_ss!departdate'] := edtstartdate.Text;
      Params.ParamValues['filter_EQL_ss!departstationid'] :=
        Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['filter_INS_ss!status'] := '(0,2,4,5)';

      Params.ParamValues['filter_EQL_sd!id'] := scheduleid;

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

          Params.ParamValues['filter_GED_p!departdate'] := edtstartdate.Text;
          Params.ParamValues['filter_LED_p!departdate'] := edtstartdate.Text;
          Params.ParamValues['filter_EQS_p!status'] := '1';

          Params.ParamValues['filter_EQL_p!scheduleid'] := scheduleid;

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

    ModalResult := mrOk;
  finally

  end;




end;

procedure TFrmPackDepartinvoicesEdit.FormShow(Sender: TObject);
begin
  inherited;

  with jcdsFindPackDepNum do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['scheduleid'] := scheduleid;
    Params.ParamValues['departdate'] := departdate;

    Active := true;
  end;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount > 0 then
  begin
      edtyeschecked.Text := jcdsFindPackDepNum.FieldByName('yesfaban').AsString;
      edtnochecked.Text:=jcdsFindPackDepNum.FieldByName('nofaban').AsString;
  end;

end;

procedure TFrmPackDepartinvoicesEdit.refreshBill;
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
