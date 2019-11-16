unit UFrmPackpick;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  UFrmPackacceptAdd,UFrmPackaccept,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox,
  Generics.Collections;

type
  TFrmPackpick = class(TSimpleCRUDForm)
    jcdspackwaste: TjsonClientDataSet;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    Label1: TLabel;
    nvedtname: TNovaEdit;
    Label3: TLabel;
    nvhelptostation1: TNovaHelp;
    jcdspackedvalue: TjsonClientDataSet;
    jcdcertificatetypevalue: TjsonClientDataSet;
    jcdshiptypevalue: TjsonClientDataSet;
    jcdspaymethodvalue: TjsonClientDataSet;
    jcdsstatusvalue: TjsonClientDataSet;
    nvcbborg: TNovaCheckedComboBox;
    jcdsgoodtypevalue: TjsonClientDataSet;
    Label4: TLabel;
    nvcbbpackstatus: TNovaComboBox;
    Label5: TLabel;
    nvedtsenderphone: TNovaEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    nvcbbpaymethod: TNovaComboBox;
    nvhelpvehiclecode: TNovaHelp;
    jcdspacktypevalue: TjsonClientDataSet;
    jcdsrevenue: TjsonClientDataSet;
    jcdsrevenueacceptpieces: TLargeintField;
    jcdsrevenueaccepttotalfee: TFloatField;
    jcdsrevenuegoodspieces: TLargeintField;
    jcdsrevenuegoodstotalfee: TFloatField;
    jcdsrevenuepkuppieces: TLargeintField;
    jcdsrevenuepkuptotalfee: TFloatField;
    jcdscancelPack: TjsonClientDataSet;
    tbtnpackbill: TToolButton;
    lblpackno: TLabel;
    nvedtpackno: TNovaEdit;
    GroupBox2: TGroupBox;
    lbpackrebill: TLabel;
    Label10: TLabel;
    lbbillnum: TLabel;
    GroupBox3: TGroupBox;
    lbpackbill: TLabel;
    Label11: TLabel;
    lbpackbillnum: TLabel;
    jcdspacksave: TjsonClientDataSet;
    Label6: TLabel;
    Nvhelpsendstation: TNovaHelp;
    nvhlpseller: TNovaHelp;
    jcdslocationvalue: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnpackbillClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    ispackbill, ispacksgbill, ispackrebill: Boolean; // �ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��
    cancelMonth, wasteMonth: Integer; // ���ٷ����ڿ���ȡ��ǩ�������졣
    isprint: string; // �Ƿ��ӡ���쵥��
    isprintpackbill: String; // �Ƿ��ӡ���˵���
    isdrawpackbill: string; // �Ƿ���ȡ���˵���
    procedure refreshBill;
    procedure printpack;
    procedure showpackbill;
  public
    { Public declarations }
    totaldeliveryfee: Integer;
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmPackpick: TFrmPackpick;

implementation

uses UFrmPackPickout, DateUtils, UFrmPackTransfer;
{$R *.dfm}

procedure TFrmPackpick.refreshBill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackReBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackReBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackReBill'] > 0) then
  begin
    lbpackrebill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['PackReBill'];
    lbbillnum.Caption := IntToStr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['PackReBill']);
    ispacksgbill := True;
  end
  else
  begin
    lbpackrebill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ispacksgbill := False;
  end;

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then
  begin
    lbpackbill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
    lbpackbillnum.Caption := IntToStr
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill']);
    ispackbill := True;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbpackbillnum.Caption := '0';
    ispackbill := False;
  end;

end;

procedure TFrmPackpick.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  // sysdialogs.ShowMessage(jcdsResult.FieldByName('vcstatus').AsString);
  // if (jcdsResult.FieldByName('zhuanyuntostationid').AsLargeInt > 0) then // ��ת��
  // begin
  // if ((jcdsResult.FieldByName('vcstatus').AsString) <> '�������') then
  // begin
  // AFont.Color := clGreen;
  // end
  // end
  // else
  // begin
  // if ((jcdsResult.FieldByName('vcstatus').AsString) = '�������') then
  // begin
  // AFont.Color := clRed;
  // end;
  // end;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = '�������') then
    AFont.Color := clRed;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = '��ת���') then
    AFont.Color := clGreen;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = 'ת����վ') then
    AFont.Color := clGreen;

end;

procedure TFrmPackpick.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackpick.showpackbill();
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

procedure TFrmPackpick.FormActivate(Sender: TObject);
begin
  inherited;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackpick.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbpackstatus.Active := True;
  // nvcbbshiptype.Active := true;
  // nvcbbpaymethod.Active := true;

  cancelMonth := StrToInt(getParametervalue('8018', Sysinfo.LoginUserInfo.OrgID)
    );
  wasteMonth := StrToInt(getParametervalue('8019', Sysinfo.LoginUserInfo.OrgID)
    );

  GroupBox2.Visible := False;
  isprint := getParametervalue('8007', Sysinfo.LoginUserInfo.OrgID);
  if (isprint = '1') then
  begin
    GroupBox2.Visible := True;
    if not checkBillno('PackReBill') then
    begin
      SysDialogs.ShowInfo('δ���а����쵥Ʊ��,�޷��������������');
    end;
    next;
  end;

  GroupBox3.Visible := False;
  isprintpackbill := getParametervalue('8016', Sysinfo.LoginUserInfo.OrgID);
  isdrawpackbill := getParametervalue('8017', Sysinfo.LoginUserInfo.OrgID);
  if (isdrawpackbill = '1') then
  begin
    GroupBox3.Visible := True;
    if not checkBillno('PackBill') then
      SysDialogs.ShowInfo('δ���а����˵�Ʊ��,�޷��������������');
  end;

  refreshBill;

end;

