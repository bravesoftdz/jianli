unit UFrmhirebusaccept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox, NovaPrint,
  Generics.Collections;

type
  TFrmHirebusaccept = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    jcdsResultorgname: TWideStringField;
    Label8: TLabel;
    nvhlpseller: TNovaHelp;
    Label1: TLabel;
    dtphirestartdate: TDateTimePicker;
    lblunitid: TLabel;
    NovaHelpUnits: TNovaHelp;
    Label3: TLabel;
    jcdsResulthireunit: TWideStringField;
    jcdsResultunitid: TLargeintField;
    jcdsResultunitname: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultid: TLargeintField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultstartstation: TWideStringField;
    jcdsResultendstation: TWideStringField;
    jcdsResultbasefee: TFloatField;
    jcdsResultinsurefee: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResultfeetype: TWideStringField;
    jcdsResultfeerate: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultremark: TWideStringField;
    jcdsResultoperater: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultsynccode: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultoperatername: TWideStringField;
    jcdsResultstatus: TWideStringField;
    NvDbgridEh1: TNvDbgridEh;
    jcdsstatusvalue: TjsonClientDataSet;
    jcdsResultstatusvalue: TWideStringField;
    Label4: TLabel;
    nvcbbstatus: TNovaComboBox;
    jcdsResultdistance: TIntegerField;
    jcdsResultactpeople: TIntegerField;
    jcdsResultusehour: TIntegerField;
    nvhlvehicleno: TNovaHelp;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    jcdsResulthiredate: TDateTimeField;
    jcdsResultstartdate: TDateTimeField;
    jcdsResultenddate: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsupdateBillinuse: TjsonClientDataSet;
    jcdswaste: TjsonClientDataSet;
    Label6: TLabel;
    dtphireenddate: TDateTimePicker;
    tmGetCurInvoinNo: TTimer;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    jcdswhackhirebus: TjsonClientDataSet;
    jcdsResulthirebusno: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdstype: TjsonClientDataSet;
    jcdsResulttypevalue: TWideStringField;
    jcdsResulttlname: TWideStringField;
    Label7: TLabel;
    nvcbbtype: TNovaComboBox;
    jcdsResultticketoutletsid: TLargeintField;
    Label9: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultdistricttypecode: TWideStringField;
    jcdsResultdistrictname: TWideStringField;
    jcdsResultdistrictid: TLargeintField;
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);

  private
    { Private declarations }
    ishirebusbill: Boolean; // �ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��

    procedure printpack;
    procedure refreshBill;
    procedure updatepackbill;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmHirebusaccept: TFrmHirebusaccept;

implementation

uses UFrmHirebusacceptAdd;
{$R *.dfm}

procedure TFrmHirebusaccept.dtpenddateChange(Sender: TObject);
begin
  inherited;
  dtpstartdate.Checked := dtpenddate.Checked;
end;

procedure TFrmHirebusaccept.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  dtpenddate.Checked := dtpstartdate.Checked;
end;

procedure TFrmHirebusaccept.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmHirebusaccept.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  tmGetCurInvoinNo.Enabled := false;
end;

procedure TFrmHirebusaccept.FormCreate(Sender: TObject);
begin
  inherited;
  if not checkBillno('HirebusBill') then
  begin
    SysDialogs.ShowInfo('δ�������Ʊ��,�޷����а���������');
  end
  else
  begin

  end;

  refreshBill;
end;

procedure TFrmHirebusaccept.FormShow(Sender: TObject);
begin
  inherited;
  dtphirestartdate.DateTime := Now();
  dtphireenddate.DateTime := Now();
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbborg.Active := false;
  nvcbborg.Active := true;
  nvcbbstatus.Active := false;
  nvcbbstatus.Active := true;
  nvcbbtype.Active := false;
  nvcbbtype.Active := true;
  jcdsstatusvalue.Active := false;
  jcdsstatusvalue.Active := true;
  jcdstype.Active := false;
  jcdstype.Active := true;

  tmGetCurInvoinNo.Enabled := true;
end;

