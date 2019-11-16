unit UFrmSelfDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  NovaPrint,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, UICcardRW,
  Generics.Collections;

type
  TFrmSelfDepartinvoices = class(TSimpleCRUDForm, IBaseCardfound)
    Label2: TLabel;
    DpDepartDate: TDateTimePicker;
    NovaHCobEntrance: TNovaCheckedComboBox;
    Label1: TLabel;
    Label7: TLabel;
    dtpfromdatetime: TDateTimePicker;
    ChkIsReproted: TCheckBox;
    ChkIsdepart: TCheckBox;
    jcdsScheduleStatus: TjsonClientDataSet;
    Panel2: TPanel;
    lbl2: TLabel;
    lblBillnum: TLabel;
    lblBillno: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    jcdsResultid: TLargeintField;
    jcdsResultdeparttime: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultdepartdate: TDateField;
    jcdsResultcode: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultschedulestatus: TWideStringField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultvehiclereportid: TLargeintField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultcarrychildnum: TIntegerField;
    jcdsResultcheckeds: TIntegerField;
    jcdsResultroutename: TWideStringField;
    NovaEdtCardNo: TNovaEdit;
    jscdSchDepartinvoice: TjsonClientDataSet;
    tmrFlash: TTimer;
    jcdsDepartinvoice: TjsonClientDataSet;
    jscdQryDeductfees: TjsonClientDataSet;
    jcdsQryDetail: TjsonClientDataSet;
    jcdsOthersells: TjsonClientDataSet;
    jscdqryScheduleReport: TjsonClientDataSet;
    jcdsResultdepartstation: TWideStringField;
    jcdsResultendstation: TWideStringField;
    jcdsResultvehicletypename: TWideStringField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultbuspark: TWideStringField;
    jcdsResultbrandname: TWideStringField;
    jcdsResultmodelcode: TWideStringField;
    jcdsResultislinework: TBooleanField;
    jcdsResultisreported: TBooleanField;
    jcdsResultworktype: TWideStringField;
    jcdsResultschtype: TWideStringField;
    jcdsResultdistance: TIntegerField;
    jcdsResultplanvehiclebrandmodelid: TLargeintField;
    Label5: TLabel;
    jcdsResultreporttime: TDateTimeField;
    jcdsResultdriver1: TWideStringField;
    jcdsResultdriver2: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure NovaEdtCardNoChange(Sender: TObject);
    procedure tmrFlashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NovaEdtCardNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    isjumpno, isaotoreflash: boolean;
    serialnumber: String;
    billPrint: TNovaPrint;
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    procedure refreshBill; // 刷新票号
    procedure iccardfound(icCard: TBaseCard);
    procedure departSchImpl(invoincesno: String; isreprint: boolean;
      iscomputeno: boolean);
  public
    { Public declarations }
  end;

var
  FrmSelfDepartinvoices: TFrmSelfDepartinvoices;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmSelfDepartinvoices.departSchImpl(invoincesno: String;
  isreprint, iscomputeno: boolean);
var
  vehiclereportid, departinvoicesid, vehicleid, scheduleplanid: int64;
  nresult: integer;
  sresult, vehicleno: String;
  multipleValueValue: TDictionary<String, String>;
  schedulecode, departdate: string;
  departtime, departstation, endstation: string;
  routename, templtename: string;
  fulls, halfs, students, discounts, totalpsdistance: integer;
  totalpeople, psdistance: integer;
  totalfee, noagentbalanceprice: double;
  i: integer;
