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
    ispackbill, ispacksgbill, ispackrebill: Boolean; // 判断前面是否领取过票号来判断用完后重置票号
    cancelMonth, wasteMonth: Integer; // 多少分钟内可以取消签发、提领。
    isprint: string; // 是否打印提领单？
    isprintpackbill: String; // 是否打印托运单？
    isdrawpackbill: string; // 是否领取托运单？
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
  // if (jcdsResult.FieldByName('zhuanyuntostationid').AsLargeInt > 0) then // 已转移
  // begin
  // if ((jcdsResult.FieldByName('vcstatus').AsString) <> '提领出库') then
  // begin
  // AFont.Color := clGreen;
  // end
  // end
  // else
  // begin
  // if ((jcdsResult.FieldByName('vcstatus').AsString) = '到货库存') then
  // begin
  // AFont.Color := clRed;
  // end;
  // end;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = '到货库存') then
    AFont.Color := clRed;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = '中转库存') then
    AFont.Color := clGreen;
  if ((jcdsResult.FieldByName('vcstatus').AsString) = '转至它站') then
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
      SysDialogs.ShowInfo('未领行包提领单票号,无法进行提领操作！');
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
      SysDialogs.ShowInfo('未领行包托运单票号,无法进行受理操作！');
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
    if not SysDialogs.Confirm('提示', '确定把该行包取消提领吗？') then
    begin
      Exit;
    end;
    with jcdsResult do
    begin
      if FieldByName('packtype').AsString <> '1' then
      begin
        SysDialogs.ShowMessage('发货类型行包不能进行取消提领操作！');
        Exit;
      end;

      if ((FieldByName('status').AsString <> '2') and
          (FieldByName('packtype').AsString = '1')) then
      begin
        SysDialogs.ShowMessage('只能对已提领的行包进行取消提领操作！');
        Exit;
      end;

      // if Sysinfo.LoginUserInfo.StationID <> FieldByName('TOSTATIONID')
      // .AsInteger then
      // begin
      // SysDialogs.ShowInfo('只能对本站点的已提领行包进行取消提领操作！');
      // Exit;
      // end;

      if (wasteMonth <> 0) and (StrToFloat(FormatDateTime('yyyyMMddHHmm',
            Now())) - StrToFloat(FormatDateTime('yyyyMMddHHmm',
            FieldByName('updatetime').AsDateTime)) > wasteMonth) then
      begin
        SysDialogs.ShowMessage('只能对已提领后' + IntToStr(wasteMonth)
            + '分钟内的行包进行取消签发操作！');
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
    SysDialogs.ShowInfo('请先选择需要取消提领的行包！');
  end;
end;

procedure TFrmPackpick.tbtnDeleteClick(Sender: TObject);

begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定把该信息作废吗？') then
    begin
      Exit;
    end;

    with jcdspackwaste do
    begin

      Active := False;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('该行包已签发，无法废弃！');
        Exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('该行包已处理，无法废弃！');
        Exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '3' then
      begin
        SysDialogs.ShowInfo('该行包已废弃,无法再次废弃！');
        Exit;
      end;

      if jcdsResult.FieldByName('createby').AsString = '0' then
      begin
        SysDialogs.ShowInfo('中心下载数据,无法废弃！');
        Exit;
      end;

      Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['pack.status'] := '6'; // 中转出库

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
    SysDialogs.ShowInfo('请先选择需要作废的记录！');
  end;
end;