procedure TFrmPackpick.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F1) then
  begin
    tbtnFilterClick(Sender);
  end
  else if (Key = VK_F2) then
  begin
    tbtnInsertClick(Sender);
  end
  else if (Key = VK_F3) then
  begin
    tbtnEditClick(Sender);
  end
  else if (Key = VK_F4) then
  begin
    tbtnDeleteClick(Sender);
  end
  else if (Key = VK_F5) then
  begin
    ToolButton50Click(Sender);
  end
  else if (Key = VK_F6) then
  begin
    // tbtnSaveClick(sender);
  end
  else if (Key = VK_F7) then
  begin
    tbtnCancelClick(Sender);
  end;
  Key := 0;

end;

procedure TFrmPackpick.FormShow(Sender: TObject);
begin
  inherited;

  jcdspackedvalue.Active := True;
  jcdcertificatetypevalue.Active := True;
  jcdshiptypevalue.Active := True;
  jcdspaymethodvalue.Active := True;
  jcdsstatusvalue.Active := True;
  jcdsgoodtypevalue.Active := True;
  jcdspacktypevalue.Active := True;
  nvcbborg.Active := True;
  nvcbbpaymethod.Active := True;
  jcdslocationvalue.Active := True;
end;

procedure TFrmPackpick.HandleAuthority(const Key: TGUID; aEnable: Boolean);
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

procedure TFrmPackpick.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if ((wasteMonth = 0) and (jcdsResult.FieldByName('status').AsString = '2')) then
      begin
         tbtnCancel.Enabled:=False;
      end
  else
  begin
    tbtnCancel.Enabled:=true;
  end;
end;

procedure TFrmPackpick.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackpick.tbtnCancelClick(Sender: TObject);
var id : Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;

  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ��а�ȡ��������') then
    begin
      Exit;
    end;
    with jcdsResult do
    begin
      if FieldByName('packtype').AsString <> '1' then
      begin
        SysDialogs.ShowMessage('���������а����ܽ���ȡ�����������');
        Exit;
      end;

      if ((FieldByName('status').AsString <> '2') and
          (FieldByName('packtype').AsString = '1')) then
      begin
        SysDialogs.ShowMessage('ֻ�ܶ���������а�����ȡ�����������');
        Exit;
      end;

      // if Sysinfo.LoginUserInfo.StationID <> FieldByName('TOSTATIONID')
      // .AsInteger then
      // begin
      // SysDialogs.ShowInfo('ֻ�ܶԱ�վ����������а�����ȡ�����������');
      // Exit;
      // end;

      if (wasteMonth <> 0) and (StrToFloat(FormatDateTime('yyyyMMddHHmm',
            Now())) - StrToFloat(FormatDateTime('yyyyMMddHHmm',
            FieldByName('updatetime').AsDateTime)) > wasteMonth) then
      begin
        SysDialogs.ShowMessage('ֻ�ܶ��������' + IntToStr(wasteMonth)
            + '�����ڵ��а�����ȡ��ǩ��������');
        Exit;
      end;

    end;

    with jcdscancelPack do
    begin
      Active := False;
      id := jcdsResult.FieldByName('id').AsInteger;
      Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
      id := jcdsResult.FieldByName('id').AsInteger;
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
        jcdsResult.Locate('id', id, []);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫȡ��������а���');
  end;
end;

procedure TFrmPackpick.tbtnDeleteClick(Sender: TObject);

begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ���Ϣ������') then
    begin
      Exit;
    end;

    with jcdspackwaste do
    begin

      Active := False;

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
      Params.ParamValues['pack.status'] := '6'; // ��ת����

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

procedure TFrmPackpick.tbtnEditClick(Sender: TObject);
var
  i, id, days, maxday: Integer;
  storagefee: Double;
  paymethod: string;
  basicshipfee: Double; // �а��������ܷ�
