unit UFrmPackWarehousing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NovaCheckedComboBox, NvDbgridEh, NovaHComboBox, NvPrnDbgeh, NovaPrint, StrUtils,
  Generics.Collections;

type
  TFrmPackWarehousing = class(TSimpleCRUDForm)

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
    jcdsResultpacktype: TWideStringField;
    Label1: TLabel;
    jcdsResultischoose: TBooleanField;
    jcdspacktypevalue: TjsonClientDataSet;
    jcdsResultpacktypevalue: TWideStringField;
    jcdspackwaste: TjsonClientDataSet;
    jcdsResultunloadfee: TFloatField;
    jcdsResultweight: TFloatField;
    Label3: TLabel;
    nvedtpackno: TNovaEdit;
    jcdsPackup: TjsonClientDataSet;
    inwarehousemsg: TLabel;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label5: TLabel;
    lbbillnum: TLabel;
    jcdsResultzhuanyuntostationid: TLargeintField;
    jcdsResultzhuanyuntostationname: TWideStringField;
    jcdslocationvalue: TjsonClientDataSet;
    jcdsResultlocationvalue: TWideStringField;
    Label4: TLabel;
    nvcbbgoodsstatus: TNovaComboBox;
    nvcbbsellby: TNovaCheckedComboBox;
    jcdsResultpackarriverno: TWideStringField;
    jcdsResultpackarriverstatus: TWideStringField;
    jcdsResultpackarriverdate: TDateTimeField;
    jcdspackarriverstatus: TjsonClientDataSet;
    jcdsResultpackarriverstatusname: TWideStringField;
    jcdsResultgoodsstatus: TWideStringField;
    jcdsResultservicefee: TFloatField;
    jcdspaymentrecyclesave: TjsonClientDataSet;
    jcdsResultrecyclestatus: TWideStringField;
    jcdsResultpackarriverid: TLargeintField;
    jcdswhackpackarriver: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    jcdsgoodsstatus: TjsonClientDataSet;
    jcdsResultgoodsstatusname: TWideStringField;
    jcdsResultpackarrivercreatby: TLargeintField;
    jcdsResultpackarrivercreatetime: TDateTimeField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure nvedtpacknoKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtpacknoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ToolButton50Click(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);

  private
    { Private declarations }
    id: Integer;
    ispackbill: Boolean; // 判断前面是否领取过票号来判断用完后重置票号
    ispackarrivalbill: string; // 是否领取行包到货收讫单？
    // packarriverno : String; //行包收讫单号
    isoriginalprint: Boolean; // 是原票号重打
    packprint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    procedure refreshBill;
    procedure packnoUpStatus;
    procedure updatepackarrivalbill;
  public
    { Public declarations }
    billinuseid: Integer;
    billinusestartno, billinusenextno, billinuseendno: Integer;
  end;

var
  FrmPackWarehousing: TFrmPackWarehousing;

implementation

uses UFrmPackWarehousingAdd;
{$R *.dfm}

procedure TFrmPackWarehousing.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackWarehousing.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbgoodsstatus.Active := True;

  with nvcbbsellby do
  begin
    nvcbbsellby.Active := False;
    Params.ParamValues['filter_INS_u!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_INS_r!id'] := '(2,38767)'; // 有入仓权限的角色：入库人员 ,管理员
    nvcbbsellby.Active := True;
  end;

  // nvhlpseller.id := SysInfo.LoginUserInfo.UserID;
  // nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
  GroupBox2.Visible := False;
  ispackarrivalbill := getParametervalue('8068', Sysinfo.LoginUserInfo.OrgID);
  if (ispackarrivalbill = '1') then
  begin
    GroupBox2.Visible := True;
    if not checkBillno('PackArrivalBill') then
    begin
      SysDialogs.ShowInfo('未领行包到货收讫单票号,无法进行入库操作！');
    end
    else
    begin

    end;
  end;

  refreshBill;

end;

procedure TFrmPackWarehousing.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // inherited;
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
  end;
  Key := 0;

end;

