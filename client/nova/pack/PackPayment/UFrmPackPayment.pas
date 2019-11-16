unit UFrmPackPayment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NovaCheckedComboBox, NvDbgridEh, NovaHComboBox, NvPrnDbgeh;

type
  TFrmPackPayment = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    Label1: TLabel;
    jcdsrevenue: TjsonClientDataSet;
    jcdsrevenueacceptpieces: TIntegerField;
    jcdsrevenueaccepttotalfee: TFloatField;
    jcdsrevenuegoodspieces: TIntegerField;
    jcdsrevenuegoodstotalfee: TFloatField;
    jcdsrevenuepkuppieces: TIntegerField;
    jcdsrevenuepkuptotalfee: TFloatField;
    nvhlpseller: TNovaHelp;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lblreason: TLabel;
    Cobdatafrom: TComboBox;
    lbl2: TLabel;
    chkyes: TCheckBox;
    chkno: TCheckBox;
    Label3: TLabel;
    chkaudityes: TCheckBox;
    chkauditno: TCheckBox;
    jcdsQrypacktturnover: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure CobdatafromChange(Sender: TObject);
  private
    { Private declarations }
    id: Integer;
    isAuthority:Boolean;
  public
    { Public declarations }
    billinuseid: Integer;
    billinusestartno, billinusenextno, billinuseendno: Integer;
    pturnoverdetailid: string;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmPackPayment: TFrmPackPayment;

implementation

uses UFrmPackPaymentAdd,UFrmPackPaymentAudit,UFrmPackpaymentRevenue,UFrmPackTurnoverError;
{$R *.dfm}

procedure TFrmPackPayment.CobdatafromChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TFrmPackPayment.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackPayment.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  // nvhlpseller.Id := SysInfo.LoginUserInfo.UserID;
  // nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
end;

procedure TFrmPackPayment.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := true;
  if Cobdatafrom.ItemIndex = 0 then   //发货
    begin
       dbgrdhResult.Columns.Items[3].title.caption:='发货日期';
       dbgrdhResult.Columns.Items[6].Visible:=true;
       dbgrdhResult.Columns.Items[7].Visible:=true;
       dbgrdhResult.Columns.Items[8].Visible:=false;
       dbgrdhResult.Columns.Items[9].Visible:=false;
    end
    else
    begin
      if Cobdatafrom.ItemIndex = 1 then    //到货
      begin
           dbgrdhResult.Columns.Items[3].title.caption:='到货日期';
           dbgrdhResult.Columns.Items[6].Visible:=false;
           dbgrdhResult.Columns.Items[7].Visible:=false;
           dbgrdhResult.Columns.Items[8].Visible:=true;
           dbgrdhResult.Columns.Items[9].Visible:=true;
      end;

    end;
end;

procedure TFrmPackPayment.NvHpendstationKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackPayment.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  FrmPackTurnoverError := TFrmPackTurnoverError.Create(self);
  try
    with FrmPackTurnoverError do
    begin
      if SysMainForm.showFormModal(FrmPackTurnoverError, false) = mrok then
      begin
 //       jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmPackTurnoverError);
  end;
end;

procedure TFrmPackPayment.tbtnEditClick(Sender: TObject);
var
  i, id, sellby: Integer;
  FSetting: TFormatSettings;
  s_sendpacks, s_pickups, s_depositpieces, s_recaptionspieces: Integer;
  s_sendpackamount, s_pickupamount, s_goodsamount: Double;
  s_moneypayable, s_actupmoney, s_lastlost: Double;
  arrs_sendpacks, arrs_pickups, arrs_depositpieces, arrs_recaptionspieces,
    arrs_sendpackamount, arrs_pickupamount, arrs_goodsamount,
    arrs_moneypayable, arrs_upmoneydate, arrs_lastlost: string;
  sign: string;packtturndetailid:string;