begin
  inherited;

  if (jcdsResult.Active = True) then
  begin
    if getParametervalue('8007', Sysinfo.LoginUserInfo.OrgID) = '1' then
    begin

      if ((ispackrebill = True) and (Sysinfo.LoginUserInfo.curBillNum.Items
            ['PackReBill'] = 0)) then
      begin
        if (initBillNo('PackReBill')) then
        begin
          if (Sysinfo.LoginUserInfo.curBillNum.Items['PackReBill'] = 0) then
          begin
            SysDialogs.Warning('����ǰ�ĵ��������꣬��������ȡ��Ʊ��');
            Exit;
          end
          else
            showpackbill();

        end;
      end
      else
      begin

        if not checkBillno('PackReBill') then
        begin
          SysDialogs.ShowInfo('δ���а����ⵥƱ��,�޷����⣡');
          ispackrebill := False;
          Exit;
        end
        else
        begin
          ispackrebill := True;
        end;
      end;

      if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackReBill')
        and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackReBill') and
        (Sysinfo.LoginUserInfo.curBillNum.Items['PackReBill'] > 0) then
      begin

      end
      else
      begin
        SysDialogs.ShowInfo('δ���а����ⵥƱ��,�޷����⣡');
        Exit;
      end;
    end;

    // if Sysinfo.LoginUserInfo.StationID <> jcdsResult.FieldByName('TOSTATIONID')
    // .AsInteger then
    // begin
    // SysDialogs.ShowInfo('��ǰ��¼վ�㲻���а���վ��,�޷����죡');
    // Exit;
    // end;

    with jcdsResult do
    begin
      DisableControls;
      try

        if FieldByName('packtype').AsString <> '1' then
        begin
          SysDialogs.ShowMessage('���������а����ܽ������죡');
          Exit;
        end;

        if ((FieldByName('status').AsString <> '4') and
            (FieldByName('packtype').AsString = '1')) then
        begin
          SysDialogs.ShowMessage('���ڿ��״̬���а��������죡');
          Exit;
        end;

        FrmPackpickout := TFrmPackpickout.Create(self);
        try
          with FrmPackpickout do
          begin

            packid := FieldByName('id').AsInteger; // �а�id
            nvhelpStation.id := FieldByName('SENDSTATIONID').AsInteger;
            nvhelpStation.Text := FieldByName('sendstationname').AsString;
            // Ŀ�ĵ�
            nvedtpackno.Text := FieldByName('packno').AsString; // �а�����
            nvedtname.Text := FieldByName('name').AsString; // ��������
            nvedtpieces.Text := FieldByName('pieces').AsString; // ����
            nvedtsignaturer.Text := FieldByName('consignee').AsString; // �ջ���
            nvedtphone.Text := FieldByName('consigneephone').AsString;
            // �ջ���֤����
            dtppickupenddate.DateTime := FieldByName('departdate').AsDateTime;
            // ��������
            dtppickupdate.DateTime := Now(); // ��������
            nvhlpseller.id := FieldByName('SELLBY').AsLargeInt;
            nvhlpseller.Text := FieldByName('sellbyname').AsString;

            storagefee := StrToFloat(getParametervalue('8008',
                Sysinfo.LoginUserInfo.OrgID)); // �а�ÿ�챣�ܵķ���
            basicshipfee := StrToFloat(getParametervalue('8023',
                Sysinfo.LoginUserInfo.OrgID)); // �а��������ܷ�
            days := DaysBetween(Now, FieldByName('departdate').AsDateTime);
            maxday := StrToInt(getParametervalue('8013',
                Sysinfo.LoginUserInfo.OrgID)); // �����а������ѱ�������
            if days >= maxday then
            begin
              nvedtpackfee.Text := FloatToStr(basicshipfee);
              Nedtnvedtpenalty.Text := FloatToStr((days - maxday) * storagefee);
            end
            // ���ܷ�
            else
              Nedtnvedtpenalty.Text := '0';
            // ��ʱȥ�����ܷ�
            // nvedtpenalty.Text := FloatToStr(days * storagefee);

            {
              if FieldByName('paymethod').AsString='1' then
              begin
              //�Ḷ
              rbyes.Checked :=true;

              nvedtgoodsprice.Text :=FieldByName('packprice').AsString;//���ջ���
              nvedthandfee.Text :=FieldByName('handfee').AsString;//װж��
              nvedtpackfee.Text :=FieldByName('totalfee').AsString;//�Ḷ����(���˷�)

              nvedttotalfee.Text :=FloatToStr(FieldByName('totalfee').AsFloat+FieldByName('packprice').AsFloat+days*storagefee);//�ϼƽ��
              end
              else if FieldByName('paymethod').AsString='0' then
              begin
              //�ָ�
              rbno.Checked :=false;
              nvedtgoodsprice.Text :=FieldByName('packprice').AsString;//���ջ���
              nvedthandfee.Text :='0';//װж��
              nvedtpackfee.Text :=FieldByName('totalfee').AsString;//�Ḷ��
              nvedttotalfee.Text :=FloatToStr(FieldByName('packprice').AsFloat+days*storagefee);//�ϼƽ��
              end; }
            // nvedtpackfee.Text := FieldByName('packfee').AsString; //

            // �Ḷ����(���˷�) = �������ʱ�� �˷� + ��ת�� + ����� + ������
            // NovaEdtshipprice.Text := FieldByName('shipprice').AsString;
            NovaEdtshipprice.Text := FloatToStr
              (FieldByName('shipprice').AsFloat + FieldByName
                ('transitfee').AsFloat + FieldByName('servicefee')
                .AsFloat + FieldByName('otherfee').AsFloat);
            // ���ջ���
            nvedtgoodsprice.Text := FieldByName('packprice').AsString;

            // nvedtpackfee.Text := FieldByName('totalfee').AsString;
            // �Ḷ����(���˺ϼƽ��) = �Ḷ����(���˷�) + ���ջ��� + ���ܷ���� + ��ʱ�����
            nvedttotalfee.Text := FloatToStr(StrToFloat(NovaEdtshipprice.Text)
                + StrToFloat(nvedtgoodsprice.Text) + StrToFloat
                (nvedtpackfee.Text) + StrToFloat(Nedtnvedtpenalty.Text));
            // ����ϼƽ��

            tostationname := FieldByName('tostationname').AsString;

            if SysMainForm.showFormModal(FrmPackpickout, False) = mrOk then
            begin
//              id := FrmPackpickout.operationid;
              id := packid;
              tbtnFilter.Click;
              jcdsResult.Locate('id', id, []);
            end;
            refreshBill();
          end;
        finally
          FreeAndNil(FrmPackpickout);
        end;

        // end;
        // Next;
        // end;
      finally
        EnableControls;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ������а���');
  end;
end;

procedure TFrmPackpick.tbtnFilterClick(Sender: TObject);
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
    Active := False;

    Params.ParamValues['filter_INS_p!orgid'] := nvcbborg.GetSelectID;

    Params.ParamValues['filter_EQS_p!packtype'] := '1';

    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);

    if Nvhelpsendstation.id > 0 then
      Params.ParamValues['filter_EQL_p!sendstationid'] := Nvhelpsendstation.id
    else
      Params.ParamValues['filter_EQL_p!sendstationid'] := '';

    if nvhelptostation1.id > 0 then
      Params.ParamValues['filter_EQL_p!tostationid'] := nvhelptostation1.id
    else
      Params.ParamValues['filter_EQL_p!tostationid'] := '';

    Params.ParamValues['filter_LIKES_p!sender_OR_p!consignee'] := Trim
      (nvedtname.Text);

    // Params.ParamValues['filter_LIKES_p!singbillno'] := Trim(nvedtsingbillno.Text);

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

    { if nvcbbshiptype.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!shiptype'] := ''
      else
      Params.ParamValues['filter_EQS_p!shiptype'] :=
      nvcbbshiptype.GetSelectCode; }

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

   // jcdsResult.AfterScroll := nil;

    Active := True;

  end;
