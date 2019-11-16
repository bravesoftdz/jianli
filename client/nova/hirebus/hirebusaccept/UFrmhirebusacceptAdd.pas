unit UFrmhirebusacceptAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, ComCtrls, NovaPrint, Generics.Collections;

type
  TFrmHirebusacceptAdd = class(TSimpleEditForm)
    jcdssave: TjsonClientDataSet;
    Panel1: TPanel;
    memremarks: TMemo;
    Label11: TLabel;
    Label59: TLabel;
    nvedtfeetype: TNovaEdit;
    Label41: TLabel;
    Label34: TLabel;
    nvedtactpeople: TNovaEdit;
    Label33: TLabel;
    Label52: TLabel;
    Label9: TLabel;
    nvedtusehour: TNovaEdit;
    Label8: TLabel;
    nvhelpvehiclecode: TNovaHelp;
    Label5: TLabel;
    Label18: TLabel;
    Label3: TLabel;
    nvedtbasefee: TNovaEdit;
    nvedtdistance: TNovaEdit;
    Label25: TLabel;
    Label24: TLabel;
    Label23: TLabel;
    Label22: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    nvedthireunit: TNovaEdit;
    Label46: TLabel;
    nvedtinsurefee: TNovaEdit;
    Label47: TLabel;
    Label37: TLabel;
    nvedtfeerate: TNovaEdit;
    Label56: TLabel;
    Label50: TLabel;
    nvedttotalfee: TNovaEdit;
    Label53: TLabel;
    Label49: TLabel;
    nvedtotherfee: TNovaEdit;
    Label60: TLabel;
    Label29: TLabel;
    dtphiredate: TDateTimePicker;
    lblunitid: TLabel;
    nvhelpunitname: TNovaHelp;
    Label2: TLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label31: TLabel;
    dtpstartdate: TDateTimePicker;
    Label15: TLabel;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    Label10: TLabel;
    jcdsupdateBillinuse: TjsonClientDataSet;
    nvedtstartstation: TNovaHelp;
    nvedtendstation: TNovaHelp;
    Label12: TLabel;
    nvcbbtype: TNovaComboBox;
    Label14: TLabel;
    Label16: TLabel;
    CobDISTRICTTYPE: TNovaComboBox;
    Label17: TLabel;
    lbl1: TLabel;
    nvhlpdistrictid: TNovaHelp;
    Label19: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtbasefeeChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvhelpunitnameIdChange(Sender: TObject);
    procedure nvhelpvehiclecodeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    Foperationid: Integer;
    log: string;

    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������

    procedure printpack;
    procedure updatepackbill;

  public
    { Public declarations }
    hirebusid: Integer;
    createby: Integer;
    createTime: TDateTime;
    synccode: string;
    operater: Integer;
    orgid: Integer;
    operatername: string;
    orgname: string;
    ticketoutletsid: Integer;

    hireunit, hiredate, unitname, vehiclecode, startstation, endstation,
      distance, basefee, startdate, enddate, usehour, insurefee, actpeople,
      otherfee, feetype, feerate, totalfee, remark, hirebusno, hirebustype,
      tlname,districttype,districtname: string;

    property operationid: Integer read Foperationid;
  end;

var
  FrmHirebusacceptAdd: TFrmHirebusacceptAdd;

implementation

uses PubFn;
{$R *.dfm}

procedure TFrmHirebusacceptAdd.bbtnSaveClick(Sender: TObject);
var
  result: string;
