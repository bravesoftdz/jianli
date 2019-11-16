unit UFrmChanageDepartVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHelp, Generics.Collections,
  NovaPrint, DateUtils;

type
  TFrmChanageDepartVehicle = class(TSimpleEditForm)
    lbl1: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    NovaEdtReportVehicle: TNovaEdit;
    NovaEdtUnit: TNovaEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    NovaEdtSeat: TNovaEdit;
    txt1: TStaticText;
    lbl4: TLabel;
    NovaEdtNewSeat: TNovaEdit;
    jcsdchanageDepartinvoices: TjsonClientDataSet;
    jcdsOthersells: TjsonClientDataSet;
    jcdsVehicledistance: TjsonClientDataSet;
    jcsdQryVehiclecheck: TjsonClientDataSet;
    jscdQryDeductfees: TjsonClientDataSet;
    jcdsQryDetail: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
  private
    { Private declarations }
    billPrint: TNovaPrint;
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    procedure refreshBill; // 刷新票号
  public
    { Public declarations }
    departinvoicesid: Int64;
    vehiclereportid, vehicleid, scheduleplanid: Int64;
    vehicleno, schedulecode: string;
    departdate, log: string;
    maintainvaliddate: TDatetime;
    departtime, routename, departstation, endstation, distancemessage: string;
    temp: Integer;
  end;

var
  FrmChanageDepartVehicle: TFrmChanageDepartVehicle;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmChanageDepartVehicle.bbtnSaveClick(Sender: TObject);
var
  multipleValueValue: TDictionary<String, String>;
  templtename, sresult, ischeckwithout, isMustCheck: string;
  fulls, halfs, students, discounts, totalpsdistance: Integer;
  totalpeople, nresult, psdistance, limitdistance, departdistance,
    messagedistance, messagedate: Integer;
  noagentbalanceprice,totalfee: double;
