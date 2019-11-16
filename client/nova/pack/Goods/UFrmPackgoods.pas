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
    isgoodsbill:Boolean;//�ж�ǰ���Ƿ���ȡ��Ʊ�����ж����������Ʊ��

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
    SysDialogs.ShowInfo('δ��С���Ĵ浥Ʊ��,�޷����мĴ������');
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
    if not SysDialogs.Confirm('��ʾ', 'ȷ���Ѹ���Ϣ������') then
    begin
      exit;
    end;

    with jcdsgoodswaste do
    begin

      Active :=false;

      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        SysDialogs.ShowInfo('��С�������죬�޷�������');
        exit;
      end;

      if jcdsResult.FieldByName('status').AsString = '2' then
      begin
        SysDialogs.ShowInfo('��С���ѷ���,�޷��ٴη�����');
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
    SysDialogs.ShowInfo('����ѡ����Ҫ���ϵļ�¼��');
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
         SysDialogs.ShowInfo('δ��С���Ĵ浥Ʊ��,�޷������޸Ĳ�����');
         exit;
       end;
    end;
    refreshBill;
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('��С��������,�����޸ģ�');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('��С���ѷ���,�����޸ģ�');
      exit;
    end;

//     if sysInfo.LoginUserInfo.StationID<>jcdsResult.FieldByName('TOSTATIONID').AsInteger then
//     begin
//      SysDialogs.ShowInfo('��ǰ��¼վ�㲻���а���վ��,�޷����죡');
//      exit;
//     end;

    if formatdatetime('yyyyMMdd',
            jcdsResult.FieldByName('pickupenddate').AsDateTime) < formatdatetime
            ('yyyyMMdd', Now) then
    begin
      SysDialogs.Warning('�ѹ���ȡ��ֹ���ڲ������޸ģ�');
      exit;
    end;

    FrmPackGoodsAdd := TFrmPackGoodsAdd.Create(self, self.functionItem);
    with FrmPackGoodsAdd do
    begin
       try
          FrmPackGoodsAdd.Caption := '�޸�С���Ĵ�';
          FrmPackGoodsAdd.edittype := Tedittype.update;
          goodsid := jcdsResult.FieldByName('id').AsInteger;
          goodsno := jcdsResult.FieldByName('goodsno').AsString;
          createby := jcdsResult.FieldByName('createby').AsInteger;
          createtime := jcdsResult.FieldByName('createtime').AsDateTime;
          pickupenddate :=jcdsResult.FieldByName('pickupenddate').AsDateTime;//��ȡ��ֹ����
          consigneename :=jcdsResult.FieldByName('consigneename').AsString;;//�ջ���
          consignee :=jcdsResult.FieldByName('consignee').AsInteger;//�ջ���
          deposittiime :=jcdsResult.FieldByName('deposittiime').AsDateTime; //�Ĵ�ʱ��
          memremarks.Text :=jcdsResult.FieldByName('remak').AsString;//��ע
          orgid :=jcdsResult.FieldByName('orgid').AsInteger;

          nvedtnum.Text :=jcdsResult.FieldByName('num').AsString;//�����ƺ�
          nvedtcustomer.Text :=jcdsResult.FieldByName('customer').AsString;//�ÿ�����
          nvedtphone.Text :=jcdsResult.FieldByName('phone').AsString;//�ÿ͵绰
          nvedtidcardno.Text :=jcdsResult.FieldByName('idcardno').AsString;//���֤
          nvcbbgoodstype.SetItemIndexByCode(jcdsResult.FieldByName('goodstype').AsString);//С�����
          nvedtpieces.Text :=jcdsResult.FieldByName('pieces').AsString;//����;
          nvedtlocation.Text :=jcdsResult.FieldByName('location').AsString;//��ŵص�;
          nvedtcustodial.Text :=jcdsResult.FieldByName('custodial').AsString;//���ܷ�
      //    Params.ParamByName('goods.penalty').Value := '';//���ɽ�
      //    Params.ParamByName('goods.totalfee').Value := '';//�ϼƽ��
      //    Params.ParamByName('goods.status').Value := '0';//״̬��0����桢1�������죬2�����ϣ�
      //    Params.ParamByName('goods.pickuper').Value := '';//������
      //    Params.ParamByName('goods.pickupdate').Value := '';//��������
      //    Params.ParamByName('goods.operatorby').Value := '';//����Ա


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
    SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  end;
end;

