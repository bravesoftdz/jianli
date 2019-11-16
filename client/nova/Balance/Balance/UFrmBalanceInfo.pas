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
    SysDialogs.Warning('请输入结算对象！');
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
    SysDialogs.Warning('请输入实结金额！');
    NovaEdtActBalance.SetFocus;
    exit;
  end;
  if (not isonebalanceunit) and (NovaEdtLeave.Text <> NovaEdtActBalance.Text) then
  begin
    SysDialogs.Warning('多结算单位一起结算不允许产生溢欠款！');
    NovaEdtActBalance.SetFocus;
    exit;
  end;
  if (divide > 0) and (NovaEdtLeave.Text <> NovaEdtActBalance.Text) then
  begin
    SysDialogs.Warning('分层结算不允许产生溢欠款！');
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
          // 开始打印结账单
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
      SysLog.WriteErr('结算处理失败：' + E.Message);
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
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationacreport.apt') //打印结算单号
     else
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationacreport_old.apt');//不打印结算单号

     AcRptEngineTotalDeatil.AddGlobalVariable('balancefrom',  fromdepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceto',  todepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('vehicleno',  EdtVehicleNo.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunitname', NovaHUnit.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
     AcRptEngineTotalDeatil.AddGlobalVariable('routename', routename);
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamountdaxie', moneyToChinaStr(StrToCurr(jcdsQryBalanceStationDetail.FieldByName('balanceamount').AsString)));

//         AcRptEngineTotalDeatil.ShowDesigner;  //开发模式
     AcRptEngineTotalDeatil.Preview;     //预览模式

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
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationpriceacreport.apt') //打印结算单号
     else
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'stationpriceacreport_old.apt');//不打印结算单号

     AcRptEngineTotalDeatil.AddGlobalVariable('balancefrom',  fromdepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceto',  todepart);
     AcRptEngineTotalDeatil.AddGlobalVariable('vehicleno',  EdtVehicleNo.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunitname', NovaHUnit.Text);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
     AcRptEngineTotalDeatil.AddGlobalVariable('routename', routename);
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamountdaxie', moneyToChinaStr(StrToCurr(jcdsQryBalanceStationDetail.FieldByName('balanceamount').AsString)));

//         AcRptEngineTotalDeatil.ShowDesigner;  //开发模式
     AcRptEngineTotalDeatil.Preview;     //预览模式

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
      SysDialogs.Warning('结算车辆的附加费扣费不一致不能一起结算！');
      //NovaEdtActBalance.SetFocus;
      exit;
    end;
  end;

  FrmAddFeeCal := TFrmAddFeeCal.Create(self);
  try
    with FrmAddFeeCal do
    begin
      Caption := '设置附加费扣费';
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
  printValue: TDictionary<String, String>; // 输出单变量
  multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
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
    // 除手工输入外扣费
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
    billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('结算通知单',
        '结算通知单'));

    // 票价分项、客运代理费扣费
    printValue.Add('ticketitemsum', floattostr(ticketitemsum * (1 - divide)));
    printValue.Add('balanceunit', balanceunit);
    printValue.Add('balanceno', balanceno);
    if length(vehicleno) > 15 then
      // 7*5+4
      vehicleno := copy(vehicleno, 0, 15) + '等';

    printValue.Add('vehicleno', vehicleno);
    printValue.Add('balancedate', formatdatetime('yyyy-mm-dd', now));
    printValue.Add('ditotalnum', NovaEdtTicketnum.Text);
    // 总票款金额
    printValue.Add('ditotalmoney',
      floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)));
    // 站务费
    printValue.Add('stationfee',
      floattostr(strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)));

    //新增只扣除站务费的结算总额
    printValue.Add('nostationfeetotalmoney',floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)) );


    // 其他扣费
    printValue.Add('otherfee',
      floattostr(strtofloat(NovaEdtothterfee.Text) * (1 - divide)));
    // 客运代理费
    agentfee := strtofloat(NovaEdtagentfee.Text) * (1 - divide);
    printValue.Add('agentfee', floattostr(agentfee));
    ticketitemagentfeesum:=ticketitemsum+ agentfee;
    printValue.Add('ticketitemagentfeesum', floattostr(ticketitemagentfeesum));

    // '票款-票价分项',0,'invoicesamount'
    printValue.Add('invoicesamount', floattostr(invoicesamount * (1 - divide)));

    // 营收小计',0,'totalincome =票款-票价分项-agentfee+行包金额+回程结算金额 +包车金额
    totalincome := invoicesamount * (1 - divide)-agentfee + strtofloat
      (NovaEdtReturnBalance.Text) + strtofloat(NovaEdtPackPrice.Text)
      + strtofloat(NovaEdtPreUpmoney.Text)
      + strtofloat(NovaEdtRentPrice.Text);

    printValue.Add('totalincome', floattostr(totalincome));

    // 站务附加费
    printValue.Add('additionfee',
      floattostr(strtoCurr(NovaEdtAddFee.Text) * (1 - divide)));
    // 手工扣费
    printValue.Add('dideductmoney', NovaEdtDeduct.Text);
    // 总扣费=中手工输入扣费不参与分成
    printValue.Add('deductifee',
      floattostr(deductifee * (1 - divide) + strtoCurr(NovaEdtDeduct.Text)));
    //添加车属单位
    printValue.Add('vehicleunit', vehicleunit);
    //货运代理费
    printValue.Add('hydlffee', self.NovaEdtPackAgent.Text);
    //本月上交
    printValue.Add('bysj', self.NovaEditnow.Text);
    //上月欠交
    printValue.Add('syqj', self.NovaEditprevious.Text);
    //总扣费1 =  原总扣费基础去掉站务费
    printValue.Add('deductifee1',
      floattostr(deductifee1 * (1 - divide) + strtoCurr(NovaEdtDeduct.Text)));

    printValue.Add('packmoney', self.NovaEdtPack.Text);
    printValue.Add('packprice', NovaEdtPackPrice.Text);
    packdeduct := strtoCurr(NovaEdtPackPrice.Text) - strtoCurr
      (NovaEdtPack.Text);
    // 行包代理费',0,'packdeduct
    printValue.Add('packdeduct', floattostr(packdeduct));
    // 包车营收
    printValue.Add('rentmoney', NovaEdtRentPrice.Text);
    // 包车应结
    printValue.Add('rentprice', NovaEdtRentIncome.Text);
    rentdeduct := strtoCurr(NovaEdtRentPrice.Text) - strtoCurr
      (NovaEdtRentIncome.Text);
    // 包车代理费',0,'packdeduct
    printValue.Add('rentdeduct', floattostr(rentdeduct));

    nottickeitemdeduct := strtoCurr(NovaEdtagentfee.Text) + strtoCurr
      (NovaEdtAddFee.Text) ;

    // 除票价分项外扣费
    printValue.Add('nottickeitemdeduct',
      floattostr(nottickeitemdeduct * (1 - divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));

        // 除票价分项外客运代理费外的扣费     noItemAndagentdeduct
    printValue.Add('noItemAndagentdeduct',
      currtostr(strtoCurr(NovaEdtAddFee.Text) * (1 - divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));
    // 总可结算金额=运量的结算金额(1-分成)=总结算金额*(1-分成)
    // =票款金额-站务费-燃油费-其它扣费-客运代理费* (1-分成)
    dibalanceablemoney := (strtoCurr(NovaEdtBalanceMoney.Text)+strtoCurr(NovaEdtAddFee.Text)) * (1 - divide);
    printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

    // dibalancemoney 应结金额 = 总可结算金额-手工扣费
    dibalancemoney := dibalanceablemoney - strtoCurr(NovaEdtDeduct.Text);
    printValue.Add('dibalancemoney', floattostr(dibalanceablemoney));

    // 结算营收= 应结金额 +\- 其他结算信息 -站务附加费*（1-客运代理费比例）*（1-分成比例）
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

    printValue.Add('totalprice', floattostr(totalprice * (1 - divide))); //总收入
    printValue.Add('actdeduct', floattostr(actdeduct * (1 - divide))); //实扣金额
    // 剩余应结金额 =结算营收+行包应得 +包车应得
//    leavebalancemoney := ticketincome + strtoCurr(NovaEdtPack.Text) + strtoCurr
//      (NovaEdtRentIncome.Text);
    printValue.Add('leavebalancemoney', NovaEdtLeave.Text);

    // 实结金额 = 剩余应结金额
    printValue.Add('balancemoney', NovaEdtActBalance.Text);

    //减免金额
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
    // 查询扣费明细,原来多数据集的代码
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
    end// 改为 非数据集输出
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
      // 总票款金额
      printValue.Add('ditotalmoney',
        floattostr(strtofloat(NovaEdttotalamount.Text) * divide));
      // 站务费
      printValue.Add('stationfee',
        floattostr(strtofloat(NovaEdtstationservicefee.Text) * divide));
      // 其他扣费
      printValue.Add('otherfee',
        floattostr(strtofloat(NovaEdtothterfee.Text) * divide));
      // 客运代理费
      printValue.Add('agentfee',
        floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

      printValue.Add('ticketitemagentfeesum', floattostr(ticketitemsum * divide)
      +floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

      // 营收小计',0,'totalincome =票款-票价分项+行包金额+回程结算金额
      totalincome := invoicesamount * divide;
      printValue.Add('totalincome', floattostr(totalincome));

      // '票款-票价分项',0,'invoicesamount'
      printValue.Add('invoicesamount', floattostr(invoicesamount * divide));

      // 站务附加费
      printValue.Add('additionfee',
        floattostr(strtoCurr(NovaEdtAddFee.Text) * divide));
      // 手工扣费
      printValue.Add('dideductmoney', NovaEdtDivdeDeduct.Text);

      // 总扣费:中手工输入扣费不参与分成
      printValue.Add('deductifee', floattostr(deductifee * divide));
      nottickeitemdeduct:=strtofloat(NovaEdtagentfee.Text) * divide
      + strtoCurr(NovaEdtAddFee.Text) * divide+strtofloat(NovaEdtDivdeDeduct.Text);
      // 除票价分项外扣费
      printValue.Add('nottickeitemdeduct',floattostr(nottickeitemdeduct));
        // 除票价分项外客运代理费外的扣费     noItemAndagentdeduct
      printValue.Add('noItemAndagentdeduct',
      currtostr(strtoCurr(NovaEdtAddFee.Text) * (divide) + strtoCurr
          (NovaEdtDeduct.Text) + packdeduct + rentdeduct+ strtoCurr(NovaEdtdebit.Text)
          + strtoCurr(NovaEdtLateMoney.Text)+ strtoCurr(NovaEdtLostMoney.Text)));
      // 总可结算金额=运量的结算金额*分成=总结算金额*分成
      // =(票款金额-站务费-燃油费-其它扣费-客运代理费)* 分成
      dibalanceablemoney := strtofloat(NovaEdtbalanceamount.Text) * divide;
      printValue.Add('dibalanceablemoney', floattostr(dibalanceablemoney));

      // dibalancemoney 应结金额 = 总可结算金额-手工扣费
      dibalancemoney := dibalanceablemoney - nottickeitemdeduct;
      printValue.Add('dibalancemoney', floattostr(dibalancemoney));

      // 结算营收= 应结金额 +\- 其他结算信息
      ticketincome := dibalancemoney ;
      printValue.Add('ticketincome', floattostr(ticketincome));

      // 剩余应结金额 =结算营收+行包应得
      //leavebalancemoney := ticketincome + 0;
      printValue.Add('leavebalancemoney', NovaEdtDivdeBalance.Text);

      // 实结金额 = 剩余应结金额
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
      // 行包代理费',0,'packdeduct
      printValue.Add('packdeduct', '0');
      // 包车代理费',0,'packdeduct
      printValue.Add('rentdeduct','0');
      printValue.Add('balancby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('departstartdate', fromdepart);
      printValue.Add('departenddate', todepart);
      printValue.Add('debit', '0');
      // 查询扣费明细
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
      SysLog.WriteErr('打印结算帐单失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBalanceInfo.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  inherited;
  //修改  其中需要手工输入的结算扣费，赋值给 结算单位其他结算信息-->手工扣费
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
     AcRptEngineTotalDeatil.AddGlobalVariable('stationname',  SysInfo.LoginUserInfo.ticketoutletsname);  // 车站简称
     AcRptEngineTotalDeatil.AddGlobalVariable('stationfullname', SysInfo.LoginUserInfo.OrgName + '客运收入结算汇总单');  //车站全名
     AcRptEngineTotalDeatil.AddGlobalVariable('qryfromdate', qryfromdate); //查询开始时间
     AcRptEngineTotalDeatil.AddGlobalVariable('qrytodate', qrytodate);     //查询结束时间
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceunit', NovaHUnit.Text); // 结算单位
     AcRptEngineTotalDeatil.AddGlobalVariable('printname', SysInfo.LoginUserInfo.UserName);  //打单人
     //结算金额
     AcRptEngineTotalDeatil.AddGlobalVariable('balanceamount', floattostr(strtofloat(NovaEdttotalamount.Text) * (1 - divide)-strtofloat(NovaEdtstationservicefee.Text) * (1 - divide)));
     //结算单张数
     AcRptEngineTotalDeatil.AddGlobalVariable('depcount', NovaEdtCount.Text);
     //客运代理费
     AcRptEngineTotalDeatil.AddGlobalVariable('agentfee', floattostr(strtofloat(NovaEdtagentfee.Text) * divide));

     AcRptEngineTotalDeatil.AddGlobalVariable('balanceno', balanceno);
//         AcRptEngineTotalDeatil.ShowDesigner;  //开发模式
     AcRptEngineTotalDeatil.Preview;     //预览模式

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
  //0：结算时扣费项目作为数据集，1：扣费项目作为打印项目
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
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr                     //扣费后营收，只减掉一次手工扣费即可
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //十堰需求 减去货运代理费
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
        - strtoCurr(NovaEdtDeduct.Text) + strtoCurr                     //扣费后营收，只减掉一次手工扣费即可
        (NovaEdtReturnBalance.Text) - strtoCurr(NovaEdtLateMoney.Text)
        - strtoCurr(NovaEdtLostMoney.Text) - strtoCurr(NovaEdtLastLost.Text)
        + strtoCurr(NovaEdtFree.Text) + strtoCurr(NovaEdtPreUpmoney.Text)
        - strtoCurr(NovaEdtdebit.Text),
      2) + strtoCurr(NovaEdtbackMoney.Text)-strtoCurr(NovaEditprevious.Text)
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //十堰需求 减去货运代理费
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
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //十堰需求 减去货运代理费
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
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //十堰需求 减去货运代理费
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
      -strtoCurr(NovaEditnow.Text)-StrToCurr(NovaEdtPackAgent.Text)); //十堰需求 减去货运代理费
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
        2));      //减去货票金额
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
      // 查询结算分层单位
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
          MeRemark.Text := '分成前客运收入￥' + floattostr(invoicesamount) + '元';
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
    // 查询其他结算信息
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
//        NovaEdtPackPrice.Text := CurrToStr(StrToCurr(packfee)+goodsmoney);//行包金额+货票金额
        //NovaEdtFreeChange(nil);
      end;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('获取其他结算数据失败：' + E.Message);
    end;
  end;
end;

end.