begin
  if not jcdsResult.FieldByName('isreported').AsBoolean then
  begin
    lbl2.Caption := '该班次还未报班，不能发班！';
    exit;
  end;
  fulls := 0;
  halfs := 0;
  students := 0;
  discounts := 0;
  totalpsdistance := 0;
  totalfee := 0;
  if tmrFlash.Enabled then
    tmrFlash.Enabled := false;
  { if (jcdsResult.FieldByName('islinework').AsBoolean) then
    begin
    if not jscdQryVehicleReport.Active then
    exit;
    if jscdQryVehicleReport.RecordCount = 0 then
    exit;
    vehiclereportid := jscdQryVehicleReport.FieldByName('id').AsLargeInt;
    vehicleno := jscdQryVehicleReport.FieldByName('vehicleno').AsString;
    vehicleid := jscdQryVehicleReport.FieldByName('vehicleid').AsLargeInt;
    end
    else
    begin

    vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
    end; }
  vehiclereportid := jcdsResult.FieldByName('vehiclereportid').AsLargeInt;
  vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;

  schedulecode := jcdsResult.FieldByName('code').AsString;
  departdate := jcdsResult.FieldByName('departdate').AsString;
  departtime := jcdsResult.FieldByName('departtime').AsString;
  departstation := jcdsResult.FieldByName('departstation').AsString;
  endstation := jcdsResult.FieldByName('endstation').AsString;
  routename := jcdsResult.FieldByName('routename').AsString;
  templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');

  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);

  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

  notprintValue := getNotprintValue(Sysinfo.LoginUserInfo.OrgID, vehicleid,
    templtename);

  try
    with jcdsDepartinvoice do
    begin
      Active := false;
      Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['departinvoicesno'] := invoincesno;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      Params.ParamValues['isreprint'] := isreprint;
      Params.ParamValues['iscomputeno'] := iscomputeno;
      Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
        DpDepartDate.Date);
      Active := true;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        if (RecordCount > 0) and (iscomputeno) then
        begin
          while not Eof do
          begin
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create
            else
              printValue.Clear;
            printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
            printValue.Add('seats', FieldByName('seatnum').AsString);
            printValue.Add('brandmodel', FieldByName('brandname').AsString);
            printValue.Add('vehicletype', FieldByName('vehicletype').AsString);
            printValue.Add('route', routename);
            printValue.Add('routedistance', FieldByName('distance').AsString);
            printValue.Add('schedulecode', schedulecode);
            printValue.Add('departdate', departdate);
            printValue.Add('departtime', departtime);
            printValue.Add('departstation', departstation);
            printValue.Add('checkedname', FieldByName('checkedname').AsString);
            printValue.Add('endstation', endstation);
            printValue.Add('freetickets', FieldByName('freetickets').AsString);
            printValue.Add('armtickets', FieldByName('armtickets').AsString);

            departinvoicesid := FieldByName('id').AsLargeInt;
            printValue.Add('invoicesno', FieldByName('invoicesno').AsString);
            printValue.Add('unit', FieldByName('unit').AsString);
            printValue.Add('ticketnum', FieldByName('ticketnum').AsString);
            printValue.Add('driver1', FieldByName('driver1').AsString);
            printValue.Add('driver2', FieldByName('driver2').AsString);
            printValue.Add('driver3', FieldByName('driver3').AsString);
            printValue.Add('driver4', FieldByName('driver4').AsString);
            printValue.Add('steward', FieldByName('steward').AsString);
            printValue.Add('balanceunit', FieldByName('balanceunit').AsString);
            // 扣费明细改为由数据集返回
            with jscdQryDeductfees do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Active := true;
              if RecordCount > 0 then
              begin
                first;
                while (not Eof) do
                begin
                  printValue.Add(FieldByName('code').AsString,
                    FieldByName('deductmoney').AsString);
                  next;
                end;
              end;
            end;
            // 扣费明细改为由数据集返回
            printValue.Add('stationfee', FieldByName('stationfee').AsString);

            totalfee := FieldByName('totalamount').AsFloat - FieldByName
              ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;
            noagentbalanceprice := FieldByName('agentfee').AsFloat + FieldByName
              ('balanceamount').AsFloat;
            printValue.Add('noagentbalanceprice',
              floattostr(noagentbalanceprice));
            printValue.Add('totalfee', floattostr(totalfee));
            if isreprint then
              printValue.Add('reprint', '重打')
            else
              printValue.Add('reprint', '');
            printValue.Add('agentfee', FieldByName('agentfee').AsString);
            printValue.Add('fueladditionfee',
              FieldByName('fueladditionfee').AsString);

            printValue.Add('otherfee', FieldByName('otherfee').AsString);
            printValue.Add('totalamount', FieldByName('totalamount').AsString);
            printValue.Add('balanceamount',
              FieldByName('balanceamount').AsString);
            if FieldByName('isovertime').AsBoolean then
              printValue.Add('isovertime', '加班')
            else
              printValue.Add('isovertime', '');
            printValue.Add('printby', Sysinfo.LoginUserInfo.UserName);
            printValue.Add('printstation', Sysinfo.LoginUserInfo.OrgName);
            printValue.Add('printertime',
              formatdatetime('yyyy-mm-dd hh:mm', now));

            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            with jcdsQryDetail do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Active := true;
              if RecordCount > 0 then
              begin
                first;

                while (not Eof) do
                begin
                  multipleValueValue := TDictionary<String, String>.Create;
                  multipleValueValue.Add('fromstation',
                    FieldByName('fromstation').AsString);
                  multipleValueValue.Add('reachstation',
                    FieldByName('reachstation').AsString);
                  multipleValueValue.Add('fullpeople',
                    FieldByName('fullpeople').AsString);
                  multipleValueValue.Add('price',
                    FieldByName('price').AsString);
                  multipleValueValue.Add('halfpeople',
                    FieldByName('halfpeople').AsString);
                  multipleValueValue.Add('studentpeople', '0');
                  multipleValueValue.Add('discountpeople',
                    FieldByName('discountpeople').AsString);
                  multipleValueValue.Add('distance',
                    FieldByName('distance').AsString);
                  totalpeople := FieldByName('fullpeople')
                    .AsInteger + FieldByName('halfpeople').AsInteger;
                  psdistance := FieldByName('distance').AsInteger * totalpeople;
                  multipleValueValue.Add('psdistance', inttostr(psdistance));
                  multipleValueValue.Add('totalamount',
                    FieldByName('totalamount').AsString);
                  multipleValueValue.Add('balanceprice',
                    FieldByName('balanceprice').AsString);
                  multiplelist.Add(multipleValueValue);
                  multipleValueValue.Add('balanceamount',
                    FieldByName('balanceamount').AsString);
                  multipleValueValue.Add('noagentbalanceamount',
                    FieldByName('noagentbalanceamount').AsString);
                  fulls := fulls + FieldByName('fullpeople').AsInteger;
                  halfs := halfs + FieldByName('halfpeople').AsInteger;
                  students := 0;
                  discounts := 0;
                  totalpsdistance := totalpsdistance + psdistance;
                  next;
                end;
              end;
            end;
            // 根据运量ID 发车日期获取他站售票情况
            with jcdsOthersells do
            begin
              Active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Params.ParamValues['departdate'] := departdate;
              execute;
              printValue.Add('othersell',
                Params.ParamByName('othersells').Value);
            end;
            printValue.Add('fulls', inttostr(fulls));
            printValue.Add('halfs', inttostr(halfs));
            printValue.Add('students', inttostr(students));
            printValue.Add('discounts', inttostr(discounts));
            printValue.Add('totalpsdistance', inttostr(totalpsdistance));

            billPrint.SingleValue := printValue;
            billPrint.MultipleValue := multiplelist;

            billPrint.Print;
            if isreprint then
            begin
              if isjumpno then
              begin
                with Sysinfo.LoginUserInfo do
                begin
                  curBillNo.AddOrSetValue('BalanceBill',
                    zerofill
                      (inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                          + 1), length(curBillNo.Items['BalanceBill'])));
                  curBillNum.AddOrSetValue('BalanceBill',
                    curBillNum.Items['BalanceBill'] - 1);
                end;
              end;
            end
            else
            begin
              with Sysinfo.LoginUserInfo do
              begin
                curBillNo.AddOrSetValue('BalanceBill',
                  zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                        + 1), length(curBillNo.Items['BalanceBill'])));
                curBillNum.AddOrSetValue('BalanceBill',
                  curBillNum.Items['BalanceBill'] - 1);
              end;
            end;
            // ChkAddCheck.Checked := false;
            refreshBill;
            next;
          end;
          // SysDialogs.ShowMessage(sresult);
          lbl2.Caption := sresult;
          // dtpfromdatetime.Time := now - 0.08;
          // qryScheduleplan(scheduleplanid);

          // NovaEdtTicketNo.SetFocus;
        end;
        { if not iscomputeno then
          begin
          qryScheduleplan(scheduleplanid);
          end; }
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
      if isaotoreflash then
        tmrFlash.Enabled := true;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('发班操作失败：' + E.Message);
    end;
  end;
  ChkIsReproted.Checked := true;
  ChkIsdepart.Checked := true;
  dtpfromdatetime.Checked := false;
  tbtnFilterClick(nil);