begin
  inherited;
  if ((NovaHelpVehicleno.Text) = '') or (NovaHelpVehicleno.Id = 0) then
  begin
    SysDialogs.ShowMessage('请输入更换的车号！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  if (NovaHelpVehicleno.Text = NovaEdtReportVehicle.Text) then
  begin
    SysDialogs.ShowMessage('更换的车号不能与当前报到车辆一样！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  if not checkBillno('BalanceBill') then
    exit;
  fulls := 0;
  halfs := 0;
  students := 0;
  discounts := 0;
  totalpsdistance := 0;
  templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  notprintValue := getNotprintValue(SysInfo.LoginUserInfo.OrgID, vehicleid,
    templtename);

  with jcsdQryVehiclecheck do
  begin
    active := false;
    Params.ParamValues['vehiclereport.vehicleid'] := NovaHelpVehicleno.Id;
    Params.ParamValues['vehiclereport.departdate'] := formatdatetime
      ('yyyy-mm-dd', now);
    try
      Execute;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      ischeckwithout := getParametervalue('6008', SysInfo.LoginUserInfo.OrgID);
      isMustCheck := getParametervalue('2013', SysInfo.LoginUserInfo.OrgID);
      // -1未检 1合格 0不合格 2是无安检计划无需校验安检 3:24小时内安检合格，
      // - 2,已发班里程大于设置需要重复安检里程，提示需要再次安检
      if (isMustCheck = '1') then
      begin
        // if (nResult = -3) then  //有安检计划，必须安检
        // begin
        // SysDialogs.ShowMessage('该车辆必须先安检合格，才能保存！');
        // exit;
        // end;
        if (nresult = -1) then // 该车辆当日还没例检！
        begin
          if ischeckwithout = '1' then
          begin
            SysDialogs.ShowMessage('该车辆必须先安检合格，才能保存！');
            exit;
          end;
        end
        else if (nresult = 2) then // 当前车辆无安检计划!
        begin
          // 是否需要安检合格才允许报到
          if isMustCheck = '1' then
          begin
            if ischeckwithout = '1' then
            begin
              SysDialogs.ShowMessage('无安检计划，必须安检合格才能保存！');
              exit;
            end;
          end;
        end
        else if (nresult = -2) or (nresult = -3) then // 提示需要再次安检
        begin
          SysDialogs.ShowMessage('该车辆必须再次安检合格才能保存!');
          exit;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('获取车辆安检信息失败：' + E.Message);
        exit;
      end;
    end;
  end;

  // 是否开启车辆里程限制
  if getParametervalue('0143', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    // 查询车辆里程激活管理，取出发班里程数和限制的里程数
    with jcdsVehicledistance do
    begin
      Close;
      Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
      Params.ParamValues['iscomparedate'] := 'false';
      Execute;
      nresult := Params.ParamByName('flag').Value;
      if (nresult <= 0) then
      begin
        sresult := Params.ParamByName('msg').Value;
        temp := Pos('该车辆还有', sresult);
        if temp > 0 then
          distancemessage := sresult
        else
        begin
          SysDialogs.Warning(sresult);
          exit;
        end;
      end;
    end;
  end;
  // 是否开启车辆二期维护有效期
  if getParametervalue('6006', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    // 查询车辆里程激活管理，取出二维有效期
    with jcdsVehicledistance do
    begin
      Close;
      Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
      Params.ParamValues['iscomparedate'] := 'true';
      Execute;
      nresult := Params.ParamByName('flag').Value;
      if (nresult <= 0) then
      begin
        sresult := Params.ParamByName('msg').Value;
        temp := Pos('该车辆还有', sresult);
        if temp > 0 then
        begin
          if distancemessage <> '' then
          begin
            sresult := Copy(sresult, 4);
            distancemessage := distancemessage + ',' + sresult;
          end
          else
            distancemessage := sresult;
        end
        else
        begin
          SysDialogs.Warning(sresult);
          exit;
        end;
      end;
    end;
  end;
  if distancemessage <> '' then
    SysDialogs.ShowInfo(distancemessage + ',达到二维期限！');
  distancemessage := '';

  try
    with jcsdchanageDepartinvoices do
    begin
      active := false;
      Params.ParamValues['departstationid'] := SysInfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['newvehicleid'] := NovaHelpVehicleno.Id;
      Params.ParamValues['departinvoicesno'] :=
        SysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
      Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
      active := true;
      nresult := Params.ParamByName('flag').Value;
      sresult := Params.ParamByName('msg').Value;
      if (nresult = 1) then
      begin
        templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
        if not Assigned(billPrint) then
          billPrint := TNovaPrint.Create(self, templtename);
        if RecordCount > 0 then
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
              active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              active := true;
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
            printValue.Add('reprint', '补开');
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
            printValue.Add('printby', SysInfo.LoginUserInfo.UserName);
            printValue.Add('printstation', SysInfo.LoginUserInfo.OrgName);
            printValue.Add('printertime',
              formatdatetime('yyyy-mm-dd hh:mm', now));

            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            with jcdsQryDetail do
            begin
              active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              active := true;
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
              active := false;
              Params.ParamValues['departinvoicesid'] := departinvoicesid;
              Params.ParamValues['departdate'] := departdate;
              Execute;
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
            with SysInfo.LoginUserInfo do
            begin
              curBillNo.AddOrSetValue('BalanceBill',
                zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                      + 1), length(curBillNo.Items['BalanceBill'])));
              curBillNum.AddOrSetValue('BalanceBill',
                curBillNum.Items['BalanceBill'] - 1);
            end;
            refreshBill;
            next;
          end;
        end;

        log := '结算单换车重打：当前报到车辆=' + NovaEdtReportVehicle.Text + ',座位数=' +
          NovaEdtSeat.Text + ',车属单位=' + NovaEdtUnit.Text + ',更换报到车辆=' +
          NovaHelpVehicleno.Text + ',更换后的座位数=' + NovaEdtNewSeat.Text;
        SysLog.WriteLog('结算单管理——>换车重打', '换车重打结算单', log);
        SysDialogs.ShowMessage(sresult);
        ModalResult := mrOk;
      end
      else
      begin
        SysDialogs.Warning(sresult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('换车打单操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmChanageDepartVehicle.NovaHelpVehiclenoIdChange(Sender: TObject);
begin
  inherited;
  if ((NovaHelpVehicleno.isactive) and (NovaHelpVehicleno.Id > 0)) then
    NovaEdtNewSeat.Text := NovaHelpVehicleno.HelpFieldValue['seatnum']
  else
    NovaEdtNewSeat.Clear;
end;

procedure TFrmChanageDepartVehicle.refreshBill;
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (SysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin
    // lblBillno.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    // lblBillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
    // ['BalanceBill']);
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    // lblBillno.Caption := '';
    // lblBillnum.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    SysDialogs.Warning('请重置结算单号！');
    // self.Close;
  end;
end;

end.