procedure TFrmPackpick.tbtnEditClick(Sender: TObject);
var
  i, id, days, maxday: Integer;
  storagefee: Double;
  paymethod: string;
  basicshipfee: Double; // 行包基本保管费
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
            SysDialogs.Warning('您当前的单据已用完，请重新领取单票！');
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
          SysDialogs.ShowInfo('未领行包出库单票号,无法出库！');
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
        SysDialogs.ShowInfo('未领行包出库单票号,无法出库！');
        Exit;
      end;
    end;

    // if Sysinfo.LoginUserInfo.StationID <> jcdsResult.FieldByName('TOSTATIONID')
    // .AsInteger then
    // begin
    // SysDialogs.ShowInfo('当前登录站点不是行包到站点,无法提领！');
    // Exit;
    // end;

    with jcdsResult do
    begin
      DisableControls;
      try

        if FieldByName('packtype').AsString <> '1' then
        begin
          SysDialogs.ShowMessage('发货类型行包不能进行提领！');
          Exit;
        end;

        if ((FieldByName('status').AsString <> '4') and
            (FieldByName('packtype').AsString = '1')) then
        begin
          SysDialogs.ShowMessage('不在库存状态的行包不能提领！');
          Exit;
        end;

        FrmPackpickout := TFrmPackpickout.Create(self);
        try
          with FrmPackpickout do
          begin

            packid := FieldByName('id').AsInteger; // 行包id
            nvhelpStation.id := FieldByName('SENDSTATIONID').AsInteger;
            nvhelpStation.Text := FieldByName('sendstationname').AsString;
            // 目的地
            nvedtpackno.Text := FieldByName('packno').AsString; // 行包单号
            nvedtname.Text := FieldByName('name').AsString; // 货物名称
            nvedtpieces.Text := FieldByName('pieces').AsString; // 件数
            nvedtsignaturer.Text := FieldByName('consignee').AsString; // 收货人
            nvedtphone.Text := FieldByName('consigneephone').AsString;
            // 收货人证件号
            dtppickupenddate.DateTime := FieldByName('departdate').AsDateTime;
            // 到货日期
            dtppickupdate.DateTime := Now(); // 提领日期
            nvhlpseller.id := FieldByName('SELLBY').AsLargeInt;
            nvhlpseller.Text := FieldByName('sellbyname').AsString;

            storagefee := StrToFloat(getParametervalue('8008',
                Sysinfo.LoginUserInfo.OrgID)); // 行包每天保管的费用
            basicshipfee := StrToFloat(getParametervalue('8023',
                Sysinfo.LoginUserInfo.OrgID)); // 行包基本保管费
            days := DaysBetween(Now, FieldByName('departdate').AsDateTime);
            maxday := StrToInt(getParametervalue('8013',
                Sysinfo.LoginUserInfo.OrgID)); // 到货行包最大免费保管天数
            if days >= maxday then
            begin
              nvedtpackfee.Text := FloatToStr(basicshipfee);
              Nedtnvedtpenalty.Text := FloatToStr((days - maxday) * storagefee);
            end
            // 保管费
            else
              Nedtnvedtpenalty.Text := '0';
            // 暂时去掉保管费
            // nvedtpenalty.Text := FloatToStr(days * storagefee);

            {
              if FieldByName('paymethod').AsString='1' then
              begin
              //提付
              rbyes.Checked :=true;

              nvedtgoodsprice.Text :=FieldByName('packprice').AsString;//代收货款
              nvedthandfee.Text :=FieldByName('handfee').AsString;//装卸费
              nvedtpackfee.Text :=FieldByName('totalfee').AsString;//提付费用(托运费)

              nvedttotalfee.Text :=FloatToStr(FieldByName('totalfee').AsFloat+FieldByName('packprice').AsFloat+days*storagefee);//合计金额
              end
              else if FieldByName('paymethod').AsString='0' then
              begin
              //现付
              rbno.Checked :=false;
              nvedtgoodsprice.Text :=FieldByName('packprice').AsString;//代收货款
              nvedthandfee.Text :='0';//装卸费
              nvedtpackfee.Text :=FieldByName('totalfee').AsString;//提付费
              nvedttotalfee.Text :=FloatToStr(FieldByName('packprice').AsFloat+days*storagefee);//合计金额
              end; }
            // nvedtpackfee.Text := FieldByName('packfee').AsString; //

            // 提付费用(托运费) = 到货入仓时的 运费 + 中转费 + 服务费 + 其他费
            // NovaEdtshipprice.Text := FieldByName('shipprice').AsString;
            NovaEdtshipprice.Text := FloatToStr
              (FieldByName('shipprice').AsFloat + FieldByName
                ('transitfee').AsFloat + FieldByName('servicefee')
                .AsFloat + FieldByName('otherfee').AsFloat);
            // 代收货款
            nvedtgoodsprice.Text := FieldByName('packprice').AsString;

            // nvedtpackfee.Text := FieldByName('totalfee').AsString;
            // 提付费用(托运合计金额) = 提付费用(托运费) + 代收货款 + 保管服务费 + 超时服务费
            nvedttotalfee.Text := FloatToStr(StrToFloat(NovaEdtshipprice.Text)
                + StrToFloat(nvedtgoodsprice.Text) + StrToFloat
                (nvedtpackfee.Text) + StrToFloat(Nedtnvedtpenalty.Text));
            // 提领合计金额

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
    SysDialogs.ShowInfo('请先选择需要出库的行包！');
  end;