end;

procedure TFrmSelfDepartinvoices.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  if Assigned(printValue) then
    printValue.Free;
  if Assigned(multiplelist) then
    multiplelist.Free;

  // tmGetCurInvoinNo.Enabled := false;
  tmrFlash.Enabled := false;
  inherited;
end;

procedure TFrmSelfDepartinvoices.FormCreate(Sender: TObject);
begin
  inherited;
  checkBillno('BalanceBill');
  try
    TBaseCardRW.GetInstance.addObserver(self);
  except
    TBaseCardRW.GetInstance.addObserver(self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    Sysinfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, Sysinfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    Sysinfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, Sysinfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, Sysinfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    Sysinfo.curBillLength.Items['Unit']);
end;

procedure TFrmSelfDepartinvoices.FormDeactivate(Sender: TObject);
begin
  inherited;
  if Assigned(Sysinfo.CardManage) then
  begin
    Sysinfo.CardManage.StopRead;
  end;
end;

procedure TFrmSelfDepartinvoices.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(self);
  except
  end;
end;

procedure TFrmSelfDepartinvoices.FormShow(Sender: TObject);
begin
  inherited;
  DpDepartDate.Date := now;
  dtpfromdatetime.Time := now - 0.08;
  dtpfromdatetime.Checked := false;
  refreshBill;
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := true;
  with NovaHCobEntrance do
  begin
    Active := false;
    Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.OrgID;
    Active := true;
    NovaHCobEntrance.CheckAll(true);
  end;
  tbtnFilterClick(Sender);
  tmrFlash.Enabled := true;
