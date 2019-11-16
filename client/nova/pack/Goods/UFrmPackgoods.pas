unit UFrmPackGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmPackGoods = class(TSimpleCRUDForm)
    jcdsgoodswaste: TjsonClientDataSet;

    jcdsResultid: TLargeintField;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    Label1: TLabel;
    nvedtcustomer: TNovaEdit;
    Label3: TLabel;
    jcdsgoodstypevalue: TjsonClientDataSet;
    jcdsstatusvalue: TjsonClientDataSet;
    nvcbborg: TNovaCheckedComboBox;
    jcdswhackpack: TjsonClientDataSet;
    jcdsupdateBillinuse: TjsonClientDataSet;
    Label5: TLabel;
    nvedtgoodsno: TNovaEdit;
    nvedtphone: TNovaEdit;
    Label4: TLabel;
    jcdsResultgoodsno: TWideStringField;
    jcdsResultnum: TWideStringField;
    jcdsResultcustomer: TWideStringField;
    jcdsResultphone: TWideStringField;
    jcdsResultidcardno: TWideStringField;
    jcdsResultGOODSTYPE: TWideStringField;
    jcdsResultpieces: TIntegerField;
    jcdsResultlocation: TWideStringField;
    jcdsResultpickupenddate: TDateTimeField;
    jcdsResultdeposittiime: TDateTimeField;
    jcdsResultcustodial: TFloatField;
    jcdsResultpenalty: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultconsignee: TLargeintField;
    jcdsResultconsigneename: TWideStringField;
    jcdsResultSTATUS: TWideStringField;
    jcdsResultpickuper: TWideStringField;
    jcdsResultpickupdate: TDateTimeField;
    jcdsResultoperator: TLargeintField;
    jcdsResultoperatorname: TWideStringField;
    jcdsResultremak: TWideStringField;
    jcdsResultorgname: TWideStringField;
    Label6: TLabel;
    nvcbbgoodsstatus: TNovaComboBox;
    jcdsResultcreatebyname: TWideStringField;
    jcdsResultupdatebyname: TWideStringField;
    jcdsResultstatusvalue: TWideStringField;
    jcdsResultgoodstypevalue: TWideStringField;
    nvhlpseller: TNovaHelp;
    GroupBox2: TGroupBox;
    lbpackbill: TLabel;
    Label7: TLabel;
    lbbillnum: TLabel;
    tmGetCurInvoinNo: TTimer;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmGetCurInvoinNoTimer(Sender: TObject);

  private
    { Private declarations }
    isgoodsbill:Boolean;//判断前面是否领取过票号来判断用完后重置票号

    procedure printpack;
    procedure refreshBill;
    procedure updatepackbill;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmPackGoods: TFrmPackGoods;

implementation

uses UFrmPackGoodsAdd,UFrmGoodsReceive,DateUtils;
{$R *.dfm}