procedure TFrmPackGoods.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
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
          SysDialogs.Warning('����ǰ�ĵ��������꣬��������ȡ��Ʊ��');
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
         SysDialogs.ShowInfo('δ��С���Ĵ浥Ʊ��,�޷����мĴ������');
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
  // ��ʼ��
  SysDialogs.ShowMessage(inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['PackBill'])); // ��ȡ��}

  FrmPackGoodsAdd := TFrmPackGoodsAdd.Create(self, self.functionItem);
  try
    FrmPackGoodsAdd.Caption := 'С���Ĵ�';
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
    SysDialogs.ShowInfo('δ��С���Ĵ浥Ʊ��,�޷����мĴ������');
    exit;
  end;

  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('GoodsBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('GoodsBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['GoodsBill'] > 0) then
  begin

  end
  else
  begin
    SysDialogs.ShowInfo('δ��С���Ĵ浥Ʊ��,�޷����мĴ������');
    exit;
  end; }

  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      SysDialogs.ShowInfo('��С��������,�����ٴ����죡');
      exit;
    end;

    if jcdsResult.FieldByName('status').AsString = '2' then
    begin
      SysDialogs.ShowInfo('��С���ѷ���,�������죡');
      exit;
    end;

    if sysInfo.LoginUserInfo.OrgID<>jcdsResult.FieldByName('orgid').AsInteger then
    begin
     SysDialogs.ShowInfo('��ǰ��¼��������С���Ĵ����,�޷����죡');
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

          consigneename :=jcdsResult.FieldByName('consigneename').AsString;;//�ջ���
          consignee :=jcdsResult.FieldByName('consignee').AsInteger;//�ջ���
          deposittiime :=jcdsResult.FieldByName('deposittiime').AsDateTime; //�Ĵ�ʱ��
          memremarks.Text :=jcdsResult.FieldByName('remak').AsString;//��ע
          orgid :=jcdsResult.FieldByName('orgid').AsInteger;


          nvhelpgoodsno.Text := jcdsResult.FieldByName('goodsno').AsString;//�Ĵ浥��
          nvhelpgoodsno.Id := jcdsResult.FieldByName('id').AsInteger;//

          nvedtgoodsno.Text := jcdsResult.FieldByName('goodsno').AsString;//�Ĵ浥��

          dtppickupenddate.DateTime :=jcdsResult.FieldByName('pickupenddate').AsDateTime;//��ȡ��ֹ����
          nvedtnum.Text :=jcdsResult.FieldByName('num').AsString;//�����ƺ�
          nvedtcustomer.Text :=jcdsResult.FieldByName('customer').AsString;//�ÿ�����
          nvedtphone.Text :=jcdsResult.FieldByName('phone').AsString;//�ÿ͵绰
          nvedtidcardno.Text :=jcdsResult.FieldByName('idcardno').AsString;//���֤
          nvcbbgoodstype.SetItemIndexByCode(jcdsResult.FieldByName('goodstype').AsString);//С�����
          nvedtpieces.Text :=jcdsResult.FieldByName('pieces').AsString;//����;
          nvedtlocation.Text :=jcdsResult.FieldByName('location').AsString;//��ŵص�;
          nvedtcustodial.Text :=jcdsResult.FieldByName('custodial').AsString;//���ܷ�

          storagefeemoney :=StrToFloat(nvedtcustodial.Text);//���ܷ�
          dtppickupdate.DateTime :=Now();//��������

          if formatdatetime('yyyyMMdd',
           dtppickupenddate.DateTime) < formatdatetime
            ('yyyyMMdd', Now) then
          begin
          //����ȡ��ֹ����С����������
            daymoney :=StrToFloat(getParametervalue('8010', sysInfo.LoginUserInfo.OrgID));//ÿ������ɽ�
            days :=DaysBetween(Now,dtppickupenddate.DateTime);//��������
            penaltymoney:= daymoney*days;// ���ɽ�
          end;



          nvedtpenalty.Text :=FloatToStr(penaltymoney);
          nvedttotalfee.Text :=FloatToStr(penaltymoney+storagefeemoney);//�ϼƽ��

          nvedtpickuper.Text := nvedtcustomer.Text; //������

      //    Params.ParamByName('goods.penalty').Value := '';//���ɽ�
      //    Params.ParamByName('goods.totalfee').Value := '';//�ϼƽ��
      //    Params.ParamByName('goods.status').Value := '0';//״̬��0����桢1�������죬2�����ϣ�
      //    Params.ParamByName('goods.pickuper').Value := '';//������
      //    Params.ParamByName('goods.pickupdate').Value := '';//��������
      //    Params.ParamByName('goods.operatorby').Value := '';//����Ա


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