end;

procedure TFrmPackpick.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;

  with jcdsResult do
  begin
    // DisableControls;
    // EnableControls;
    if FieldByName('packtype').AsString <> '1' then
    begin
      SysDialogs.ShowMessage('���������а�������ת����վ��');
      Exit;
    end;

    if ((FieldByName('status').AsString <> '4') and (FieldByName('packtype')
          .AsString = '1')) then
    begin // ���ǵ������  and  ����
      SysDialogs.ShowMessage('���ǵ������״̬���а�������ת����վ��');
      Exit;
    end;

    FrmPackTransfer := TFrmPackTransfer.Create(self);
    try
      with FrmPackTransfer do
      begin
        packid := jcdsResult.FieldByName('id').AsInteger; // �а�id
        id := packid;
        NovaEditPackno.Text := jcdsResult.FieldByName('packno').AsString;
        // �а�����
        NovaEditTakename.Text := jcdsResult.FieldByName('consignee').AsString;
        // �ջ���
        // nvhelptostation.id := jcdsResult.FieldByName('zhuanyuntostationid').AsInteger;
        // nvhelptostation.Text := jcdsResult.FieldByName('zhuanyuntostationid').AsString;

      end;
      if SysMainForm.showFormModal(FrmPackTransfer, False) = mrOk then
      begin
        // id := FrmPackTransfer.operationid;
        tbtnFilter.Click;
         jcdsResult.Locate('id', id, []);
      end;
    finally
      FreeAndNil(FrmPackTransfer);
    end;
    jcdsResult.EnableControls;
    // EnableControls;
  end;
end;

procedure TFrmPackpick.tbtnpackbillClick(Sender: TObject);
begin
  inherited;
  SysDialogs.ShowMessage('23');
end;