end;

procedure TFrmPackpick.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  // nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
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
      SysDialogs.ShowMessage('发货类型行包，不能转至它站！');
      Exit;
    end;

    if ((FieldByName('status').AsString <> '4') and (FieldByName('packtype')
          .AsString = '1')) then
    begin // 不是到货库存  and  到货
      SysDialogs.ShowMessage('不是到货库存状态的行包，不能转至它站！');
      Exit;
    end;

    FrmPackTransfer := TFrmPackTransfer.Create(self);
    try
      with FrmPackTransfer do
      begin
        packid := jcdsResult.FieldByName('id').AsInteger; // 行包id
        id := packid;
        NovaEditPackno.Text := jcdsResult.FieldByName('packno').AsString;
        // 行包单号
        NovaEditTakename.Text := jcdsResult.FieldByName('consignee').AsString;
        // 收货人
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
      SysDialogs.ShowMessage('发货类型行包，不能进行中转运输！');
      Exit;
    end;

    if ((FieldByName('status').AsString <> '4') and (FieldByName('packtype')
          .AsString = '1')) then
    begin // 不是到货库存  and  到货
      SysDialogs.ShowMessage('不是到货库存状态的行包，不能进行中转运输！');
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
            SysDialogs.Warning('您当前的托运单据已用完，请重新领取单票！');
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
            SysDialogs.ShowInfo('未领行包托运单票号,无法进行受理操作！');
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
          Caption := '中转运输';
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
          edittype := Tedittype.add; // 中转运输当作行包受理

          // packid := jcdsResult.FieldByName('id').AsInteger; // 行包id
          // NovaEditPackno.Text := jcdsResult.FieldByName('packno').AsString; // 行包单号
          packno := Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
          nvedtpackno.Text := packno;
          nvhelptostation.id := self.jcdsResult.FieldByName('tostationid')
            .AsInteger;
          nvhelptostation.Text := self.jcdsResult.FieldByName('tostationname')
            .AsString;
          nvcbbgoodname.Text := self.jcdsResult.FieldByName('name').AsString;
          // 货物名称
          nvcbbgoodname.SetItemIndexByValue(self.jcdsResult.FieldByName('name')
              .AsString);
          // nvcbbgoodname.SetItemIndexByCode(self.jcdsResult.FieldByName('name').AsString);
          // sysdialogs.ShowMessage(inttostr(nvcbbgoodname.ItemIndex));
          // nvcbbgoodname.SetItemIndexByCode(self.jcdsResult.FieldByName('goodtype')
          // .AsString);
          dtpdepartdate.DateTime := self.jcdsResult.FieldByName('departdate')
            .AsDateTime;
          nvcbbpacked.SetItemIndexByCode(self.jcdsResult.FieldByName('packed')
              .AsString); // 包装类型
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
          // 证件类型
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
          // 服务费
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
              ('id').AsString; // 行包id
            id :=  self.jcdsResult.FieldByName('id').AsInteger;
            // packtype:string;//	;//varchar2(10)	y			行包类型（0：发货，1：到货
            Params.ParamByName('pack.packtype').Value := '1';
            // self.jcdsResult.FieldByName('packtype').AsString;

            // goodtype:string;//货物类别
            Params.ParamByName('pack.goodtype').Value :=
              self.jcdsResult.FieldByName('goodtype').AsString;
            // sendstationid:Integer;//number(10)	y			发货站
            Params.ParamByName('pack.sendstationid')
              .Value := self.jcdsResult.FieldByName('sendstationid').AsString;
            // tostationid:Integer;//number(10)	n			目的地
            // sysdialogs.ShowMessage(IntToStr(FrmPackacceptAdd.nvhelptostation.Id));
            Params.ParamByName('pack.tostationid').Value := IntToStr
              (FrmPackacceptAdd.nvhelptostation.id); // self.jcdsResult.FieldByName('tostationid').AsString;
            // name:string;//varchar2(50)	n			货物名称
            Params.ParamByName('pack.name').Value :=
              FrmPackacceptAdd.nvcbbgoodname.Text; // self.jcdsResult.FieldByName('name').AsString;
            // scheduleid:Integer;//number(10)	y			班次
            Params.ParamByName('pack.scheduleid').Value :=
              FrmPackacceptAdd.nvhelpschedule.id;
            // self.jcdsResult.FieldByName('scheduleid').AsString;
            // Params.ParamByName('pack.packstatus').Value :=

            // depart:TDateTime;//date	;//date	y			发货、到货日期
            Params.ParamByName('pack.departdate').Value := FormatDateTime
              ('yyyy-mm-dd', FrmPackacceptAdd.dtpdepartdate.DateTime);
            // self.jcdsResult.FieldByName('departdate').AsString;
            // packno:string;//varchar2(20)	y			行包单号
            Params.ParamByName('pack.packno').Value :=
              Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'];
            // self.jcdsResult.FieldByName('packno').AsString;
            // invoiceno:string;//varchar2(20)	y			发票号
            Params.ParamByName('pack.invoiceno').Value :=
              FrmPackacceptAdd.invoiceno;
            // self.jcdsResult.FieldByName('invoiceno').AsString;

            // sellby:Integer;//number(10)	y			办理员
            Params.ParamByName('pack.sellby').Value := IntToStr
              (Sysinfo.LoginUserInfo.UserId);
            // self.jcdsResult.FieldByName('sellby').AsString;
            // 代收人
            // Params.ParamByName('pack.collectby').Value := self.jcdsResult.FieldByName('collectby').AsString; // 代收人  代收日期
            // Params.ParamByName('pack.collectdate').Value := self.jcdsResult.FieldByName('collectdate').AsString;

            // pieces:Integer;//number(3)	y			件数
            Params.ParamByName('pack.pieces').Value := Trim
              (FrmPackacceptAdd.nvedtpieces.Text);
            // self.jcdsResult.FieldByName('pieces').AsString;
            // weight:Integer;//number(3)	y			重
            Params.ParamByName('pack.weight').Value := Trim
              (FrmPackacceptAdd.nvedtweight.Text);
            // self.jcdsResult.FieldByName('weight').AsString;
            // volume:string;//varchar2(20)	y			体积
            Params.ParamByName('pack.volume').Value :=
              self.jcdsResult.FieldByName('volume').AsString;

            // self.jcdsResult.FieldByName('packed').AsString; // 手动输入包装类别
            if FrmPackacceptAdd.isinputpacked then
            begin
              Params.ParamByName('pack.packed').Value :=
                FrmPackacceptAdd.packaed; // 手动输入包装类别
            end
            else
            begin
              // packaed:Double;//varchar2(10)	y			包装（纸箱、塑料袋、无）
              Params.ParamByName('pack.packed').Value :=
                FrmPackacceptAdd.nvcbbpacked.GetSelectCode;
            end;
            // shipprice:Double;//number(6,2)	y			托运费
            Params.ParamByName('pack.shipprice').Value := Trim
              (FrmPackacceptAdd.nvedtshipprice.Text);
            // self.jcdsResult.FieldByName('shipprice').AsString;
            // packfee:Double;//number(6,2)	y			包装费
            Params.ParamByName('pack.packfee').Value := Trim
              (FrmPackacceptAdd.nvedtpackfee.Text);
            // self.jcdsResult.FieldByName('packfee').AsString;
            Params.ParamByName('pack.unloadfee').Value :=
              self.jcdsResult.FieldByName('unloadfee').AsString; // 到货装卸费
            // handfee:Double;//number(6,2)	y			装卸费
            Params.ParamByName('pack.handfee').Value := Trim
              (FrmPackacceptAdd.nvedthandfee.Text);
            // self.jcdsResult.FieldByName('handfee').AsString;
            // deliveryfee:Double;//                         送货费
            Params.ParamByName('pack.deliveryfee').Value := Trim
              (FrmPackacceptAdd.nvedtdeliveryfee.Text); // self.jcdsResult.FieldByName('deliveryfee').AsString;
            // custodial:Double;//number(6,2)	y			保管费
            Params.ParamByName('pack.custodial').Value :=
              self.jcdsResult.FieldByName('custodial').AsString;
            // transitfee:Double;//number(6,2)	y			中转费
            Params.ParamByName('pack.transitfee').Value := Trim
              (FrmPackacceptAdd.nvedttransitfee.Text);
            // self.jcdsResult.FieldByName('transitfee').AsString;
            // insuredamount:Double;//number(6,2)	y			保价金额
            Params.ParamByName('pack.insuredamount').Value := Trim
              (FrmPackacceptAdd.nvedtinsuredamount.Text); // self.jcdsResult.FieldByName('insuredamount').AsString;
            // insurancefee:Double;//number(6,2)	y			保价费
            Params.ParamByName('pack.insurancefee').Value := Trim
              (FrmPackacceptAdd.nvedtinsurancefee.Text); // self.jcdsResult.FieldByName('insurancefee').AsString;
            // insurance:Double;//number(6,2)	y			保险费
            Params.ParamByName('pack.insurance').Value :=
              self.jcdsResult.FieldByName('insurance').AsString;
            // otherfee:Double;//number(6,2)	y			其他费用
            Params.ParamByName('pack.otherfee').Value := Trim
              (FrmPackacceptAdd.nvedtotherfee.Text);
            // self.jcdsResult.FieldByName('otherfee').AsString;
            // otherfee:Double;//number(6,2)	y			服务费
            Params.ParamByName('pack.servicefee').Value := Trim
              (FrmPackacceptAdd.nvedtservicefee.Text);
            // self.jcdsResult.FieldByName('servicefee').AsString;
            // totalfee:Double;//number(6,2)	y			合计金额
            Params.ParamByName('pack.totalfee').Value := Trim
              (FrmPackacceptAdd.nvedttotalfee.Text);
            // self.jcdsResult.FieldByName('totalfee').AsString;
            // 存放位置
            Params.ParamByName('pack.location').Value :=
              self.jcdsResult.FieldByName('location').AsString;
            // 抵扣积分金额
            Params.ParamByName('pack.integraterprice').Value := Trim
              (FrmPackacceptAdd.nvedtIntegrateMoney.Text); // self.jcdsResult.FieldByName('integraterprice').AsString;
            // location:string;//varchar2(20)	y			存放位置
            // packprice:Double;//number(6,2)	y			代收货款
            Params.ParamByName('pack.packprice').Value := Trim
              (FrmPackacceptAdd.nvedtpackprice.Text);
            // self.jcdsResult.FieldByName('packprice').AsString;
            // sender:string;//varchar2(30)	y			托运人
            Params.ParamByName('pack.sender').Value := Trim
              (FrmPackacceptAdd.nvedtsender.Text);
            // self.jcdsResult.FieldByName('sender').AsString;
            // senderphone:string;//varchar2(20)	y			托运人电话
            Params.ParamByName('pack.senderphone').Value := Trim
              (FrmPackacceptAdd.nvedtsenderphone.Text); // self.jcdsResult.FieldByName('senderphone').AsString;
            // senderaddress:string;//varchar2(100)	y			托运人地址
            Params.ParamByName('pack.senderaddress').Value := Trim
              (FrmPackacceptAdd.nvedtsenderaddress.Text); // self.jcdsResult.FieldByName('senderaddress').AsString;
            // consignee:string;//varchar2(30)	y			收货人
            Params.ParamByName('pack.consignee').Value := Trim
              (FrmPackacceptAdd.nvedtconsignee.Text);
            // self.jcdsResult.FieldByName('consignee').AsString;
            // consigneephone:string;//varchar2(20)	y			收货人电话
            Params.ParamByName('pack.consigneephone').Value := Trim
              (FrmPackacceptAdd.nvedtconsigneephone.Text); // self.jcdsResult.FieldByName('consigneephone').AsString;
            // consigneeaddress:string;//varchar2(100)	y			收货人地址
            Params.ParamByName('pack.consigneeaddress').Value := Trim
              (FrmPackacceptAdd.nvedtconsigneeaddress.Text); // self.jcdsResult.FieldByName('consigneeaddress').AsString;

            // certificatetype:string;//varchar2(10)	y			证件类型：0：身份证，1：学生证，2：军官证，3：教师证 取数据字典
            if (FrmPackacceptAdd.nvcbbcertificatetype.ItemIndex >= 0) then
              Params.ParamByName('pack.certificatetype').Value :=
                FrmPackacceptAdd.nvcbbcertificatetype.GetSelectCode
            else
              Params.ParamByName('pack.certificatetype').Value := '-1';

            // certificateno:string;//varchar2(30)	y			证件号码
            if (Trim(FrmPackacceptAdd.nvedtcertificateno.Text) = '') then
              Params.ParamByName('pack.certificateno').Value := '无'
            else
              Params.ParamByName('pack.certificateno').Value := Trim
                (FrmPackacceptAdd.nvedtcertificateno.Text);

            // shiptype:string;//varchar2(10)	y			托运方式（随车自提、收获人提领）取数据字典
            Params.ParamByName('pack.shiptype').Value :=
              FrmPackacceptAdd.nvcbbshiptype.GetSelectCode;
            // self.jcdsResult.FieldByName('shiptype').AsString;
            // paymethod:string;//varchar2(10)	y			付款方式（现付、提付）取数据字典
            Params.ParamByName('pack.paymethod').Value :=
              FrmPackacceptAdd.nvcbbpaymethod.GetSelectCode;
            // self.jcdsResult.FieldByName('paymethod').AsString;

            if (nvcbbpaymethod.GetSelectCode = '1') then
            begin
              Params.ParamByName('pack.collectstatus').Value := '1'; // 已代付
              Params.ParamByName('pack.recyclestatus').Value := '0'; // 代付货款回收状态
            end
            else
            begin
              Params.ParamByName('pack.collectstatus').Value := '0'; // 未代付
            end;
            // Params.ParamByName('pack.collectstatus')
            // .Value := self.jcdsResult.FieldByName('collectstatus').AsString;
            // Params.ParamByName('pack.recyclestatus')
            // .Value := self.jcdsResult.FieldByName('recyclestatus').AsString;
            // 代付货款回收状态
            // valuables:string;//number(1)	y			是否贵重物品
            if FrmPackacceptAdd.rbvaluablesno.Checked then
              Params.ParamByName('pack.valuables').Value := False
            else
              Params.ParamByName('pack.valuables').Value := True;
            // self.jcdsResult.FieldByName('valuables').AsString;

            // status:string;//varchar2(10)	y			状态(0：库存、1：签发、2：提领、3：作废)
            Params.ParamByName('pack.status').Value := '6'; // 中转出库

            // packtturnoverid:string;//number(10)	y			缴款id
            Params.ParamByName('pack.packtturnoverid')
              .Value := self.jcdsResult.FieldByName('packtturnoverid')
              .AsString;
            // orgid:Integer;//number(10)	y
            Params.ParamByName('pack.orgid').Value :=
              self.jcdsResult.FieldByName('orgid').AsString;
            // CREATETIME创建时间
            Params.ParamByName('pack.createtime').Value := FormatDateTime
              ('yyyy-mm-dd', Now()); ;
            // self.jcdsResult.FieldByName('createtime').AsString;
            // createby创建人
            Params.ParamByName('pack.createby').Value := IntToStr
              (Sysinfo.LoginUserInfo.UserId);
            // self.jcdsResult.FieldByName('createby').AsString;
            // remak:string;//varchar2(50)	y			备注
            Params.ParamByName('pack.remak').Value := Trim
              (FrmPackacceptAdd.memremarks.Text);
            // self.jcdsResult.FieldByName('remak').AsString;
            // updatetime
            // Params.ParamByName('pack.updatetime').Value :=self.jcdsResult.FieldByName('updatetime').AsString;
            // createby创建人
            // Params.ParamByName('pack.updateby').Value := self.jcdsResult.FieldByName('updateby').AsString;
            // synccode 全局同步编码
            // Params.ParamByName('pack.synccode').Value := self.jcdsResult.FieldByName('synccode').AsString;
            // onlycode 上传时唯一判断编码
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
      // log := '修改' + VarToStr(Params.ParamValues['packid'])
      // + '行包受理：所属机构=' + orgname + ',' + '修改' + '人=' +
      // Sysinfo.LoginUserInfo.UserName + ',行包单号=' + packno + ',发票号=' +
      // invoiceno + ',班次=' + schedulename + ',车牌号=' + vehiclecodename +
      // ',目的地=' + nvhelptostation.Value + ',货物名称=' +
      // nvcbbgoodname.Text + ',货物类别=0,包装类型=' + nvcbbpacked.Text + ',件数=' +
      // nvedtpieces.Text + ',重量=' + nvedtweight.Text + ',托运人=' +
      // nvedtsender.Text + ',托运人联系电话=' + nvedtsenderphone.Text + ',收货人=' +
      // nvedtconsignee.Text + ',收货人联系电话=' + nvedtconsigneephone.Text +
      // ',证件类型=' + nvcbbcertificatetype.Text + ',收货人证件号码=' +
      // nvedtcertificateno.Text + ',提货方式=' + nvcbbshiptype.Text + ',付款方式=' +
      // nvcbbpaymethod.Text + ',托运费=' + nvedtshipprice.Text + ',声明价值=' +
      // nvedtinsuredamount.Text + ',保价费=' + nvedtinsurancefee.Text + ',包装费=' +
      // nvedtpackfee.Text + ',装卸费=' + nvedthandfee.Text + ',中转费=' +
      // nvedttransitfee.Text + ',送货费=' + nvedtdeliveryfee.Text + ',其他费用=' +
      // nvedtotherfee.Text + ',合计金额=' + nvedttotalfee.Text + ',代收货款=' +
      // nvedtpackprice.Text + ',状态=' + packstatus;
      // SysLog.WriteLog('行包管理->行包中转运输', '中转运输', log);

      // end;

      // end;

    end;

  end;

  procedure TFrmPackpick.printpack();
  begin

  end;

end.