begin
  inherited;

  if trim(nvedthireunit.Text) = '' then
  begin
    SysDialogs.ShowMessage('������λ����Ϊ��!');
    nvedthireunit.SetFocus;
    exit;
  end;

  if nvhelpunitname.Id <= 0 then
  begin
    SysDialogs.ShowMessage('��ѡ������λ!');
    nvhelpunitname.SetFocus;
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpstartdate.SetFocus;
    exit;
  end;

  if trim(nvedtstartstation.Text) = '' then
  begin
    SysDialogs.ShowMessage('������㲻��Ϊ��!');
    nvedtstartstation.SetFocus;
    exit;
  end;

  if trim(nvedtendstation.Text) = '' then
  begin
    SysDialogs.ShowMessage('������վ����Ϊ��!');
    nvedtendstation.SetFocus;
    exit;
  end;

  if nvcbbtype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ���������!');
    nvcbbtype.SetFocus;
    exit;
  end;

  if CobDISTRICTTYPE.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('��ѡ����������');
    CobDISTRICTTYPE.SetFocus;
    exit;
  end;

  if nvhlpdistrictid.Id <= 0 then
  begin
    SysDialogs.ShowMessage('��ѡ����������!');
    nvhlpdistrictid.SetFocus;
    exit;
  end;

  if trim(nvedtactpeople.Text) = '' then
  begin
    SysDialogs.ShowMessage('ʵ����������Ϊ��!');
    nvedtactpeople.SetFocus;
    exit;
  end;

  if trim(nvedtdistance.Text) = '' then
  begin
    SysDialogs.ShowMessage('�Ʒ���̲���Ϊ��!');
    nvedtdistance.SetFocus;
    exit;
  end;

  if (trim(nvedtusehour.Text) = '') then
  begin
    SysDialogs.ShowMessage('�Ʒ�ʱ�䲻��Ϊ��!');
    nvedtusehour.SetFocus;
    exit;
  end;

  if trim(nvedtfeetype.Text) = '' then
  begin
    SysDialogs.ShowMessage('�Ʒѷ�ʽ����Ϊ��!');
    nvedtfeetype.SetFocus;
    exit;
  end;

  if trim(nvedtbasefee.Text) = '' then
  begin
    SysDialogs.ShowMessage('�����˷Ѳ���Ϊ��!');
    nvedtbasefee.SetFocus;
    exit;
  end;

  if trim(nvedtinsurefee.Text) = '' then
  begin
    SysDialogs.ShowMessage('���շѲ���Ϊ��!');
    nvedtinsurefee.SetFocus;
    exit;
  end;

  if (trim(nvedtotherfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('�������ò���Ϊ��!');
    nvedtotherfee.SetFocus;
    exit;
  end;

  if (trim(nvedtfeerate.Text) = '') then
  begin
    SysDialogs.ShowMessage('���ʲ���Ϊ��!');
    nvedtfeerate.SetFocus;
    exit;
  end;

  if (trim(nvedttotalfee.Text) = '') then
  begin
    SysDialogs.ShowMessage('�ܷ��ò���Ϊ��!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  if StrToFloat(nvedttotalfee.Text) >= 1000000 then
  begin
    SysDialogs.ShowMessage('�ܷ�����ֵ������Χ(0~999999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;

  with jcdssave do
  begin
    Active := false;
    if self.edittype = Tedittype.update then
    begin
      Params.ParamValues['hirebus.id'] := IntToStr(hirebusid);
      Params.ParamValues['hirebus.createby'] := IntToStr(createby);
      Params.ParamValues['hirebus.createtime'] := FormatDateTime
        ('yyyy-mm-dd HH:mm:ss', createTime); ;
      // Params.ParamValues['hirebus.orgid'] := IntToStr(orgid);
      // Params.ParamValues['hirebus.operater']:= IntToStr(operater);
      Params.ParamValues['hirebus.synccode'] := synccode;
      Params.ParamValues['hirebus.ticketoutletsid'] := IntToStr
        (ticketoutletsid);

    end
    else
    begin
      orgid := SysInfo.LoginUserInfo.orgid;
      orgname := SysInfo.LoginUserInfo.orgname;
      operater := SysInfo.LoginUserInfo.UserID;
      operatername := SysInfo.LoginUserInfo.UserName;
      hirebusno := SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill'];
      ticketoutletsid := SysInfo.LoginUserInfo.ticketoutletsid;
      tlname := SysInfo.LoginUserInfo.ticketoutletsname;
    end;

    // ������λ
    hireunit := trim(nvedthireunit.Text);
    // ������λ
    self.unitname := trim(nvhelpunitname.Text);
    // ����
    vehiclecode := trim(nvhelpvehiclecode.Text);
    // �ó�����
    hiredate := FormatDateTime('yyyy-mm-dd', dtphiredate.DateTime);
    // hiredate := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    // ��ʼʱ��
    startdate := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    // ����ʱ��
    enddate := FormatDateTime('yyyy-mm-dd ', dtpenddate.DateTime);
    // �������
    startstation := trim(nvedtstartstation.Text);
    // ������վ
    endstation := trim(nvedtendstation.Text);
    // ʵ������
    actpeople := trim(nvedtactpeople.Text);
    // �Ʒ����
    distance := trim(nvedtdistance.Text);
    // �Ʒ�ʱ��
    usehour := trim(nvedtusehour.Text);
    // �Ʒѷ�ʽ
    feetype := trim(nvedtfeetype.Text);
    // �����˷�
    basefee := trim(nvedtbasefee.Text);
    // ���շ�
    insurefee := trim(nvedtinsurefee.Text);
    // ��������
    otherfee := trim(nvedtotherfee.Text);
    // ����
    feerate := trim(nvedtfeerate.Text);
    // �ܷ���
    totalfee := trim(nvedttotalfee.Text);
    // ��ע
    remark := trim(memremarks.Text);
    // ����
    hirebustype := trim(nvcbbtype.Text);
    districttype := trim(CobDISTRICTTYPE.Text);

    //��������
    districtname :=nvhlpdistrictid.Text;


    // ������λ
    Params.ParamByName('hirebus.hireunit').Value := hireunit;
    // ������λ
    Params.ParamByName('hirebus.unitid').Value := IntToStr(nvhelpunitname.Id);
    // ����
    if nvhelpvehiclecode.Id > 0 then
      Params.ParamByName('hirebus.vehicleid').Value := nvhelpvehiclecode.Id
    else
      Params.ParamByName('hirebus.vehicleid').Value := '';

    // �ó�����
    Params.ParamByName('hirebus.hiredate').Value := hiredate;
    // ��ʼʱ��
    Params.ParamByName('hirebus.startdate').Value := startdate;
    // ����ʱ��
    Params.ParamByName('hirebus.enddate').Value := enddate;
    // �������
    Params.ParamByName('hirebus.startstation').Value := startstation;
    // ������վ
    Params.ParamByName('hirebus.endstation').Value := endstation;
    // ʵ������
    Params.ParamByName('hirebus.actpeople').Value := actpeople;
    // �Ʒ����
    Params.ParamByName('hirebus.distance').Value := distance;
    // �Ʒ�ʱ��
    Params.ParamByName('hirebus.usehour').Value := usehour;
    // �Ʒѷ�ʽ
    Params.ParamByName('hirebus.feetype').Value := feetype;
    // �����˷�
    Params.ParamByName('hirebus.basefee').Value := basefee;

    // ���շ�
    Params.ParamByName('hirebus.insurefee').Value := insurefee;
    // ��������
    Params.ParamByName('hirebus.otherfee').Value := otherfee;
    // ����
    Params.ParamByName('hirebus.feerate').Value := feerate;
    // �ܷ���
    Params.ParamByName('hirebus.totalfee').Value := totalfee;
    // ��ע
    Params.ParamByName('hirebus.remark').Value := remark;
    // ����
    Params.ParamByName('hirebus.orgid').Value := orgid;
    // ������
    Params.ParamByName('hirebus.operater').Value := operater;
    // ״̬
    Params.ParamByName('hirebus.status').Value := '0';
    // ������
    Params.ParamByName('hirebus.hirebusno').Value := hirebusno;
    // ��������
    Params.ParamByName('hirebus.ticketoutletsid').Value := IntToStr
      (ticketoutletsid);
      //��������
    Params.ParamByName('hirebus.districttype').Value := CobDISTRICTTYPE.GetSelectCode;
    // ��Ʊ��
    Params.ParamByName('hirebus.type').Value := nvcbbtype.GetSelectCode;
    //��������
    Params.ParamByName('hirebus.districtid').Value := nvhlpdistrictid.Id;

    Execute;
    bbtnSave.Enabled := true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled := false;
      if self.edittype = Tedittype.update then
        result := '�޸�'
      else
        result := '���';
      log := result + VarToStr(Params.ParamValues['hirebusid'])
        + '����������=' + SysInfo.LoginUserInfo.orgname + ',' + result + '��=' +
        SysInfo.LoginUserInfo.UserName + ',����=' + hirebusno + ',��������=' +
        ',��������=' +districttype+ ',��������='+districtname+
        nvcbbtype.Text + ',��Ʊ��=' + tlname + ',������λ=' + trim(nvedthireunit.Text)
        + ',������λ=' + nvhelpunitname.Text + ',���ƺ�=' + nvhelpvehiclecode.Text +
        ',�ó�����=' + FormatDateTime('yyyy-mm-dd', dtphiredate.DateTime)
        + ',��ʼʱ��=' + FormatDateTime('yyyy-mm-dd',
        dtpstartdate.DateTime) + ',����ʱ��=' + FormatDateTime('yyyy-mm-dd',
        dtpenddate.DateTime) + ',�������=' + nvedtstartstation.Text + ',������վ' +
        nvedtendstation.Text + ',ʵ������=' + nvedtactpeople.Text + ',�Ʒ����=' +
        nvedtdistance.Text + ',�Ʒ�ʱ��=' + nvedtusehour.Text + ',�Ʒѷ�ʽ=' +
        nvedtfeetype.Text + ',�����˷�=' + nvedtbasefee.Text + ',���շ�=' +
        nvedtinsurefee.Text + ',��������=' + nvedtotherfee.Text + ',����=' +
        nvedtfeerate.Text + ',�ܷ���=' + nvedttotalfee.Text + ',��ע=' +
        memremarks.Text;
      SysLog.WriteLog('��������->������Ϣ', result, log);
      Foperationid := Params.ParamValues['hirebusid'];
      try
        if self.edittype = Tedittype.add then
        begin
          printpack;
          updatepackbill;
        end;
      finally
        self.ModalResult := mrOk;
      end;

    end;

  end;
end;

procedure TFrmHirebusacceptAdd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(printValue) then
    printValue.Free;
end;

procedure TFrmHirebusacceptAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbtype.Active := false;
  nvcbbtype.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;
end;

procedure TFrmHirebusacceptAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then

  else
  begin
    dtphiredate.DateTime := Now();
    dtpstartdate.DateTime := Now();
    dtpenddate.DateTime := Now();
    nvcbbtype.ItemIndex := 3;
  end;

end;

procedure TFrmHirebusacceptAdd.nvedtbasefeeChange(Sender: TObject);
var
  totalfeemoney: Double;
begin
  inherited;
  if (trim(nvedtbasefee.Text) <> '') then
  begin
    // �����˷�
    if StrToFloat(nvedtbasefee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('�����˷ѽ����ֵ������Χ(0~999999.99)!');
      nvedtbasefee.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtbasefee.Text));
  end;

  if (trim(nvedtinsurefee.Text) <> '') then
  begin
    // ���շ�
    if StrToFloat(nvedtinsurefee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('���շѽ����ֵ������Χ(0~999999.99)!');
      nvedtinsurefee.SetFocus;
      exit;
    end;

    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtinsurefee.Text));
  end;

  if (trim(nvedtotherfee.Text) <> '') then
  begin
    // ��������
    if StrToFloat(nvedtotherfee.Text) >= 1000000 then
    begin
      SysDialogs.ShowMessage('�������ý����ֵ������Χ(0~999999.99)!');
      nvedtotherfee.SetFocus;
      exit;
    end;
    totalfeemoney := totalfeemoney + StrToFloat(trim(nvedtotherfee.Text));
  end;

  nvedttotalfee.Text := FloatToStr(totalfeemoney);

  if totalfeemoney >= 1000000 then
  begin
    SysDialogs.ShowMessage('�ϼƽ����ֵ������Χ(0~999999.99)!');
    nvedttotalfee.SetFocus;
    exit;
  end;
end;

procedure TFrmHirebusacceptAdd.nvhelpunitnameIdChange(Sender: TObject);
var
  unitid, vehicleid: Integer;
  vehicleno: string;
begin
  inherited;
  if (nvhelpvehiclecode.Id > 0) then
  begin
    vehicleid := nvhelpvehiclecode.Id;
    vehicleno := nvhelpvehiclecode.Text;
  end;

  if (nvhelpunitname.Id > 0) then
  begin
    nvhelpvehiclecode.Params.ParamValues['filter_EQL_t!unitid'] :=
      nvhelpunitname.Id;
    if unitid <> nvhelpunitname.Id then
    begin
      nvhelpvehiclecode.Id := -1;
      nvhelpvehiclecode.Text := '';
    end
    else
    begin
      nvhelpvehiclecode.Id := vehicleid;
      nvhelpvehiclecode.Text := vehicleno;
    end;
    unitid := nvhelpunitname.Id;
  end
  else
  begin
    nvhelpvehiclecode.Id := -1;
    nvhelpvehiclecode.Text := '';
  end;
end;

procedure TFrmHirebusacceptAdd.nvhelpvehiclecodeClick(Sender: TObject);
begin
  inherited;
  if (nvhelpunitname.Id > 0) then
  begin
    nvhelpvehiclecode.Params.ParamValues['filter_EQL_t!unitid'] :=
      nvhelpunitname.Id;
  end
  else
  begin
    SysDialogs.ShowMessage('����ѡ������λ');
    nvhelpunitname.SetFocus;
  end;
end;

procedure TFrmHirebusacceptAdd.printpack();
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // ���������
  templtename: string;
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('������',
      '������'));
  printValue.Clear;

  // ������λ
  printValue.add('hireunit', hireunit);
  // ������λ
  printValue.add('unitname', unitname);
  // ����
  printValue.add('vehiclecode', vehiclecode);
  // �ó�����
  printValue.add('hiredate', hiredate);
  // ��ʼʱ��
  printValue.add('startdate', startdate);
  // ����ʱ��
  printValue.add('enddate', enddate);
  // �������
  printValue.add('startstation', startstation);
  // ������վ
  printValue.add('endstation', endstation);
  // ʵ������
  printValue.add('actpeople', actpeople);
  // �Ʒ����
  printValue.add('distance', distance);
  // �Ʒ�ʱ��
  printValue.add('usehour', usehour + '/h');
  // �Ʒѷ�ʽ
  printValue.add('feetype', feetype);
  // �����˷�
  printValue.add('basefee', basefee);
  // ���շ�
  printValue.add('insurefee', insurefee);
  // ��������
  printValue.add('otherfee', otherfee);
  // ����
  printValue.add('feerate', feerate);
  // �ܷ���
  printValue.add('totalfee', totalfee);
  // ��ע
  printValue.add('remark', remark);
  // ����
  printValue.add('orgname', orgname);
  // ������
  printValue.add('operatername', operatername);
  // ������
  printValue.add('hirebusno', hirebusno);
  // ��������
  printValue.add('typevalue', hirebustype);
  // ��Ʊ��
  printValue.add('ticketoutletsname', tlname);
  //��������
  printValue.Add('districttype',districttype);
  //��������
  printValue.Add('districtname',districtname);

  billPrint.SingleValue := printValue;
  billPrint.Print;

  ModalResult := mrOk;

end;

procedure TFrmHirebusacceptAdd.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with SysInfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill']));
    billinusenextno := IntToStr
      (strtoint64(SysInfo.LoginUserInfo.curBillNo.Items['HirebusBill'])
        + 1);

    curBillNo.AddOrSetValue('HirebusBill', zerofill(billinusenextno,
        length(curBillNo.Items['HirebusBill'])));
    curBillNum.AddOrSetValue('HirebusBill',
      curBillNum.Items['HirebusBill'] - 1);

    if curBillNum.Items['HirebusBill'] > 0 then
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
    Params.ParamValues['billtypecode'] := 'HirebusBill';

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