procedure TFrmPackGoods.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmPackGoods.refreshBill();
begin

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('GoodsBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('GoodsBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] > 0) then
  begin
    lbpackbill.Caption :=Sysinfo.LoginUserInfo.curBillNo.Items['GoodsBill'];
    lbbillnum.Caption :=IntToStr(Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill']);
  end
  else
  begin
    lbpackbill.Caption :='000000000000';
    lbbillnum.Caption :='0';
  end;

end;

procedure TFrmPackGoods.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
tmGetCurInvoinNo.Enabled := false;
end;

procedure TFrmPackGoods.FormCreate(Sender: TObject);
begin
  inherited;

  if not checkBillno('GoodsBill') then
  begin
    SysDialogs.ShowInfo('未领小件寄存单票号,无法进行寄存操作！');
    isgoodsbill:=False;
  end
  else
  begin
     isgoodsbill:=True;
  end;
  refreshBill;

  dtpstartdate.DateTime :=Now();
  dtpenddate.DateTime :=Now();

end;


procedure TFrmPackGoods.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active :=true;
  nvcbbgoodsstatus.Active :=true;
  jcdsgoodstypevalue.Active :=true;
  jcdsstatusvalue.Active :=true;
  tmGetCurInvoinNo.Enabled := true;
end;

procedure TFrmPackGoods.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmPackGoods.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;


procedure TFrmPackGoods.tbtnDeleteClick(Sender: TObject);

begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('提示', '确定把该信息作废吗？') then
    begin
      exit;
    end;

    with jcdsgoodswaste do
    begin

      Active :=false;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('该小件已提领，无法废弃！');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('该小件已废弃,无法再次废弃！');
        exit;
      end;

      Params.ParamValues['goods.id'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['goods.status'] := '2';

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

procedure TFrmPackGoods.tbtnEditClick(Sender: TObject);
var id:Integer;
begin
  inherited;



  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin

    if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('GoodsBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('GoodsBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] > 0) then
    begin

    end
    else
    begin
       if not checkBillno('GoodsBill') then
       begin
         SysDialogs.ShowInfo('未领小件寄存单票号,无法进行修改操作！');
         exit;
       end;
    end;
    refreshBill;
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('该小件已提领,不能修改！');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('该小件已废弃,不能修改！');
      exit;
    end;

//     if sysInfo.LoginUserInfo.StationID<>jcdsResult.FieldByName('TOSTATIONID').AsInteger then
//     begin
//      SysDialogs.ShowInfo('当前登录站点不是行包到站点,无法提领！');
//      exit;
//     end;

    if formatdatetime('yyyyMMdd',
            jcdsResult.FieldByName('pickupenddate').AsDateTime) < formatdatetime
            ('yyyyMMdd', Now) then
    begin
      SysDialogs.Warning('已过提取截止日期不允许修改！');
      exit;
    end;

    FrmPackGoodsAdd := TFrmPackGoodsAdd.Create(self, self.functionItem);
    with FrmPackGoodsAdd do
    begin
       try
          FrmPackGoodsAdd.Caption := '修改小件寄存';
          FrmPackGoodsAdd.edittype := Tedittype.update;
          goodsid := jcdsResult.FieldByName('id').AsInteger;
          goodsno := jcdsResult.FieldByName('goodsno').AsString;
          createby := jcdsResult.FieldByName('createby').AsInteger;
          createtime := jcdsResult.FieldByName('createtime').AsDateTime;
          pickupenddate :=jcdsResult.FieldByName('pickupenddate').AsDateTime;//提取截止日期
          consigneename :=jcdsResult.FieldByName('consigneename').AsString;;//收货人
          consignee :=jcdsResult.FieldByName('consignee').AsInteger;//收货人
          deposittiime :=jcdsResult.FieldByName('deposittiime').AsDateTime; //寄存时间
          memremarks.Text :=jcdsResult.FieldByName('remak').AsString;//备注
          orgid :=jcdsResult.FieldByName('orgid').AsInteger;

          nvedtnum.Text :=jcdsResult.FieldByName('num').AsString;//保管牌号
          nvedtcustomer.Text :=jcdsResult.FieldByName('customer').AsString;//旅客姓名
          nvedtphone.Text :=jcdsResult.FieldByName('phone').AsString;//旅客电话
          nvedtidcardno.Text :=jcdsResult.FieldByName('idcardno').AsString;//身份证
          nvcbbgoodstype.SetItemIndexByCode(jcdsResult.FieldByName('goodstype').AsString);//小件类别
          nvedtpieces.Text :=jcdsResult.FieldByName('pieces').AsString;//件数;
          nvedtlocation.Text :=jcdsResult.FieldByName('location').AsString;//存放地点;
          nvedtcustodial.Text :=jcdsResult.FieldByName('custodial').AsString;//保管费
      //    Params.ParamByName('goods.penalty').Value := '';//滞纳金
      //    Params.ParamByName('goods.totalfee').Value := '';//合计金额
      //    Params.ParamByName('goods.status').Value := '0';//状态（0：库存、1：已提领，2：作废）
      //    Params.ParamByName('goods.pickuper').Value := '';//提领人
      //    Params.ParamByName('goods.pickupdate').Value := '';//提领日期
      //    Params.ParamByName('goods.operatorby').Value := '';//办理员


          if SysMainForm.showFormModal(FrmPackGoodsAdd, false) = mrOk then
          begin
            id := FrmPackGoodsAdd.operationid;
            tbtnFilter.Click;

            jcdsResult.Locate('id', id, []);
          end;
        finally
          FreeAndNil(FrmPackGoodsAdd);
          refreshBill;
        end;
    end;

  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmPackGoods.tbtnFilterClick(Sender: TObject);
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

    Params.ParamValues['filter_INS_g!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_g!deposittiime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_g!deposittiime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);

    Params.ParamValues['filter_LIKES_g!goodsno'] := Trim(nvedtgoodsno.Text);
    Params.ParamValues['filter_LIKES_g!customer'] := Trim(nvedtcustomer.Text);
    Params.ParamValues['filter_LIKES_g!phone'] := Trim(nvedtphone.Text);

    if nvhlpseller.id <= 0 then
      Params.ParamValues['filter_EQL_g!consignee_OR_g!operator'] := ''
    else
      Params.ParamValues['filter_EQL_g!consignee_OR_g!operator'] := nvhlpseller.id;

    if nvcbbgoodsstatus.ItemIndex<0 then
       Params.ParamValues['filter_EQS_g!status'] := ''
    else
       Params.ParamValues['filter_EQS_g!status'] :=nvcbbgoodsstatus.GetSelectCode;

    Active := true;


  end;
end;

procedure TFrmPackGoods.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;



  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('GoodsBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('GoodsBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] > 0) then
  begin

  end
  else
  begin

    if (isgoodsbill=True) and (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] = 0) then
    begin
      if (initBillNo('GoodsBill')) then
      begin
        if (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] = 0) then
        begin
          SysDialogs.Warning('您当前的单据已用完，请重新领取单票！');
          exit;
  //          result := false;
        end
        else
            refreshBill();
  //          result := true;

      end;
    end
    else
    begin
       if not checkBillno('GoodsBill') then
       begin
         SysDialogs.ShowInfo('未领小件寄存单票号,无法进行寄存操作！');
         exit;
       end;
    end;


  end;
  refreshBill;


 {
 SysDialogs.ShowMessage(inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'])+ 1));
 SysDialogs.ShowMessage(boolToStr(Sysinfo.LoginUserInfo.curBillNo.ContainsKey
        ('PackBill'))); // 0
  SysDialogs.ShowMessage(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']);
  // 起始号
  SysDialogs.ShowMessage(inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['PackBill'])); // 领取数}

  FrmPackGoodsAdd := TFrmPackGoodsAdd.Create(self, self.functionItem);
  try
    FrmPackGoodsAdd.Caption := '小件寄存';
    FrmPackGoodsAdd.edittype := Tedittype.add;
    if SysMainForm.showFormModal(FrmPackGoodsAdd, false) = mrOk then
    begin
      id := FrmPackGoodsAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmPackGoodsAdd);
    refreshBill;
  end;
end;

procedure TFrmPackGoods.tmGetCurInvoinNoTimer(Sender: TObject);
begin
  inherited;
  refreshBill;
end;

procedure TFrmPackGoods.ToolButton50Click(Sender: TObject);
var id,days:Integer;
 storagefeemoney,daymoney,penaltymoney:Double;
begin
  inherited;

 { if not checkBillno('GoodsBill') then
  begin
    SysDialogs.ShowInfo('未领小件寄存单票号,无法进行寄存操作！');
    exit;
  end;

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('GoodsBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('GoodsBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] > 0) then
  begin

  end
  else
  begin
    SysDialogs.ShowInfo('未领小件寄存单票号,无法进行寄存操作！');
    exit;
  end; }

  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('该小件已提领,不能再次提领！');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('该小件已废弃,不能提领！');
      exit;
    end;

    if sysInfo.LoginUserInfo.OrgID<>jcdsResult.FieldByName('orgid').AsInteger then
    begin
     SysDialogs.ShowInfo('当前登录机构不是小件寄存机构,无法提领！');
     exit;
    end;

    FrmGoodsReceive := TFrmGoodsReceive.Create(self, self.functionItem);
    with FrmGoodsReceive do
    begin
       try
          FrmGoodsReceive.edittype := Tedittype.update;
          goodsid := jcdsResult.FieldByName('id').AsInteger;
          goodsno := jcdsResult.FieldByName('goodsno').AsString;
          createby := jcdsResult.FieldByName('createby').AsInteger;
          createtime := jcdsResult.FieldByName('createtime').AsDateTime;

          consigneename :=jcdsResult.FieldByName('consigneename').AsString;;//收货人
          consignee :=jcdsResult.FieldByName('consignee').AsInteger;//收货人
          deposittiime :=jcdsResult.FieldByName('deposittiime').AsDateTime; //寄存时间
          memremarks.Text :=jcdsResult.FieldByName('remak').AsString;//备注
          orgid :=jcdsResult.FieldByName('orgid').AsInteger;


          nvhelpgoodsno.Text := jcdsResult.FieldByName('goodsno').AsString;//寄存单号
          nvhelpgoodsno.Id := jcdsResult.FieldByName('id').AsInteger;//

          nvedtgoodsno.Text := jcdsResult.FieldByName('goodsno').AsString;//寄存单号

          dtppickupenddate.DateTime :=jcdsResult.FieldByName('pickupenddate').AsDateTime;//提取截止日期
          nvedtnum.Text :=jcdsResult.FieldByName('num').AsString;//保管牌号
          nvedtcustomer.Text :=jcdsResult.FieldByName('customer').AsString;//旅客姓名
          nvedtphone.Text :=jcdsResult.FieldByName('phone').AsString;//旅客电话
          nvedtidcardno.Text :=jcdsResult.FieldByName('idcardno').AsString;//身份证
          nvcbbgoodstype.SetItemIndexByCode(jcdsResult.FieldByName('goodstype').AsString);//小件类别
          nvedtpieces.Text :=jcdsResult.FieldByName('pieces').AsString;//件数;
          nvedtlocation.Text :=jcdsResult.FieldByName('location').AsString;//存放地点;
          nvedtcustodial.Text :=jcdsResult.FieldByName('custodial').AsString;//保管费

          storagefeemoney :=StrToFloat(nvedtcustodial.Text);//保管费
          dtppickupdate.DateTime :=Now();//提领日期

          if formatdatetime('yyyyMMdd',
           dtppickupenddate.DateTime) < formatdatetime
            ('yyyyMMdd', Now) then
          begin
          //当提取截止日期小于提领日期
            daymoney :=StrToFloat(getParametervalue('8010', sysInfo.LoginUserInfo.OrgID));//每天的滞纳金
            days :=DaysBetween(Now,dtppickupenddate.DateTime);//超期天数
            penaltymoney:= daymoney*days;// 滞纳金
          end;



          nvedtpenalty.Text :=FloatToStr(penaltymoney);
          nvedttotalfee.Text :=FloatToStr(penaltymoney+storagefeemoney);//合计金额

          nvedtpickuper.Text := nvedtcustomer.Text; //提领人

      //    Params.ParamByName('goods.penalty').Value := '';//滞纳金
      //    Params.ParamByName('goods.totalfee').Value := '';//合计金额
      //    Params.ParamByName('goods.status').Value := '0';//状态（0：库存、1：已提领，2：作废）
      //    Params.ParamByName('goods.pickuper').Value := '';//提领人
      //    Params.ParamByName('goods.pickupdate').Value := '';//提领日期
      //    Params.ParamByName('goods.operatorby').Value := '';//办理员


          if SysMainForm.showFormModal(FrmGoodsReceive, false) = mrOk then
          begin
            id := FrmGoodsReceive.operationid;
            tbtnFilter.Click;
            jcdsResult.Locate('id', id, []);
          end;
        finally
          FreeAndNil(FrmGoodsReceive);