begin
  inherited;

  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  pturnoverdetailid := '';
  sellby := 0;

  s_sendpacks := 0;
  s_sendpackamount := 0;
  s_pickups := 0;
  s_pickupamount := 0;
  s_moneypayable := 0;

  s_actupmoney := 0;

  with jcdsResult do
  begin
    DisableControls;
    try
      First;
      i := 0;
      while not eof do
        if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
        begin
          if FieldByName('ischoose').AsBoolean then
          begin

            if (i > 0) and (sellby <> FieldByName('sellby').AsInteger) then
            begin
              SysDialogs.ShowMessage('你选择的不是同一个人的营收记录！');
              exit;
            end;
            if sysInfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
              .AsInteger then
            begin
              SysDialogs.ShowInfo('不在同一个机构,不能审核！');
              exit;
            end;

            if jcdsResult.FieldByName('isaudit').AsBoolean then
            begin
              SysDialogs.ShowInfo('该记录已审核,不能重复审核！');

              exit;
            end;

            if not(jcdsResult.FieldByName('isturnover').AsBoolean) then
            begin
              SysDialogs.ShowInfo('该记录未缴款,不能审核！');
              exit;
            end;

            i := i + 1;
            if i <> 1 then
              sign := ','
            else
              sign := '';

            sellby := FieldByName('sellby').AsInteger;

            s_sendpacks := s_sendpacks + FieldByName('sendpacks').AsInteger;
            // 受理件数
            s_sendpackamount := s_sendpackamount + FieldByName('sendpackamount')
              .AsFloat; // 受理金额
            s_pickups := s_pickups + FieldByName('pickups').AsInteger; // 提领件数
            s_pickupamount := s_pickupamount + FieldByName('pickupamount')
              .AsFloat; // 提领金额
            s_moneypayable := s_moneypayable + FieldByName('moneypayable')
              .AsFloat; // 合计金额/应缴款
            s_actupmoney := s_actupmoney + FieldByName('moneypayable').AsFloat;

            pturnoverdetailid := pturnoverdetailid + sign + jcdsResult.FieldByName('id').AsString; // 行包缴款明细表ID
            packtturndetailid := jcdsResult.FieldByName('id').AsString;
          end;
          Next;
        end;
      if i < 1 then
      begin
        SysDialogs.ShowMessage('请选择需要审核的记录！');
        exit;
      end;
    finally
      EnableControls;
    end;
  end;
 {
  with jcdsQrypacktturnover do
  begin
     active:=false;
        Params.ParamValues['packtturndetailid']:= packtturndetailid;
     active:=true;

  end;
   }

  FrmPackPaymentAudit := TFrmPackPaymentAudit.Create(self, self.functionItem);

  try
    FrmPackPaymentAudit.Caption := '营收审核';
    FrmPackPaymentAudit.edittype := Tedittype.add;
    with FrmPackPaymentAudit do
    begin

      nvedtorgname.id := sysInfo.LoginUserInfo.OrgID;
      nvedtorgname.Text := sysInfo.LoginUserInfo.OrgName;
      nvedtsellby.id := sysInfo.LoginUserInfo.UserID;
      nvedtsellby.Text := sysInfo.LoginUserInfo.UserName;
      {
      nvedtsendpacks.Text := IntToStr(jcdsQrypacktturnover.FieldByName('sendpacks').AsInteger);
      nvedtsendpackamount.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('sendpackamount').AsFloat);

      nvedtpickups.Text := IntToStr(jcdsQrypacktturnover.FieldByName('pickups').AsInteger);
      nvedtpickupamount.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('pickupamount').AsFloat);
      nvedtmoneypayable.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('moneypayable').AsFloat);

      nvedtpackstrike.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('packstrike').AsFloat);

      nvedtactupmoney.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('actupmoney').AsFloat);
      nvedtlost.Text := FloatToStr(jcdsQrypacktturnover.FieldByName('lost').AsFloat);
      }

      nvedtsendpacks.Text := IntToStr(s_sendpacks);
      nvedtsendpackamount.Text := FloatToStr(s_sendpackamount);

      nvedtpickups.Text := IntToStr(s_pickups);
      nvedtpickupamount.Text := FloatToStr(s_pickupamount);

      nvedtmoneypayable.Text := FloatToStr(s_moneypayable);

      nvedtactupmoney.Text := FloatToStr(s_actupmoney);
      nvedtlost.Text := FloatToStr(StrToFloat(nvedtmoneypayable.Text)
          - StrToFloat(nvedtactupmoney.Text));


 //     nvedtpackstrike.Text := ;


      nvedtactupmoney.Enabled := false;


      FSetting.ShortDateFormat := 'yyyy-MM-dd';
      FSetting.DateSeparator := '-';
      dtpupmoneydate.DateTime := StrToDateTime
        (jcdsResult.FieldByName('moneydate').AsString, FSetting);
      dtpreceipttime.DateTime := Now();

      pactturnoverdetailid := pturnoverdetailid;


      if Cobdatafrom.ItemIndex = 0 then  //发货
      begin
         nvedtsendpacks.Visible:=true;
         nvedtsendpackamount.Visible:=true;
         nvedtpickups.Visible:=false;
         nvedtpickupamount.Visible:=false;
         lblsendpacks.Visible:=true;
         lblsendpackamount.Visible:=true;
         lblpickups.Visible:=false;
         lblpickupamount.Visible:=false;
      end
      else
      begin
         if Cobdatafrom.ItemIndex = 1 then  //到货
         begin
             nvedtpickups.Visible:=true;
             nvedtpickupamount.Visible:=true;
             nvedtsendpacks.Visible:=false;
             nvedtsendpackamount.Visible:=false;
             lblsendpacks.Visible:=false;
             lblsendpackamount.Visible:=false;
             lblpickups.Visible:=true;
             lblpickupamount.Visible:=true;
         end;
      end;


    end;
    if SysMainForm.showFormModal(FrmPackPaymentAudit, false) = mrOk then
    begin
      id := FrmPackPaymentAudit.operationid;
      tbtnFilter.Click;
    end;
  finally
    FreeAndNil(FrmPackPaymentAudit);
  end;