end;

procedure TFrmSelfDepartinvoices.iccardfound(icCard: TBaseCard);
begin
  serialnumber := '';
  if integer(icCard.cardtype) <> 0 then
  begin
    ShowMessage('该卡不是报到卡，不能用于报到！');
  end
  else
  begin
    serialnumber := inttostr(icCard.internalSerialNo);
    NovaEdtCardNo.Text := icCard.cardNo;
  end;
end;

procedure TFrmSelfDepartinvoices.NovaEdtCardNoChange(Sender: TObject);
var
  reportid, scheduleplanid: int64;
  log: string;
begin
  if length(NovaEdtCardNo.Text) = Sysinfo.curBillLength.Items['Vehicle'] then
  begin
    if trim(NovaEdtCardNo.Text) = '' then
      exit;
    if not checkBillno('BalanceBill') then
      exit;
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
    begin
      tbtnFilterClick(Sender);
      // exit;
    end;
    log := '卡号：' + trim(NovaEdtCardNo.Text) + '进行自助打印结算单刷卡操作！';
    SysLog.WriteLog('检票管理->综合检票', '自助打印结算单', log);
    with jscdqryScheduleReport do
    begin
      Active := false;
      Params.ParamValues['cardno'] := trim(NovaEdtCardNo.Text);
      Params.ParamValues['reportorgid'] := Sysinfo.LoginUserInfo.OrgID;
      Active := true;
      if RecordCount > 0 then
      begin
        lbl2.Caption := '当前卡号：' +  trim(NovaEdtCardNo.Text);
        lbl2.Update;
        //scheduleplanid := FieldByName('scheduleplanid').AsLargeInt;
        reportid := FieldByName('reportid').AsLargeInt;
        if jcdsResult.Locate('vehiclereportid', reportid, []) then
        begin
          {if jcdsResult.FieldByName('islinework').AsBoolean then
          begin
            if jscdQryVehicleReport.Locate('id', reportid, []) then
            begin
              departSchImpl
                (Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'], false,
                true);
            end;
          end
          else }
          begin
            departSchImpl(Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'],
              false, true);

          end;
        end;
      end
      else
      begin
        lbl2.Caption := '卡号：'+NovaEdtCardNo.text+' 没有报到的班次！';
        lbl2.Refresh;
        Panel2.Refresh;
      end;
    end;
    NovaEdtCardNo.Clear;
  end;