procedure TFrmPackWarehousing.FormShow(Sender: TObject);
begin
  inherited;

  jcdspackedvalue.Active := True;
  jcdslocationvalue.Active := True;
  jcdcertificatetypevalue.Active := True;
  jcdshiptypevalue.Active := True;
  jcdspaymethodvalue.Active := True;
  jcdsstatusvalue.Active := True;
  jcdsgoodtypevalue.Active := True;
  jcdspacktypevalue.Active := True;

  nvcbborg.Active := True;

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackBill'] > 0) then

  begin

  end
  else
  begin

  end;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackWarehousing.nvedtpacknoKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    if trim(nvedtpackno.Text) = '' then
      exit;
    // if length(trim(NovaEdtTicketNo.text)) > Sysinfo.curBillLength.Items
    // ['PackBill'] then
    // begin
    //
    // // 如果获取的车票长度大于系统票据长度，则从后面截取到符合系统的票据长度
    // templen := length(trim(NovaEdtTicketNo.text))
    // - Sysinfo.curBillLength.Items['Ticket'];
    // NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen + 1,
    // length(NovaEdtTicketNo.text));
    // end;

    // 不判断票号长度，如果长度不对，提示“该车票不存在，或过了补开天数”
    // if length(trim(nvedtpackno.Text)) = SysInfo.curBillLength.Items['PackBill']
    // then
    // begin
    packnoUpStatus();
    nvedtpackno.Clear;
    nvedtpackno.SetFocus;
    // end
    // else
    // begin
    // // SysDialogs.Warning('该票号不存在！');
    // inwarehousemsg.Caption := trim(nvedtpackno.Text) + '票号不存在！';
    // nvedtpackno.Clear;
    // nvedtpackno.SetFocus;
    // end;
  end;

end;

procedure TFrmPackWarehousing.nvedtpacknoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  nvedtpackno.SetFocus;
end;