end;

procedure TFrmPackPayment.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_ptd!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_ptd!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_ptd!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);

    if nvhlpseller.id > 0 then
      Params.ParamValues['filter_EQL_ptd!sellby'] := nvhlpseller.id
    else
      Params.ParamValues['filter_EQL_ptd!sellby'] := '';

    if chkyes.Checked and chkno.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isturnover'] := '';
    end
    else if chkyes.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isturnover'] := 'true';
    end
    else if chkno.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isturnover'] := 'false';
    end
    else
    begin
      Params.ParamValues['filter_EQB_ptd!isturnover'] := '';
    end;

    if chkaudityes.Checked and chkauditno.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isaudit'] := '';
    end
    else if chkaudityes.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isaudit'] := 'true';
    end
    else if chkauditno.Checked then
    begin
      Params.ParamValues['filter_EQB_ptd!isaudit'] := 'false';
    end
    else
    begin
      Params.ParamValues['filter_EQB_ptd!isaudit'] := '';
    end;

    if Cobdatafrom.ItemIndex >= 0 then
    begin
      Params.ParamValues['filter_EQS_ptd!datafrom'] := Cobdatafrom.ItemIndex;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ptd!datafrom'] := '';
    end;

    if Cobdatafrom.ItemIndex = 0 then   //发货
    begin
       dbgrdhResult.Columns.Items[3].title.caption:='发货日期';
       dbgrdhResult.Columns.Items[6].Visible:=true;
       dbgrdhResult.Columns.Items[7].Visible:=true;
       dbgrdhResult.Columns.Items[8].Visible:=false;
       dbgrdhResult.Columns.Items[9].Visible:=false;
    end
    else
    if Cobdatafrom.ItemIndex = 1 then    //到货
    begin
       dbgrdhResult.Columns.Items[3].title.caption:='到货日期';
       dbgrdhResult.Columns.Items[6].Visible:=false;
       dbgrdhResult.Columns.Items[7].Visible:=false;
       dbgrdhResult.Columns.Items[8].Visible:=true;
       dbgrdhResult.Columns.Items[9].Visible:=true;
        dbgrdhResult.Columns.Items[8].Title.Caption:='提领件数';
           dbgrdhResult.Columns.Items[9].Title.Caption:='提领金额';
    end
    else
    begin
      if  Cobdatafrom.ItemIndex = 2 then    //小件寄存
      begin

           dbgrdhResult.Columns.Items[8].Title.Caption:='寄存件数';
           dbgrdhResult.Columns.Items[9].Title.Caption:='寄存金额';
           dbgrdhResult.Columns.Items[3].title.caption:='小件寄存日期';
           dbgrdhResult.Columns.Items[6].Visible:=false;
           dbgrdhResult.Columns.Items[7].Visible:=false;
           dbgrdhResult.Columns.Items[8].Visible:=true;
           dbgrdhResult.Columns.Items[9].Visible:=true;

      end;
    end;
    Active := true;
  end;