//          refreshBill;
        end;
    end;
  end
  else
  begin
    FrmGoodsReceive := TFrmGoodsReceive.Create(self, self.functionItem);
    with FrmGoodsReceive do
    begin
        try
          FrmGoodsReceive.edittype := Tedittype.add;
          if SysMainForm.showFormModal(FrmGoodsReceive, false) = mrOk then
          begin
            id := FrmGoodsReceive.operationid;
            tbtnFilter.Click;
            jcdsResult.Locate('id', id, []);
          end;
        finally
           FreeAndNil(FrmGoodsReceive);
        end;
    end;
  end;
end;

procedure TFrmPackGoods.printpack();
begin

end;


procedure TFrmPackGoods.updatepackbill();
var billinusestatus,billinusenextno,billinusenextform:string;
begin

     with Sysinfo.LoginUserInfo do
     begin
        billinusenextform := inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill']));
        billinusenextno := inttostr(strtoint64(Sysinfo.LoginUserInfo.curBillNo.Items['PackBill'])+ 1);

        curBillNo.AddOrSetValue('PackBill',
        zerofill(billinusenextno,
         length(curBillNo.Items['PackBill'])));
        curBillNum.AddOrSetValue('PackBill',
        curBillNum.Items['PackBill'] - 1);

        if curBillNum.Items['PackBill']>0 then
          billinusestatus :='1'
        else
          billinusestatus :='2';


     end;

     with jcdsupdateBillinuse do
     begin
        Active :=false;
        Params.ParamValues['billinusestatus']:=billinusestatus;
        Params.ParamValues['billinusenextno']:=billinusenextno;
        Params.ParamValues['billinusenextform']:=billinusenextform;
        Params.ParamValues['billtypecode']:='PackBill';


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