procedure TFrmHirebusaccept.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmHirebusaccept.NvHpendstationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmHirebusaccept.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ���Ϣ������') then
    begin
      exit;
    end;

    with jcdswaste do
    begin

      Active := false;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('�ð����ѽ��㣬�޷����ϣ�');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('�ð��������ϣ�');
        exit;
      end;

      if (sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
          .AsInteger) then
      begin
        SysDialogs.ShowInfo('ֻ�ܶԱ������İ�����Ϣ�������ϲ�����');
        exit;
      end;

      Params.ParamValues['hirebus.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['hirebus.status'] := '2';

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
  end;
end;

procedure TFrmHirebusaccept.tbtnEditClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin

    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('�ð����ѽ��㣬�����޸ģ�');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('�ð����ѷ���,�����޸ģ�');
      exit;
    end;

    if (sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
        .AsInteger) then
    begin
      SysDialogs.ShowInfo('ֻ�ܶԱ������İ�����Ϣ�����޸Ĳ�����');
      exit;
    end;

    { if (SysInfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby').AsInteger)
      or (SysInfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger) then
      begin
      SysDialogs.ShowMessage('�������޸����˿��İ�����Ϣ��');
      exit;
      end; }

    FrmHirebusacceptAdd := TFrmHirebusacceptAdd.Create(self, self.functionItem);
    try
      with FrmHirebusacceptAdd do
      begin
        Caption := '�����޸�';
        edittype := Tedittype.update;
        // ������λ
        nvedthireunit.Text := jcdsResult.FieldByName('hireunit').AsString;

        // ������λ
        nvhelpunitname.id := jcdsResult.FieldByName('unitid').AsInteger;
        nvhelpunitname.Text := jcdsResult.FieldByName('unitname').AsString;
        // ����
        nvhelpvehiclecode.id := jcdsResult.FieldByName('vehicleid').AsInteger;
        nvhelpvehiclecode.Text := jcdsResult.FieldByName('vehicleno').AsString;
        // �ó�����
        dtphiredate.DateTime := jcdsResult.FieldByName('hiredate').AsDateTime;
        // ��ʼʱ��
        dtpstartdate.DateTime := jcdsResult.FieldByName('startdate').AsDateTime;
        // ����ʱ��
        dtpenddate.DateTime := jcdsResult.FieldByName('enddate').AsDateTime;
        // �������
        nvedtstartstation.Text := jcdsResult.FieldByName('startstation')
          .AsString;
        // ������վ
        nvedtendstation.Text := jcdsResult.FieldByName('endstation').AsString;
        // ʵ������
        nvedtactpeople.Text := jcdsResult.FieldByName('actpeople').AsString;
        // �Ʒ����
        nvedtdistance.Text := jcdsResult.FieldByName('distance').AsString;
        // �Ʒ�ʱ��
        nvedtusehour.Text := jcdsResult.FieldByName('usehour').AsString;
        // �Ʒѷ�ʽ
        nvedtfeetype.Text := jcdsResult.FieldByName('feetype').AsString;
        // �����˷�
        nvedtbasefee.Text := jcdsResult.FieldByName('basefee').AsString;
        // ���շ�
        nvedtinsurefee.Text := jcdsResult.FieldByName('insurefee').AsString;
        // ��������
        nvedtotherfee.Text := jcdsResult.FieldByName('otherfee').AsString;
        // ����
        nvedtfeerate.Text := jcdsResult.FieldByName('feerate').AsString;
        // �ܷ���
        nvedttotalfee.Text := jcdsResult.FieldByName('totalfee').AsString;
        // ��ע
        memremarks.Text := jcdsResult.FieldByName('remark').AsString;

        // ��������
        nvhlpdistrictid.id := jcdsResult.FieldByName('districtid').AsInteger;
        nvhlpdistrictid.Text := jcdsResult.FieldByName('districtname').AsString;
        // ������
        operater := jcdsResult.FieldByName('operater').AsInteger;
        operatername := jcdsResult.FieldByName('operatername').AsString;
        synccode := self.jcdsResult.FieldByName('synccode').AsString;
        hirebusid := self.jcdsResult.FieldByName('id').AsInteger;
        createtime := self.jcdsResult.FieldByName('createtime').AsDateTime;
        createby := self.jcdsResult.FieldByName('createby').AsInteger;
        OrgID := self.jcdsResult.FieldByName('orgid').AsInteger;
        orgname := self.jcdsResult.FieldByName('orgname').AsString;
        // ����
        hirebusno := jcdsResult.FieldByName('hirebusno').AsString;
        ticketoutletsid := jcdsResult.FieldByName('ticketoutletsid').AsInteger;
        tlname := jcdsResult.FieldByName('tlname').AsString;
        nvcbbtype.SetItemIndexByCode(jcdsResult.FieldByName('type').AsString);
        CobDISTRICTTYPE.SetItemIndexByCode(jcdsResult.FieldByName('districttype').AsString);

      end;
      if SysMainForm.showFormModal(FrmHirebusacceptAdd, false) = mrOk then
      begin
        id := FrmHirebusacceptAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id', id, []);
      end;
    finally
      FreeAndNil(FrmHirebusacceptAdd);
      refreshBill;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  end;
end;

procedure TFrmHirebusaccept.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvcbborg.SetFocus;
    exit;
  end;

  if dtpstartdate.Checked and (FormatDateTime('yyyymmdd',
      dtpstartdate.Date) > FormatDateTime('yyyymmdd', dtpenddate.Date)) then
  begin
    SysDialogs.ShowMessage('��ֹ���ڿ�ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtphirestartdate.Date) > FormatDateTime
      ('yyyymmdd', dtphireenddate.Date)) then
  begin
    SysDialogs.ShowMessage('�ó����ڿ�ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtphirestartdate.SetFocus;
    exit;
  end;

  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_h!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_h!hiredate'] := FormatDateTime('yyyy-mm-dd',
      dtphirestartdate.DateTime);
    Params.ParamValues['filter_LED_h!hiredate'] := FormatDateTime('yyyy-mm-dd',
      dtphireenddate.DateTime);

    if dtpstartdate.Checked then
    begin
      Params.ParamValues['filter_LED_h!startdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_GED_h!enddate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
    end
    else
    begin
      Params.ParamValues['filter_LED_h!startdate'] := '';
      Params.ParamValues['filter_GED_h!enddate'] := '';
    end;

    if nvcbbstatus.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_h!status'] := ''
    else
      Params.ParamValues['filter_EQS_h!status'] := nvcbbstatus.GetSelectCode;

    if NovaHelpUnits.id <= 0 then
      Params.ParamValues['filter_EQL_h!unitid'] := ''
    else
      Params.ParamValues['filter_EQL_h!unitid'] := NovaHelpUnits.id;

    if nvhlvehicleno.id <= 0 then
      Params.ParamValues['filter_EQL_h!vehicleid'] := ''
    else
      Params.ParamValues['filter_EQL_h!vehicleid'] := nvhlvehicleno.id;
    if nvhlpseller.id <= 0 then
      Params.ParamValues['filter_EQL_h!operater'] := ''
    else
      Params.ParamValues['filter_EQL_h!operater'] := nvhlpseller.id;

    if nvhelpTicketoutlets.id > 0 then // ��Ʊ��
    begin
      Params.ParamValues['filter_EQL_h!ticketoutletsid'] :=
        nvhelpTicketoutlets.id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_h!ticketoutletsid'] := '';
    end;

    if nvcbbtype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_h!type'] := ''
    else
      Params.ParamValues['filter_EQS_h!type'] := nvcbbtype.GetSelectCode;

    Active := true;

  end;
end;

procedure TFrmHirebusaccept.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;

  if sysinfo.LoginUserInfo.curBillNo.ContainsKey('HirebusBill')
    and sysinfo.LoginUserInfo.curBillNum.ContainsKey('HirebusBill') and
    (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] > 0) then
  begin

  end
  else
  begin

    if (ishirebusbill = true) and (sysinfo.LoginUserInfo.curBillNum.Items
        ['HirebusBill'] = 0) then
    begin
      if (initBillNo('HirebusBill')) then
      begin
        if (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] = 0) then
        begin
          SysDialogs.Warning('����ǰ�İ������������꣬��������ȡ��Ʊ��');
          exit;
          // result := false;
        end
        else
          refreshBill();
        // result := true;

      end;
    end
    else
    begin
      if not checkBillno('HirebusBill') then
      begin
        SysDialogs.ShowInfo('δ�������Ʊ��,�޷����а���������');

        exit;
      end
      else
      begin
        refreshBill();
      end;
    end;

  end;

  FrmHirebusacceptAdd := TFrmHirebusacceptAdd.Create(self, self.functionItem);
  try
    FrmHirebusacceptAdd.Caption := '��������';
    if SysMainForm.showFormModal(FrmHirebusacceptAdd, false) = mrOk then
    begin
      id := FrmHirebusacceptAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmHirebusacceptAdd);
    refreshBill;
  end;