procedure TFrmPackpick.ToolButton50Click(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount = 0 then
    Exit;

  with jcdsResult do
  begin
    // DisableControls;
    // EnableControls;
    if FieldByName('packtype').AsString <> '1' then
    begin
      SysDialogs.ShowMessage('���������а������ܽ�����ת���䣡');
      Exit;
    end;

    if ((FieldByName('status').AsString <> '4') and (FieldByName('packtype')
          .AsString = '1')) then
    begin // ���ǵ������  and  ����
      SysDialogs.ShowMessage('���ǵ������״̬���а������ܽ�����ת���䣡');
      Exit;
    end;

    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
      (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then
    begin
        refreshBill();
    end
    else
    begin
      if (ispacksgbill = True) and (Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill')) and
        (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] = 0) then
      begin
        if (initBillNo('PackBill')) then
        begin
          if (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] = 0) then
          begin
            SysDialogs.Warning('����ǰ�����˵��������꣬��������ȡ��Ʊ��');
            Exit;
          end
          else
            // refreshBill();
          end;
        end
        else
        begin
          if not checkBillno('PackBill') then
          begin
            SysDialogs.ShowInfo('δ���а����˵�Ʊ��,�޷��������������');
            Exit;
          end
          else
          begin
            // refreshBill();
          end;
        end;
      end;
      //
      /// /  end;

      FrmPackacceptAdd := TFrmPackacceptAdd.Create(self);
      try
        with FrmPackacceptAdd do
        begin
          Caption := '��ת����';
          packinfo.Enabled := True;
          // dtpdepartdate .Enabled := False;
          // nvcbbgoodname.Enabled := False;
          // nvcbbpacked.Enabled := False;
          // nvedtpacked.Enabled := False;
          // nvedtpieces.Enabled := False;
          // nvedtweight.Enabled := False;
          // rbvaluablesno.Enabled := False;
          // rbvaluablesyes.Enabled := False;
          // nvcbbpaymethod.Enabled := False;
          // nvcbbshiptype.Enabled := False;
          // memremarks.Enabled := False;
          feeinfo.Enabled := True;
          edittype := Tedittype.add; // ��ת���䵱���а�����

          // packid := jcdsResult.FieldByName('id').AsInteger; // �а�id
          // NovaEditPackno.Text := jcdsResult.FieldByName('packno').AsString; // �а�����
          packno := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
          nvedtpackno.Text := packno;
          nvhelptostation.id := self.jcdsResult.FieldByName('tostationid')
            .AsInteger;
          nvhelptostation.Text := self.jcdsResult.FieldByName('tostationname')
            .AsString;
          nvcbbgoodname.Text := self.jcdsResult.FieldByName('name').AsString;
          // ��������
          nvcbbgoodname.SetItemIndexByValue(self.jcdsResult.FieldByName('name')
              .AsString);
          // nvcbbgoodname.SetItemIndexByCode(self.jcdsResult.FieldByName('name').AsString);
          // sysdialogs.ShowMessage(inttostr(nvcbbgoodname.ItemIndex));
          // nvcbbgoodname.SetItemIndexByCode(self.jcdsResult.FieldByName('goodtype')
          // .AsString);
          dtpdepartdate.DateTime := self.jcdsResult.FieldByName('departdate')
            .AsDateTime;
          nvcbbpacked.SetItemIndexByCode(self.jcdsResult.FieldByName('packed')
              .AsString); // ��װ����
          nvedtpieces.Text := self.jcdsResult.FieldByName('pieces').AsString;
          nvedtweight.Text := self.jcdsResult.FieldByName('weight').AsString;
          // nvedtvolume.Text := self.jcdsResult.FieldByName('volume').AsString;
          if self.jcdsResult.FieldByName('valuables').AsBoolean then
          begin
            rbvaluablesno.Checked := False;
            rbvaluablesyes.Checked := True;
          end
          else
          begin
            rbvaluablesno.Checked := True;
            rbvaluablesyes.Checked := False;
          end;
          memremarks.Text := self.jcdsResult.FieldByName('remak').AsString;
          nvedtsender.Text := self.jcdsResult.FieldByName('sender').AsString;
          nvedtsenderphone.Text := self.jcdsResult.FieldByName('senderphone')
            .AsString;
          nvedtsenderaddress.Text := self.jcdsResult.FieldByName
            ('senderaddress').AsString;
          nvedtconsignee.Text := self.jcdsResult.FieldByName('consignee')
            .AsString;
          nvedtconsigneephone.Text := self.jcdsResult.FieldByName
            ('consigneephone').AsString;
          nvedtconsigneeaddress.Text := self.jcdsResult.FieldByName
            ('consigneeaddress').AsString;
          // ֤������
          nvcbbcertificatetype.SetItemIndexByCode
            (self.jcdsResult.FieldByName('certificatetype').AsString);
          // nvcbbcertificatetype.SetItemIndexByValue(self.jcdsResult.FieldByName('certificatetype').AsString);
          nvedtcertificateno.Text := self.jcdsResult.FieldByName
            ('certificateno').AsString;
          nvcbbshiptype.SetItemIndexByCode
            (self.jcdsResult.FieldByName('shiptype').AsString);
          nvcbbpaymethod.SetItemIndexByCode
            (self.jcdsResult.FieldByName('paymethod').AsString);
          nvedtshipprice.Text := self.jcdsResult.FieldByName('shipprice')
            .AsString;
          nvedtinsuredamount.Text := self.jcdsResult.FieldByName
            ('insuredamount').AsString;
          // nvedtinsurance.Text := self.jcdsResult.FieldByName('insurance').AsString;
          nvedthandfee.Text := self.jcdsResult.FieldByName('handfee').AsString;
          nvedtpackfee.Text := self.jcdsResult.FieldByName('packfee').AsString;
          // �����
          nvedtinsurancefee.Text := self.jcdsResult.FieldByName('insurancefee')
            .AsString;
          nvedttransitfee.Text := self.jcdsResult.FieldByName('transitfee')
            .AsString;
          nvedtdeliveryfee.Text := self.jcdsResult.FieldByName('deliveryfee')
            .AsString;
          nvedtotherfee.Text := self.jcdsResult.FieldByName('otherfee')
            .AsString;
          nvedttotalfee.Text := self.jcdsResult.FieldByName('totalfee')
            .AsString;
          nvedtpackprice.Text := self.jcdsResult.FieldByName('packprice')
            .AsString;

          if self.jcdsResult.FieldByName('clientid').AsString <> '' then
          begin
            nvhelpclient.id := self.jcdsResult.FieldByName('clientid')
              .AsInteger;
            nvedtsendtype.ItemIndex := self.jcdsResult.FieldByName('clienttype')
              .AsInteger;
          end
          else
          begin
            nvedtsendtype.ItemIndex := -1;
          end;
          nvhelpclient.Text := self.jcdsResult.FieldByName('clientcode')
            .AsString;
          nvedtsendintegrater.Text := self.jcdsResult.FieldByName
            ('clientintegrater').AsString;
          nvedtIntegrateMoney.Text := self.jcdsResult.FieldByName
            ('integraterprice').AsString;
          nvedtservicefee.Text := self.jcdsResult.FieldByName('servicefee')
            .AsString;
          nvedtsenderphone.Text := self.jcdsResult.FieldByName('senderphone')
            .AsString;
          nvedtsenderaddress.Text := self.jcdsResult.FieldByName
            ('senderaddress').AsString;
          nvedtsender.Text := self.jcdsResult.FieldByName('sender').AsString;
          // end;

          // nvedtpackno.Text := self.jcdsResult.FieldByName('packno').AsString;
          nvedtpackno.Enabled := False;
          // packno := self.jcdsResult.FieldByName('packno').AsString;
          invoiceno := self.jcdsResult.FieldByName('invoiceno').AsString;
          onlycode := self.jcdsResult.FieldByName('onlycode').AsString;
          synccode := self.jcdsResult.FieldByName('synccode').AsString;
          sellby := self.jcdsResult.FieldByName('sellby').AsInteger;
          sellbyname := self.jcdsResult.FieldByName('sellbyname').AsString;
          packid := self.jcdsResult.FieldByName('id').AsInteger;
          createtime := self.jcdsResult.FieldByName('createtime').AsDateTime;
          createby := self.jcdsResult.FieldByName('createby').AsInteger;
          OrgID := self.jcdsResult.FieldByName('orgid').AsInteger;
          orgname := self.jcdsResult.FieldByName('orgname').AsString;

        end;
        if SysMainForm.showFormModal(FrmPackacceptAdd, False) = mrOk then
        begin

          { with Sysinfo.LoginUserInfo do
            begin
            curBillNo.AddOrSetValue('PackBill',
            zerofill(inttostr(strtoint64(curBillNo.Items['PackBill']) + 1),
            length(curBillNo.Items['PackBill'])));
            curBillNum.AddOrSetValue('PackBill',
            curBillNum.Items['PackBill'] - 1);
            end; }
          refreshBill;

          with jcdspacksave do
          begin
            Active := False;
            Params.ParamByName('pack.id').Value := self.jcdsResult.FieldByName
              ('id').AsString; // �а�id
            id :=  self.jcdsResult.FieldByName('id').AsInteger;
            // packtype:string;//	;//varchar2(10)	y			�а����ͣ�0��������1������
            Params.ParamByName('pack.packtype').Value := '1';
            // self.jcdsResult.FieldByName('packtype').AsString;

            // goodtype:string;//�������
            Params.ParamByName('pack.goodtype').Value :=
              self.jcdsResult.FieldByName('goodtype').AsString;
            // sendstationid:Integer;//number(10)	y			����վ
            Params.ParamByName('pack.sendstationid')
              .Value := self.jcdsResult.FieldByName('sendstationid').AsString;
            // tostationid:Integer;//number(10)	n			Ŀ�ĵ�
            // sysdialogs.ShowMessage(IntToStr(FrmPackacceptAdd.nvhelptostation.Id));
            Params.ParamByName('pack.tostationid').Value := IntToStr
              (FrmPackacceptAdd.nvhelptostation.id); // self.jcdsResult.FieldByName('tostationid').AsString;
            // name:string;//varchar2(50)	n			��������
            Params.ParamByName('pack.name').Value :=
              FrmPackacceptAdd.nvcbbgoodname.Text; // self.jcdsResult.FieldByName('name').AsString;
            // scheduleid:Integer;//number(10)	y			���
            Params.ParamByName('pack.scheduleid').Value :=
              FrmPackacceptAdd.nvhelpschedule.id;
            // self.jcdsResult.FieldByName('scheduleid').AsString;
            // Params.ParamByName('pack.packstatus').Value :=

            // depart:TDateTime;//date	;//date	y			��������������
            Params.ParamByName('pack.departdate').Value := FormatDateTime
              ('yyyy-mm-dd', FrmPackacceptAdd.dtpdepartdate.DateTime);
            // self.jcdsResult.FieldByName('departdate').AsString;
            // packno:string;//varchar2(20)	y			�а�����
            Params.ParamByName('pack.packno').Value :=
              Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
            // self.jcdsResult.FieldByName('packno').AsString;
            // invoiceno:string;//varchar2(20)	y			��Ʊ��
            Params.ParamByName('pack.invoiceno').Value :=
              FrmPackacceptAdd.invoiceno;
            // self.jcdsResult.FieldByName('invoiceno').AsString;

            // sellby:Integer;//number(10)	y			����Ա
            Params.ParamByName('pack.sellby').Value := IntToStr
              (Sysinfo.LoginUserInfo.UserId);
            // self.jcdsResult.FieldByName('sellby').AsString;
            // ������
            // Params.ParamByName('pack.collectby').Value := self.jcdsResult.FieldByName('collectby').AsString; // ������  ��������
            // Params.ParamByName('pack.collectdate').Value := self.jcdsResult.FieldByName('collectdate').AsString;

            // pieces:Integer;//number(3)	y			����
            Params.ParamByName('pack.pieces').Value := Trim
              (FrmPackacceptAdd.nvedtpieces.Text);
            // self.jcdsResult.FieldByName('pieces').AsString;
            // weight:Integer;//number(3)	y			��
            Params.ParamByName('pack.weight').Value := Trim
              (FrmPackacceptAdd.nvedtweight.Text);
            // self.jcdsResult.FieldByName('weight').AsString;
            // volume:string;//varchar2(20)	y			���
            Params.ParamByName('pack.volume').Value :=
              self.jcdsResult.FieldByName('volume').AsString;

            // self.jcdsResult.FieldByName('packed').AsString; // �ֶ������װ���
            if FrmPackacceptAdd.isinputpacked then
            begin
              Params.ParamByName('pack.packed').Value :=
                FrmPackacceptAdd.packaed; // �ֶ������װ���
            end
            else
            begin
              // packaed:Double;//varchar2(10)	y			��װ��ֽ�䡢���ϴ����ޣ�
              Params.ParamByName('pack.packed').Value :=
                FrmPackacceptAdd.nvcbbpacked.GetSelectCode;
            end;
            // shipprice:Double;//number(6,2)	y			���˷�
            Params.ParamByName('pack.shipprice').Value := Trim
              (FrmPackacceptAdd.nvedtshipprice.Text);
            // self.jcdsResult.FieldByName('shipprice').AsString;
            // packfee:Double;//number(6,2)	y			��װ��
            Params.ParamByName('pack.packfee').Value := Trim
              (FrmPackacceptAdd.nvedtpackfee.Text);
            // self.jcdsResult.FieldByName('packfee').AsString;
            Params.ParamByName('pack.unloadfee').Value :=
              self.jcdsResult.FieldByName('unloadfee').AsString; // ����װж��
            // handfee:Double;//number(6,2)	y			װж��
            Params.ParamByName('pack.handfee').Value := Trim
              (FrmPackacceptAdd.nvedthandfee.Text);
            // self.jcdsResult.FieldByName('handfee').AsString;
            // deliveryfee:Double;//                         �ͻ���
            Params.ParamByName('pack.deliveryfee').Value := Trim
              (FrmPackacceptAdd.nvedtdeliveryfee.Text); // self.jcdsResult.FieldByName('deliveryfee').AsString;
            // custodial:Double;//number(6,2)	y			���ܷ�
            Params.ParamByName('pack.custodial').Value :=
              self.jcdsResult.FieldByName('custodial').AsString;
            // transitfee:Double;//number(6,2)	y			��ת��
            Params.ParamByName('pack.transitfee').Value := Trim
              (FrmPackacceptAdd.nvedttransitfee.Text);
            // self.jcdsResult.FieldByName('transitfee').AsString;
            // insuredamount:Double;//number(6,2)	y			���۽��
            Params.ParamByName('pack.insuredamount').Value := Trim
              (FrmPackacceptAdd.nvedtinsuredamount.Text); // self.jcdsResult.FieldByName('insuredamount').AsString;
            // insurancefee:Double;//number(6,2)	y			���۷�
            Params.ParamByName('pack.insurancefee').Value := Trim
              (FrmPackacceptAdd.nvedtinsurancefee.Text); // self.jcdsResult.FieldByName('insurancefee').AsString;
            // insurance:Double;//number(6,2)	y			���շ�
            Params.ParamByName('pack.insurance').Value :=
              self.jcdsResult.FieldByName('insurance').AsString;
            // otherfee:Double;//number(6,2)	y			��������
            Params.ParamByName('pack.otherfee').Value := Trim
              (FrmPackacceptAdd.nvedtotherfee.Text);
            // self.jcdsResult.FieldByName('otherfee').AsString;
            // otherfee:Double;//number(6,2)	y			�����
            Params.ParamByName('pack.servicefee').Value := Trim
              (FrmPackacceptAdd.nvedtservicefee.Text);
            // self.jcdsResult.FieldByName('servicefee').AsString;
            // totalfee:Double;//number(6,2)	y			�ϼƽ��
            Params.ParamByName('pack.totalfee').Value := Trim
              (FrmPackacceptAdd.nvedttotalfee.Text);
            // self.jcdsResult.FieldByName('totalfee').AsString;
            // ���λ��
            Params.ParamByName('pack.location').Value :=
              self.jcdsResult.FieldByName('location').AsString;
            // �ֿۻ��ֽ��
            Params.ParamByName('pack.integraterprice').Value := Trim
              (FrmPackacceptAdd.nvedtIntegrateMoney.Text); // self.jcdsResult.FieldByName('integraterprice').AsString;
            // location:string;//varchar2(20)	y			���λ��
            // packprice:Double;//number(6,2)	y			���ջ���
            Params.ParamByName('pack.packprice').Value := Trim
              (FrmPackacceptAdd.nvedtpackprice.Text);
            // self.jcdsResult.FieldByName('packprice').AsString;
            // sender:string;//varchar2(30)	y			������
            Params.ParamByName('pack.sender').Value := Trim
              (FrmPackacceptAdd.nvedtsender.Text);
            // self.jcdsResult.FieldByName('sender').AsString;
            // senderphone:string;//varchar2(20)	y			�����˵绰
            Params.ParamByName('pack.senderphone').Value := Trim
              (FrmPackacceptAdd.nvedtsenderphone.Text); // self.jcdsResult.FieldByName('senderphone').AsString;
            // senderaddress:string;//varchar2(100)	y			�����˵�ַ
            Params.ParamByName('pack.senderaddress').Value := Trim
              (FrmPackacceptAdd.nvedtsenderaddress.Text); // self.jcdsResult.FieldByName('senderaddress').AsString;
            // consignee:string;//varchar2(30)	y			�ջ���
            Params.ParamByName('pack.consignee').Value := Trim
              (FrmPackacceptAdd.nvedtconsignee.Text);
            // self.jcdsResult.FieldByName('consignee').AsString;
            // consigneephone:string;//varchar2(20)	y			�ջ��˵绰
            Params.ParamByName('pack.consigneephone').Value := Trim
              (FrmPackacceptAdd.nvedtconsigneephone.Text); // self.jcdsResult.FieldByName('consigneephone').AsString;
            // consigneeaddress:string;//varchar2(100)	y			�ջ��˵�ַ
            Params.ParamByName('pack.consigneeaddress').Value := Trim
              (FrmPackacceptAdd.nvedtconsigneeaddress.Text); // self.jcdsResult.FieldByName('consigneeaddress').AsString;

            // certificatetype:string;//varchar2(10)	y			֤�����ͣ�0�����֤��1��ѧ��֤��2������֤��3����ʦ֤ ȡ�����ֵ�
            if (FrmPackacceptAdd.nvcbbcertificatetype.ItemIndex >= 0) then
              Params.ParamByName('pack.certificatetype').Value :=
                FrmPackacceptAdd.nvcbbcertificatetype.GetSelectCode
            else
              Params.ParamByName('pack.certificatetype').Value := '-1';

            // certificateno:string;//varchar2(30)	y			֤������
            if (Trim(FrmPackacceptAdd.nvedtcertificateno.Text) = '') then
              Params.ParamByName('pack.certificateno').Value := '��'
            else
              Params.ParamByName('pack.certificateno').Value := Trim
                (FrmPackacceptAdd.nvedtcertificateno.Text);

            // shiptype:string;//varchar2(10)	y			���˷�ʽ���泵���ᡢ�ջ������죩ȡ�����ֵ�
            Params.ParamByName('pack.shiptype').Value :=
              FrmPackacceptAdd.nvcbbshiptype.GetSelectCode;
            // self.jcdsResult.FieldByName('shiptype').AsString;
            // paymethod:string;//varchar2(10)	y			���ʽ���ָ����Ḷ��ȡ�����ֵ�
            Params.ParamByName('pack.paymethod').Value :=
              FrmPackacceptAdd.nvcbbpaymethod.GetSelectCode;
            // self.jcdsResult.FieldByName('paymethod').AsString;

            if (nvcbbpaymethod.GetSelectCode = '1') then
            begin
              Params.ParamByName('pack.collectstatus').Value := '1'; // �Ѵ���
              Params.ParamByName('pack.recyclestatus').Value := '0'; // �����������״̬
            end
            else
            begin
              Params.ParamByName('pack.collectstatus').Value := '0'; // δ����
            end;
            // Params.ParamByName('pack.collectstatus')
            // .Value := self.jcdsResult.FieldByName('collectstatus').AsString;
            // Params.ParamByName('pack.recyclestatus')
            // .Value := self.jcdsResult.FieldByName('recyclestatus').AsString;
            // �����������״̬
            // valuables:string;//number(1)	y			�Ƿ������Ʒ
            if FrmPackacceptAdd.rbvaluablesno.Checked then
              Params.ParamByName('pack.valuables').Value := False
            else
              Params.ParamByName('pack.valuables').Value := True;
            // self.jcdsResult.FieldByName('valuables').AsString;

            // status:string;//varchar2(10)	y			״̬(0����桢1��ǩ����2�����졢3������)
            Params.ParamByName('pack.status').Value := '6'; // ��ת����

            // packtturnoverid:string;//number(10)	y			�ɿ�id
            Params.ParamByName('pack.packtturnoverid')
              .Value := self.jcdsResult.FieldByName('packtturnoverid')
              .AsString;
            // orgid:Integer;//number(10)	y
            Params.ParamByName('pack.orgid').Value :=
              self.jcdsResult.FieldByName('orgid').AsString;
            // CREATETIME����ʱ��
            Params.ParamByName('pack.createtime').Value := FormatDateTime
              ('yyyy-mm-dd', Now()); ;
            // self.jcdsResult.FieldByName('createtime').AsString;
            // createby������
            Params.ParamByName('pack.createby').Value := IntToStr
              (Sysinfo.LoginUserInfo.UserId);
            // self.jcdsResult.FieldByName('createby').AsString;
            // remak:string;//varchar2(50)	y			��ע
            Params.ParamByName('pack.remak').Value := Trim
              (FrmPackacceptAdd.memremarks.Text);
            // self.jcdsResult.FieldByName('remak').AsString;
            // updatetime
            // Params.ParamByName('pack.updatetime').Value :=self.jcdsResult.FieldByName('updatetime').AsString;
            // createby������
            // Params.ParamByName('pack.updateby').Value := self.jcdsResult.FieldByName('updateby').AsString;
            // synccode ȫ��ͬ������
            // Params.ParamByName('pack.synccode').Value := self.jcdsResult.FieldByName('synccode').AsString;
            // onlycode �ϴ�ʱΨһ�жϱ���
            // Params.ParamByName('pack.onlycode').Value := self.jcdsResult.FieldByName('onlycode').AsString;

            if (FrmPackacceptAdd.nvhelpclient.id > 0) and
              (FrmPackacceptAdd.nvhelpclient.Text <> '') then
            begin
              Params.ParamByName('packIntegraterPay.clientid').Value :=
                FrmPackacceptAdd.nvhelpclient.id;
            end
            else
            begin
              Params.ParamByName('packIntegraterPay.clientid').Value := '';
            end;
            // orgid:Integer;//number(10)	y
            Params.ParamByName('packIntegraterPay.orgid').Value := IntToStr
              (Sysinfo.LoginUserInfo.OrgID);
            Params.ParamByName('packIntegraterPay.price').Value := Trim
              (FrmPackacceptAdd.nvedtIntegrateMoney.Text);
            // Params.ParamByName('packIntegraterPay.integrater').Value :=IntToStr(integrater-StrToInt(Trim(nvedtintegrate.Text)));
            Params.ParamByName('packIntegraterPay.integrater').Value := Trim
              (FrmPackacceptAdd.nvedtintegrate.Text);

            // self.jcdsResult.FieldByName('clientid').AsString;
            // Params.ParamByName('packIntegraterPay.clientid').Value := self.jcdsResult.FieldByName('clientid').AsString;
            // orgid:Integer;//number(10)	y
            // Params.ParamByName('packIntegraterPay.orgid').Value := self.jcdsResult.FieldByName('orgid').AsString;
            // Params.ParamByName('packIntegraterPay.price').Value := self.jcdsResult.FieldByName('price').AsString;
            // Params.ParamByName('packIntegraterPay.integrater').Value :=IntToStr(integrater-StrToInt(Trim(nvedtintegrate.Text)));
            // Params.ParamByName('packIntegraterPay.integrater').Value := self.jcdsResult.FieldByName('integrater').AsString;
            // Params.ParamByName('integrate.integrater').Value := Trim(nvedtintegrate.Text);

            Execute;
          end;
          tbtnFilter.Click;
          tbtnFilter.Click;
          jcdsResult.Locate('id', id, []);
        end;
      finally
        FreeAndNil(FrmPackacceptAdd);
      end;

      // if Params.ParamValues['msg'] <> '' then
      // begin
      // SysDialogs.ShowMessage(Params.ParamValues['msg']);
      // end;
      // if Params.ParamValues['flag'] = 1 then
      // begin
      // log := '�޸�' + VarToStr(Params.ParamValues['packid'])
      // + '�а�������������=' + orgname + ',' + '�޸�' + '��=' +
      // Sysinfo.LoginUserInfo.UserName + ',�а�����=' + packno + ',��Ʊ��=' +
      // invoiceno + ',���=' + schedulename + ',���ƺ�=' + vehiclecodename +
      // ',Ŀ�ĵ�=' + nvhelptostation.Value + ',��������=' +
      // nvcbbgoodname.Text + ',�������=0,��װ����=' + nvcbbpacked.Text + ',����=' +
      // nvedtpieces.Text + ',����=' + nvedtweight.Text + ',������=' +
      // nvedtsender.Text + ',��������ϵ�绰=' + nvedtsenderphone.Text + ',�ջ���=' +
      // nvedtconsignee.Text + ',�ջ�����ϵ�绰=' + nvedtconsigneephone.Text +
      // ',֤������=' + nvcbbcertificatetype.Text + ',�ջ���֤������=' +
      // nvedtcertificateno.Text + ',�����ʽ=' + nvcbbshiptype.Text + ',���ʽ=' +
      // nvcbbpaymethod.Text + ',���˷�=' + nvedtshipprice.Text + ',������ֵ=' +
      // nvedtinsuredamount.Text + ',���۷�=' + nvedtinsurancefee.Text + ',��װ��=' +
      // nvedtpackfee.Text + ',װж��=' + nvedthandfee.Text + ',��ת��=' +
      // nvedttransitfee.Text + ',�ͻ���=' + nvedtdeliveryfee.Text + ',��������=' +
      // nvedtotherfee.Text + ',�ϼƽ��=' + nvedttotalfee.Text + ',���ջ���=' +
      // nvedtpackprice.Text + ',״̬=' + packstatus;
      // SysLog.WriteLog('�а�����->�а���ת����', '��ת����', log);

      // end;

      // end;

    end;

  end;

  procedure TFrmPackpick.printpack();
  begin

  end;

end.