end;

procedure TFrmPackPayment.tbtnInsertClick(Sender: TObject);
var
  i, id, sellby: Integer;
  FSetting: TFormatSettings;
  s_sendpacks, s_pickups, s_depositpieces, s_recaptionspieces: Integer;
  s_sendpackamount, s_pickupamount, s_goodsamount: Double;
  s_moneypayable, s_actupmoney, s_lastlost: Double;
  arrs_sendpacks, arrs_pickups, arrs_depositpieces, arrs_recaptionspieces,
    arrs_sendpackamount, arrs_pickupamount, arrs_goodsamount,
    arrs_moneypayable, arrs_upmoneydate, arrs_lastlost: string;
  sign: string;

begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  pturnoverdetailid := '';
  sellby := 0;

  s_sendpacks := 0;
  s_sendpackamount := 0;
  s_pickups := 0;
  s_pickupamount := 0;
  s_moneypayable := 0;

  s_actupmoney := 0;

  with jcdsResult do
  begin
    DisableControls;
    try
      First;
      i := 0;
      while not eof do
        if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
        begin
          if FieldByName('ischoose').AsBoolean then
          begin

            if (i > 0) and (sellby <> FieldByName('sellby').AsInteger) then
            begin
              SysDialogs.ShowMessage('你选择的不是同一个人的营收记录！');
              exit;
            end;
            if sysInfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid')
              .AsInteger then
            begin
              SysDialogs.ShowInfo('不在同一个机构,不能缴款！');
              exit;
            end;