end;

procedure TFrmHirebusaccept.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmHirebusaccept.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ��Ҫ�����ش����Ϣ��') then
    begin
      exit;
    end;
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('����Ϣ�ѽ��㣬�����ش�');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('����Ϣ�ѷ���,�����ش�');
      exit;
    end;
    printpack;
    try

      with jcdswhackhirebus do
      begin
        Active := false;
        Params.ParamValues['hirebus.id'] := jcdsResult.FieldByName('id')
          .AsString;
        Params.ParamValues['hirebus.operater'] := jcdsResult.FieldByName
          ('operater').AsString;
        Params.ParamValues['hirebus.hirebusno'] :=
          sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'];

        Execute;

        if Params.ParamValues['msg'] <> '' then
        begin
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
        end;
        if Params.ParamValues['flag'] = 1 then
        begin

        end;
        tbtnFilter.Click;
        jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
      end;

    finally
      updatepackbill();
      refreshBill();
    end;

  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ�ش�ļ�¼��');
  end;
end;

procedure TFrmHirebusaccept.refreshBill();
begin

  if sysinfo.LoginUserInfo.curBillNo.ContainsKey('HirebusBill')
    and sysinfo.LoginUserInfo.curBillNum.ContainsKey('HirebusBill') and
    (sysinfo.LoginUserInfo.curBillNum.Items['HirebusBill'] > 0) then
  begin
    lbpackbill.Caption := sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'];
    lbbillnum.Caption := IntToStr(sysinfo.LoginUserInfo.curBillNum.Items
        ['HirebusBill']);
    ishirebusbill := true;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ishirebusbill := false;
  end;