procedure TFrmPackWarehousing.packnoUpStatus();
begin
  inherited;
  with jcdsPackup do
  begin
    Active := False;

    Params.ParamValues['pack.packno'] := trim(nvedtpackno.Text);
    Params.ParamValues['pack.status'] := '4';

    Execute;

    if Params.ParamValues['msg'] <> '' then
    begin
      // SysDialogs.ShowMessage(Params.ParamValues['msg']);
      inwarehousemsg.Caption := Params.ParamValues['msg'];
      SysLog.WriteLog('行包管理->到货入仓', '扫描入库', Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      with jcdsResult do
      begin
        Active := False;
        Params.ParamValues['filter_EQS_p!packno'] := trim(nvedtpackno.Text);
        Active := True;
        nvedtpackno.Text := '';
      end;
    end;
  end;
end;

procedure TFrmPackWarehousing.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定把该行包作废吗？') then
    begin
      exit;
    end;

    with jcdspackwaste do
    begin

      Active := False;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('该行包已签发，无法废弃！');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('该行包已处理，无法废弃！');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '3' then
      begin
        SysDialogs.ShowInfo('该行包已废弃,无法再次废弃！');
        exit;
      end;

      if jcdsResult.FieldByName('createby').AsString = '0' then
      begin
        SysDialogs.ShowInfo('中心下载数据,无法废弃！');
        exit;
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
    SysDialogs.ShowInfo('请先选择需要作废的记录！');
  end;
end;

procedure TFrmPackWarehousing.tbtnEditClick(Sender: TObject);
var entrypackerList : TStringList;
var i : Integer;
begin
  inherited;
  if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  begin

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('该行包已处理，无法修改！');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '3' then
    begin
      SysDialogs.ShowInfo('该行包已废弃,无法修改！');
      exit;
    end;

    if jcdsResult.FieldByName('createby').AsString = '0' then
    begin
      SysDialogs.ShowInfo('中心下载数据,无法修改！');
      exit;
    end;

    FrmPackWarehousingAdd := TFrmPackWarehousingAdd.Create(self,
      self.functionItem);
    try
      with FrmPackWarehousingAdd do
      begin
        Caption := '修改到货入仓';
        edittype := Tedittype.update;

        packarriverid := jcdsResult.FieldByName('packarriverid').AsInteger;
        id := packarriverid;
        packarrivercreateby := jcdsResult.FieldByName('packarrivercreatby').AsInteger;
        packarrivercreatetime := jcdsResult.FieldByName('packarrivercreatetime').AsString;
        nvedtpackarriverno.Text := jcdsResult.FieldByName('packarriverno')
          .AsString; // 收讫单号
        nvedtpackno.Text := jcdsResult.FieldByName('packno').AsString; // 行包单号
        // 行包名称
        nveditpackname.Text := jcdsResult.FieldByName('name').AsString;
        // 货物状态
        nvcbbgoodsstatus.ItemIndex := jcdsResult.FieldByName('goodsstatus')
          .AsInteger;
        // 中转费
        nvedttransitfee.Text := jcdsResult.FieldByName('transitfee').AsString;
        // 服务费
        nvedtservicefee.Text := jcdsResult.FieldByName('servicefee').AsString;
        // 货款
        nvedtpackprice.Text := jcdsResult.FieldByName('packprice').AsString;
        // 操作人
        // nvcbbentrypacker.Text := jcdsResult.FieldByName('entrypacker').AsString;
        entrypackerList := TStringList.Create;
        entrypackerList.DelimitedText := jcdsResult.FieldByName('entrypacker').AsString;
        entrypackerList.Delimiter := ';';
        for i := 0 to (entrypackerList.Count -2) do
         begin
            nvcbbentrypacker.SetCheck(nvcbbentrypacker.Items.indexOf(StrUtils.LeftStr(entrypackerList[i],length(entrypackerList[i])-1)),true);
         end;
         nvcbbentrypacker.SetCheck(nvcbbentrypacker.Items.indexOf(entrypackerList[entrypackerList.Count-1]),true);
        // 付款方式
        nvcbbpaymethod.ItemIndex := StrToInt
          (jcdsResult.FieldByName('paymethod').AsString);

        // goodtype := jcdsResult.FieldByName('goodtypevalue').AsString; // 货物类别
        packid := jcdsResult.FieldByName('id').AsInteger;
        createby := jcdsResult.FieldByName('createby').AsInteger;
        createtime := jcdsResult.FieldByName('createtime').AsDateTime;
        nvhelpsendstationid.id := jcdsResult.FieldByName('sendstationid')
          .AsInteger; // 发货站
        nvhelpsendstationid.Text := jcdsResult.FieldByName('sendstationname')
          .AsString;

        // tostationid := jcdsResult.FieldByName('tostationname').AsInteger; // 目的地
        // nvedtname.Text := jcdsResult.FieldByName('name').AsString; // 货物名称
        // scheduleid := jcdsResult.FieldByName('scheduleid').AsInteger; // 班次
        nvhelpvehiclecode.id := jcdsResult.FieldByName('vehicleid').AsInteger;
        // 车牌号
        nvhelpvehiclecode.Text := jcdsResult.FieldByName('vehiclecode')
          .AsString;
        // depart := jcdsResult.FieldByName('departdate').AsDateTime; // 发货、到货日期
        nvedtpackno.Text := jcdsResult.FieldByName('packno').AsString; // 行包单号
        nvedtpackno.Enabled := False;
        // invoiceno := ''; // 发票号
        // sellby := jcdsResult.FieldByName('sellby').AsInteger; // 办理员
        nvedtpieces.Text := jcdsResult.FieldByName('pieces').AsString; // 件数;
        // nvedtweight.Text := jcdsResult.FieldByName('weight').AsString; // 重量
        // volume := jcdsResult.FieldByName('volume').AsString; // 体积
        nvcbbpacked.SetItemIndexByCode
          (jcdsResult.FieldByName('packed').AsString); // 包装
        nvedtshipprice.Text := jcdsResult.FieldByName('shipprice').AsString;
        // 托运费
        // nvedtpackfee.Text := jcdsResult.FieldByName('packfee').AsString; // 包装费
        // nvedthandfee.Text := jcdsResult.FieldByName('handfee').AsString;
        // 发货装卸费
        // nvedtunloadfee.Text := jcdsResult.FieldByName('unloadfee').AsString;
        // 到货装卸费

        // nvedtdeliveryfee.Text := jcdsResult.FieldByName('deliveryfee')
        // .AsString; // 送货费
        // custodial := jcdsResult.FieldByName('custodial').AsFloat; // 保管费
        // nvedttransitfee.Text := jcdsResult.FieldByName('transitfee').AsString;
        // 中转费;
        // nvedtinsuredamount.Text := jcdsResult.FieldByName('insuredamount')
        // .AsString; // 保价金额
        // nvedtinsurancefee.Text := jcdsResult.FieldByName('insurancefee')
        // .AsString; // 保价费
        // nvedtinsurance.Text := jcdsResult.FieldByName('insurance').AsString;
        // 保险费
        nvedtotherfee.Text := jcdsResult.FieldByName('otherfee').AsString;
        // 其他费用
        nvedttotalfee.Text := jcdsResult.FieldByName('totalfee').AsString;
        // 合计金额
        // location:string;//varchar2(20)	y			存放位置
        nvedtpackprice.Text := jcdsResult.FieldByName('packprice').AsString;
        // 代收货款
        // nvedtSender.Text := jcdsResult.FieldByName('sender').AsString; // 托运人
        // senderphone := jcdsResult.FieldByName('senderphone').AsString; // 托运人电话
        // senderaddress := jcdsResult.FieldByName('senderaddress').AsString; // 托运人地址
        nvedtconsignee.Text := jcdsResult.FieldByName('consignee').AsString;
        // 收货人
        nvedtconsigneephone.Text := jcdsResult.FieldByName('consigneephone')
          .AsString; // 收货人电话
        // 收货人地址
        // nvedtconsigneeaddress.Text := jcdsResult.FieldByName('consigneeaddress')
        // .AsString;

        // certificatetype := jcdsResult.FieldByName('certificatetype').AsString;// 证件类型

        // nvedtcertificateno.Text := jcdsResult.FieldByName('certificateno')
        // .AsString; // 证件号码
        // shiptype := jcdsResult.FieldByName('shiptype').AsString; // 托运方式

        nvhelpzytostationid.id := jcdsResult.FieldByName('zhuanyuntostationid')
          .AsInteger;
        nvhelpzytostationid.Text := jcdsResult.FieldByName
          ('zhuanyuntostationname').AsString;
        // nvhlpseller.Id := jcdsResult.FieldByName('sellby')        //操作人
        // .AsInteger;
        // nvhlpseller.Text := jcdsResult.FieldByName('sellbyname')
        // .AsString;
        nvcbblocation.SetItemIndexByCode(jcdsResult.FieldByName('location')
            .AsString);
        // 备注
      end;
      if SysMainForm.showFormModal(FrmPackWarehousingAdd, False) = mrok then
      begin
//        id := FrmPackWarehousingAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('packarriverid', inttostr(id), []);
      end;
    finally
      FreeAndNil(FrmPackWarehousingAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmPackWarehousing.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdspackedvalue.Active := False;
  jcdspackedvalue.Active := True;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;

    Params.ParamValues['filter_INS_p!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);
    Params.ParamValues['filter_LIKES_p!packno'] := trim(nvedtpackno.Text);
    if (nvcbbsellby.GetSelectID = '') then // 操作人
      Params.ParamValues['filter_LIKES_p!entrypacker'] := ''
    else
      Params.ParamValues['filter_LIKES_p!entrypacker'] := nvcbbsellby.Text;
    Params.ParamValues['filter_EQS_p!packtype'] := '1'; // 行包类型: 1到货
    if (nvcbbgoodsstatus.GetSelectID > -1) then // 货物状态：0完好，1破损，2打湿
      Params.ParamValues['filter_EQS_p!goodsstatus'] :=
        nvcbbgoodsstatus.GetSelectCode
    else
      Params.ParamValues['filter_EQS_p!goodsstatus'] := '';
    Active := True;
    nvedtpackno.SetFocus;
  end;
end;

procedure TFrmPackWarehousing.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;

  if (ispackarrivalbill = '1') then
  begin
    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackArrivalBill')
      and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackArrivalBill')
      and (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] > 0)
      then
    begin

    end
    else
    begin

      if (ispackbill = True) and (Sysinfo.LoginUserInfo.curBillNum.Items
          ['PackArrivalBill'] = 0) then
      begin
        if (initBillNo('PackArrivalBill')) then
        begin
          if (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] = 0)
            then
          begin
            SysDialogs.Warning('您当前的到货收讫单据已用完，请重新领取单票！');
            exit;
          end
          else
            refreshBill();
        end;
      end
      else
      begin
        if not checkBillno('PackArrivalBill') then
        begin
          SysDialogs.ShowInfo('未领行包到货收讫单票号,无法进行入库操作！');

          exit;
        end
        else
        begin
          refreshBill();
        end;
      end;
    end;

  end;

  FrmPackWarehousingAdd := TFrmPackWarehousingAdd.Create(self);

  try
    FrmPackWarehousingAdd.Caption := '添加到货入仓';
    FrmPackWarehousingAdd.edittype := Tedittype.add;
    FrmPackWarehousingAdd.packarriverno := Sysinfo.LoginUserInfo.curBillNo.Items
      ['PackArrivalBill']; // 行包收讫单号
      id := strtoint(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']) ;
    if SysMainForm.showFormModal(FrmPackWarehousingAdd, False) = mrok then
    begin
//      id := FrmPackWarehousingAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('packarriverno', id, []);
      nvedtpackno.SetFocus;
    end;
  finally
    FreeAndNil(FrmPackWarehousingAdd);
    refreshBill;
  end;
end;

procedure TFrmPackWarehousing.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  isoriginalprint := False; // 新单号重打
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  // if (jcdsResult.Active = True) and (jcdsResult.RecNo > 0) then
  // begin
  if not SysDialogs.Confirm('提示', '确定要重打该信息吗？') then
  begin
    exit;
  end;
  { if jcdsResult.FieldByName('status').AsString = '1' then
    begin
    SysDialogs.ShowInfo('该行包已签发，不能重打！');
    exit;
    end;
    }
  if jcdsResult.FieldByName('packarriverstatus').AsString = '1' then
  // 行包出库结算状态：0：未结算；1：已注销：2：已结算
  begin
    SysDialogs.ShowInfo('该行包已注销,不能重打！');
    exit;
  end;

  if jcdsResult.FieldByName('status').AsString = '7' then
  begin
    SysDialogs.ShowInfo('该行包已退票,不能重打！');
    exit;
  end;

  if (Sysinfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby')
      .AsInteger) or
    (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowMessage('不可以重打他人开的受理单！');
    exit;
  end;
  try

    if not Assigned(packprint) then
      packprint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('到货收讫单', '到货收讫单'));
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;
    printValue.add('P_NO', Sysinfo.LoginUserInfo.curBillNo.Items
        ['PackArrivalBill']); // 收讫单号
    id :=  strtoint(Sysinfo.LoginUserInfo.curBillNo.Items
        ['PackArrivalBill']);
    printValue.add('departdate', FormatDateTime('yyyy-mm-dd',
        jcdsResult.FieldByName('departdate').AsDateTime));
    printValue.add('sendstationvalue',
      jcdsResult.FieldByName('sendstationname').AsString);
    printValue.add('vehiclevalue',
      jcdsResult.FieldByName('vehiclecode').AsString);
    printValue.add('shippricemoney',
      jcdsResult.FieldByName('totalfee').AsString);   //  代收运费：应为合计金额
    printValue.add('packpricemoney',
      jcdsResult.FieldByName('packprice').AsString);   //  代收货款
    printValue.add('shiptostation',
      jcdsResult.FieldByName('zhuanyuntostationname').AsString);
    printValue.add('sellbyname',
      jcdsResult.FieldByName('entrypacker').AsString); // 到货入仓操作员
    printValue.add('consignee', jcdsResult.FieldByName('consignee').AsString);
    printValue.add('consigneephone',
      jcdsResult.FieldByName('consigneephone').AsString);
    printValue.add('packed',
      jcdsResult.FieldByName('packedvalue').AsString);
    printValue.add('location',
      jcdsResult.FieldByName('locationvalue').AsString);
    printValue.add('totalprice', jcdsResult.FieldByName('totalfee').AsString);
    printValue.add('pieces', jcdsResult.FieldByName('pieces').AsString);
    packprint.SingleValue := printValue;

    with jcdswhackpackarriver do
    begin
      Active := False;
      Params.ParamValues['packarriver.id'] := jcdsResult.FieldByName
        ('packarriverid').AsString;
      Params.ParamValues['packarriver.packarriverno'] :=
        Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill'];
      Params.ParamValues['packarriver.updateby'] := inttostr
        (Sysinfo.LoginUserInfo.UserID);
      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        try
          packprint.Print;
        finally
          updatepackarrivalbill();
          refreshBill();
        end;
      end;
    end;

  finally
    tbtnFilter.Click;
    jcdsResult.Locate('packarriverno', id, []);
//    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;
end;

procedure TFrmPackWarehousing.ToolButton50Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  try
    if (jcdsResult.FieldByName('paymethod').AsString <> '1') then
    begin
      SysDialogs.ShowInfo('没有代付,无需做对付款回收操作！');
      exit;
    end
    else
    begin
      if jcdsResult.FieldByName('recyclestatus').AsString = '1' then
      begin
        SysDialogs.ShowInfo('对付款已回收,无需再做对付款回收操作！');
        exit;
      end
      else
      begin
        // SysDialogs.ShowInfo('需要收款！');
        if not SysDialogs.Confirm('提示', '确定进行对付款回收操作？') then
        begin
          exit;
        end;
        with jcdspaymentrecyclesave do
        begin

          Params.ParamValues['pack.id'] := jcdsResult.FieldByName('id')
            .AsString;
          Execute;
        end;

      end;
    end;
  finally
    // FreeAndNil(jcdsResult);
    tbtnFilterClick(Sender);
  end;

end;

procedure TFrmPackWarehousing.ToolButton51Click(Sender: TObject);
begin
  inherited;
  isoriginalprint := True; // 按原票号重打
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if not SysDialogs.Confirm('提示', '确定要重打该信息吗？') then
  begin
    exit;
  end;
  if jcdsResult.FieldByName('status').AsString = '3' then
  begin
    SysDialogs.ShowInfo('该行包已废弃,不能重打！');
    exit;
  end;
  if (Sysinfo.LoginUserInfo.UserID <> jcdsResult.FieldByName('sellby')
      .AsInteger) or
    (Sysinfo.LoginUserInfo.OrgID <> jcdsResult.FieldByName('orgid').AsInteger)
    then
  begin
    SysDialogs.ShowMessage('不可以重打他人开的受理单！');
    exit;
  end;

  try

    if not Assigned(packprint) then
      packprint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('到货收讫单', '到货收讫单'));
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;
    printValue.add('P_NO', jcdsResult.FieldByName('packarriverno').AsString);
    // 收讫单号
    printValue.add('departdate', FormatDateTime('yyyy-mm-dd',
        jcdsResult.FieldByName('departdate').AsDateTime));
    printValue.add('sendstationvalue',
      jcdsResult.FieldByName('sendstationname').AsString);
    printValue.add('vehiclevalue',
      jcdsResult.FieldByName('vehiclecode').AsString);
    printValue.add('shippricemoney',
      jcdsResult.FieldByName('totalfee').AsString);    // 代收运费
    printValue.add('packpricemoney',
      jcdsResult.FieldByName('packprice').AsString);   // 代收货款
    printValue.add('shiptostation',
      jcdsResult.FieldByName('zhuanyuntostationname').AsString);
    printValue.add('sellbyname',
      jcdsResult.FieldByName('entrypacker').AsString); // 到货入仓操作员
    printValue.add('consignee', jcdsResult.FieldByName('consignee').AsString);
    printValue.add('consigneephone',
      jcdsResult.FieldByName('consigneephone').AsString);
    printValue.add('packed',
      jcdsResult.FieldByName('packedvalue').AsString);
    printValue.add('location',
      jcdsResult.FieldByName('locationvalue').AsString);
    printValue.add('totalprice', jcdsResult.FieldByName('totalfee').AsString);
    printValue.add('pieces', jcdsResult.FieldByName('pieces').AsString);
    packprint.SingleValue := printValue;
    packprint.Print;

  finally
    tbtnFilter.Click;
    jcdsResult.Locate('id', jcdsResult.FieldByName('id').AsInteger, []);
  end;

end;

procedure TFrmPackWarehousing.refreshBill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('PackArrivalBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('PackArrivalBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['PackArrivalBill'] > 0) then
  begin
    lbpackbill.Caption := Sysinfo.LoginUserInfo.curBillNo.Items
      ['PackArrivalBill'];
    lbbillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['PackArrivalBill']);
    ispackbill := True;
  end
  else
  begin
    lbpackbill.Caption := '000000000000';
    lbbillnum.Caption := '0';
    ispackbill := False;
  end;

end;

procedure TFrmPackWarehousing.updatepackarrivalbill();
var
  billinusestatus, billinusenextno, billinusenextform: string;
begin

  with Sysinfo.LoginUserInfo do
  begin
    billinusenextform := inttostr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']));
    billinusenextno := inttostr
      (strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackArrivalBill']
        ) + 1);

    curBillNo.AddOrSetValue('PackArrivalBill', zerofill(billinusenextno,
        length(curBillNo.Items['PackArrivalBill'])));
    curBillNum.AddOrSetValue('PackArrivalBill',
      curBillNum.Items['PackArrivalBill'] - 1);

    if curBillNum.Items['PackArrivalBill'] > 0 then
      billinusestatus := '1'
    else
      billinusestatus := '2';

  end;

  with jcdsupdateBillinuse do
  begin
    Active := False;
    Params.ParamValues['billinusestatus'] := billinusestatus;
    Params.ParamValues['billinusenextno'] := billinusenextno;
    Params.ParamValues['billinusenextform'] := billinusenextform;
    Params.ParamValues['billtypecode'] := 'PackArrivalBill';

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