end;

procedure TFrmSelfDepartinvoices.NovaEdtCardNoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  key:=0;
end;

procedure TFrmSelfDepartinvoices.refreshBill;
begin
  if Sysinfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and Sysinfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (Sysinfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin
    lblBillno.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    lblBillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
        ['BalanceBill']);
    lblBillno.Update;
    lblBillnum.Update;
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    lblBillno.Caption := '';
    lblBillnum.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    // SysDialogs.Warning('请重置结算单号！');
    // self.Close;
  end;
end;

procedure TFrmSelfDepartinvoices.tbtnFilterClick(Sender: TObject);
var
  ticketentrance: string;
  curid: int64;
begin
  inherited;
  if NovaHCobEntrance.Text = '' then
  begin
    SysDialogs.ShowMessage('请选择检票口');
    exit;
  end;
  if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    // lbl2.Caption:=IntToStr(curid);
  end;
  // jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      DpDepartDate.Date);
    Params.ParamValues['reportorgid'] := Sysinfo.LoginUserInfo.OrgID;
    Params.ParamValues['checkstationid'] := Sysinfo.LoginUserInfo.StationID;

    if NovaHCobEntrance.Text <> '' then
    begin
      ticketentrance := NovaHCobEntrance.GetSelectID;
      Params.ParamValues['filter_INS_ta!id'] := ticketentrance;
    end
    else
    begin
      Params.ParamValues['filter_INS_ta!id'] := null;
    end;

    if (ChkIsReproted.Checked) then
      Params.ParamValues['filter_EQB_ss!isreported'] := true
    else
      Params.ParamValues['filter_EQB_ss!isreported'] := null;

    if ChkIsdepart.Checked then
    begin
      Params.ParamValues['filter_EQB_ss!isdeparted'] := false;
      Params.ParamValues['filter_EQB_vr!isdeparted'] := false;
    end
    else
    begin
      Params.ParamValues['filter_EQB_ss!isdeparted'] := null;
      Params.ParamValues['filter_EQB_vr!isdeparted'] := null;
    end;
    if dtpfromdatetime.Checked then
    begin
      Params.ParamValues['filter_GES_ss!departtime'] := formatdatetime('hh:mm',
        dtpfromdatetime.Time)
    end
    else
      Params.ParamValues['filter_GES_ss!departtime'] := null;
    Active := true;

    if RecordCount > 0 then
    begin
      // ToolButton50.Enabled := true; ;
      jcdsResult.Locate('id', curid, []);
      dbgrdhResult.SelectedRows.CurrentRowSelected := true;
      { if FieldByName('islinework').AsBoolean then
        setLineWorkScheduleinfo
        else
        setScheduleInfo; }
    end
    else
    begin
      // ToolButton50.Enabled := false;

    end;
    // NovaEdtTicketNo.SetFocus;
  end;

  // jcdsResult.AfterScroll := jcdsResultAfterScroll;

end;

procedure TFrmSelfDepartinvoices.tbtnInsertClick(Sender: TObject);
var
  reportid, scheduleplanid: int64;
begin
  inherited;
  if not checkBillno('BalanceBill') then
    exit;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;

  departSchImpl(Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'], false,
    true);

end;

procedure TFrmSelfDepartinvoices.tmrFlashTimer(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

end.