//            if (not isAuthority) and (SysInfo.LoginUserInfo.UserName<>jcdsResult.FieldByName('sellbyname').Value) then
//            begin
//              SysDialogs.Warning('不能缴款其他人的营收！');
//              Exit;
//            end;

            if jcdsResult.FieldByName('isturnover').AsBoolean then
            begin
              SysDialogs.ShowInfo('该记录已缴款,不能重复缴款！');
              exit;
            end;

            i := i + 1;
            if i <> 1 then
              sign := ','
            else
              sign := '';

            sellby := FieldByName('sellby').AsInteger;

            s_sendpacks := s_sendpacks + FieldByName('sendpacks').AsInteger;
            // 受理件数
            s_sendpackamount := s_sendpackamount + FieldByName('sendpackamount')
              .AsFloat; // 受理金额
            s_pickups := s_pickups + FieldByName('pickups').AsInteger; // 提领件数
            s_pickupamount := s_pickupamount + FieldByName('pickupamount')
              .AsFloat; // 提领金额
            s_moneypayable := s_moneypayable + FieldByName('moneypayable')
              .AsFloat; // 合计金额/应缴款
            s_actupmoney := s_actupmoney + FieldByName('moneypayable').AsFloat;

            pturnoverdetailid := pturnoverdetailid + sign +
              jcdsResult.FieldByName('id').AsString; // 行包缴款明细表ID
          end;
          Next;
        end;
      if i < 1 then
      begin
        SysDialogs.ShowMessage('请选择需要缴款的记录！');
        exit;
      end;
    finally
      EnableControls;
    end;
  end;

  FrmPackPaymentAdd := TFrmPackPaymentAdd.Create(self, self.functionItem);

  try
    FrmPackPaymentAdd.Caption := '营收缴款';
    FrmPackPaymentAdd.edittype := Tedittype.add;
    with FrmPackPaymentAdd do
    begin

      nvedtorgname.id := sysInfo.LoginUserInfo.OrgID;
      nvedtorgname.Text := sysInfo.LoginUserInfo.OrgName;
      nvedtsellby.id := sysInfo.LoginUserInfo.UserID;
      nvedtsellby.Text := sysInfo.LoginUserInfo.UserName;

      nvedtsendpacks.Text := IntToStr(s_sendpacks);
      nvedtsendpackamount.Text := FloatToStr(s_sendpackamount);

      nvedtpickups.Text := IntToStr(s_pickups);
      nvedtpickupamount.Text := FloatToStr(s_pickupamount);
      if Cobdatafrom.ItemIndex = 0 then  //发货
      begin
         nvedtsendpacks.Visible:=true;
         nvedtsendpackamount.Visible:=true;
         nvedtpickups.Visible:=false;
         nvedtpickupamount.Visible:=false;
         lblsendpack.Visible:=true;
         lblsendpackmount.Visible:=true;
         lblpickup.Visible:=false;
         lblpickpackmount.Visible:=false;
         packdatafrom:=0;
      end
      else
      begin
         if Cobdatafrom.ItemIndex = 1 then  //到货
         begin
             nvedtpickups.Visible:=true;
             nvedtpickupamount.Visible:=true;
             nvedtsendpacks.Visible:=false;
             nvedtsendpackamount.Visible:=false;
             lblsendpack.Visible:=false;
             lblsendpackmount.Visible:=false;
             lblpickup.Visible:=true;
             lblpickpackmount.Visible:=true;
             packdatafrom:=1;
         end;
      end;
      nvedtmoneypayable.Text := FloatToStr(s_moneypayable);

      nvedtpackmoneypayable.Text := FloatToStr(s_moneypayable);

      nvedtactupmoney.Text := FloatToStr(s_actupmoney);
      nvedtlost.Text := FloatToStr(StrToFloat(nvedtmoneypayable.Text)
          - StrToFloat(nvedtactupmoney.Text));
      // actupmoneyvalue();
//      if getParametervalue('8012', sysInfo.LoginUserInfo.OrgID) = '1' then
//        nvedtactupmoney.Enabled := false
//      else
        nvedtactupmoney.Enabled := true;

      FSetting.ShortDateFormat := 'yyyy-MM-dd';
      FSetting.DateSeparator := '-';
      dtpupmoneydate.DateTime := StrToDateTime
        (jcdsResult.FieldByName('moneydate').AsString, FSetting);
      dtpreceipttime.DateTime := Now();

      pactturnoverdetailid := pturnoverdetailid;

    end;
    if SysMainForm.showFormModal(FrmPackPaymentAdd, false) = mrOk then
    begin
      id := FrmPackPaymentAdd.operationid;
      tbtnFilter.Click;
      // jcdsResult.Locate('sellby', id, []);
    end;
  finally
    FreeAndNil(FrmPackPaymentAdd);
  end;

end;

procedure TFrmPackPayment.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  FrmPackpaymentRevenue := TFrmPackpaymentRevenue.Create(self);
  try
    with FrmPackpaymentRevenue do
    begin
      Caption := '行包日营收单';
      if SysMainForm.showFormModal(FrmPackpaymentRevenue, false) = mrok then
      begin
 //       jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmPackpaymentRevenue);
  end;
end;

procedure TFrmPackPayment.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{7D5B1824-8BC3-4778-87AF-59A306085AC5}' then
  begin
    isAuthority:=aEnable;
  end ;

end;

end.