end;

procedure TFrmHirebusaccept.printpack();
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // ���������
  templtename: string;
begin

  printValue := TDictionary<String, String>.Create;
  billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('������',
      '������'));
  printValue.Clear;

  with jcdsResult do
  begin
    // ������λ
    printValue.Add('hireunit', FieldByName('hireunit').AsString);
    // ������λ
    printValue.Add('unitname', FieldByName('unitname').AsString);
    // ����
    printValue.Add('vehiclecode', FieldByName('vehicleno').AsString);
    // �ó�����
    printValue.Add('hiredate', FormatDateTime('yyyy-mm-dd',
        FieldByName('hiredate').AsDateTime));
    // ��ʼʱ��
    printValue.Add('startdate', FormatDateTime('yyyy-mm-dd',
        FieldByName('startdate').AsDateTime));
    // ����ʱ��
    printValue.Add('enddate', FormatDateTime('yyyy-mm-dd',
        FieldByName('enddate').AsDateTime));
    // �������
    printValue.Add('startstation', FieldByName('startstation').AsString);
    // ������վ
    printValue.Add('endstation', FieldByName('endstation').AsString);
    // ʵ������
    printValue.Add('actpeople', FieldByName('actpeople').AsString);
    // �Ʒ����
    printValue.Add('distance', FieldByName('distance').AsString);
    // �Ʒ�ʱ��
    printValue.Add('usehour', FieldByName('usehour').AsString + '/h');
    // �Ʒѷ�ʽ
    printValue.Add('feetype', FieldByName('feetype').AsString);
    // �����˷�
    printValue.Add('basefee', FieldByName('basefee').AsString);
    // ���շ�
    printValue.Add('insurefee', FieldByName('insurefee').AsString);
    // ��������
    printValue.Add('otherfee', FieldByName('otherfee').AsString);
    // ����
    printValue.Add('feerate', FieldByName('feerate').AsString);
    // �ܷ���
    printValue.Add('totalfee', FieldByName('totalfee').AsString);
    // ��ע
    printValue.Add('remark', FieldByName('remark').AsString);
    // ����
    printValue.Add('orgname', FieldByName('orgname').AsString);
    // ������
    printValue.Add('operatername', FieldByName('operatername').AsString);

    // ����
    printValue.Add('hirebusno',
      sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill']);

    // ��������
    printValue.Add('typevalue', FieldByName('typevalue').AsString);
    // ��Ʊ��
    printValue.Add('ticketoutletsname', FieldByName('tlname').AsString);
    //��������
    printValue.Add('districttype',FieldByName('districttypecode').AsString);
    //��������
    printValue.Add('districtname',FieldByName('districtname').AsString);
  end;

  billPrint.SingleValue := printValue;
  billPrint.Print;

  if Assigned(printValue) then
    printValue.Free;

end;

procedure TFrmHirebusaccept.updatepackbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with sysinfo.LoginUserInfo do
  begin
    billinusenextform := IntToStr
      (strtoint64(sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill']));
    billinusenextno := IntToStr
      (strtoint64(sysinfo.LoginUserInfo.curBillNo.Items['HirebusBill'])
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
