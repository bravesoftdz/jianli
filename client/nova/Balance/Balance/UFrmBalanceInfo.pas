unit UFrmBalanceInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids,
  ComCtrls, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, NovaPrint,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, Generics.Collections,AcRptUtils3,
  ImgList, OleServer, AcReport_TLB;

type
  TFrmBalanceInfo = class(TSimpleEditForm)
    BtnPrint: TBitBtn;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    NovaEdtCount: TNovaEdit;
    GroupBox1: TGroupBox;
    NovaHUnit: TNovaHelp;
    NovaEdtTicketnum: TNovaEdit;
    NovaEdttotalamount: TNovaEdit;
    NovaEdtBalanceMoney: TNovaEdit;
    Label5: TLabel;
    NovaEdtbalanceamount: TNovaEdit;
    GroupBox4: TGroupBox;
    Label6: TLabel;
    GroupBox2: TGroupBox;
    NovaEdtReturnBalance: TNovaEdit;
    NovaEdtLastLost: TNovaEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    NovaEdtLateMoney: TNovaEdit;
    NovaEdtLostMoney: TNovaEdit;
    GroupBox6: TGroupBox;
    Label13: TLabel;
    NovaEdtLeave: TNovaEdit;
    NovaEdtFree: TNovaEdit;
    Label12: TLabel;
    Label14: TLabel;
    NovaEdtActBalance: TNovaEdit;
    Label15: TLabel;
    lblStationFee: TLabel;
    Label3: TLabel;
    NovaEdtstationservicefee: TNovaEdit;
    NovaEdtfueladditionfee: TNovaEdit;
    NovaEdtagentfee: TNovaEdit;
    Label22: TLabel;
    NovaEdtothterfee: TNovaEdit;
    jcsdQryInvoicesdeductdetails: TjsonClientDataSet;
    Lbl_REdit_memo: TLabel;
    MeRemark: TMemo;
    NvDbgridEh1: TNvDbgridEh;
    jcsdQryInvoicesdeductdetailsid: TLargeintField;
    jcsdQryInvoicesdeductdetailsname: TWideStringField;
    DataSource1: TDataSource;
    jcsdQryOtherbalace: TjsonClientDataSet;
    Label2: TLabel;
    LabLost: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    NovaEdtReturnNum: TNovaEdit;
    NovaEdtPreUpmoney: TNovaEdit;
    jcsdQryOtherDeduct: TjsonClientDataSet;
    jcsdQryDeducts: TjsonClientDataSet;
    NovaEdtPack: TNovaEdit;
    Label24: TLabel;
    NovaEdtIncome: TNovaEdit;
    Label25: TLabel;
    EdtVehicleNo: TEdit;
    Label28: TLabel;
    LabObject: TLabel;
    jsonQryDivideUnit: TjsonClientDataSet;
    jsonAddFeeIsSame: TjsonClientDataSet;
    EdtDivideVehicle: TNovaEdit;
    Label31: TLabel;
    jsoncalPackBalancePrice: TjsonClientDataSet;
    Label33: TLabel;
    NovaEdtRate: TNovaEdit;
    jsonQryRoute: TjsonClientDataSet;
    NovaEdtVehiclenum: TNovaEdit;
    Label7: TLabel;
    Label32: TLabel;
    NovaEdtRentIncome: TNovaEdit;
    jsoncalRentBalancePrice: TjsonClientDataSet;
    Label34: TLabel;
    NovaEdtdebit: TNovaEdit;
    Label35: TLabel;
    NovaEdtbackMoney: TNovaEdit;
    Label30: TLabel;
    NovaEdtAddFee: TNovaEdit;
    BtnAddFeeAct: TBitBtn;
    Label23: TLabel;
    NovaEdtPackPrice: TNovaEdit;
    Label18: TLabel;
    NovaEdtRentPrice: TNovaEdit;
    GrpDivdeInfo: TGroupBox;
    Label27: TLabel;
    NovaEdtDivdeBalance: TNovaEdit;
    jcsdQryInvoicesdeductdetailsdivdedeductmoney: TFloatField;
    Label36: TLabel;
    NovaEdtDivdeDeduct: TNovaEdit;
    Label4: TLabel;
    NovaEdtDeduct: TNovaEdit;
    Label19: TLabel;
    NovaEditprevious: TNovaEdit;
    Label26: TLabel;
    NovaEditnow: TNovaEdit;
    jcdsroundBalance: TjsonClientDataSet;
    btn1: TBitBtn;
    btn2: TBitBtn;
    AcRptEngineTotalDeatil: TAcRptEngine;
    jcdsQryBalanceStationDetail: TjsonClientDataSet;
    ds1: TDataSource;
    jcsdQryInvoicesdeductdetailsdeductmoney: TFloatField;
    chk1: TCheckBox;
    jcdsbalanceACPrint: TjsonClientDataSet;
    DataSource2: TDataSource;
    Label29: TLabel;
    NovaEdtPackAgent: TNovaEdit;
    Label37: TLabel;
    PackAgentRate: TNovaEdit;
    Label38: TLabel;
    NovaEditPackFee: TNovaEdit;
    procedure FormDeactivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcsdQryInvoicesdeductdetailsdeductmoneyChange(Sender: TField);
    procedure NovaEdtDeductChange(Sender: TObject);
    procedure NovaHUnitIdChange(Sender: TObject);
    procedure NovaEdtBalanceMoneyChange(Sender: TObject);
    procedure NovaEdtFreeChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaEdtActBalanceChange(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure NovaEdtPackChange(Sender: TObject);
    procedure BtnAddFeeActClick(Sender: TObject);
    procedure NovaEdtAddFeeChange(Sender: TObject);
    procedure NovaEdtIncomeChange(Sender: TObject);
    procedure NovaEdtPackPriceChange(Sender: TObject);
    procedure NovaEdtRateChange(Sender: TObject);
    procedure NovaEdtRentPriceChange(Sender: TObject);
    procedure jcsdQryInvoicesdeductdetailsdivdedeductmoneyChange
      (Sender: TField);
    procedure NovaEdtDivdeDeductChange(Sender: TObject);
    procedure NovaEdtagentfeeChange(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure NovaEditnowChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure PackAgentRateChange(Sender: TObject);
  private
    { Private declarations }
    divide: double;
    isbalance: boolean;
    balanceid: int64;
    balanceunit: string;
    parameter4017 : boolean;
    balanceno, parameter,parameter8021,parameter4013: String;
    // const
    // _AccountBill = 'AccountBill';
    deductprinttype : String;
    rpt_path:string;
    procedure qryOtherBalanceinfo(balanceobject: string; objectid: int64);
    procedure balanceACPrint(Sender: TObject);
  public
    { Public declarations }
    // balancemonth:Tdate;
    isonebalanceunit:boolean;
    invoicesids,otherinvoicesids,balancedatefrom,balancedateto: widestring;
    aaa:integer;
    currouteid, curvehicleid, curorgid: int64;
    ismoreroute: boolean;
    balancekind:integer;
    fromdepart, todepart, vehicleids, routename, vehicleno,qryfromdate,qrytodate,vehicleunit: string;
    goodsmoney:Currency;
  end;

var
  FrmBalanceInfo: TFrmBalanceInfo;

implementation

uses PubFn, Services, UDMPublic, UFrmAddFeeCal;
{$R *.dfm}

procedure TFrmBalanceInfo.bbtnCloseClick(Sender: TObject);
begin
  inherited;
  if isbalance then
    ModalResult := mrok
  else
    close;
end;

procedure TFrmBalanceInfo.bbtnSaveClick(Sender: TObject);
var
  balanceobject, sResult: string;
  objectid, nResult: integer;
begin
  inherited;
  if (routename = '') and (length(trim(EdtVehicleNo.Text)) <= 8) then
  begin
    with jsonQryRoute do
    begin
      active := false;
      Params.ParamValues['vehicleno'] := trim(EdtVehicleNo.Text);
      execute;
      routename := Params.ParamByName('routename').Value;
    end;
  end;
  if (NovaHUnit.Text = '') or (NovaHUnit.Id = 0) then
  begin
    SysDialogs.Warning('������������');
    // NovaHUnit.SetFocus;
    exit;
  end
  else
  begin
    balanceobject := '0';
    objectid := NovaHUnit.Id;
    balanceunit := NovaHUnit.Text;
  end;

  if NovaEdtActBalance.Text = '' then
  begin
    SysDialogs.Warning('������ʵ���');
    NovaEdtActBalance.SetFocus;
    exit;
  end;
  if (not isonebalanceunit) and (NovaEdtLeave.Text <> NovaEdtActBalance.Text) then
  begin
    SysDialogs.Warning('����㵥λһ����㲻���������Ƿ�');
    NovaEdtActBalance.SetFocus;
    exit;
  end;
  if (divide > 0) and (NovaEdtLeave.Text <> NovaEdtActBalance.Text) then
  begin
    SysDialogs.Warning('�ֲ���㲻���������Ƿ�');
    NovaEdtActBalance.SetFocus;
    exit;
  end;

  try
    begin
      with jcsdQryInvoicesdeductdetails do
      begin
        Params.ParamValues['invoicesids'] := invoicesids;
        Params.ParamValues['otherinvoicesids'] := otherinvoicesids;
        Params.ParamValues['vehicleids'] := vehicleids;
        Params.ParamValues['balancetype'] := balancekind;
        Params.ParamValues['balance.balanceobject'] := balancekind;
        Params.ParamValues['balance.agentrate'] := NovaEdtRate.Text;
        Params.ParamValues['balance.objectid'] := objectid;
        Params.ParamValues['balance.routename'] := routename;
        Params.ParamValues['balance.ditotalnum'] := NovaEdtTicketnum.Text;
        Params.ParamValues['balance.ditotalmoney'] := NovaEdttotalamount.Text;
        Params.ParamValues['balance.distationservicefee'] :=
          NovaEdtstationservicefee.Text;
        Params.ParamValues['balance.fueladditionfee'] :=
          NovaEdtfueladditionfee.Text;
        Params.ParamValues['balance.diagentfee'] := NovaEdtagentfee.Text;
        Params.ParamValues['balance.diotherpredeductifee'] :=
          NovaEdtothterfee.Text;
        Params.ParamValues['balance.dibalanceablemoney'] :=
          NovaEdtbalanceamount.Text;
        Params.ParamValues['balance.dideductmoney'] := NovaEdtDeduct.Text;
        Params.ParamValues['balance.dibalancemoney'] :=
          NovaEdtBalanceMoney.Text;

        Params.ParamValues['balance.returnmoney'] := NovaEdtReturnBalance.Text;
        // Params.ParamValues['balance.vipscoremoney'] :=
        // NovaEdtIntegralmoney.Text;
        Params.ParamValues['balance.lastlost'] := NovaEdtLastLost.Text;
        Params.ParamValues['balance.lost'] := LabLost.Caption;
        Params.ParamValues['balance.deratemoney'] := NovaEdtFree.Text;
        Params.ParamValues['balance.lateforfeit'] := NovaEdtLateMoney.Text;
        Params.ParamValues['balance.invoicesnum'] := NovaEdtCount.Text;
        Params.ParamValues['balance.preupmoney'] := NovaEdtPreUpmoney.Text;
        Params.ParamValues['balance.lostforfeit'] := NovaEdtLostMoney.Text;
        Params.ParamValues['balance.balancemoney'] := NovaEdtActBalance.Text;
        Params.ParamValues['balance.remarks'] := MeRemark.Text;
        Params.ParamValues['balance.packmoney'] := self.NovaEdtPack.Text;
        Params.ParamValues['balance.vehicleno'] := vehicleno;
        Params.ParamValues['balance.ticketincome'] := NovaEdtIncome.Text;
        Params.ParamValues['balance.departstartdate'] := fromdepart;
        Params.ParamValues['balance.departenddate'] := todepart;
        // formatdatetime('yyyy-mm-dd',balancemonth);
        Params.ParamValues['balance.orgid'] := SysInfo.LoginUserInfo.OrgID;
        Params.ParamValues['balance.additionfee'] := NovaEdtAddFee.Text;
        if EdtDivideVehicle.Id > 0 then
          Params.ParamValues['balance.balancedividevehicleid'] :=
            EdtDivideVehicle.Id;
        Params.ParamValues['balance.divide'] := divide;
        Params.ParamValues['balance.packprice'] := NovaEdtPackPrice.Text;
        Params.ParamValues['balance.rentmoney'] := NovaEdtRentPrice.Text;
        Params.ParamValues['balance.rentprice'] := NovaEdtRentIncome.Text;
        Params.ParamValues['balance.debit'] := NovaEdtdebit.Text;
        Params.ParamValues['balance.backmoney'] := NovaEdtbackMoney.Text;
        Params.ParamValues['balance.bysj'] := NovaEditnow.Text;
        Params.ParamValues['balance.syqj'] := NovaEditprevious.Text;
        Params.ParamValues['balance.goodsagent'] := NovaEdtPackAgent.Text;
        if jcsdQryInvoicesdeductdetails.ChangeCount > 0 then
          ApplyUpdates(-1)
        else
          execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        balanceid := Params.ParamValues['balanceid'];
        if nResult = 1 then
        begin
          balanceno := Params.ParamValues['balanceno'];
          SysDialogs.ShowMessage(sResult);
          BtnPrint.Enabled := true;
          btn1.Enabled:=True;
          btn2.Enabled:=True;
          BtnPrint.SetFocus;
          bbtnSave.Enabled := false;
          pnlEditBox.Enabled := false;
          isbalance := true;
          // ��ʼ��ӡ���˵�
        end
        else
        begin
          SysDialogs.Warning(sResult);
          bbtnSave.Enabled := false;
          NovaEdtActBalance.SetFocus;
        end;
      end;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('���㴦��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmBalanceInfo.btn1Click(Sender: TObject);
var
  billPrint: TNovaPrint;
  ADataset: TDataset;
  isByprice:String;
begin
  inherited;
//  ShowMessage(balancedatefromTo);
  with jcdsQryBalanceStationDetail do
  begin
    Active := false;
    isByprice := '0';
    params.ParamValues['isByprice'] := isByprice;
    Params.ParamValues['balanceid'] := balanceid;
    Active := true;
    if RecordCount>0 then
    begin
     ADataset:=ds1.DataSet;
     AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');

     if chk1.Checked then
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationacreport.apt') //��ӡ���㵥��
     else
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationacreport_old.apt');//����ӡ���㵥��

     AcRptEngineTotalDeatil.AddGlobalVariable('balancefrom',  fromdepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceto',  todepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('vehicleno',  EdtVehicleNo.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunitname', NovaHUnit.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
     AcRptEngineTotalDeatil.AddGlobalVariable('routename', routename);
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamountdaxie', moneyToChinaStr(StrToCurr(jcdsQryBalanceStationDetail.FieldByName('balanceamount').AsString)));

//         AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
     AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ

    end;
  end;

  ModalResult := mrok;

end;
procedure TFrmBalanceInfo.btn2Click(Sender: TObject);
var
  billPrint: TNovaPrint;
  ADataset: TDataset;
  isByprice:String;
begin
  inherited;
  with jcdsQryBalanceStationDetail do
  begin
     Active := false;
     isByprice := '1';
     params.ParamValues['isByprice'] := isByprice;
     Params.ParamValues['balanceid'] := balanceid;
    Active := true;
    if RecordCount>0 then
    begin
     ADataset:=ds1.DataSet;
     AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');

     if chk1.Checked then
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationpriceacreport.apt') //��ӡ���㵥��
     else
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationpriceacreport_old.apt');//����ӡ���㵥��

     AcRptEngineTotalDeatil.AddGlobalVariable('balancefrom',  fromdepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceto',  todepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('vehicleno',  EdtVehicleNo.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunitname', NovaHUnit.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
     AcRptEngineTotalDeatil.AddGlobalVariable('routename', routename);
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamountdaxie', moneyToChinaStr(StrToCurr(jcdsQryBalanceStationDetail.FieldByName('balanceamount').AsString)));

//         AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
     AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ

    end;
  end;

  ModalResult := mrok;

end;

procedure TFrmBalanceInfo.BtnAddFeeActClick(Sender: TObject);
var
  nResult: integer;
begin
  inherited;
  with jsonAddFeeIsSame do
  begin
    active := false;
    Params.ParamValues['vehicleids'] := vehicleids;
    execute;
    nResult := Params.ParamByName('flag').Value;
    if nResult <> 1 then
    begin
      SysDialogs.Warning('���㳵���ĸ��ӷѿ۷Ѳ�һ�²���һ����㣡');
      //NovaEdtActBalance.SetFocus;
      exit;
    end;
  end;

  FrmAddFeeCal := TFrmAddFeeCal.Create(self);
  try
    with FrmAddFeeCal do
    begin
      Caption := '���ø��ӷѿ۷�';
      curinvoicesids := invoicesids;
      curinvoicesidsother := otherinvoicesids;
      curvehicle_id := curvehicleid;
      if SysMainForm.showFormModal(FrmAddFeeCal, false) = mrok then
      begin
        NovaEdtAddFee.Text := CurrToStr
          (NvdbgridfEE.SumList.SumCollection.Items[2].SumValue);
       // NovaEdtActBalance.SetFocus;
        // tbtnFilterClick(Sender);
        // jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmAddFeeCal);
  end;
end;

procedure TFrmBalanceInfo.BtnPrintClick(Sender: TObject);
var
  billPrint: TNovaPrint;
  itemcode:String;
  printValue: TDictionary<String, String>; // ���������
  multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
  multipleValueValue: TDictionary<String, String>;
  deductifee,deductifee1, ticketitemsum,ticketitemagentfeesum, vehicledivde, dibalancemoney, actbalancemoney,
    ticketincome, leavebalancemoney, agentfee, dibalanceablemoney, totalincome,
    invoicesamount, nottickeitemdeduct,noItemAndagentdeduct, packdeduct,totalprice,actdeduct, rentdeduct: double;
begin
  inherited;
  try
    if parameter4017 then
    begin
      balanceACPrint(sender);
    end
    else
    begin
    ticketitemsum := strtoCurr(NovaEdtstationservicefee.Text) + strtoCurr
      (NovaEdtfueladditionfee.Text) + strtoCurr(NovaEdtothterfee.Text);
    // ���ֹ�������۷�
    deductifee := strtoCurr(NovaEdtstationservicefee.Text) + strtoCurr
      (NovaEdtfueladditionfee.Text) + strtoCurr(NovaEdtagentfee.Text)
      + strtoCurr(NovaEdtothterfee.Text) + strtoCurr(NovaEdtAddFee.Text);

    deductifee1 := strtoCurr
      (NovaEdtfueladditionfee.Text) + strtoCurr(NovaEdtagentfee.Text)
      + strtoCurr(NovaEdtothterfee.Text) + strtoCurr(NovaEdtAddFee.Text);


//    invoicesamount := strtofloat(NovaEdtbalanceamount.Text) - strtoCurr
//      (NovaEdtstationservicefee.Text) - strtoCurr(NovaEdtfueladditionfee.Text)
//      - strtoCurr(NovaEdtothterfee.Text);
    invoicesamount := strtofloat(NovaEdttotalamount.Text)-strtoCurr(NovaEdtstationservicefee.text) - strtoCurr(NovaEdtfueladditionfee.Text)
      - strtoCurr(NovaEdtothterfee.Text);
    printValue := TDictionary<String, String>.Create;
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('����֪ͨ��',
        '����֪ͨ��'));

    // Ʊ�۷�����˴���ѿ۷�
    printValue.Add('ticketitemsum', floattostr(ticketitemsum * (1 - divide)));
    printValue.Add('balanceunit', balanceunit);
    printValue.Add('balanceno', balanceno);
    if length(vehicleno) > 15 then
      // 7*5+4
      vehicleno := copy(vehicleno, 0, 15) + '��';

    printValue.Add('vehicleno', vehicleno);
    printValue.Add('balancedate', formatdatetime('yyyy-mm-dd', now));
    printValue.Add('ditotalnum', NovaEdtTicketnum.Text);
    // ��Ʊ����
    printValue.Add('ditotalmoney',
      floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)));
    // վ���
    printValue.Add('stationfee',
      floattostr(strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)));

    //����ֻ�۳�վ��ѵĽ����ܶ�
    printValue.Add('nostationfeetotalmoney',floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)) );


    // �����۷�
    printValue.Add('otherfee',
      floattostr(strtofloat(NovaEdtothterfee.Text) * (1 - divide)));
    // ���˴����
    agentfee := strtofloat(NovaEdtagentfee.Text) * (1 - divide);
    printValue.Add('agentfee', floattostr(agentfee));
    ticketitemagentfeesum:=ticketitemsum+ agentfee;
    printValue.Add('ticketitemagentfeesum', floattostr(ticketitemagentfeesum));

    // 'Ʊ��-Ʊ�۷���',0,'invoicesamount'
    printValue.Add('invoicesamount', floattostr(invoicesamount * (1 - divide)));

    // Ӫ��С��',0,'totalincome =Ʊ��-Ʊ�۷���-agentfee+�а����+�س̽����� +�������
    totalincome := invoicesamount * (1 - divide)-agentfee + strtofloat
      (NovaEdtReturnBalance.Text) + strtofloat(NovaEdtPackPrice.Text)
      + strtofloat(NovaEdtPreUpmoney.Text)
      + strtofloat(NovaEdtRentPrice.Text);

    printValue.Add('totalincome', floattostr(totalincome));

    // վ�񸽼ӷ�
    printValue.Add('additionfee',
      floattostr(strtoCurr(NovaEdtAddFee.Text) * (1 - divide)));
    // �ֹ��۷�
    printValue.Add('dideductmoney', NovaEdtDeduct.Text);
    // �ܿ۷�=���ֹ�����۷Ѳ�����ֳ�
    printValue.Add('deductifee',
      floattostr(deductifee * (1 - divide) + strtoCurr(NovaEdtDeduct.Text)));
    //��ӳ�����λ
    printValue.Add('vehicleunit', vehicleunit);
    //���˴����
    printValue.Add('hydlffee', self.NovaEdtPackAgent.Text);
    //�����Ͻ�
    printValue.Add('bysj', self.NovaEditnow.Text);
    //����Ƿ��
    printValue.Add('syqj', self.NovaEditprevious.Text);
    //�ܿ۷�1 =  ԭ�ܿ۷ѻ���ȥ��վ���
    printValue.Add('deductifee1',
      floattostr(deductifee1 * (1 - divide) + strtoCurr(NovaEdtDeduct.Text)));

    printValue.Add('packmoney', self.NovaEdtPack.Text);
    printValue.Add('packprice', NovaEdtPackPrice.Text);
    packdeduct := strtoCurr(NovaEdtPackPrice.Text) - strtoCurr
      (NovaEdtPack.Text);
    // �а������',0,'packdeduct
    printValue.Add('packdeduct', floattostr(packdeduct));
    // ����Ӫ��
    printValue.Add('rentmoney', NovaEdtRentPrice.Text);
    // ����Ӧ��
    printValue.Add('rentprice', NovaEdtRentIncome.Text);
    rentdeduct := strtoCurr(NovaEdtRentPrice.Text) - strtoCurr
      (NovaEdtRentIncome.Text);
    // ���������',0,'packdeduct
    printValue.Add('rentdeduct', floattostr(rentdeduct));

    nottickeitemdeduct := strtoCurr(NovaEdtagentfee.Text) + strtoCurr
      (NovaEdtAddFee.Text) ;

    // ��Ʊ�۷�����۷�
    printValue.Add('nottickeitemdeduct',
      floattostr(nottickeitemdeduct * (1 - divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));

        // ��Ʊ�۷�������˴������Ŀ۷�     noItemAndagentdeduct
    printValue.Add('noItemAndagentdeduct',
      currtostr(strtoCurr(NovaEdtAddFee.Text) * (1 - divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));
    // �ܿɽ�����=�����Ľ�����(1-�ֳ�)=�ܽ�����*(1-�ֳ�)
    // =Ʊ����-վ���-ȼ�ͷ�-�����۷�-���˴����* (1-�ֳ�)
    dibalanceablemoney := (strtoCurr(NovaEdtBalanceMoney.Text)+strtoCurr(NovaEdtAddFee.Text)) * (1 - divide);
    printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

    // dibalancemoney Ӧ���� = �ܿɽ�����-�ֹ��۷�
    dibalancemoney := dibalanceablemoney - strtoCurr(NovaEdtDeduct.Text);
    printValue.Add('dibalancemoney', floattostr(dibalanceablemoney));

    // ����Ӫ��= Ӧ���� +\- ����������Ϣ -վ�񸽼ӷ�*��1-���˴���ѱ�����*��1-�ֳɱ�����
    ticketincome := dibalancemoney + strtoCurr(NovaEdtReturnBalance.Text)
      - strtoCurr(NovaEdtLateMoney.Text) - strtoCurr(NovaEdtLostMoney.Text)
      + strtoCurr(NovaEdtPreUpmoney.Text) - strtoCurr(NovaEdtLastLost.Text)
      - strtoCurr(NovaEdtdebit.Text) + strtoCurr(NovaEdtFree.Text) - strtoCurr
      (NovaEdtAddFee.Text) * (1 - divide) + strtoCurr(NovaEdtbackMoney.Text);
    printValue.Add('ticketincome', floattostr(ticketincome));

    totalprice:=strtofloat(NovaEdttotalamount.Text)+strtofloat(NovaEdtPackPrice.Text)
                +strtofloat(NovaEdtRentPrice.Text);
      actdeduct:=deductifee * (1 - divide) + strtoCurr(NovaEdtDeduct.Text)
              +strtofloat(NovaEdtPackPrice.Text)+strtofloat(NovaEdtRentPrice.Text)
              -strtofloat(NovaEdtPack.Text)-strtofloat(NovaEdtRentIncome.Text);

    printValue.Add('totalprice', floattostr(totalprice * (1 - divide))); //������
    printValue.Add('actdeduct', floattostr(actdeduct * (1 - divide))); //ʵ�۽��
    // ʣ��Ӧ���� =����Ӫ��+�а�Ӧ�� +����Ӧ��
//    leavebalancemoney := ticketincome + strtoCurr(NovaEdtPack.Text) + strtoCurr
//      (NovaEdtRentIncome.Text);
    printValue.Add('leavebalancemoney', NovaEdtLeave.Text);

    // ʵ���� = ʣ��Ӧ����
    printValue.Add('balancemoney', NovaEdtActBalance.Text);

    //������
    printValue.Add('deratemoney', NovaEdtFree.Text);

    printValue.Add('routename', routename);
    printValue.Add('invoincenum', self.NovaEdtCount.Text);
    printValue.Add('returnmoney', NovaEdtReturnBalance.Text);
    // printValue.Add('vipscoremoney', NovaEdtIntegralmoney.Text);
    printValue.Add('preupmoney', NovaEdtPreUpmoney.Text);
    printValue.Add('lateforfeit', NovaEdtLateMoney.Text);
    printValue.Add('lostforfeit', NovaEdtLostMoney.Text);
    printValue.Add('lastlost', NovaEdtLastLost.Text);
    printValue.Add('lost', LabLost.Caption);
    printValue.Add('remarks', MeRemark.Text);
    printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);
    printValue.Add('departstartdate', fromdepart);
    printValue.Add('departenddate', todepart);
    printValue.Add('debit', NovaEdtdebit.Text);
    printValue.Add('backmoney', NovaEdtbackMoney.Text);
    // ��ѯ�۷���ϸ,ԭ�������ݼ��Ĵ���
    if deductprinttype='0' then
    begin
      with jcsdQryDeducts do
      begin
        active := false;
        Params.ParamValues['balanceid'] := balanceid;
        active := true;
        if RecordCount > 0 then
        begin
          first;
          multiplelist := TList < TDictionary < String, String >> .Create;
          while (not eof) do
          begin
            multipleValueValue := TDictionary<String, String>.Create;
            multipleValueValue.Add('deductname', FieldByName('name').AsString);
            multipleValueValue.Add('deductfee',
              FieldByName('deductmoney').AsString);
            multiplelist.Add(multipleValueValue);
            next;
          end;
          billPrint.MultipleValue := multiplelist;
        end;
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;
    end// ��Ϊ �����ݼ����
    ELSE
    begin
      with jcsdQryDeducts do
      begin
        active := false;
        Params.ParamValues['balanceid'] := balanceid;
        active := true;
        if RecordCount > 0 then
        begin
          first;
          while (not eof) do
          begin
            itemcode:=FieldByName('code').AsString;
            printValue.Add(itemcode, FieldByName('deductmoney').AsString);
            next;
          end;
        end;
      end;
      billPrint.SingleValue := printValue;
      billPrint.Print;
    end;
    if divide > 0 then
    begin
      printValue.Clear;
      printValue.Add('ticketitemsum', floattostr(ticketitemsum * divide));
      printValue.Add('balanceunit', EdtDivideVehicle.Text);
      printValue.Add('balanceno', balanceno);
      printValue.Add('vehicleno', vehicleno);
      printValue.Add('balancedate', formatdatetime('yyyy-mm-dd', now));
      printValue.Add('ditotalnum', NovaEdtTicketnum.Text);
      // ��Ʊ����
      printValue.Add('ditotalmoney',
        floattostr(strtofloat(NovaEdttotalamount.Text) * divide));
      // վ���
      printValue.Add('stationfee',
        floattostr(strtofloat(NovaEdtstationservicefee.Text) * divide));
      // �����۷�
      printValue.Add('otherfee',
        floattostr(strtofloat(NovaEdtothterfee.Text) * divide));
      // ���˴����
      printValue.Add('agentfee',
        floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

      printValue.Add('ticketitemagentfeesum', floattostr(ticketitemsum * divide)
      +floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

      // Ӫ��С��',0,'totalincome =Ʊ��-Ʊ�۷���+�а����+�س̽�����
      totalincome := invoicesamount * divide;
      printValue.Add('totalincome', floattostr(totalincome));

      // 'Ʊ��-Ʊ�۷���',0,'invoicesamount'
      printValue.Add('invoicesamount', floattostr(invoicesamount * divide));

      // վ�񸽼ӷ�
      printValue.Add('additionfee',
        floattostr(strtoCurr(NovaEdtAddFee.Text) * divide));
      // �ֹ��۷�
      printValue.Add('dideductmoney', NovaEdtDivdeDeduct.Text);

      // �ܿ۷�:���ֹ�����۷Ѳ�����ֳ�
      printValue.Add('deductifee', floattostr(deductifee * divide));
      nottickeitemdeduct:=strtofloat(NovaEdtagentfee.Text) * divide
      + strtoCurr(NovaEdtAddFee.Text) * divide+strtofloat(NovaEdtDivdeDeduct.Text);
      // ��Ʊ�۷�����۷�
      printValue.Add('nottickeitemdeduct',floattostr(nottickeitemdeduct));
        // ��Ʊ�۷�������˴������Ŀ۷�     noItemAndagentdeduct
      printValue.Add('noItemAndagentdeduct',
      currtostr(strtoCurr(NovaEdtAddFee.Text) * (divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));
      // �ܿɽ�����=�����Ľ�����*�ֳ�=�ܽ�����*�ֳ�
      // =(Ʊ����-վ���-ȼ�ͷ�-�����۷�-���˴����)* �ֳ�
      dibalanceablemoney := strtofloat(NovaEdtbalanceamount.Text) * divide;
      printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

      // dibalancemoney Ӧ���� = �ܿɽ�����-�ֹ��۷�
      dibalancemoney := dibalanceablemoney - nottickeitemdeduct;
      printValue.Add('dibalancemoney', floattostr(dibalancemoney));

      // ����Ӫ��= Ӧ���� +\- ����������Ϣ
      ticketincome := dibalancemoney ;
      printValue.Add('ticketincome', floattostr(ticketincome));

      // ʣ��Ӧ���� =����Ӫ��+�а�Ӧ��
      //leavebalancemoney := ticketincome + 0;
      printValue.Add('leavebalancemoney', NovaEdtDivdeBalance.Text);

      // ʵ���� = ʣ��Ӧ����
      printValue.Add('balancemoney', NovaEdtDivdeBalance.Text);

      printValue.Add('routename', routename);
      printValue.Add('invoincenum', self.NovaEdtCount.Text);
      printValue.Add('returnmoney', '0');
      printValue.Add('vipscoremoney', '0');
      printValue.Add('preupmoney', '0');
      printValue.Add('lateforfeit', '0');
      printValue.Add('lostforfeit', '0');
      printValue.Add('lastlost', '0');
      printValue.Add('lost', '0');
      printValue.Add('remarks', MeRemark.Text);
      printValue.Add('packmoney', '0');
      printValue.Add('packprice', '0');
      // �а������',0,'packdeduct
      printValue.Add('packdeduct', '0');
      // ���������',0,'packdeduct
      printValue.Add('rentdeduct','0');
      printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('departstartdate', fromdepart);
      printValue.Add('departenddate', todepart);
      printValue.Add('debit', '0');
      // ��ѯ�۷���ϸ
      with jcsdQryDeducts do
      begin
        active := false;
        Params.ParamValues['balanceid'] := balanceid;
        active := true;
        if RecordCount > 0 then
        begin
          first;
          multiplelist.Clear;
          while (not eof) do
          begin
            multipleValueValue := TDictionary<String, String>.Create;
            multipleValueValue.Add('deductname', FieldByName('name').AsString);
            multipleValueValue.Add('deductfee',FieldByName('divdedeductmoney').AsString);
            multiplelist.Add(multipleValueValue);
            // if FieldByName('isticketpriceitem').AsBoolean then
            // ticketitemsum := ticketitemsum + FieldByName('deductmoney').AsFloat;
            next;
          end;
          billPrint.MultipleValue := multiplelist;
        end;
      end;
      //billPrint.MultipleValue.Clear;
      billPrint.SingleValue := printValue;
      billPrint.Print;
    end;

    ModalResult := mrok;
    end;

  except
    on E: exception do
    begin
      SysLog.WriteErr('��ӡ�����ʵ�ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmBalanceInfo.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //�޸�  ������Ҫ�ֹ�����Ľ���۷ѣ���ֵ�� ���㵥λ����������Ϣ-->�ֹ��۷�
  //  NvDbgridEh1.Refresh;
  NovaEdtDeduct.Text := CurrToStr
          (NvDbgridEh1.SumList.SumCollection.Items[1].SumValue);
end;

procedure TFrmBalanceInfo.FormCreate(Sender: TObject);
begin
  inherited;
  rpt_path := ExtractFilePath(ParamStr(0));
end;

procedure TFrmBalanceInfo.FormDeactivate(Sender: TObject);
begin
  // inherited;

end;

procedure TFrmBalanceInfo.balanceACPrint(Sender: TObject);
var
  billPrint: TNovaPrint;
  ADataset: TDataset;
  isByprice:String;
begin
  inherited;
  with jcdsbalanceACPrint do
  begin
     Active := false;
     Params.ParamValues['balanceid'] := balanceid;
     Active := true;
//    if RecordCount>0 then
//    begin
     ADataset:=DataSource2.DataSet;
     AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');
     AcRptEngineTotalDeatil.SetReportFile(rpt_path+'BalanceACPrint.apt');
     AcRptEngineTotalDeatil.AddGlobalVariable('stationname',  SysInfo.LoginUserInfo.ticketoutletsname);  // ��վ���
     AcRptEngineTotalDeatil.AddGlobalVariable('stationfullname', SysInfo.LoginUserInfo.OrgName + '�������������ܵ�');  //��վȫ��
     AcRptEngineTotalDeatil.AddGlobalVariable('qryfromdate', qryfromdate); //��ѯ��ʼʱ��
     AcRptEngineTotalDeatil.AddGlobalVariable('qrytodate', qrytodate);     //��ѯ����ʱ��
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', NovaHUnit.Text); // ���㵥λ
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);  //����
     //������
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamount', floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)));
     //���㵥����
     AcRptEngineTotalDeatil.AddGlobalVariable('depcount', NovaEdtCount.Text);
     //���˴����
     AcRptEngineTotalDeatil.AddGlobalVariable('agentfee', floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
//         AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
     AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ

//    end;
  end;

  ModalResult := mrok;

end;

procedure TFrmBalanceInfo.FormShow(Sender: TObject);

begin
  inherited;
  parameter := getParametervalue('4005', SysInfo.LoginUserInfo.OrgID);
  parameter8021:= getParametervalue('8021', SysInfo.LoginUserInfo.OrgID);
  parameter4013:= getParametervalue('4013', SysInfo.LoginUserInfo.OrgID);
  //0������ʱ�۷���Ŀ��Ϊ���ݼ���1���۷���Ŀ��Ϊ��ӡ��Ŀ
  deductprinttype:=getParametervalue('4012', Sysinfo.LoginUserInfo.OrgID) ;
  parameter4017:= getParametervalue('4017', SysInfo.LoginUserInfo.OrgID) = '1';
  with jcsdQryOtherDeduct do
  begin
    active := false;
    Params.ParamValues['invoicesids'] := invoicesids;
    Params.ParamValues['vehicleids'] := vehicleids;
    Params.ParamValues['fromdepart'] := fromdepart;
    Params.ParamValues['todepart'] := todepart;
    execute;
    NovaEdtAddFee.Text := Params.ParamValues['additionfee'];
    if ( NovaEdtRate.Enabled) and  (NovaEdtagentfee.Text='0')
    then
    begin
       NovaEdtRate.Text := Params.ParamValues['agentrate'];
    end ;
    if parameter4013='1' then
    begin
       NovaEdtagentfee.Text := Params.ParamValues['agentfee'];
       NovaEdtagentfeeChange(sender);
    end
    else if (NovaEdtagentfee.Text='0') then
    begin
      NovaEdtagentfeeChange(sender);
    end;
  end;
  if parameter8021='0' then
     jcsdQryInvoicesdeductdetails.ReadOnly:=true;
  MeRemark.SetFocus;
end;

procedure TFrmBalanceInfo.jcsdQryInvoicesdeductdetailsdeductmoneyChange
  (Sender: TField);
begin
  inherited;
  jcsdQryInvoicesdeductdetails.Post;
  NovaEdtIncome.Text := CurrToStr
    (roundEx(strtoCurr(NovaEdtBalanceMoney.Text)*(1-divide)
//    - strtoCurr(NovaEdtDeduct.Text)-NvDbgridEh1.SumList.SumCollection.Items[1].SumValue+ strtoCurr
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr                     //�۷Ѻ�Ӫ�գ�ֻ����һ���ֹ��۷Ѽ���
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //ʮ������ ��ȥ���˴����
//  NovaEdtDeduct.Text := CurrToStr(NvDbgridEh1.SumList.SumCollection.Items[1].SumValue);
end;

procedure TFrmBalanceInfo.jcsdQryInvoicesdeductdetailsdivdedeductmoneyChange
  (Sender: TField);
begin
  inherited;
  jcsdQryInvoicesdeductdetails.Post;
  NovaEdtDivdeDeduct.Text := CurrToStr
    (NvDbgridEh1.SumList.SumCollection.Items[2].SumValue);
end;

procedure TFrmBalanceInfo.NovaEditnowChange(Sender: TObject);
begin
  inherited;
  NovaEdtIncome.Text := CurrToStr
    (roundEx(strtoCurr(NovaEdtBalanceMoney.Text)*(1-divide)
//    - strtoCurr(NovaEdtDeduct.Text)-NvDbgridEh1.SumList.SumCollection.Items[1].SumValue+ strtoCurr
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr                     //�۷Ѻ�Ӫ�գ�ֻ����һ���ֹ��۷Ѽ���
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //ʮ������ ��ȥ���˴����
end;

procedure TFrmBalanceInfo.NovaEdtActBalanceChange(Sender: TObject);
begin
  inherited;
  if (NovaEdtActBalance.Text <> '') and (NovaEdtActBalance.Text <> '-') then
  begin
    LabLost.Caption := CurrToStr((strtoCurr(NovaEdtActBalance.Text) - strtoCurr
          (NovaEdtLeave.Text)));
  end
  else
    LabLost.Caption := NovaEdtLeave.Text;

end;

procedure TFrmBalanceInfo.NovaEdtAddFeeChange(Sender: TObject);
begin
  inherited;
  NovaEdtRateChange(Sender);
  NovaEdtagentfeeChange(Sender);

  //NovaEdtFreeChange(Sender);
end;

procedure TFrmBalanceInfo.NovaEdtagentfeeChange(Sender: TObject);
begin
  inherited;
  NovaEdtBalanceMoney.Text := CurrToStr
      (roundEx(strtoCurr(NovaEdttotalamount.Text) - strtoCurr
          (NovaEdtstationservicefee.Text) - strtoCurr
          (NovaEdtfueladditionfee.Text) - strtoCurr(NovaEdtothterfee.Text)
          - strtoCurr(NovaEdtagentfee.Text) - strtoCurr(NovaEdtAddFee.Text), 2));
end;

procedure TFrmBalanceInfo.NovaEdtBalanceMoneyChange(Sender: TObject);
var
  EdtDeduct:double;
begin
  inherited;
  if NovaEdtDeduct.Text='' then
     EdtDeduct:=0
  else
    EdtDeduct:= strtoCurr(NovaEdtDeduct.Text);
  NovaEdtIncome.Text := CurrToStr
    (roundEx(strtoCurr(NovaEdtBalanceMoney.Text)*(1-divide)
    -EdtDeduct + strtoCurr
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //ʮ������ ��ȥ���˴����
  NovaEdtDivdeDeductChange(nil);
end;

procedure TFrmBalanceInfo.NovaEdtDeductChange(Sender: TObject);
begin
  inherited;
  NovaEdtIncome.Text := CurrToStr
    (roundEx(strtoCurr(NovaEdtBalanceMoney.Text)*(1-divide)
//    - strtoCurr(NovaEdtDeduct.Text)-NvDbgridEh1.SumList.SumCollection.Items[1].SumValue+ strtoCurr
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //ʮ������ ��ȥ���˴����
end;

procedure TFrmBalanceInfo.NovaEdtDivdeDeductChange(Sender: TObject);
begin
  inherited;
  if (NovaEdtDivdeDeduct.Text = '') then
    NovaEdtDivdeDeduct.Text := '0';
  NovaEdtDivdeBalance.Text := CurrToStr((strtoCurr(NovaEdtbalanceamount.Text)
   - strtoCurr(NovaEdtstationservicefee.Text)-strtoCurr(NovaEdtfueladditionfee.Text)
   -strtoCurr(NovaEdtothterfee.Text)
  - strtoCurr(NovaEdtagentfee.Text)-strtoCurr(NovaEdtAddFee.Text))
      * divide - strtoCurr(NovaEdtDivdeDeduct.Text));
end;

procedure TFrmBalanceInfo.NovaEdtFreeChange(Sender: TObject);
begin
  inherited;
  if (NovaEdtFree.Text <> '') and (NovaEdtFree.Text <> '-') then
  begin
    if NovaEdtDeduct.Text='' then
       NovaEdtDeduct.Text:='0';
    NovaEdtIncome.Text := CurrToStr
      (roundEx(strtoCurr(NovaEdtBalanceMoney.Text)*(1-divide)
//        - strtoCurr(NovaEdtDeduct.Text)-NvDbgridEh1.SumList.SumCollection.Items[1].SumValue+ strtoCurr
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr
          (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
          - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
          + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
          - strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtbackMoney.Text), 2)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //ʮ������ ��ȥ���˴����
    NovaEdtPackChange(Sender);
    NovaEdtActBalanceChange(Sender);
  end;
end;

procedure TFrmBalanceInfo.NovaEdtIncomeChange(Sender: TObject);
begin
  inherited;
  NovaEdtPackChange(Sender);
end;

procedure TFrmBalanceInfo.NovaEdtPackChange(Sender: TObject);
begin
  inherited;
  // +strtoCurr(NovaEdtPack.Text)
  if (NovaEdtPack.Text <> '') and (NovaEdtPack.Text <> '-') then
  begin
    if (strtoCurr(NovaEdtPack.Text) > strtoCurr(NovaEdtPackPrice.Text)) then
    begin
      NovaEdtPack.Text := NovaEdtPackPrice.Text;
    end;
    if (strtoCurr(NovaEdtRentIncome.Text) > strtoCurr(NovaEdtRentPrice.Text))
      then
    begin
      NovaEdtRentIncome.Text := NovaEdtRentPrice.Text;
    end;
{    NovaEdtLeave.Text := CurrToStr
      (roundEx(strtoCurr(NovaEdtIncome.Text) + strtoCurr(NovaEdtPack.Text),
        2) + strtoCurr(NovaEdtRentIncome.Text)); }

    with jcdsroundBalance do
    begin
          params.ParamValues['leaveBalance']:= CurrToStr
      (roundEx(strtoCurr(NovaEdtIncome.Text) + strtoCurr(NovaEdtPack.Text),
        2) + strtoCurr(NovaEdtRentIncome.Text));
      Execute;
      NovaEdtLeave.Text := Params.ParamValues['leaveBalanceresult'];
    end;

    NovaEdtActBalance.Text :=NovaEdtLeave.Text;
    NovaEdtActBalanceChange(Sender);
  end;
end;

procedure TFrmBalanceInfo.NovaEdtPackPriceChange(Sender: TObject);
begin
  inherited;
  if ((NovaEdtPackPrice.Text <> '')) then
    with jsoncalPackBalancePrice do
    begin
      active := false;
      Params.ParamValues['packprice'] := NovaEdtPackPrice.Text;
      Params.ParamValues['balanceunitid'] := NovaHUnit.Id;
      Params.ParamValues['routeid'] :=  currouteid ;
      Params.ParamValues['vehicleid'] :=curvehicleid;
      execute;
      NovaEdtPack.Text := Params.ParamByName('packbalanceprice').AsString;
      // NovaEdtRentIncome.Text := Params.ParamByName('rentbalanceprice').AsString;
    end;
end;

procedure TFrmBalanceInfo.NovaEdtRateChange(Sender: TObject);
begin
  inherited;
  if (NovaEdtRate.Text <> '') and (NovaEdtRate.Text <> '-')
  and (NovaEdtRate.Enabled) then
  begin
   NovaEdtagentfee.Text := CurrToStr
      (roundEx((strtoCurr(NovaEdttotalamount.Text) - strtoCurr
            (NovaEdtstationservicefee.Text) - strtoCurr
            (NovaEdtfueladditionfee.Text) - strtoCurr(NovaEdtothterfee.Text)
            - strtoCurr(NovaEdtAddFee.Text) -goodsmoney) * strtoCurr(NovaEdtRate.Text),
        2));      //��ȥ��Ʊ���
  end;
end;

procedure TFrmBalanceInfo.NovaEdtRentPriceChange(Sender: TObject);
begin
  inherited;
  if ((NovaEdtRentPrice.Text <> '')) then
    with jsoncalRentBalancePrice do
    begin
      active := false;
      Params.ParamValues['rentprice'] := NovaEdtRentPrice.Text;
      Params.ParamValues['balanceunitid'] := NovaHUnit.Id;
      Params.ParamValues['routeid'] :=  currouteid ;
      Params.ParamValues['vehicleid'] :=curvehicleid;
      execute;
      NovaEdtRentIncome.Text := Params.ParamByName('rentbalanceprice').AsString;
    end;
end;

procedure TFrmBalanceInfo.NovaHUnitIdChange(Sender: TObject);
var
  invoicesamount: double;
begin
  inherited;
  begin
    with jcsdQryInvoicesdeductdetails do
    begin
      active := false;
      Params.ParamValues['invoicesids'] := invoicesids;
      Params.ParamValues['vehicleids'] := vehicleids;
      Params.ParamValues['orgid'] := curorgid;
      Params.ParamValues['balancetype'] := balancekind;
      Params.ParamValues['balanceunitid'] := NovaHUnit.Id;
      active := true;
      if RecordCount = 0 then
      begin
        NovaEdtDeduct.Text := '0';
        NovaEdtDivdeDeduct.Text := '0';
      end
      else
      begin
        NovaEdtDeduct.Text := CurrToStr
          (NvDbgridEh1.SumList.SumCollection.Items[1].SumValue);
        NovaEdtDivdeDeduct.Text := CurrToStr
          (NvDbgridEh1.SumList.SumCollection.Items[2].SumValue);
      end;
    end;
    if not ismoreroute then
    begin
      // ��ѯ����ֲ㵥λ
      with jsonQryDivideUnit do
      begin
        active := false;
        Params.ParamValues['filter_INS_t!orgid'] :=
          SysInfo.LoginUserInfo.OrgIDs;
        Params.ParamValues['filter_EQL_r!id'] := currouteid;
        Params.ParamValues['filter_EQL_t!vehicleid'] := curvehicleid;
        active := true;
        if RecordCount > 0 then
        begin
          EdtDivideVehicle.Id := FieldByName('dividevehicleid').AsLargeInt;
          divide := FieldByName('divide').AsFloat;
          EdtDivideVehicle.Text := FieldByName('dividevehicleno').AsString;
          NovaEdtActBalance.ReadOnly := true;
          invoicesamount := strtoCurr(NovaEdttotalamount.Text) - strtoCurr
            (NovaEdtstationservicefee.Text) - strtoCurr
            (NovaEdtfueladditionfee.Text) - strtoCurr(NovaEdtothterfee.Text);
          MeRemark.Text := '�ֳ�ǰ�������룤' + floattostr(invoicesamount) + 'Ԫ';
          GrpDivdeInfo.Visible := true;
          NovaEdtActBalance.Enabled:=false;
        end
        else
        begin
          EdtDivideVehicle.Id := 0;
          divide := 0;
          EdtDivideVehicle.Clear;
          EdtDivideVehicle.Visible := false;
          Label28.Visible := false;
          NvDbgridEh1.Columns[2].Visible := false;
          GrpDivdeInfo.Visible := false;
        end;
      end;
    end;
    // ��ѯ����������Ϣ
    qryOtherBalanceinfo('0', NovaHUnit.Id);
    NovaEdtFreeChange(nil);
  end;
end;

procedure TFrmBalanceInfo.PackAgentRateChange(Sender: TObject);
begin
  inherited;
  NovaEdtPackAgent.Text :=CurrToStr(goodsmoney*(StrToCurr(PackAgentRate.Text)));
end;

procedure TFrmBalanceInfo.qryOtherBalanceinfo(balanceobject: string;
  objectid: int64);
var
  nResult: integer;
  sResult,packfee: String;
begin
  try
    with jcsdQryOtherbalace do
    begin
      active := false;
      Params.ParamValues['fromdepart'] := fromdepart;
      Params.ParamValues['todepart'] := todepart;
      Params.ParamValues['vehicleids'] := vehicleids;
      Params.ParamValues['balanceobject'] := balanceobject;
      Params.ParamValues['objectid'] := objectid;
      Params.ParamValues['invoicesids'] := invoicesids;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin

//        NovaEdtReturnBalance.Text := Params.ParamValues['obi.balancemoney'];
        NovaEdtReturnBalance.Text := '0';

        NovaEdtLateMoney.Text := Params.ParamValues['obi.lateforfeit'];

//        NovaEdtReturnNum.Text := Params.ParamValues['obi.returnpeople'];
        NovaEdtReturnNum.Text := '0';

        NovaEdtLostMoney.Text := Params.ParamValues['obi.lostforfeit'];
        // NovaEdtIntegralmoney.Text := Params.ParamValues['obi.integralmoney'];
        NovaEdtLastLost.Text := Params.ParamValues['obi.lastlost'];
        // NovaEditLessnum.Text := Params.ParamValues['obi.lessnum'];
        NovaEdtdebit.Text := Params.ParamValues['obi.debit'];
        NovaEdtPreUpmoney.Text := Params.ParamValues['obi.preupmoney'];
        NovaEdtbackMoney.Text := Params.ParamValues['obi.backmoney'];
        NovaEdtPackPrice.Text :=    Params.ParamValues['obi.packfee'];
//        packfee := Params.ParamValues['obi.packfee'];
//        NovaEdtPackPrice.Text := CurrToStr(StrToCurr(packfee)+goodsmoney);//�а����+��Ʊ���
        //NovaEdtFreeChange(nil);
      end;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('��ȡ������������ʧ�ܣ�' + E.Message);
    end;
  end;
end;

end.
